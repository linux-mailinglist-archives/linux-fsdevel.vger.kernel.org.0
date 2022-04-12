Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBD34FDCF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 13:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359397AbiDLKtG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 06:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356458AbiDLKpY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F17B283B19
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649756463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qo34ra1Ctd2P2g3kRmkGRG2uf3Jj3c0FkXva368F/aw=;
        b=GF8H11Nr5iC976yJn7vhzgBHmrwBMK77AGLzLCrY9EfXxBV3SrR4vC9do9+J5B3rDVbE+H
        G8m/RRgql7d5zsnIQ34AFzXEmjt2xhxd67yyByJivmfIBMJf2Gr/AurhcfFrgOdmqru2gi
        ByDaoT33xQpri6mJw/kczxHf0wKfGxU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-bjX97eMDMRmKjhEClZCRng-1; Tue, 12 Apr 2022 05:41:02 -0400
X-MC-Unique: bjX97eMDMRmKjhEClZCRng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 830DD1C1C521;
        Tue, 12 Apr 2022 09:41:01 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66FC540CFD1D;
        Tue, 12 Apr 2022 09:41:01 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 23C9f12Y021797;
        Tue, 12 Apr 2022 05:41:01 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 23C9f0pU021793;
        Tue, 12 Apr 2022 05:41:00 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 12 Apr 2022 05:41:00 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] stat: fix inconsistency between struct stat and struct
 compat_stat
In-Reply-To: <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2204120520140.19025@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com> <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, 11 Apr 2022, Linus Torvalds wrote:

> On Mon, Apr 11, 2022 at 7:13 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > Should we perhaps hash the number, take 16 bits of the hash and hope
> > than the collision won't happen?
> 
> That would "work", but I think it would be incredibly annoying to
> users with basically random results.
> 
> I think the solution is to just put the bits in the high bits. Yes,
> they might be masked off if people use 'MAJOR()' to pick them out, but
> the common "compare st_dev and st_ino" model at least works. That's
> the one that wants unique numbers.
> 
> > For me, the failure happens in cp_compat_stat (I have a 64-bit kernel). In
> > struct compat_stat in arch/x86/include/asm/compat.h, st_dev and st_rdev
> > are compat_dev_t which is 16-bit. But they are followed by 16-bit
> > paddings, so they could be extended.
> 
> Ok, that actually looks like a bug.
> 
> The compat structure should match the native structure.  Those "u16
> __padX" fields seem to be just a symptom of the bug.
> 
> The only user of that compat_stat structure is the kernel, so that
> should just be fixed.
> 
> Of course, who knows what the libraries have done, so user space could
> still have screwed up.

Here I'm sending a patch that makes struct compat_stat match struct stat.



stat: fix inconsistency between struct stat and struct compat_stat

struct stat (defined in arch/x86/include/uapi/asm/stat.h) has 32-bit
st_dev and st_rdev; struct compat_stat (defined in
arch/x86/include/asm/compat.h) has 16-bit st_dev and st_rdev followed by a
16-bit padding. This patch fixes struct compat_stat to match struct stat.

Note that we can't change compat_dev_t because it is used by
compat_loop_info.

Also, if the st_dev and st_rdev values are 32-bit, we don't have to use
old_valid_dev to test if the value fits into them. This fixes -EOVERFLOW
on filesystems that are on NVMe because NVMe uses the major number 259.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 arch/x86/include/asm/compat.h |    6 ++----
 fs/stat.c                     |   19 ++++++++++---------
 2 files changed, 12 insertions(+), 13 deletions(-)

