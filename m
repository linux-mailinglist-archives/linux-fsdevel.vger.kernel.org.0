Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA2103EB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfKTPaN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:30:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52934 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729076AbfKTP16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574263675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/g4mKB1A+0qGl2CwqwoxmDuIgJawS6KVR/x3rip36K4=;
        b=P+CKRiX3S9bQ/uTO3l9pnDnxfHu7t+jCfcrdUK09vOqobm4QX6NbioJv8DN+9lxZKNli6M
        XxE7BkroObLQ2TSekwDzCGIPm5dJ6sTmZi5oCfWDSdsR+By391n5aKOmw8310LVKBEjiZZ
        tJfg9dLBsO6qcLmmPrYf75c8hg02E2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-DmfTI0NbO3-wY2O6mPbbqQ-1; Wed, 20 Nov 2019 10:27:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EED3A107ACC9;
        Wed, 20 Nov 2019 15:27:52 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2DB846E76;
        Wed, 20 Nov 2019 15:27:52 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 8E72820A3B; Wed, 20 Nov 2019 10:27:50 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 21/27] NFS: Add a small buffer in nfs_fs_context to avoid string dup
Date:   Wed, 20 Nov 2019 10:27:44 -0500
Message-Id: <20191120152750.6880-22-smayhew@redhat.com>
In-Reply-To: <20191120152750.6880-1-smayhew@redhat.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: DmfTI0NbO3-wY2O6mPbbqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Add a small buffer in nfs_fs_context to avoid string duplication when
parsing numbers.  Also make the parsing function wrapper place the parsed
integer directly in the appropriate nfs_fs_context struct member.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/fs_context.c | 98 +++++++++++++++++++++------------------------
 fs/nfs/internal.h   |  2 +
 2 files changed, 48 insertions(+), 52 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index e2b584354731..ad502b37a3f3 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -468,27 +468,38 @@ static int nfs_get_option_str(substring_t args[], cha=
r **option)
 =09return !*option;
 }
=20
-static int nfs_get_option_ul(substring_t args[], unsigned long *option)
+static int nfs_get_option_ui(struct nfs_fs_context *ctx,
+=09=09=09     substring_t args[], unsigned int *option)
 {
-=09int rc;
-=09char *string;
+=09match_strlcpy(ctx->buf, args, sizeof(ctx->buf));
+=09return kstrtouint(ctx->buf, 10, option);
+}
=20
-=09string =3D match_strdup(args);
-=09if (string =3D=3D NULL)
-=09=09return -ENOMEM;
-=09rc =3D kstrtoul(string, 10, option);
-=09kfree(string);
+static int nfs_get_option_ui_bound(struct nfs_fs_context *ctx,
+=09=09=09=09   substring_t args[], unsigned int *option,
+=09=09=09=09   unsigned int l_bound, unsigned u_bound)
+{
+=09int ret;
=20
-=09return rc;
+=09match_strlcpy(ctx->buf, args, sizeof(ctx->buf));
+=09ret =3D kstrtouint(ctx->buf, 10, option);
+=09if (ret < 0)
+=09=09return ret;
+=09if (*option < l_bound || *option > u_bound)
+=09=09return -ERANGE;
+=09return 0;
 }
