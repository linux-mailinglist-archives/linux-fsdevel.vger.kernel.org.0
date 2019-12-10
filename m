Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6E3118848
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 13:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfLJMbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 07:31:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41094 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727543AbfLJMbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575981082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n9+Amg/JuGP96CgmVSVrx2hsP6YelpRgPDGtsuks6Ew=;
        b=D5GMq7lHW5gKkXHCvwkPakfAsKwULnAW/nF/XdtU5xksuxYug936hJZ6wAJcZW+m7YtS0J
        DNacRCKBrB2kebZ42q632LUieVS0k65ZviOJ7ryBoQOVFUuKLIO3mSnYWCIq+UmYLUxHnM
        X5q9f1o1+HE02uv2CDrcPnEwNpVIFnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-cgi87ErHNa2ltd2RrWoSUw-1; Tue, 10 Dec 2019 07:31:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEB01800D5F;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 642635C1B0;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id EFEFC20C35; Tue, 10 Dec 2019 07:31:15 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v6 20/27] NFS: Deindent nfs_fs_context_parse_option()
Date:   Tue, 10 Dec 2019 07:31:08 -0500
Message-Id: <20191210123115.1655-21-smayhew@redhat.com>
In-Reply-To: <20191210123115.1655-1-smayhew@redhat.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: cgi87ErHNa2ltd2RrWoSUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Deindent nfs_fs_context_parse_option().

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/fs_context.c | 739 ++++++++++++++++++++++----------------------
 1 file changed, 367 insertions(+), 372 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index a386825c3b0f..92a1e4bd9133 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -500,410 +500,405 @@ static int nfs_get_option_ul_bound(substring_t args=
[], unsigned long *option,
  */
 static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p=
)
 {
+=09substring_t args[MAX_OPT_ARGS];
+=09unsigned long option;
 =09char *string;
-=09int rc;
-
-=09{
-=09=09substring_t args[MAX_OPT_ARGS];
-=09=09unsigned long option;
-=09=09int token;
+=09int token, rc;
=20
-=09=09dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", p);
-
-=09=09token =3D match_token(p, nfs_mount_option_tokens, args);
-=09=09switch (token) {
+=09dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", p);
=20
+=09token =3D match_token(p, nfs_mount_option_tokens, args);
+=09switch (token) {
 =09=09/*
 =09=09 * boolean options:  foo/nofoo
 =09=09 */
-=09=09case Opt_soft:
-=09=09=09ctx->flags |=3D NFS_MOUNT_SOFT;
-=09=09=09ctx->flags &=3D ~NFS_MOUNT_SOFTERR;
-=09=09=09break;
-=09=09case Opt_softerr:
-=09=09=09ctx->flags |=3D NFS_MOUNT_SOFTERR;
-=09=09=09ctx->flags &=3D ~NFS_MOUNT_SOFT;
-=09=09=09break;
-=09=09case Opt_hard:
-=09=09=09ctx->flags &=3D ~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
-=09=09=09break;
-=09=09case Opt_posix:
-=09=09=09ctx->flags |=3D NFS_MOUNT_POSIX;
-=09=09=09break;
-=09=09case Opt_noposix:
-=09=09=09ctx->flags &=3D ~NFS_MOUNT_POSIX;
-=09=09=09break;
-=09=09case Opt_cto:
-=09=09=09ctx->flags &=3D ~NFS_MOUNT_NOCTO;
-=09=09=09break;
-=09=09case Opt_nocto:
-=09=09=09ctx->flags |=3D NFS_MOUNT_NOCTO;
-=09=09=09break;
-=09=09case Opt_ac:
-=09=09=09ctx->flags &=3D ~NFS_MOUNT_NOAC;
-=09=09=09break;
-=09=09case Opt_noac:
-=09=09=09ctx->flags |=3D NFS_MOUNT_NOAC;
-=09=09=09break;
-=09=09case Opt_lock:
-=09=09=09ctx->flags &=3D ~NFS_MOUNT_NONLM;
-=09=09=09ctx->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK |
-=09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
-=09=09=09break;
-=09=09case Opt_nolock:
-=09=09=09ctx->flags |=3D NFS_MOUNT_NONLM;
-=09=09=09ctx->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
-=09=09=09=09       NFS_MOUNT_LOCAL_FCNTL);
-=09=09=09break;
-=09=09case Opt_udp:
-=09=09=09ctx->flags &=3D ~NFS_MOUNT_TCP;
-=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
-=09=09=09break;
-=09=09case Opt_tcp:
-=09=09=09ctx->flags |=3D NFS_MOUNT_TCP;
-=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
-=09=09=09break;
-=09=09case Opt_rdma:
-=09=09=09ctx->flags |=3D NFS_MOUNT_TCP; /* for side protocols */
-=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_RDMA;
-=09=09=09xprt_load_transport(p);
-=09=09=09break;
-=09=09case Opt_acl:
-=09=09=09ctx->flags &=3D ~NFS_MOUNT_NOACL;
-=09=09=09break;
-=09=09case Opt_noacl:
-=09=09=09ctx->flags |=3D NFS_MOUNT_NOACL;
-=09=09=09break;
-=09=09case Opt_rdirplus:
-=09=09=09ctx->flags &=3D ~NFS_MOUNT_NORDIRPLUS;
-=09=09=09break;
-=09=09case Opt_nordirplus:
-=09=09=09ctx->flags |=3D NFS_MOUNT_NORDIRPLUS;
-=09=09=09break;
-=09=09case Opt_sharecache:
-=09=09=09ctx->flags &=3D ~NFS_MOUNT_UNSHARED;
-=09=09=09break;
-=09=09case Opt_nosharecache:
-=09=09=09ctx->flags |=3D NFS_MOUNT_UNSHARED;
-=09=09=09break;
-=09=09case Opt_resvport:
-=09=09=09ctx->flags &=3D ~NFS_MOUNT_NORESVPORT;
-=09=09=09break;
-=09=09case Opt_noresvport:
-=09=09=09ctx->flags |=3D NFS_MOUNT_NORESVPORT;
-=09=09=09break;
-=09=09case Opt_fscache:
-=09=09=09ctx->options |=3D NFS_OPTION_FSCACHE;
-=09=09=09kfree(ctx->fscache_uniq);
-=09=09=09ctx->fscache_uniq =3D NULL;
-=09=09=09break;
-=09=09case Opt_nofscache:
-=09=09=09ctx->options &=3D ~NFS_OPTION_FSCACHE;
-=09=09=09kfree(ctx->fscache_uniq);
-=09=09=09ctx->fscache_uniq =3D NULL;
-=09=09=09break;
-=09=09case Opt_migration:
-=09=09=09ctx->options |=3D NFS_OPTION_MIGRATION;
-=09=09=09break;
-=09=09case Opt_nomigration:
-=09=09=09ctx->options &=3D ~NFS_OPTION_MIGRATION;
-=09=09=09break;
+=09case Opt_soft:
+=09=09ctx->flags |=3D NFS_MOUNT_SOFT;
+=09=09ctx->flags &=3D ~NFS_MOUNT_SOFTERR;
+=09=09break;
+=09case Opt_softerr:
+=09=09ctx->flags |=3D NFS_MOUNT_SOFTERR;
+=09=09ctx->flags &=3D ~NFS_MOUNT_SOFT;
+=09=09break;
+=09case Opt_hard:
+=09=09ctx->flags &=3D ~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
+=09=09break;
+=09case Opt_posix:
+=09=09ctx->flags |=3D NFS_MOUNT_POSIX;
+=09=09break;
+=09case Opt_noposix:
+=09=09ctx->flags &=3D ~NFS_MOUNT_POSIX;
+=09=09break;
+=09case Opt_cto:
+=09=09ctx->flags &=3D ~NFS_MOUNT_NOCTO;
+=09=09break;
+=09case Opt_nocto:
+=09=09ctx->flags |=3D NFS_MOUNT_NOCTO;
+=09=09break;
+=09case Opt_ac:
+=09=09ctx->flags &=3D ~NFS_MOUNT_NOAC;
+=09=09break;
+=09case Opt_noac:
+=09=09ctx->flags |=3D NFS_MOUNT_NOAC;
+=09=09break;
+=09case Opt_lock:
+=09=09ctx->flags &=3D ~NFS_MOUNT_NONLM;
+=09=09ctx->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK |
+=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
+=09=09break;
+=09case Opt_nolock:
+=09=09ctx->flags |=3D NFS_MOUNT_NONLM;
+=09=09ctx->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
+=09=09=09       NFS_MOUNT_LOCAL_FCNTL);
+=09=09break;
+=09case Opt_udp:
+=09=09ctx->flags &=3D ~NFS_MOUNT_TCP;
+=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
+=09=09break;
+=09case Opt_tcp:
+=09=09ctx->flags |=3D NFS_MOUNT_TCP;
+=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
+=09=09break;
+=09case Opt_rdma:
+=09=09ctx->flags |=3D NFS_MOUNT_TCP; /* for side protocols */
+=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_RDMA;
+=09=09xprt_load_transport(p);
+=09=09break;
+=09case Opt_acl:
+=09=09ctx->flags &=3D ~NFS_MOUNT_NOACL;
+=09=09break;
+=09case Opt_noacl:
+=09=09ctx->flags |=3D NFS_MOUNT_NOACL;
+=09=09break;
+=09case Opt_rdirplus:
+=09=09ctx->flags &=3D ~NFS_MOUNT_NORDIRPLUS;
+=09=09break;
+=09case Opt_nordirplus:
+=09=09ctx->flags |=3D NFS_MOUNT_NORDIRPLUS;
+=09=09break;
+=09case Opt_sharecache:
+=09=09ctx->flags &=3D ~NFS_MOUNT_UNSHARED;
+=09=09break;
+=09case Opt_nosharecache:
+=09=09ctx->flags |=3D NFS_MOUNT_UNSHARED;
+=09=09break;
+=09case Opt_resvport:
+=09=09ctx->flags &=3D ~NFS_MOUNT_NORESVPORT;
+=09=09break;
+=09case Opt_noresvport:
+=09=09ctx->flags |=3D NFS_MOUNT_NORESVPORT;
+=09=09break;
+=09case Opt_fscache:
+=09=09ctx->options |=3D NFS_OPTION_FSCACHE;
+=09=09kfree(ctx->fscache_uniq);
+=09=09ctx->fscache_uniq =3D NULL;
+=09=09break;
+=09case Opt_nofscache:
+=09=09ctx->options &=3D ~NFS_OPTION_FSCACHE;
+=09=09kfree(ctx->fscache_uniq);
+=09=09ctx->fscache_uniq =3D NULL;
+=09=09break;
+=09case Opt_migration:
+=09=09ctx->options |=3D NFS_OPTION_MIGRATION;
+=09=09break;
+=09case Opt_nomigration:
+=09=09ctx->options &=3D ~NFS_OPTION_MIGRATION;
+=09=09break;
=20
 =09=09/*
 =09=09 * options that take numeric values
 =09=09 */
-=09=09case Opt_port:
-=09=09=09if (nfs_get_option_ul(args, &option) ||
-=09=09=09    option > USHRT_MAX)
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->nfs_server.port =3D option;
-=09=09=09break;
-=09=09case Opt_rsize:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->rsize =3D option;
-=09=09=09break;
-=09=09case Opt_wsize:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->wsize =3D option;
-=09=09=09break;
-=09=09case Opt_bsize:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->bsize =3D option;
-=09=09=09break;
-=09=09case Opt_timeo:
-=09=09=09if (nfs_get_option_ul_bound(args, &option, 1, INT_MAX))
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->timeo =3D option;
-=09=09=09break;
-=09=09case Opt_retrans:
-=09=09=09if (nfs_get_option_ul_bound(args, &option, 0, INT_MAX))
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->retrans =3D option;
-=09=09=09break;
-=09=09case Opt_acregmin:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->acregmin =3D option;
-=09=09=09break;
-=09=09case Opt_acregmax:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->acregmax =3D option;
-=09=09=09break;
-=09=09case Opt_acdirmin:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->acdirmin =3D option;
-=09=09=09break;
-=09=09case Opt_acdirmax:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->acdirmax =3D option;
-=09=09=09break;
-=09=09case Opt_actimeo:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->acregmin =3D ctx->acregmax =3D
+=09case Opt_port:
+=09=09if (nfs_get_option_ul(args, &option) ||
+=09=09    option > USHRT_MAX)
+=09=09=09goto out_invalid_value;
+=09=09ctx->nfs_server.port =3D option;
+=09=09break;
+=09case Opt_rsize:
+=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09goto out_invalid_value;
+=09=09ctx->rsize =3D option;
+=09=09break;
+=09case Opt_wsize:
+=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09goto out_invalid_value;
+=09=09ctx->wsize =3D option;
+=09=09break;
+=09case Opt_bsize:
+=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09goto out_invalid_value;
+=09=09ctx->bsize =3D option;
+=09=09break;
+=09case Opt_timeo:
+=09=09if (nfs_get_option_ul_bound(args, &option, 1, INT_MAX))
+=09=09=09goto out_invalid_value;
+=09=09ctx->timeo =3D option;
+=09=09break;
+=09case Opt_retrans:
+=09=09if (nfs_get_option_ul_bound(args, &option, 0, INT_MAX))
+=09=09=09goto out_invalid_value;
+=09=09ctx->retrans =3D option;
+=09=09break;
+=09case Opt_acregmin:
+=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09goto out_invalid_value;
+=09=09ctx->acregmin =3D option;
+=09=09break;
+=09case Opt_acregmax:
+=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09goto out_invalid_value;
+=09=09ctx->acregmax =3D option;
+=09=09break;
+=09case Opt_acdirmin:
+=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09goto out_invalid_value;
+=09=09ctx->acdirmin =3D option;
+=09=09break;
+=09case Opt_acdirmax:
+=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09goto out_invalid_value;
+=09=09ctx->acdirmax =3D option;
+=09=09break;
+=09case Opt_actimeo:
+=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09goto out_invalid_value;
+=09=09ctx->acregmin =3D ctx->acregmax =3D
 =09=09=09ctx->acdirmin =3D ctx->acdirmax =3D option;
-=09=09=09break;
-=09=09case Opt_namelen:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->namlen =3D option;
-=09=09=09break;
-=09=09case Opt_mountport:
-=09=09=09if (nfs_get_option_ul(args, &option) ||
-=09=09=09    option > USHRT_MAX)
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->mount_server.port =3D option;
-=09=09=09break;
-=09=09case Opt_mountvers:
-=09=09=09if (nfs_get_option_ul(args, &option) ||
-=09=09=09    option < NFS_MNT_VERSION ||
-=09=09=09    option > NFS_MNT3_VERSION)
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->mount_server.version =3D option;
-=09=09=09break;
-=09=09case Opt_minorversion:
-=09=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09=09goto out_invalid_value;
-=09=09=09if (option > NFS4_MAX_MINOR_VERSION)
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->minorversion =3D option;
-=09=09=09break;
+=09=09break;
+=09case Opt_namelen:
+=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09goto out_invalid_value;
+=09=09ctx->namlen =3D option;
+=09=09break;
+=09case Opt_mountport:
+=09=09if (nfs_get_option_ul(args, &option) ||
+=09=09    option > USHRT_MAX)
+=09=09=09goto out_invalid_value;
+=09=09ctx->mount_server.port =3D option;
+=09=09break;
+=09case Opt_mountvers:
+=09=09if (nfs_get_option_ul(args, &option) ||
+=09=09    option < NFS_MNT_VERSION ||
+=09=09    option > NFS_MNT3_VERSION)
+=09=09=09goto out_invalid_value;
+=09=09ctx->mount_server.version =3D option;
+=09=09break;
+=09case Opt_minorversion:
+=09=09if (nfs_get_option_ul(args, &option))
+=09=09=09goto out_invalid_value;
+=09=09if (option > NFS4_MAX_MINOR_VERSION)
+=09=09=09goto out_invalid_value;
+=09=09ctx->minorversion =3D option;
+=09=09break;
=20
 =09=09/*
 =09=09 * options that take text values
 =09=09 */
-=09=09case Opt_nfsvers:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09rc =3D nfs_parse_version_string(string, ctx, args);
-=09=09=09kfree(string);
-=09=09=09if (!rc)
-=09=09=09=09goto out_invalid_value;
+=09case Opt_nfsvers:
+=09=09string =3D match_strdup(args);
+=09=09if (string =3D=3D NULL)
+=09=09=09goto out_nomem;
+=09=09rc =3D nfs_parse_version_string(string, ctx, args);
+=09=09kfree(string);
+=09=09if (!rc)
+=09=09=09goto out_invalid_value;
+=09=09break;
+=09case Opt_sec:
+=09=09string =3D match_strdup(args);
+=09=09if (string =3D=3D NULL)
+=09=09=09goto out_nomem;
+=09=09rc =3D nfs_parse_security_flavors(string, ctx);
+=09=09kfree(string);
+=09=09if (!rc) {
+=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
+=09=09=09=09 "security flavor\n");
+=09=09=09return -EINVAL;
+=09=09}
+=09=09break;
+=09case Opt_proto:
+=09=09string =3D match_strdup(args);
+=09=09if (string =3D=3D NULL)
+=09=09=09goto out_nomem;
+=09=09token =3D match_token(string,
+=09=09=09=09    nfs_xprt_protocol_tokens, args);
+
+=09=09ctx->protofamily =3D AF_INET;
+=09=09switch (token) {
+=09=09case Opt_xprt_udp6:
+=09=09=09ctx->protofamily =3D AF_INET6;
+=09=09=09/* fall through */
+=09=09case Opt_xprt_udp:
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_TCP;
+=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
 =09=09=09break;
-=09=09case Opt_sec:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09rc =3D nfs_parse_security_flavors(string, ctx);
-=09=09=09kfree(string);
-=09=09=09if (!rc) {
-=09=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
-=09=09=09=09=09=09"security flavor\n");
-=09=09=09=09return -EINVAL;
-=09=09=09}
+=09=09case Opt_xprt_tcp6:
+=09=09=09ctx->protofamily =3D AF_INET6;
+=09=09=09/* fall through */
+=09=09case Opt_xprt_tcp:
+=09=09=09ctx->flags |=3D NFS_MOUNT_TCP;
+=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
 =09=09=09break;
-=09=09case Opt_proto:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09token =3D match_token(string,
-=09=09=09=09=09    nfs_xprt_protocol_tokens, args);
-
-=09=09=09ctx->protofamily =3D AF_INET;
-=09=09=09switch (token) {
-=09=09=09case Opt_xprt_udp6:
-=09=09=09=09ctx->protofamily =3D AF_INET6;
-=09=09=09=09/* fall through */
-=09=09=09case Opt_xprt_udp:
-=09=09=09=09ctx->flags &=3D ~NFS_MOUNT_TCP;
-=09=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
-=09=09=09=09break;
-=09=09=09case Opt_xprt_tcp6:
-=09=09=09=09ctx->protofamily =3D AF_INET6;
-=09=09=09=09/* fall through */
-=09=09=09case Opt_xprt_tcp:
-=09=09=09=09ctx->flags |=3D NFS_MOUNT_TCP;
-=09=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
-=09=09=09=09break;
-=09=09=09case Opt_xprt_rdma6:
-=09=09=09=09ctx->protofamily =3D AF_INET6;
-=09=09=09=09/* fall through */
-=09=09=09case Opt_xprt_rdma:
-=09=09=09=09/* vector side protocols to TCP */
-=09=09=09=09ctx->flags |=3D NFS_MOUNT_TCP;
-=09=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_RDMA;
-=09=09=09=09xprt_load_transport(string);
-=09=09=09=09break;
-=09=09=09default:
-=09=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
-=09=09=09=09=09=09"transport protocol\n");
-=09=09=09=09kfree(string);
-=09=09=09=09return -EINVAL;
-=09=09=09}
-=09=09=09kfree(string);
+=09=09case Opt_xprt_rdma6:
+=09=09=09ctx->protofamily =3D AF_INET6;
+=09=09=09/* fall through */
+=09=09case Opt_xprt_rdma:
+=09=09=09/* vector side protocols to TCP */
+=09=09=09ctx->flags |=3D NFS_MOUNT_TCP;
+=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_RDMA;
+=09=09=09xprt_load_transport(string);
 =09=09=09break;