Index: linux-5.17.2/arch/x86/include/asm/compat.h
===================================================================
--- linux-5.17.2.orig/arch/x86/include/asm/compat.h	2022-01-21 10:29:12.000000000 +0100
+++ linux-5.17.2/arch/x86/include/asm/compat.h	2022-04-12 11:27:14.000000000 +0200
@@ -28,15 +28,13 @@ typedef u16		compat_ipc_pid_t;
 typedef __kernel_fsid_t	compat_fsid_t;
 
 struct compat_stat {
-	compat_dev_t	st_dev;
-	u16		__pad1;
+	u32		st_dev;
 	compat_ino_t	st_ino;
 	compat_mode_t	st_mode;
 	compat_nlink_t	st_nlink;
 	__compat_uid_t	st_uid;
 	__compat_gid_t	st_gid;
-	compat_dev_t	st_rdev;
-	u16		__pad2;
+	u32		st_rdev;
 	u32		st_size;
 	u32		st_blksize;
 	u32		st_blocks;
Index: linux-5.17.2/fs/stat.c
===================================================================
--- linux-5.17.2.orig/fs/stat.c	2022-04-12 10:39:46.000000000 +0200
+++ linux-5.17.2/fs/stat.c	2022-04-12 10:58:28.000000000 +0200
@@ -334,9 +334,6 @@ SYSCALL_DEFINE2(fstat, unsigned int, fd,
 #  define choose_32_64(a,b) b
 #endif
 
-#define valid_dev(x)  choose_32_64(old_valid_dev(x),true)
-#define encode_dev(x) choose_32_64(old_encode_dev,new_encode_dev)(x)
-
 #ifndef INIT_STRUCT_STAT_PADDING
 #  define INIT_STRUCT_STAT_PADDING(st) memset(&st, 0, sizeof(st))
 #endif
@@ -345,7 +342,9 @@ static int cp_new_stat(struct kstat *sta
 {
 	struct stat tmp;
 
-	if (!valid_dev(stat->dev) || !valid_dev(stat->rdev))
+	if (sizeof(tmp.st_dev) < 4 && !old_valid_dev(stat->dev))
+		return -EOVERFLOW;
+	if (sizeof(tmp.st_rdev) < 4 && !old_valid_dev(stat->rdev))
 		return -EOVERFLOW;
 #if BITS_PER_LONG == 32
 	if (stat->size > MAX_NON_LFS)
@@ -353,7 +352,7 @@ static int cp_new_stat(struct kstat *sta
 #endif
 
 	INIT_STRUCT_STAT_PADDING(tmp);
-	tmp.st_dev = encode_dev(stat->dev);
+	tmp.st_dev = new_encode_dev(stat->dev);
 	tmp.st_ino = stat->ino;
 	if (sizeof(tmp.st_ino) < sizeof(stat->ino) && tmp.st_ino != stat->ino)
 		return -EOVERFLOW;
@@ -363,7 +362,7 @@ static int cp_new_stat(struct kstat *sta
 		return -EOVERFLOW;
 	SET_UID(tmp.st_uid, from_kuid_munged(current_user_ns(), stat->uid));
 	SET_GID(tmp.st_gid, from_kgid_munged(current_user_ns(), stat->gid));
-	tmp.st_rdev = encode_dev(stat->rdev);
+	tmp.st_rdev = new_encode_dev(stat->rdev);
 	tmp.st_size = stat->size;
 	tmp.st_atime = stat->atime.tv_sec;
 	tmp.st_mtime = stat->mtime.tv_sec;
@@ -644,11 +643,13 @@ static int cp_compat_stat(struct kstat *
 {
 	struct compat_stat tmp;
 
-	if (!old_valid_dev(stat->dev) || !old_valid_dev(stat->rdev))
+	if (sizeof(tmp.st_dev) < 4 && !old_valid_dev(stat->dev))
+		return -EOVERFLOW;
+	if (sizeof(tmp.st_rdev) < 4 && !old_valid_dev(stat->rdev))
 		return -EOVERFLOW;
 
 	memset(&tmp, 0, sizeof(tmp));
-	tmp.st_dev = old_encode_dev(stat->dev);
+	tmp.st_dev = new_encode_dev(stat->dev);
 	tmp.st_ino = stat->ino;
 	if (sizeof(tmp.st_ino) < sizeof(stat->ino) && tmp.st_ino != stat->ino)
 		return -EOVERFLOW;
@@ -658,7 +659,7 @@ static int cp_compat_stat(struct kstat *
 		return -EOVERFLOW;
 	SET_UID(tmp.st_uid, from_kuid_munged(current_user_ns(), stat->uid));
 	SET_GID(tmp.st_gid, from_kgid_munged(current_user_ns(), stat->gid));
-	tmp.st_rdev = old_encode_dev(stat->rdev);
+	tmp.st_rdev = new_encode_dev(stat->rdev);
 	if ((u64) stat->size > MAX_NON_LFS)
 		return -EOVERFLOW;
 	tmp.st_size = stat->size;

