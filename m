Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B32D3697
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 00:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbgLHW4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 17:56:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731346AbgLHW4d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 17:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607468107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jMmFPLyXP8JGIe1Wh/MLyyRneAlTvCrBjviV+w9jUaE=;
        b=Y54NBa03K4qvh2abz8/EquvAoCCTCrp1JGX27O+6CLY8/BVLANZdP51eFQVC0EcH3DyB9i
        xXRJliMAVizxVvpKBNJKpy5qCrNk7o0Vrqvh7WqQeyUly1lzkLl6VjqitEcgTaAnX39/eE
        5XiuCOzE6YXlnDaYPSic+wI7oS+RyCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-n3_Fhl-6NBanwYUUiMWqTA-1; Tue, 08 Dec 2020 17:55:03 -0500
X-MC-Unique: n3_Fhl-6NBanwYUUiMWqTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 945DB107ACE6;
        Tue,  8 Dec 2020 22:55:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12CC16E521;
        Tue,  8 Dec 2020 22:54:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1c752ffe-8118-f9ea-e928-d92783a5c516@infradead.org>
References: <1c752ffe-8118-f9ea-e928-d92783a5c516@infradead.org> <6db2af99-e6e3-7f28-231e-2bdba05ca5fa@infradead.org> <0000000000002a530d05b400349b@google.com> <928043.1607416561@warthog.procyon.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+86dc6632faaca40133ab@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: memory leak in generic_parse_monolithic [+PATCH]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1030307.1607468099.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 08 Dec 2020 22:54:59 +0000
Message-ID: <1030308.1607468099@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

> > Now the backtrace only shows what the state was when the string was al=
located;
> > it doesn't show what happened to it after that, so another possibility=
 is that
> > the filesystem being mounted nicked what vfs_parse_fs_param() had righ=
tfully
> > stolen, transferring fc->source somewhere else and then failed to rele=
ase it -
> > most likely on mount failure (ie. it's an error handling bug in the
> > filesystem).
> > =

> > Do we know what filesystem it was?
> =

> Yes, it's call AFS (or kAFS).

Hmmm...  afs parses the string in afs_parse_source() without modifying it,
then moves the pointer to fc->source (parallelling vfs_parse_fs_param()) a=
nd
doesn't touch it again.  fc->source should be cleaned up by do_new_mount()
calling put_fs_context() at the end of the function.

As far as I can tell with the attached print-insertion patch, it works, ca=
lled
by the following commands, some of which are correct and some which aren't=
:

# mount -t afs none /xfstest.test/ -o dyn
# umount /xfstest.test =

# mount -t afs "" /xfstest.test/ -o foo
mount: /xfstest.test: bad option; for several filesystems (e.g. nfs, cifs)=
 you might need a /sbin/mount.<type> helper program.
# umount /xfstest.test =

umount: /xfstest.test: not mounted.
# mount -t afs %xfstest.test20 /xfstest.test/ -o foo
mount: /xfstest.test: bad option; for several filesystems (e.g. nfs, cifs)=
 you might need a /sbin/mount.<type> helper program.
# umount /xfstest.test =

umount: /xfstest.test: not mounted.
# mount -t afs %xfstest.test20 /xfstest.test/ =

# umount /xfstest.test =


Do you know if the mount was successful and what the mount parameters were=
?

David
---
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 6c5900df6aa5..4c44ec0196c9 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -299,7 +299,7 @@ static int afs_parse_source(struct fs_context *fc, str=
uct fs_parameter *param)
 		ctx->cell =3D cell;
 	}
 =

-	_debug("CELL:%s [%p] VOLUME:%*.*s SUFFIX:%s TYPE:%d%s",
+	kdebug("CELL:%s [%p] VOLUME:%*.*s SUFFIX:%s TYPE:%d%s",
 	       ctx->cell->name, ctx->cell,
 	       ctx->volnamesz, ctx->volnamesz, ctx->volname,
 	       suffix ?: "-", ctx->type, ctx->force ? " FORCE" : "");
@@ -318,6 +318,8 @@ static int afs_parse_param(struct fs_context *fc, stru=
ct fs_parameter *param)
 	struct afs_fs_context *ctx =3D fc->fs_private;
 	int opt;
 =

+	kenter("%s,%p '%s'", param->key, param->string, param->string);
+
 	opt =3D fs_parse(fc, afs_fs_parameters, param, &result);
 	if (opt < 0)
 		return opt;
diff --git a/fs/fs_context.c b/fs/fs_context.c
index 2834d1afa6e8..f530a33876ce 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -450,6 +450,8 @@ void put_fs_context(struct fs_context *fc)
 	put_user_ns(fc->user_ns);
 	put_cred(fc->cred);
 	put_fc_log(fc);
+	if (strcmp(fc->fs_type->name, "afs") =3D=3D 0)
+		printk("PUT %p '%s'\n", fc->source, fc->source);
 	put_filesystem(fc->fs_type);
 	kfree(fc->source);
 	kfree(fc);
@@ -671,6 +673,8 @@ void vfs_clean_context(struct fs_context *fc)
 	fc->s_fs_info =3D NULL;
 	fc->sb_flags =3D 0;
 	security_free_mnt_opts(&fc->security);
+	if (strcmp(fc->fs_type->name, "afs") =3D=3D 0)
+		printk("CLEAN %p '%s'\n", fc->source, fc->source);
 	kfree(fc->source);
 	fc->source =3D NULL;
 =