-=09=09case Opt_mountproto:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09token =3D match_token(string,
-=09=09=09=09=09    nfs_xprt_protocol_tokens, args);
+=09=09default:
+=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
+=09=09=09=09 "transport protocol\n");
 =09=09=09kfree(string);
+=09=09=09return -EINVAL;
+=09=09}
+=09=09kfree(string);
+=09=09break;
+=09case Opt_mountproto:
+=09=09string =3D match_strdup(args);
+=09=09if (string =3D=3D NULL)
+=09=09=09goto out_nomem;
+=09=09token =3D match_token(string,
+=09=09=09=09    nfs_xprt_protocol_tokens, args);
+=09=09kfree(string);
=20
-=09=09=09ctx->mountfamily =3D AF_INET;
-=09=09=09switch (token) {
-=09=09=09case Opt_xprt_udp6:
-=09=09=09=09ctx->mountfamily =3D AF_INET6;
-=09=09=09=09/* fall through */
-=09=09=09case Opt_xprt_udp:
-=09=09=09=09ctx->mount_server.protocol =3D XPRT_TRANSPORT_UDP;
-=09=09=09=09break;
-=09=09=09case Opt_xprt_tcp6:
-=09=09=09=09ctx->mountfamily =3D AF_INET6;
-=09=09=09=09/* fall through */
-=09=09=09case Opt_xprt_tcp:
-=09=09=09=09ctx->mount_server.protocol =3D XPRT_TRANSPORT_TCP;
-=09=09=09=09break;
-=09=09=09case Opt_xprt_rdma: /* not used for side protocols */
-=09=09=09default:
-=09=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
-=09=09=09=09=09=09"transport protocol\n");
-=09=09=09=09return -EINVAL;
-=09=09=09}
-=09=09=09break;
-=09=09case Opt_addr:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09ctx->nfs_server.addrlen =3D
-=09=09=09=09rpc_pton(ctx->net, string, strlen(string),
-=09=09=09=09=09(struct sockaddr *)
-=09=09=09=09=09&ctx->nfs_server.address,
-=09=09=09=09=09sizeof(ctx->nfs_server.address));
-=09=09=09kfree(string);
-=09=09=09if (ctx->nfs_server.addrlen =3D=3D 0)
-=09=09=09=09goto out_invalid_address;
-=09=09=09break;
-=09=09case Opt_clientaddr:
-=09=09=09if (nfs_get_option_str(args, &ctx->client_address))
-=09=09=09=09goto out_nomem;
+=09=09ctx->mountfamily =3D AF_INET;
+=09=09switch (token) {
+=09=09case Opt_xprt_udp6:
+=09=09=09ctx->mountfamily =3D AF_INET6;
+=09=09=09/* fall through */
+=09=09case Opt_xprt_udp:
+=09=09=09ctx->mount_server.protocol =3D XPRT_TRANSPORT_UDP;
+=09=09=09break;
+=09=09case Opt_xprt_tcp6:
+=09=09=09ctx->mountfamily =3D AF_INET6;
+=09=09=09/* fall through */
+=09=09case Opt_xprt_tcp:
+=09=09=09ctx->mount_server.protocol =3D XPRT_TRANSPORT_TCP;
+=09=09=09break;
+=09=09case Opt_xprt_rdma: /* not used for side protocols */
+=09=09default:
+=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
+=09=09=09=09 "transport protocol\n");
+=09=09=09return -EINVAL;
+=09=09}
+=09=09break;
+=09case Opt_addr:
+=09=09string =3D match_strdup(args);
+=09=09if (string =3D=3D NULL)
+=09=09=09goto out_nomem;
+=09=09ctx->nfs_server.addrlen =3D
+=09=09=09rpc_pton(ctx->net, string, strlen(string),
+=09=09=09=09 (struct sockaddr *)
+=09=09=09=09 &ctx->nfs_server.address,
+=09=09=09=09 sizeof(ctx->nfs_server.address));
+=09=09kfree(string);
+=09=09if (ctx->nfs_server.addrlen =3D=3D 0)
+=09=09=09goto out_invalid_address;
+=09=09break;
+=09case Opt_clientaddr:
+=09=09if (nfs_get_option_str(args, &ctx->client_address))
+=09=09=09goto out_nomem;
+=09=09break;
+=09case Opt_mounthost:
+=09=09if (nfs_get_option_str(args,
+=09=09=09=09       &ctx->mount_server.hostname))
+=09=09=09goto out_nomem;
+=09=09break;
+=09case Opt_mountaddr:
+=09=09string =3D match_strdup(args);
+=09=09if (string =3D=3D NULL)
+=09=09=09goto out_nomem;
+=09=09ctx->mount_server.addrlen =3D
+=09=09=09rpc_pton(ctx->net, string, strlen(string),
+=09=09=09=09 (struct sockaddr *)
+=09=09=09=09 &ctx->mount_server.address,
+=09=09=09=09 sizeof(ctx->mount_server.address));
+=09=09kfree(string);
+=09=09if (ctx->mount_server.addrlen =3D=3D 0)
+=09=09=09goto out_invalid_address;
+=09=09break;
+=09case Opt_nconnect:
+=09=09if (nfs_get_option_ul_bound(args, &option, 1, NFS_MAX_CONNECTIONS))
+=09=09=09goto out_invalid_value;
+=09=09ctx->nfs_server.nconnect =3D option;
+=09=09break;
+=09case Opt_lookupcache:
+=09=09string =3D match_strdup(args);
+=09=09if (string =3D=3D NULL)
+=09=09=09goto out_nomem;
+=09=09token =3D match_token(string,
+=09=09=09=09    nfs_lookupcache_tokens, args);
+=09=09kfree(string);
+=09=09switch (token) {
+=09=09case Opt_lookupcache_all:
+=09=09=09ctx->flags &=3D ~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_C=
ACHE_NONE);
 =09=09=09break;
