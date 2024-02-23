Return-Path: <linux-fsdevel+bounces-12566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E811D861268
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB3F1F242AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF097EF02;
	Fri, 23 Feb 2024 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiJGQgJA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1487E767
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694112; cv=none; b=eEX3GtP4c3eLTt26pIXz5P25BnzSsDdiQnz7u0ailEnqPtjCgIfX/v7j3TfROKfnnX/1Gn2ZQCfjwlKUtveDYfO0g81tV7m38FLXeSzFFzEGC3w5D+iM2lRVnwFk0GX4zoJkVuiljiSyHOf3Wfy7qlYcI6aTGV0CE6JUF6fV7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694112; c=relaxed/simple;
	bh=NqcAryQexHKldcmtQ7oljqwVi0qu+Trmo1bd478NK5s=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=aEczi0IWE/hsEThTpvMTFUeuh7YDx/obCGbhKDEY99vnEsIOrIJ3lFB7TUkr5Md+j30qCezaxg2oZGZKre4UBlWYKPUIK6/mH2aqVoS+5Iw5ZB/16r+JlYIkdXWlsiCgpsZrXiKfgRJEV7pupmt+rG3vUjqNRmQpNss5DL5kL8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CiJGQgJA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708694109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TtbWAR6OLr2FDqFsVB9geJjS7w0NfEeR4GtkwedoxAM=;
	b=CiJGQgJAgU9QhUyCennNIk/CWJknZ4A7onUbJNlsS5GL5xRsT475eAGpzGA/0sYk2q7BMe
	Hb/agFN2+IeW4FPHApAAkXM+hxTL9q/RL+GKTRI2xQya9o8nF6xYYMR6VlolC2OCeQqcGa
	0pBbJ3Zykin4UpGVqAtSUGkT5b4iRcw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-6ZLkPUbtN3685804BkJiLg-1; Fri, 23 Feb 2024 08:15:04 -0500
X-MC-Unique: 6ZLkPUbtN3685804BkJiLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A62D783B825;
	Fri, 23 Feb 2024 13:15:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CA8081C06713;
	Fri, 23 Feb 2024 13:15:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
cc: dhowells@redhat.com, Markus Suvanto <markus.suvanto@gmail.com>,
    Christian Brauner <brauner@kernel.org>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix endless loop in directory parsing
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <786184.1708694102.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Feb 2024 13:15:02 +0000
Message-ID: <786185.1708694102@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

    =

If a directory has a block with only ".__afsXXXX" files in it (from
uncompleted silly-rename), these .__afsXXXX files are skipped but without
advancing the file position in the dir_context.  This leads to
afs_dir_iterate() repeating the block again and again.

Fix this by making the code that skips the .__afsXXXX file also manually
advance the file position.

The symptoms are a soft lookup:

        watchdog: BUG: soft lockup - CPU#3 stuck for 52s! [check:5737]
        ...
        RIP: 0010:afs_dir_iterate_block+0x39/0x1fd
        ...
         ? watchdog_timer_fn+0x1a6/0x213
        ...
         ? asm_sysvec_apic_timer_interrupt+0x16/0x20
         ? afs_dir_iterate_block+0x39/0x1fd
         afs_dir_iterate+0x10a/0x148
         afs_readdir+0x30/0x4a
         iterate_dir+0x93/0xd3
         __do_sys_getdents64+0x6b/0xd4

This is almost certainly the actual fix for:

        https://bugzilla.kernel.org/show_bug.cgi?id=3D218496

Fixes: 57e9d49c5452 ("afs: Hide silly-rename files from userspace")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Markus Suvanto <markus.suvanto@gmail.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dir.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index b5b8de521f99..8a67fc427e74 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -479,8 +479,10 @@ static int afs_dir_iterate_block(struct afs_vnode *dv=
node,
 		    dire->u.name[0] =3D=3D '.' &&
 		    ctx->actor !=3D afs_lookup_filldir &&
 		    ctx->actor !=3D afs_lookup_one_filldir &&
-		    memcmp(dire->u.name, ".__afs", 6) =3D=3D 0)
+		    memcmp(dire->u.name, ".__afs", 6) =3D=3D 0) {
+			ctx->pos =3D blkoff + next * sizeof(union afs_xdr_dirent);
 			continue;
+		}
 =

 		/* found the next entry */
 		if (!dir_emit(ctx, dire->u.name, nlen,


