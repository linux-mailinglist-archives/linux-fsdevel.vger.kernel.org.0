Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36A0C103E98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfKTP3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:29:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23239 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730260AbfKTP17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574263678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wekJscu6cm369WD4uQJdb9qYgiKDXk4+ct5ppuxTsA=;
        b=Yx0AENh7LSAIqTPoa3gfhmkKjhCrqoJZN3zeAPKpID4iyn4iBt8ad5T5Zs37Hj5qtg4yyA
        S2sWZYsFfG3gMCYqiuTD//EWaz8nAoNQH5d9cex1zkMDyZTo2mLwdStY2IvYBcqSlfOxWq
        SnG0bkE2NUaa9QKjgtuBA8dWIajY+Rg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-AUfzCtVWMjWximUWge1jjg-1; Wed, 20 Nov 2019 10:27:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D8A4107ACE6;
        Wed, 20 Nov 2019 15:27:53 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDE8A67E40;
        Wed, 20 Nov 2019 15:27:52 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 9CD3420AB4; Wed, 20 Nov 2019 10:27:50 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 24/27] NFS: Convert mount option parsing to use functionality from fs_parser.h
Date:   Wed, 20 Nov 2019 10:27:47 -0500
Message-Id: <20191120152750.6880-25-smayhew@redhat.com>
In-Reply-To: <20191120152750.6880-1-smayhew@redhat.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: AUfzCtVWMjWximUWge1jjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split out from commit "NFS: Add fs_context support."

Convert existing mount option definitions to fs_parameter_enum's and
fs_parameter_spec's.  Parse mount options using fs_parse() and
lookup_constant().

Notes:

1) Fixed a typo in the udp6 definition in nfs_xprt_protocol_tokens
from the original commit.

2) fs_parse() expects an fs_context as the first arg so that any
errors can be logged to the fs_context.  We're passing NULL for the
fs_context (this will change in commit "NFS: Add fs_context support.")
which is okay as it will cause logfc() to do a printk() instead.

3) fs_parse() expects an fs_paramter as the third arg.  We're
building an fs_parameter manually in nfs_fs_context_parse_option(),
which will go away in commit "NFS: Add fs_context support.".

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/fs_context.c | 789 ++++++++++++++++++++------------------------
 1 file changed, 365 insertions(+), 424 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 96720cfd1065..9a3162055d5d 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -11,7 +11,8 @@
=20
 #include <linux/module.h>
 #include <linux/fs.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
@@ -28,218 +29,215 @@
=20
 #define NFS_MAX_CONNECTIONS 16