-=09=09case Opt_mounthost:
-=09=09=09if (nfs_get_option_str(args,
-=09=09=09=09=09       &ctx->mount_server.hostname))
-=09=09=09=09goto out_nomem;
+=09=09case Opt_lookupcache_positive:
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_LOOKUP_CACHE_NONE;
+=09=09=09ctx->flags |=3D NFS_MOUNT_LOOKUP_CACHE_NONEG;
 =09=09=09break;
-=09=09case Opt_mountaddr:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09ctx->mount_server.addrlen =3D
-=09=09=09=09rpc_pton(ctx->net, string, strlen(string),
-=09=09=09=09=09(struct sockaddr *)
-=09=09=09=09=09&ctx->mount_server.address,
-=09=09=09=09=09sizeof(ctx->mount_server.address));
-=09=09=09kfree(string);
-=09=09=09if (ctx->mount_server.addrlen =3D=3D 0)
-=09=09=09=09goto out_invalid_address;
+=09=09case Opt_lookupcache_none:
+=09=09=09ctx->flags |=3D NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CAC=
HE_NONE;
 =09=09=09break;
-=09=09case Opt_nconnect:
-=09=09=09if (nfs_get_option_ul_bound(args, &option, 1, NFS_MAX_CONNECTIONS=
))
-=09=09=09=09goto out_invalid_value;
-=09=09=09ctx->nfs_server.nconnect =3D option;
+=09=09default:
+=09=09=09dfprintk(MOUNT, "NFS:   invalid "
+=09=09=09=09 "lookupcache argument\n");
+=09=09=09return -EINVAL;
+=09=09}
+=09=09break;
+=09case Opt_fscache_uniq:
+=09=09if (nfs_get_option_str(args, &ctx->fscache_uniq))
+=09=09=09goto out_nomem;
+=09=09ctx->options |=3D NFS_OPTION_FSCACHE;
+=09=09break;
+=09case Opt_local_lock:
+=09=09string =3D match_strdup(args);
+=09=09if (string =3D=3D NULL)
+=09=09=09goto out_nomem;
+=09=09token =3D match_token(string, nfs_local_lock_tokens,
+=09=09=09=09    args);
+=09=09kfree(string);
+=09=09switch (token) {
+=09=09case Opt_local_lock_all:
+=09=09=09ctx->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
+=09=09=09=09       NFS_MOUNT_LOCAL_FCNTL);
 =09=09=09break;