=20
-static int nfs_get_option_ul_bound(substring_t args[], unsigned long *opti=
on,
-=09=09unsigned long l_bound, unsigned long u_bound)
+static int nfs_get_option_us_bound(struct nfs_fs_context *ctx,
+=09=09=09=09   substring_t args[], unsigned short *option,
+=09=09=09=09   unsigned short l_bound,
+=09=09=09=09   unsigned short u_bound)
 {
 =09int ret;
=20
-=09ret =3D nfs_get_option_ul(args, option);
-=09if (ret !=3D 0)
+=09match_strlcpy(ctx->buf, args, sizeof(ctx->buf));
+=09ret =3D kstrtou16(ctx->buf, 10, option);
+=09if (ret < 0)
 =09=09return ret;
 =09if (*option < l_bound || *option > u_bound)
 =09=09return -ERANGE;
@@ -501,7 +512,6 @@ static int nfs_get_option_ul_bound(substring_t args[], =
unsigned long *option,
 static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p=
)
 {
 =09substring_t args[MAX_OPT_ARGS];
-=09unsigned long option;
 =09char *string;
 =09int token, rc;
=20
@@ -609,86 +619,70 @@ static int nfs_fs_context_parse_option(struct nfs_fs_=
context *ctx, char *p)
 =09=09 * options that take numeric values
 =09=09 */
 =09case Opt_port:
-=09=09if (nfs_get_option_ul(args, &option) ||
-=09=09    option > USHRT_MAX)
+=09=09if (nfs_get_option_ui_bound(ctx, args, &ctx->nfs_server.port,
+=09=09=09=09=09    0, USHRT_MAX))
 =09=09=09goto out_invalid_value;
-=09=09ctx->nfs_server.port =3D option;
 =09=09break;
 =09case Opt_rsize:
-=09=09if (nfs_get_option_ul(args, &option))
+=09=09if (nfs_get_option_ui(ctx, args, &ctx->rsize))
 =09=09=09goto out_invalid_value;
-=09=09ctx->rsize =3D option;
 =09=09break;
 =09case Opt_wsize:
-=09=09if (nfs_get_option_ul(args, &option))
+=09=09if (nfs_get_option_ui(ctx, args, &ctx->wsize))
 =09=09=09goto out_invalid_value;
-=09=09ctx->wsize =3D option;
 =09=09break;
 =09case Opt_bsize:
-=09=09if (nfs_get_option_ul(args, &option))
+=09=09if (nfs_get_option_ui(ctx, args, &ctx->bsize))
 =09=09=09goto out_invalid_value;
-=09=09ctx->bsize =3D option;
 =09=09break;
 =09case Opt_timeo:
-=09=09if (nfs_get_option_ul_bound(args, &option, 1, INT_MAX))
+=09=09if (nfs_get_option_ui_bound(ctx, args, &ctx->timeo, 1, INT_MAX))
 =09=09=09goto out_invalid_value;
-=09=09ctx->timeo =3D option;
 =09=09break;
 =09case Opt_retrans:
-=09=09if (nfs_get_option_ul_bound(args, &option, 0, INT_MAX))
+=09=09if (nfs_get_option_ui_bound(ctx, args, &ctx->retrans, 0, INT_MAX))
 =09=09=09goto out_invalid_value;
-=09=09ctx->retrans =3D option;
 =09=09break;
 =09case Opt_acregmin:
-=09=09if (nfs_get_option_ul(args, &option))
+=09=09if (nfs_get_option_ui(ctx, args, &ctx->acregmin))
 =09=09=09goto out_invalid_value;
-=09=09ctx->acregmin =3D option;
 =09=09break;
 =09case Opt_acregmax:
-=09=09if (nfs_get_option_ul(args, &option))
+=09=09if (nfs_get_option_ui(ctx, args, &ctx->acregmax))
 =09=09=09goto out_invalid_value;
-=09=09ctx->acregmax =3D option;
 =09=09break;
 =09case Opt_acdirmin:
-=09=09if (nfs_get_option_ul(args, &option))
+=09=09if (nfs_get_option_ui(ctx, args, &ctx->acdirmin))
 =09=09=09goto out_invalid_value;
-=09=09ctx->acdirmin =3D option;
 =09=09break;
 =09case Opt_acdirmax:
-=09=09if (nfs_get_option_ul(args, &option))
+=09=09if (nfs_get_option_ui(ctx, args, &ctx->acdirmax))
 =09=09=09goto out_invalid_value;
-=09=09ctx->acdirmax =3D option;
 =09=09break;
 =09case Opt_actimeo:
-=09=09if (nfs_get_option_ul(args, &option))
+=09=09if (nfs_get_option_ui(ctx, args, &ctx->acdirmax))
 =09=09=09goto out_invalid_value;
 =09=09ctx->acregmin =3D ctx->acregmax =3D
-=09=09=09ctx->acdirmin =3D ctx->acdirmax =3D option;
+=09=09=09ctx->acdirmin =3D ctx->acdirmax;
 =09=09break;
 =09case Opt_namelen:
-=09=09if (nfs_get_option_ul(args, &option))
+=09=09if (nfs_get_option_ui(ctx, args, &ctx->namlen))
 =09=09=09goto out_invalid_value;
-=09=09ctx->namlen =3D option;
 =09=09break;
 =09case Opt_mountport:
-=09=09if (nfs_get_option_ul(args, &option) ||
-=09=09    option > USHRT_MAX)
+=09=09if (nfs_get_option_ui_bound(ctx, args, &ctx->mount_server.port,
+=09=09=09=09=09    0, USHRT_MAX))
 =09=09=09goto out_invalid_value;
-=09=09ctx->mount_server.port =3D option;
 =09=09break;
 =09case Opt_mountvers:
-=09=09if (nfs_get_option_ul(args, &option) ||
-=09=09    option < NFS_MNT_VERSION ||
-=09=09    option > NFS_MNT3_VERSION)
+=09=09if (nfs_get_option_ui_bound(ctx, args, &ctx->mount_server.version,
+=09=09=09=09=09    NFS_MNT_VERSION, NFS_MNT3_VERSION))
 =09=09=09goto out_invalid_value;
-=09=09ctx->mount_server.version =3D option;
 =09=09break;
 =09case Opt_minorversion:
-=09=09if (nfs_get_option_ul(args, &option))
-=09=09=09goto out_invalid_value;
-=09=09if (option > NFS4_MAX_MINOR_VERSION)
+=09=09if (nfs_get_option_ui_bound(ctx, args, &ctx->minorversion,
+=09=09=09=09=09    0, NFS4_MAX_MINOR_VERSION))
 =09=09=09goto out_invalid_value;
-=09=09ctx->minorversion =3D option;
 =09=09break;
=20
 =09=09/*
@@ -820,9 +814,9 @@ static int nfs_fs_context_parse_option(struct nfs_fs_co=
ntext *ctx, char *p)
 =09=09=09goto out_invalid_address;
 =09=09break;
 =09case Opt_nconnect:
-=09=09if (nfs_get_option_ul_bound(args, &option, 1, NFS_MAX_CONNECTIONS))
+=09=09if (nfs_get_option_us_bound(ctx, args, &ctx->nfs_server.nconnect,
+=09=09=09=09=09    1, NFS_MAX_CONNECTIONS))
 =09=09=09goto out_invalid_value;
-=09=09ctx->nfs_server.nconnect =3D option;
 =09=09break;
 =09case Opt_lookupcache:
 =09=09string =3D match_strdup(args);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 6e290b480fa8..7afc9dd009fc 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -122,6 +122,8 @@ struct nfs_fs_context {
=20
 =09void=09=09=09*lsm_opts;
 =09struct net=09=09*net;
+
+=09char=09=09=09buf[32];=09/* Parse buffer */
 };
=20
 /* mount_clnt.c */
--=20
2.17.2