=20
-enum {
-=09/* Mount options that take no arguments */
-=09Opt_soft, Opt_softerr, Opt_hard,
-=09Opt_posix, Opt_noposix,
-=09Opt_cto, Opt_nocto,
-=09Opt_ac, Opt_noac,
-=09Opt_lock, Opt_nolock,
-=09Opt_udp, Opt_tcp, Opt_rdma,
-=09Opt_acl, Opt_noacl,
-=09Opt_rdirplus, Opt_nordirplus,
-=09Opt_sharecache, Opt_nosharecache,
-=09Opt_resvport, Opt_noresvport,
-=09Opt_fscache, Opt_nofscache,
-=09Opt_migration, Opt_nomigration,
-
-=09/* Mount options that take integer arguments */
-=09Opt_port,
-=09Opt_rsize, Opt_wsize, Opt_bsize,
-=09Opt_timeo, Opt_retrans,
-=09Opt_acregmin, Opt_acregmax,
-=09Opt_acdirmin, Opt_acdirmax,
+enum nfs_param {
+=09Opt_ac,
+=09Opt_acdirmax,
+=09Opt_acdirmin,
+=09Opt_acl,
+=09Opt_acregmax,
+=09Opt_acregmin,
 =09Opt_actimeo,
-=09Opt_namelen,
+=09Opt_addr,
+=09Opt_bg,
+=09Opt_bsize,
+=09Opt_clientaddr,
+=09Opt_cto,
+=09Opt_fg,
+=09Opt_fscache,
+=09Opt_hard,
+=09Opt_intr,
+=09Opt_local_lock,
+=09Opt_lock,
+=09Opt_lookupcache,
+=09Opt_migration,
+=09Opt_minorversion,
+=09Opt_mountaddr,
+=09Opt_mounthost,
 =09Opt_mountport,
+=09Opt_mountproto,
 =09Opt_mountvers,
-=09Opt_minorversion,
-
-=09/* Mount options that take string arguments */
-=09Opt_nfsvers,
-=09Opt_sec, Opt_proto, Opt_mountproto, Opt_mounthost,
-=09Opt_addr, Opt_mountaddr, Opt_clientaddr,
+=09Opt_namelen,
 =09Opt_nconnect,
-=09Opt_lookupcache,
-=09Opt_fscache_uniq,
-=09Opt_local_lock,
-
-=09/* Special mount options */
-=09Opt_userspace, Opt_deprecated, Opt_sloppy,
-
-=09Opt_err
+=09Opt_port,
+=09Opt_posix,
+=09Opt_proto,
+=09Opt_rdirplus,
+=09Opt_rdma,
+=09Opt_resvport,
+=09Opt_retrans,
+=09Opt_retry,
+=09Opt_rsize,
+=09Opt_sec,
+=09Opt_sharecache,
+=09Opt_sloppy,
+=09Opt_soft,
+=09Opt_softerr,
+=09Opt_source,
+=09Opt_tcp,
+=09Opt_timeo,
+=09Opt_udp,
+=09Opt_v,
+=09Opt_vers,
+=09Opt_wsize,
 };
=20
-static const match_table_t nfs_mount_option_tokens =3D {
-=09{ Opt_userspace, "bg" },
-=09{ Opt_userspace, "fg" },
-=09{ Opt_userspace, "retry=3D%s" },
-
-=09{ Opt_sloppy, "sloppy" },
-
-=09{ Opt_soft, "soft" },
-=09{ Opt_softerr, "softerr" },
-=09{ Opt_hard, "hard" },
-=09{ Opt_deprecated, "intr" },
-=09{ Opt_deprecated, "nointr" },
-=09{ Opt_posix, "posix" },
-=09{ Opt_noposix, "noposix" },
-=09{ Opt_cto, "cto" },
-=09{ Opt_nocto, "nocto" },
-=09{ Opt_ac, "ac" },
-=09{ Opt_noac, "noac" },
-=09{ Opt_lock, "lock" },
-=09{ Opt_nolock, "nolock" },
-=09{ Opt_udp, "udp" },
-=09{ Opt_tcp, "tcp" },
-=09{ Opt_rdma, "rdma" },
-=09{ Opt_acl, "acl" },
-=09{ Opt_noacl, "noacl" },
-=09{ Opt_rdirplus, "rdirplus" },
-=09{ Opt_nordirplus, "nordirplus" },
-=09{ Opt_sharecache, "sharecache" },
-=09{ Opt_nosharecache, "nosharecache" },
-=09{ Opt_resvport, "resvport" },
-=09{ Opt_noresvport, "noresvport" },
-=09{ Opt_fscache, "fsc" },
-=09{ Opt_nofscache, "nofsc" },
-=09{ Opt_migration, "migration" },
-=09{ Opt_nomigration, "nomigration" },
-
-=09{ Opt_port, "port=3D%s" },
-=09{ Opt_rsize, "rsize=3D%s" },
-=09{ Opt_wsize, "wsize=3D%s" },
-=09{ Opt_bsize, "bsize=3D%s" },
-=09{ Opt_timeo, "timeo=3D%s" },
-=09{ Opt_retrans, "retrans=3D%s" },
-=09{ Opt_acregmin, "acregmin=3D%s" },
-=09{ Opt_acregmax, "acregmax=3D%s" },
-=09{ Opt_acdirmin, "acdirmin=3D%s" },
-=09{ Opt_acdirmax, "acdirmax=3D%s" },
-=09{ Opt_actimeo, "actimeo=3D%s" },
-=09{ Opt_namelen, "namlen=3D%s" },
-=09{ Opt_mountport, "mountport=3D%s" },
-=09{ Opt_mountvers, "mountvers=3D%s" },
-=09{ Opt_minorversion, "minorversion=3D%s" },
-
-=09{ Opt_nfsvers, "nfsvers=3D%s" },
-=09{ Opt_nfsvers, "vers=3D%s" },
-
-=09{ Opt_sec, "sec=3D%s" },
-=09{ Opt_proto, "proto=3D%s" },
-=09{ Opt_mountproto, "mountproto=3D%s" },
-=09{ Opt_addr, "addr=3D%s" },
-=09{ Opt_clientaddr, "clientaddr=3D%s" },
-=09{ Opt_mounthost, "mounthost=3D%s" },
-=09{ Opt_mountaddr, "mountaddr=3D%s" },
-
-=09{ Opt_nconnect, "nconnect=3D%s" },
-
-=09{ Opt_lookupcache, "lookupcache=3D%s" },
-=09{ Opt_fscache_uniq, "fsc=3D%s" },
-=09{ Opt_local_lock, "local_lock=3D%s" },
-
-=09/* The following needs to be listed after all other options */
-=09{ Opt_nfsvers, "v%s" },
-
-=09{ Opt_err, NULL }
+static const struct fs_parameter_spec nfs_param_specs[] =3D {
+=09fsparam_flag_no("ac",=09=09Opt_ac),
+=09fsparam_u32   ("acdirmax",=09Opt_acdirmax),
+=09fsparam_u32   ("acdirmin",=09Opt_acdirmin),
+=09fsparam_flag_no("acl",=09=09Opt_acl),
+=09fsparam_u32   ("acregmax",=09Opt_acregmax),
+=09fsparam_u32   ("acregmin",=09Opt_acregmin),
+=09fsparam_u32   ("actimeo",=09Opt_actimeo),
+=09fsparam_string("addr",=09=09Opt_addr),
+=09fsparam_flag  ("bg",=09=09Opt_bg),
+=09fsparam_u32   ("bsize",=09=09Opt_bsize),
+=09fsparam_string("clientaddr",=09Opt_clientaddr),
+=09fsparam_flag_no("cto",=09=09Opt_cto),
+=09fsparam_flag  ("fg",=09=09Opt_fg),
+=09__fsparam(fs_param_is_string, "fsc",=09=09Opt_fscache,
+=09=09  fs_param_neg_with_no|fs_param_v_optional),
+=09fsparam_flag  ("hard",=09=09Opt_hard),
+=09__fsparam(fs_param_is_flag, "intr",=09=09Opt_intr,
+=09=09  fs_param_neg_with_no|fs_param_deprecated),
+=09fsparam_enum  ("local_lock",=09Opt_local_lock),
+=09fsparam_flag_no("lock",=09=09Opt_lock),
+=09fsparam_enum  ("lookupcache",=09Opt_lookupcache),
+=09fsparam_flag_no("migration",=09Opt_migration),
+=09fsparam_u32   ("minorversion",=09Opt_minorversion),
+=09fsparam_string("mountaddr",=09Opt_mountaddr),
+=09fsparam_string("mounthost",=09Opt_mounthost),
+=09fsparam_u32   ("mountport",=09Opt_mountport),
+=09fsparam_string("mountproto",=09Opt_mountproto),
+=09fsparam_u32   ("mountvers",=09Opt_mountvers),
+=09fsparam_u32   ("namlen",=09Opt_namelen),
+=09fsparam_u32   ("nconnect",=09Opt_nconnect),
+=09fsparam_string("nfsvers",=09Opt_vers),
+=09fsparam_u32   ("port",=09=09Opt_port),
+=09fsparam_flag_no("posix",=09Opt_posix),
+=09fsparam_string("proto",=09=09Opt_proto),
+=09fsparam_flag_no("rdirplus",=09Opt_rdirplus),
+=09fsparam_flag  ("rdma",=09=09Opt_rdma),
+=09fsparam_flag_no("resvport",=09Opt_resvport),
+=09fsparam_u32   ("retrans",=09Opt_retrans),
+=09fsparam_string("retry",=09=09Opt_retry),
+=09fsparam_u32   ("rsize",=09=09Opt_rsize),
+=09fsparam_string("sec",=09=09Opt_sec),
+=09fsparam_flag_no("sharecache",=09Opt_sharecache),
+=09fsparam_flag  ("sloppy",=09Opt_sloppy),
+=09fsparam_flag  ("soft",=09=09Opt_soft),
+=09fsparam_flag  ("softerr",=09Opt_softerr),
+=09fsparam_string("source",=09Opt_source),
+=09fsparam_flag  ("tcp",=09=09Opt_tcp),
+=09fsparam_u32   ("timeo",=09=09Opt_timeo),
+=09fsparam_flag  ("udp",=09=09Opt_udp),
+=09fsparam_flag  ("v2",=09=09Opt_v),
+=09fsparam_flag  ("v3",=09=09Opt_v),
+=09fsparam_flag  ("v4",=09=09Opt_v),
+=09fsparam_flag  ("v4.0",=09=09Opt_v),
+=09fsparam_flag  ("v4.1",=09=09Opt_v),
+=09fsparam_flag  ("v4.2",=09=09Opt_v),
+=09fsparam_string("vers",=09=09Opt_vers),
+=09fsparam_u32   ("wsize",=09=09Opt_wsize),
+=09{}
 };
=20
 enum {
-=09Opt_xprt_udp, Opt_xprt_udp6, Opt_xprt_tcp, Opt_xprt_tcp6, Opt_xprt_rdma=
,
-=09Opt_xprt_rdma6,
-
-=09Opt_xprt_err
-};
-
-static const match_table_t nfs_xprt_protocol_tokens =3D {
-=09{ Opt_xprt_udp, "udp" },
-=09{ Opt_xprt_udp6, "udp6" },
-=09{ Opt_xprt_tcp, "tcp" },
-=09{ Opt_xprt_tcp6, "tcp6" },
-=09{ Opt_xprt_rdma, "rdma" },
-=09{ Opt_xprt_rdma6, "rdma6" },
-
-=09{ Opt_xprt_err, NULL }
+=09Opt_local_lock_all,
+=09Opt_local_lock_flock,
+=09Opt_local_lock_none,
+=09Opt_local_lock_posix,
 };
=20
 enum {
-=09Opt_sec_none, Opt_sec_sys,
-=09Opt_sec_krb5, Opt_sec_krb5i, Opt_sec_krb5p,
-=09Opt_sec_lkey, Opt_sec_lkeyi, Opt_sec_lkeyp,
-=09Opt_sec_spkm, Opt_sec_spkmi, Opt_sec_spkmp,
-
-=09Opt_sec_err
+=09Opt_lookupcache_all,
+=09Opt_lookupcache_none,
+=09Opt_lookupcache_positive,
 };
=20
-static const match_table_t nfs_secflavor_tokens =3D {
-=09{ Opt_sec_none, "none" },
-=09{ Opt_sec_none, "null" },
-=09{ Opt_sec_sys, "sys" },
-
-=09{ Opt_sec_krb5, "krb5" },
-=09{ Opt_sec_krb5i, "krb5i" },
-=09{ Opt_sec_krb5p, "krb5p" },
-
-=09{ Opt_sec_lkey, "lkey" },
-=09{ Opt_sec_lkeyi, "lkeyi" },
-=09{ Opt_sec_lkeyp, "lkeyp" },
-
-=09{ Opt_sec_spkm, "spkm3" },
-=09{ Opt_sec_spkmi, "spkm3i" },
-=09{ Opt_sec_spkmp, "spkm3p" },
+static const struct fs_parameter_enum nfs_param_enums[] =3D {
+=09{ Opt_local_lock,=09"all",=09=09Opt_local_lock_all },
+=09{ Opt_local_lock,=09"flock",=09Opt_local_lock_flock },
+=09{ Opt_local_lock,=09"none",=09=09Opt_local_lock_none },
+=09{ Opt_local_lock,=09"posix",=09Opt_local_lock_posix },
+=09{ Opt_lookupcache,=09"all",=09=09Opt_lookupcache_all },
+=09{ Opt_lookupcache,=09"none",=09=09Opt_lookupcache_none },
+=09{ Opt_lookupcache,=09"pos",=09=09Opt_lookupcache_positive },
+=09{ Opt_lookupcache,=09"positive",=09Opt_lookupcache_positive },
+=09{}
+};
=20
-=09{ Opt_sec_err, NULL }
+static const struct fs_parameter_description nfs_fs_parameters =3D {
+=09.name=09=09=3D "nfs",
+=09.specs=09=09=3D nfs_param_specs,
+=09.enums=09=09=3D nfs_param_enums,
 };
=20
 enum {
-=09Opt_lookupcache_all, Opt_lookupcache_positive,
-=09Opt_lookupcache_none,
-
-=09Opt_lookupcache_err
+=09Opt_vers_2,
+=09Opt_vers_3,
+=09Opt_vers_4,
+=09Opt_vers_4_0,
+=09Opt_vers_4_1,
+=09Opt_vers_4_2,
 };
=20
-static const match_table_t nfs_lookupcache_tokens =3D {
-=09{ Opt_lookupcache_all, "all" },
-=09{ Opt_lookupcache_positive, "pos" },
-=09{ Opt_lookupcache_positive, "positive" },
-=09{ Opt_lookupcache_none, "none" },
-
-=09{ Opt_lookupcache_err, NULL }
+static const struct constant_table nfs_vers_tokens[] =3D {
+=09{ "2",=09=09Opt_vers_2 },
+=09{ "3",=09=09Opt_vers_3 },
+=09{ "4",=09=09Opt_vers_4 },
+=09{ "4.0",=09Opt_vers_4_0 },
+=09{ "4.1",=09Opt_vers_4_1 },
+=09{ "4.2",=09Opt_vers_4_2 },
 };
=20
 enum {
-=09Opt_local_lock_all, Opt_local_lock_flock, Opt_local_lock_posix,
-=09Opt_local_lock_none,
-
-=09Opt_local_lock_err
+=09Opt_xprt_rdma,
+=09Opt_xprt_rdma6,
+=09Opt_xprt_tcp,
+=09Opt_xprt_tcp6,
+=09Opt_xprt_udp,
+=09Opt_xprt_udp6,
+=09nr__Opt_xprt
 };
=20
-static const match_table_t nfs_local_lock_tokens =3D {
-=09{ Opt_local_lock_all, "all" },
-=09{ Opt_local_lock_flock, "flock" },
-=09{ Opt_local_lock_posix, "posix" },
-=09{ Opt_local_lock_none, "none" },
-
-=09{ Opt_local_lock_err, NULL }
+static const struct constant_table nfs_xprt_protocol_tokens[nr__Opt_xprt] =
=3D {
+=09{ "rdma",=09Opt_xprt_rdma },
+=09{ "rdma6",=09Opt_xprt_rdma6 },
+=09{ "tcp",=09Opt_xprt_tcp },
+=09{ "tcp6",=09Opt_xprt_tcp6 },
+=09{ "udp",=09Opt_xprt_udp },
+=09{ "udp6",=09Opt_xprt_udp6 },
 };
=20
 enum {
-=09Opt_vers_2, Opt_vers_3, Opt_vers_4, Opt_vers_4_0,
-=09Opt_vers_4_1, Opt_vers_4_2,
-
-=09Opt_vers_err
+=09Opt_sec_krb5,
+=09Opt_sec_krb5i,
+=09Opt_sec_krb5p,
+=09Opt_sec_lkey,
+=09Opt_sec_lkeyi,
+=09Opt_sec_lkeyp,
+=09Opt_sec_none,
+=09Opt_sec_spkm,
+=09Opt_sec_spkmi,
+=09Opt_sec_spkmp,
+=09Opt_sec_sys,
+=09nr__Opt_sec
 };
=20
-static const match_table_t nfs_vers_tokens =3D {
-=09{ Opt_vers_2, "2" },
-=09{ Opt_vers_3, "3" },
-=09{ Opt_vers_4, "4" },
-=09{ Opt_vers_4_0, "4.0" },
-=09{ Opt_vers_4_1, "4.1" },
-=09{ Opt_vers_4_2, "4.2" },
-
-=09{ Opt_vers_err, NULL }
+static const struct constant_table nfs_secflavor_tokens[] =3D {
+=09{ "krb5",=09Opt_sec_krb5 },
+=09{ "krb5i",=09Opt_sec_krb5i },
+=09{ "krb5p",=09Opt_sec_krb5p },
+=09{ "lkey",=09Opt_sec_lkey },
+=09{ "lkeyi",=09Opt_sec_lkeyi },
+=09{ "lkeyp",=09Opt_sec_lkeyp },
+=09{ "none",=09Opt_sec_none },
+=09{ "null",=09Opt_sec_none },
+=09{ "spkm3",=09Opt_sec_spkm },
+=09{ "spkm3i",=09Opt_sec_spkmi },
+=09{ "spkm3p",=09Opt_sec_spkmp },
+=09{ "sys",=09Opt_sec_sys },
 };
=20
 struct nfs_fs_context *nfs_alloc_parsed_mount_data(void)
@@ -368,17 +366,19 @@ static int nfs_auth_info_add(struct nfs_fs_context *c=
tx,
 /*
  * Parse the value of the 'sec=3D' option.
  */
-static int nfs_parse_security_flavors(struct nfs_fs_context *ctx, char *va=
lue)
+static int nfs_parse_security_flavors(struct nfs_fs_context *ctx,
+=09=09=09=09      struct fs_parameter *param)
 {
-=09substring_t args[MAX_OPT_ARGS];
 =09rpc_authflavor_t pseudoflavor;
-=09char *p;
+=09char *string =3D param->string, *p;
 =09int ret;
=20
-=09dfprintk(MOUNT, "NFS: parsing sec=3D%s option\n", value);
+=09dfprintk(MOUNT, "NFS: parsing %s=3D%s option\n", param->key, param->str=
ing);
=20
-=09while ((p =3D strsep(&value, ":")) !=3D NULL) {
-=09=09switch (match_token(p, nfs_secflavor_tokens, args)) {
+=09while ((p =3D strsep(&string, ":")) !=3D NULL) {
+=09=09if (!*p)
+=09=09=09continue;
+=09=09switch (lookup_constant(nfs_secflavor_tokens, p, -1)) {
 =09=09case Opt_sec_none:
 =09=09=09pseudoflavor =3D RPC_AUTH_NULL;
 =09=09=09break;
@@ -427,11 +427,10 @@ static int nfs_parse_security_flavors(struct nfs_fs_c=
ontext *ctx, char *value)
 }
=20
 static int nfs_parse_version_string(struct nfs_fs_context *ctx,
-=09=09=09=09    char *string,
-=09=09=09=09    substring_t *args)
+=09=09=09=09    const char *string)
 {
 =09ctx->flags &=3D ~NFS_MOUNT_VER3;
-=09switch (match_token(string, nfs_vers_tokens, args)) {
+=09switch (lookup_constant(nfs_vers_tokens, string, -1)) {
 =09case Opt_vers_2:
 =09=09ctx->version =3D 2;
 =09=09break;
@@ -465,64 +464,24 @@ static int nfs_parse_version_string(struct nfs_fs_con=
text *ctx,
 =09return 0;
 }
=20
-static int nfs_get_option_str(substring_t args[], char **option)
-{
-=09kfree(*option);
-=09*option =3D match_strdup(args);
-=09return !*option;
-}
-
-static int nfs_get_option_ui(struct nfs_fs_context *ctx,
-=09=09=09     substring_t args[], unsigned int *option)
-{
-=09match_strlcpy(ctx->buf, args, sizeof(ctx->buf));
-=09return kstrtouint(ctx->buf, 10, option);
-}
-
-static int nfs_get_option_ui_bound(struct nfs_fs_context *ctx,
-=09=09=09=09   substring_t args[], unsigned int *option,
-=09=09=09=09   unsigned int l_bound, unsigned u_bound)
-{
-=09int ret;
-
-=09match_strlcpy(ctx->buf, args, sizeof(ctx->buf));
-=09ret =3D kstrtouint(ctx->buf, 10, option);
-=09if (ret < 0)
-=09=09return ret;
-=09if (*option < l_bound || *option > u_bound)
-=09=09return -ERANGE;
-=09return 0;
-}
-
-static int nfs_get_option_us_bound(struct nfs_fs_context *ctx,
-=09=09=09=09   substring_t args[], unsigned short *option,
-=09=09=09=09   unsigned short l_bound,
-=09=09=09=09   unsigned short u_bound)
-{
-=09int ret;
-
-=09match_strlcpy(ctx->buf, args, sizeof(ctx->buf));
-=09ret =3D kstrtou16(ctx->buf, 10, option);
-=09if (ret < 0)
-=09=09return ret;
-=09if (*option < l_bound || *option > u_bound)
-=09=09return -ERANGE;
-=09return 0;
-}
-
 /*
- * Parse a single mount option in "key[=3Dval]" form.
+ * Parse a single mount parameter.
  */
-static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p=
)
+static int nfs_fs_context_parse_param(struct nfs_fs_context *ctx,
+=09=09=09=09      struct fs_parameter *param)
 {
-=09substring_t args[MAX_OPT_ARGS];
-=09char *string;
-=09int token, ret;
+=09struct fs_parse_result result;
+=09unsigned short protofamily, mountfamily;
+=09unsigned int len;
+=09int ret, opt;
=20
-=09dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", p);
+=09dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", param->key);
=20
-=09token =3D match_token(p, nfs_mount_option_tokens, args);
-=09switch (token) {
+=09opt =3D fs_parse(NULL, &nfs_fs_parameters, param, &result);
+=09if (opt < 0)
+=09=09return ctx->sloppy ? 1 : opt;
+
+=09switch (opt) {
 =09=09/*
 =09=09 * boolean options:  foo/nofoo
 =09=09 */
@@ -538,30 +497,31 @@ static int nfs_fs_context_parse_option(struct nfs_fs_=
context *ctx, char *p)
 =09=09ctx->flags &=3D ~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
 =09=09break;
 =09case Opt_posix:
-=09=09ctx->flags |=3D NFS_MOUNT_POSIX;
-=09=09break;
-=09case Opt_noposix:
-=09=09ctx->flags &=3D ~NFS_MOUNT_POSIX;
+=09=09if (result.negated)
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_POSIX;
+=09=09else
+=09=09=09ctx->flags |=3D NFS_MOUNT_POSIX;
 =09=09break;
 =09case Opt_cto:
-=09=09ctx->flags &=3D ~NFS_MOUNT_NOCTO;
-=09=09break;
-=09case Opt_nocto:
-=09=09ctx->flags |=3D NFS_MOUNT_NOCTO;
+=09=09if (result.negated)
+=09=09=09ctx->flags |=3D NFS_MOUNT_NOCTO;
+=09=09else
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_NOCTO;
 =09=09break;
 =09case Opt_ac:
-=09=09ctx->flags &=3D ~NFS_MOUNT_NOAC;
-=09=09break;
-=09case Opt_noac:
-=09=09ctx->flags |=3D NFS_MOUNT_NOAC;
+=09=09if (result.negated)
+=09=09=09ctx->flags |=3D NFS_MOUNT_NOAC;
+=09=09else
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_NOAC;
 =09=09break;
 =09case Opt_lock:
-=09=09ctx->flags &=3D ~NFS_MOUNT_NONLM;
-=09=09ctx->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
-=09=09break;
-=09case Opt_nolock:
-=09=09ctx->flags |=3D NFS_MOUNT_NONLM;
-=09=09ctx->flags |=3D (NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
+=09=09if (result.negated) {
+=09=09=09ctx->flags |=3D NFS_MOUNT_NONLM;
+=09=09=09ctx->flags |=3D (NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
+=09=09} else {
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_NONLM;
+=09=09=09ctx->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
+=09=09}
 =09=09break;
 =09case Opt_udp:
 =09=09ctx->flags &=3D ~NFS_MOUNT_TCP;
@@ -574,195 +534,177 @@ static int nfs_fs_context_parse_option(struct nfs_f=
s_context *ctx, char *p)
 =09case Opt_rdma:
 =09=09ctx->flags |=3D NFS_MOUNT_TCP; /* for side protocols */
 =09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_RDMA;
-=09=09xprt_load_transport(p);
+=09=09xprt_load_transport(param->key);
 =09=09break;
 =09case Opt_acl:
-=09=09ctx->flags &=3D ~NFS_MOUNT_NOACL;
-=09=09break;
-=09case Opt_noacl:
-=09=09ctx->flags |=3D NFS_MOUNT_NOACL;
+=09=09if (result.negated)
+=09=09=09ctx->flags |=3D NFS_MOUNT_NOACL;
+=09=09else
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_NOACL;
 =09=09break;
 =09case Opt_rdirplus:
-=09=09ctx->flags &=3D ~NFS_MOUNT_NORDIRPLUS;
-=09=09break;
-=09case Opt_nordirplus:
-=09=09ctx->flags |=3D NFS_MOUNT_NORDIRPLUS;
+=09=09if (result.negated)
+=09=09=09ctx->flags |=3D NFS_MOUNT_NORDIRPLUS;
+=09=09else
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_NORDIRPLUS;
 =09=09break;
 =09case Opt_sharecache:
-=09=09ctx->flags &=3D ~NFS_MOUNT_UNSHARED;
-=09=09break;
-=09case Opt_nosharecache:
-=09=09ctx->flags |=3D NFS_MOUNT_UNSHARED;
+=09=09if (result.negated)
+=09=09=09ctx->flags |=3D NFS_MOUNT_UNSHARED;
+=09=09else
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_UNSHARED;
 =09=09break;
 =09case Opt_resvport:
-=09=09ctx->flags &=3D ~NFS_MOUNT_NORESVPORT;
-=09=09break;
-=09case Opt_noresvport:
-=09=09ctx->flags |=3D NFS_MOUNT_NORESVPORT;
+=09=09if (result.negated)
+=09=09=09ctx->flags |=3D NFS_MOUNT_NORESVPORT;
+=09=09else
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_NORESVPORT;
 =09=09break;
 =09case Opt_fscache:
-=09=09ctx->options |=3D NFS_OPTION_FSCACHE;
 =09=09kfree(ctx->fscache_uniq);
-=09=09ctx->fscache_uniq =3D NULL;
-=09=09break;
-=09case Opt_nofscache:
-=09=09ctx->options &=3D ~NFS_OPTION_FSCACHE;
-=09=09kfree(ctx->fscache_uniq);
-=09=09ctx->fscache_uniq =3D NULL;
+=09=09ctx->fscache_uniq =3D param->string;
+=09=09param->string =3D NULL;
+=09=09if (result.negated)
+=09=09=09ctx->options &=3D ~NFS_OPTION_FSCACHE;
+=09=09else
+=09=09=09ctx->options |=3D NFS_OPTION_FSCACHE;
 =09=09break;
 =09case Opt_migration:
-=09=09ctx->options |=3D NFS_OPTION_MIGRATION;
-=09=09break;
-=09case Opt_nomigration:
-=09=09ctx->options &=3D ~NFS_OPTION_MIGRATION;
+=09=09if (result.negated)
+=09=09=09ctx->options &=3D ~NFS_OPTION_MIGRATION;
+=09=09else
+=09=09=09ctx->options |=3D NFS_OPTION_MIGRATION;
 =09=09break;
=20
 =09=09/*
 =09=09 * options that take numeric values
 =09=09 */
 =09case Opt_port:
-=09=09if (nfs_get_option_ui_bound(ctx, args, &ctx->nfs_server.port,
-=09=09=09=09=09    0, USHRT_MAX))
-=09=09=09goto out_invalid_value;
+=09=09if (result.uint_32 > USHRT_MAX)
+=09=09=09goto out_of_bounds;
+=09=09ctx->nfs_server.port =3D result.uint_32;
 =09=09break;
 =09case Opt_rsize:
-=09=09if (nfs_get_option_ui(ctx, args, &ctx->rsize))
-=09=09=09goto out_invalid_value;
+=09=09ctx->rsize =3D result.uint_32;
 =09=09break;
 =09case Opt_wsize:
-=09=09if (nfs_get_option_ui(ctx, args, &ctx->wsize))
-=09=09=09goto out_invalid_value;
+=09=09ctx->wsize =3D result.uint_32;
 =09=09break;
 =09case Opt_bsize:
-=09=09if (nfs_get_option_ui(ctx, args, &ctx->bsize))
-=09=09=09goto out_invalid_value;
+=09=09ctx->bsize =3D result.uint_32;
 =09=09break;
 =09case Opt_timeo:
-=09=09if (nfs_get_option_ui_bound(ctx, args, &ctx->timeo, 1, INT_MAX))
-=09=09=09goto out_invalid_value;
+=09=09if (result.uint_32 < 1 || result.uint_32 > INT_MAX)
+=09=09=09goto out_of_bounds;
+=09=09ctx->timeo =3D result.uint_32;
 =09=09break;
 =09case Opt_retrans:
-=09=09if (nfs_get_option_ui_bound(ctx, args, &ctx->retrans, 0, INT_MAX))
-=09=09=09goto out_invalid_value;
+=09=09if (result.uint_32 > INT_MAX)
+=09=09=09goto out_of_bounds;
+=09=09ctx->retrans =3D result.uint_32;
 =09=09break;
 =09case Opt_acregmin:
-=09=09if (nfs_get_option_ui(ctx, args, &ctx->acregmin))
-=09=09=09goto out_invalid_value;
+=09=09ctx->acregmin =3D result.uint_32;
 =09=09break;
 =09case Opt_acregmax:
-=09=09if (nfs_get_option_ui(ctx, args, &ctx->acregmax))
-=09=09=09goto out_invalid_value;
+=09=09ctx->acregmax =3D result.uint_32;
 =09=09break;
 =09case Opt_acdirmin:
-=09=09if (nfs_get_option_ui(ctx, args, &ctx->acdirmin))
-=09=09=09goto out_invalid_value;
+=09=09ctx->acdirmin =3D result.uint_32;
 =09=09break;
 =09case Opt_acdirmax:
-=09=09if (nfs_get_option_ui(ctx, args, &ctx->acdirmax))
-=09=09=09goto out_invalid_value;
+=09=09ctx->acdirmax =3D result.uint_32;
 =09=09break;
 =09case Opt_actimeo:
-=09=09if (nfs_get_option_ui(ctx, args, &ctx->acdirmax))
-=09=09=09goto out_invalid_value;
-=09=09ctx->acregmin =3D ctx->acregmax =3D
-=09=09=09ctx->acdirmin =3D ctx->acdirmax;
+=09=09ctx->acregmin =3D result.uint_32;
+=09=09ctx->acregmax =3D result.uint_32;
+=09=09ctx->acdirmin =3D result.uint_32;
+=09=09ctx->acdirmax =3D result.uint_32;
 =09=09break;
 =09case Opt_namelen:
-=09=09if (nfs_get_option_ui(ctx, args, &ctx->namlen))
-=09=09=09goto out_invalid_value;
+=09=09ctx->namlen =3D result.uint_32;
 =09=09break;
 =09case Opt_mountport:
-=09=09if (nfs_get_option_ui_bound(ctx, args, &ctx->mount_server.port,
-=09=09=09=09=09    0, USHRT_MAX))
-=09=09=09goto out_invalid_value;
+=09=09if (result.uint_32 > USHRT_MAX)
+=09=09=09goto out_of_bounds;
+=09=09ctx->mount_server.port =3D result.uint_32;
 =09=09break;
 =09case Opt_mountvers:
-=09=09if (nfs_get_option_ui_bound(ctx, args, &ctx->mount_server.version,
-=09=09=09=09=09    NFS_MNT_VERSION, NFS_MNT3_VERSION))
-=09=09=09goto out_invalid_value;
+=09=09if (result.uint_32 < NFS_MNT_VERSION ||
+=09=09    result.uint_32 > NFS_MNT3_VERSION)
+=09=09=09goto out_of_bounds;
+=09=09ctx->mount_server.version =3D result.uint_32;
 =09=09break;
 =09case Opt_minorversion:
-=09=09if (nfs_get_option_ui_bound(ctx, args, &ctx->minorversion,
-=09=09=09=09=09    0, NFS4_MAX_MINOR_VERSION))
-=09=09=09goto out_invalid_value;
+=09=09if (result.uint_32 > NFS4_MAX_MINOR_VERSION)
+=09=09=09goto out_of_bounds;
+=09=09ctx->minorversion =3D result.uint_32;
 =09=09break;
=20
 =09=09/*
 =09=09 * options that take text values
 =09=09 */
-=09case Opt_nfsvers:
-=09=09string =3D match_strdup(args);
-=09=09if (string =3D=3D NULL)
-=09=09=09goto out_nomem;
-=09=09ret =3D nfs_parse_version_string(ctx, string, args);
-=09=09kfree(string);
+=09case Opt_v:
+=09=09ret =3D nfs_parse_version_string(ctx, param->key + 1);
+=09=09if (ret < 0)
+=09=09=09return ret;
+=09=09break;
+=09case Opt_vers:
+=09=09ret =3D nfs_parse_version_string(ctx, param->string);
 =09=09if (ret < 0)
 =09=09=09return ret;
 =09=09break;
 =09case Opt_sec:
-=09=09string =3D match_strdup(args);
-=09=09if (string =3D=3D NULL)
-=09=09=09goto out_nomem;
-=09=09ret =3D nfs_parse_security_flavors(ctx, string);
-=09=09kfree(string);
+=09=09ret =3D nfs_parse_security_flavors(ctx, param);
 =09=09if (ret < 0)
 =09=09=09return ret;
 =09=09break;
-=09case Opt_proto:
-=09=09string =3D match_strdup(args);
-=09=09if (string =3D=3D NULL)
-=09=09=09goto out_nomem;
-=09=09token =3D match_token(string, nfs_xprt_protocol_tokens, args);
=20
-=09=09ctx->protofamily =3D AF_INET;
-=09=09switch (token) {
+=09case Opt_proto:
+=09=09protofamily =3D AF_INET;
+=09=09switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)=
) {
 =09=09case Opt_xprt_udp6:
-=09=09=09ctx->protofamily =3D AF_INET6;
+=09=09=09protofamily =3D AF_INET6;
 =09=09=09/* fall through */
 =09=09case Opt_xprt_udp:
 =09=09=09ctx->flags &=3D ~NFS_MOUNT_TCP;
 =09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
 =09=09=09break;
 =09=09case Opt_xprt_tcp6:
-=09=09=09ctx->protofamily =3D AF_INET6;
+=09=09=09protofamily =3D AF_INET6;
 =09=09=09/* fall through */
 =09=09case Opt_xprt_tcp:
 =09=09=09ctx->flags |=3D NFS_MOUNT_TCP;
 =09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
 =09=09=09break;
 =09=09case Opt_xprt_rdma6:
-=09=09=09ctx->protofamily =3D AF_INET6;
+=09=09=09protofamily =3D AF_INET6;
 =09=09=09/* fall through */
 =09=09case Opt_xprt_rdma:
 =09=09=09/* vector side protocols to TCP */
 =09=09=09ctx->flags |=3D NFS_MOUNT_TCP;
 =09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_RDMA;
-=09=09=09xprt_load_transport(string);
+=09=09=09xprt_load_transport(param->string);
 =09=09=09break;
 =09=09default:
-=09=09=09kfree(string);
 =09=09=09dfprintk(MOUNT, "NFS:   unrecognized transport protocol\n");
 =09=09=09return -EINVAL;
 =09=09}
-=09=09kfree(string);
+
+=09=09ctx->protofamily =3D protofamily;
 =09=09break;
-=09case Opt_mountproto:
-=09=09string =3D match_strdup(args);
-=09=09if (string =3D=3D NULL)
-=09=09=09goto out_nomem;
-=09=09token =3D match_token(string, nfs_xprt_protocol_tokens, args);
-=09=09kfree(string);
=20
-=09=09ctx->mountfamily =3D AF_INET;
-=09=09switch (token) {
+=09case Opt_mountproto:
+=09=09mountfamily =3D AF_INET;
+=09=09switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)=
) {
 =09=09case Opt_xprt_udp6:
-=09=09=09ctx->mountfamily =3D AF_INET6;
+=09=09=09mountfamily =3D AF_INET6;
 =09=09=09/* fall through */
 =09=09case Opt_xprt_udp:
 =09=09=09ctx->mount_server.protocol =3D XPRT_TRANSPORT_UDP;
 =09=09=09break;
 =09=09case Opt_xprt_tcp6:
-=09=09=09ctx->mountfamily =3D AF_INET6;
+=09=09=09mountfamily =3D AF_INET6;
 =09=09=09/* fall through */
 =09=09case Opt_xprt_tcp:
 =09=09=09ctx->mount_server.protocol =3D XPRT_TRANSPORT_TCP;
@@ -772,51 +714,42 @@ static int nfs_fs_context_parse_option(struct nfs_fs_=
context *ctx, char *p)
 =09=09=09dfprintk(MOUNT, "NFS:   unrecognized transport protocol\n");
 =09=09=09return -EINVAL;
 =09=09}
+=09=09ctx->mountfamily =3D mountfamily;
 =09=09break;
+
 =09case Opt_addr:
-=09=09string =3D match_strdup(args);
-=09=09if (string =3D=3D NULL)
-=09=09=09goto out_nomem;
-=09=09ctx->nfs_server.addrlen =3D
-=09=09=09rpc_pton(ctx->net, string, strlen(string),
-=09=09=09=09 &ctx->nfs_server.address,
-=09=09=09=09 sizeof(ctx->nfs_server._address));
-=09=09kfree(string);
-=09=09if (ctx->nfs_server.addrlen =3D=3D 0)
+=09=09len =3D rpc_pton(ctx->net, param->string, param->size,
+=09=09=09       &ctx->nfs_server.address,
+=09=09=09       sizeof(ctx->nfs_server._address));
+=09=09if (len =3D=3D 0)
 =09=09=09goto out_invalid_address;
+=09=09ctx->nfs_server.addrlen =3D len;
 =09=09break;
 =09case Opt_clientaddr:
-=09=09if (nfs_get_option_str(args, &ctx->client_address))
-=09=09=09goto out_nomem;
+=09=09kfree(ctx->client_address);
+=09=09ctx->client_address =3D param->string;
+=09=09param->string =3D NULL;
 =09=09break;
 =09case Opt_mounthost:
-=09=09if (nfs_get_option_str(args, &ctx->mount_server.hostname))
-=09=09=09goto out_nomem;
+=09=09kfree(ctx->mount_server.hostname);
+=09=09ctx->mount_server.hostname =3D param->string;
+=09=09param->string =3D NULL;
 =09=09break;
 =09case Opt_mountaddr:
-=09=09string =3D match_strdup(args);
-=09=09if (string =3D=3D NULL)
-=09=09=09goto out_nomem;
-=09=09ctx->mount_server.addrlen =3D
-=09=09=09rpc_pton(ctx->net, string, strlen(string),
-=09=09=09=09 &ctx->mount_server.address,
-=09=09=09=09 sizeof(ctx->mount_server._address));
-=09=09kfree(string);
-=09=09if (ctx->mount_server.addrlen =3D=3D 0)
+=09=09len =3D rpc_pton(ctx->net, param->string, param->size,
+=09=09=09       &ctx->mount_server.address,
+=09=09=09       sizeof(ctx->mount_server._address));
+=09=09if (len =3D=3D 0)
 =09=09=09goto out_invalid_address;
+=09=09ctx->mount_server.addrlen =3D len;
 =09=09break;
 =09case Opt_nconnect:
-=09=09if (nfs_get_option_us_bound(ctx, args, &ctx->nfs_server.nconnect,
-=09=09=09=09=09    1, NFS_MAX_CONNECTIONS))
-=09=09=09goto out_invalid_value;
+=09=09if (result.uint_32 < 1 || result.uint_32 > NFS_MAX_CONNECTIONS)
+=09=09=09goto out_of_bounds;
+=09=09ctx->nfs_server.nconnect =3D result.uint_32;
 =09=09break;
 =09case Opt_lookupcache:
-=09=09string =3D match_strdup(args);
-=09=09if (string =3D=3D NULL)
-=09=09=09goto out_nomem;
-=09=09token =3D match_token(string, nfs_lookupcache_tokens, args);
-=09=09kfree(string);
-=09=09switch (token) {
+=09=09switch (result.uint_32) {
 =09=09case Opt_lookupcache_all:
 =09=09=09ctx->flags &=3D ~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_C=
ACHE_NONE);
 =09=09=09break;
@@ -828,22 +761,11 @@ static int nfs_fs_context_parse_option(struct nfs_fs_=
context *ctx, char *p)
 =09=09=09ctx->flags |=3D NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CAC=
HE_NONE;
 =09=09=09break;
 =09=09default:
-=09=09=09dfprintk(MOUNT, "NFS:   invalid lookupcache argument\n");
-=09=09=09return -EINVAL;
+=09=09=09goto out_invalid_value;
 =09=09}
 =09=09break;
-=09case Opt_fscache_uniq:
-=09=09if (nfs_get_option_str(args, &ctx->fscache_uniq))
-=09=09=09goto out_nomem;
-=09=09ctx->options |=3D NFS_OPTION_FSCACHE;
-=09=09break;
 =09case Opt_local_lock:
-=09=09string =3D match_strdup(args);
-=09=09if (string =3D=3D NULL)
-=09=09=09goto out_nomem;
-=09=09token =3D match_token(string, nfs_local_lock_tokens, args);
-=09=09kfree(string);
-=09=09switch (token) {
+=09=09switch (result.uint_32) {
 =09=09case Opt_local_lock_all:
 =09=09=09ctx->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
 =09=09=09=09       NFS_MOUNT_LOCAL_FCNTL);
@@ -859,39 +781,58 @@ static int nfs_fs_context_parse_option(struct nfs_fs_=
context *ctx, char *p)
 =09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
 =09=09=09break;
 =09=09default:
-=09=09=09dfprintk(MOUNT, "NFS:=09invalid=09local_lock argument\n");
-=09=09=09return -EINVAL;
-=09=09};
+=09=09=09goto out_invalid_value;
+=09=09}
 =09=09break;
=20
 =09=09/*
 =09=09 * Special options
 =09=09 */
 =09case Opt_sloppy:
-=09=09ctx->sloppy =3D 1;
+=09=09ctx->sloppy =3D true;
 =09=09dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
 =09=09break;
-=09case Opt_userspace:
-=09case Opt_deprecated:
-=09=09dfprintk(MOUNT, "NFS:   ignoring mount option '%s'\n", p);
-=09=09break;
-
-=09default:
-=09=09dfprintk(MOUNT, "NFS:   unrecognized mount option '%s'\n", p);
-=09=09return -EINVAL;
 =09}
=20
 =09return 0;
=20
-out_invalid_address:
-=09printk(KERN_INFO "NFS: bad IP address specified: %s\n", p);
-=09return -EINVAL;
 out_invalid_value:
-=09printk(KERN_INFO "NFS: bad mount option value specified: %s\n", p);
+=09printk(KERN_INFO "NFS: Bad mount option value specified\n");
 =09return -EINVAL;
-out_nomem:
-=09printk(KERN_INFO "NFS: not enough memory to parse option\n");
-=09return -ENOMEM;
+out_invalid_address:
+=09printk(KERN_INFO "NFS: Bad IP address specified\n");
+=09return -EINVAL;
+out_of_bounds:
+=09printk(KERN_INFO "NFS: Value for '%s' out of range\n", param->key);
+=09return -ERANGE;
+}
+
+/* cribbed from generic_parse_monolithic and vfs_parse_fs_string */
+static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p=
)
+{
+=09int ret;
+=09char *key =3D p, *value;
+=09size_t v_size =3D 0;
+=09struct fs_parameter param;
+
+=09memset(&param, 0, sizeof(param));
+=09value =3D strchr(key, '=3D');
+=09if (value && value !=3D key) {
+=09=09*value++ =3D 0;
+=09=09v_size =3D strlen(value);
+=09}
+=09param.key =3D key;
+=09param.type =3D fs_value_is_flag;
+=09param.size =3D v_size;
+=09if (v_size > 0) {
+=09=09param.type =3D fs_value_is_string;
+=09=09param.string =3D kmemdup_nul(value, v_size, GFP_KERNEL);
+=09=09if (!param.string)
+=09=09=09return -ENOMEM;
+=09}
+=09ret =3D nfs_fs_context_parse_param(ctx, &param);
+=09kfree(param.string);
+=09return ret;
 }
=20
 /*
--=20
2.17.2