-=09=09case Opt_lookupcache:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09token =3D match_token(string,
-=09=09=09=09=09nfs_lookupcache_tokens, args);
-=09=09=09kfree(string);
-=09=09=09switch (token) {
-=09=09=09=09case Opt_lookupcache_all:
-=09=09=09=09=09ctx->flags &=3D ~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LO=
OKUP_CACHE_NONE);
-=09=09=09=09=09break;
-=09=09=09=09case Opt_lookupcache_positive:
-=09=09=09=09=09ctx->flags &=3D ~NFS_MOUNT_LOOKUP_CACHE_NONE;
-=09=09=09=09=09ctx->flags |=3D NFS_MOUNT_LOOKUP_CACHE_NONEG;
-=09=09=09=09=09break;
-=09=09=09=09case Opt_lookupcache_none:
-=09=09=09=09=09ctx->flags |=3D NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOK=
UP_CACHE_NONE;
-=09=09=09=09=09break;
-=09=09=09=09default:
-=09=09=09=09=09dfprintk(MOUNT, "NFS:   invalid "
-=09=09=09=09=09=09=09"lookupcache argument\n");
-=09=09=09=09=09return -EINVAL;
-=09=09=09}
+=09=09case Opt_local_lock_flock:
+=09=09=09ctx->flags |=3D NFS_MOUNT_LOCAL_FLOCK;
 =09=09=09break;
-=09=09case Opt_fscache_uniq:
-=09=09=09if (nfs_get_option_str(args, &ctx->fscache_uniq))
-=09=09=09=09goto out_nomem;
-=09=09=09ctx->options |=3D NFS_OPTION_FSCACHE;
+=09=09case Opt_local_lock_posix:
+=09=09=09ctx->flags |=3D NFS_MOUNT_LOCAL_FCNTL;
 =09=09=09break;
-=09=09case Opt_local_lock:
-=09=09=09string =3D match_strdup(args);
-=09=09=09if (string =3D=3D NULL)
-=09=09=09=09goto out_nomem;
-=09=09=09token =3D match_token(string, nfs_local_lock_tokens,
-=09=09=09=09=09args);
-=09=09=09kfree(string);
-=09=09=09switch (token) {
-=09=09=09case Opt_local_lock_all:
-=09=09=09=09ctx->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
-=09=09=09=09=09       NFS_MOUNT_LOCAL_FCNTL);
-=09=09=09=09break;
-=09=09=09case Opt_local_lock_flock:
-=09=09=09=09ctx->flags |=3D NFS_MOUNT_LOCAL_FLOCK;
-=09=09=09=09break;
-=09=09=09case Opt_local_lock_posix:
-=09=09=09=09ctx->flags |=3D NFS_MOUNT_LOCAL_FCNTL;
-=09=09=09=09break;
-=09=09=09case Opt_local_lock_none:
-=09=09=09=09ctx->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK |
-=09=09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
-=09=09=09=09break;
-=09=09=09default:
-=09=09=09=09dfprintk(MOUNT, "NFS:=09invalid=09"
-=09=09=09=09=09=09"local_lock argument\n");
-=09=09=09=09return -EINVAL;
-=09=09=09}
+=09=09case Opt_local_lock_none:
+=09=09=09ctx->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK |
+=09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
 =09=09=09break;
+=09=09default:
+=09=09=09dfprintk(MOUNT, "NFS:=09invalid=09"
+=09=09=09=09 "local_lock argument\n");
+=09=09=09return -EINVAL;
+=09=09}
+=09=09break;
=20
 =09=09/*
 =09=09 * Special options
 =09=09 */
-=09=09case Opt_sloppy:
-=09=09=09ctx->sloppy =3D 1;
-=09=09=09dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
-=09=09=09break;
-=09=09case Opt_userspace:
-=09=09case Opt_deprecated:
-=09=09=09dfprintk(MOUNT, "NFS:   ignoring mount option "
-=09=09=09=09=09"'%s'\n", p);
-=09=09=09break;
+=09case Opt_sloppy:
+=09=09ctx->sloppy =3D 1;
+=09=09dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
+=09=09break;
+=09case Opt_userspace:
+=09case Opt_deprecated:
+=09=09dfprintk(MOUNT, "NFS:   ignoring mount option "
+=09=09=09 "'%s'\n", p);
+=09=09break;
=20
-=09=09default:
-=09=09=09dfprintk(MOUNT, "NFS:   unrecognized mount option "
-=09=09=09=09=09"'%s'\n", p);
-=09=09=09return -EINVAL;
-=09=09}
+=09default:
+=09=09dfprintk(MOUNT, "NFS:   unrecognized mount option "
+=09=09=09 "'%s'\n", p);
+=09=09return -EINVAL;
 =09}
=20
 =09return 0;
--=20
2.17.2

