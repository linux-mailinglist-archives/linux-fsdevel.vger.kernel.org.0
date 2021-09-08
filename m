Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845A24036EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 11:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348547AbhIHJbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 05:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348527AbhIHJbZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:31:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32477C061575
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Sep 2021 02:30:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eb14so1978548edb.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Sep 2021 02:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=62lKjEsFnBS2MD21CJsw/IB60lRrgmqdjFtRoRbzjS0=;
        b=IrqE9CeQMfxBxbO4xfFTDL/kNjEWENVjg85P/dC5YaxS3emovqA5aK/kK7oJPprwmd
         OvLTwawxFrGY2Pm/ETNyTfiUEwSWXrqF/VcBZlVz9UV9Rh4BSi4LcA5lh4uYNOFDWSG5
         quUFd+ow35mguJjoVWol/flp6OHicl/xkLlFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=62lKjEsFnBS2MD21CJsw/IB60lRrgmqdjFtRoRbzjS0=;
        b=DPLtUkf/XIhxABfz1pZ2JPjT8bPXI72e/s9Be3LTShBIiGnhdaMv7rSLYdo95wCCPb
         du9B99/AJjGHyLAO+gPJfD6Vh8bpdSYkjQBFPPDptE0+6ML0uUMkM9Y3t1Cz8x5WLJ/r
         NUgHsRpU7EW+zK01uv12Q55PyBn7t5HAli7VWutNAm9xZSLqN3LU5vtlSJlIOjWL8rrd
         e4dKJTxbYd9wljK2GCFAh2XpF8UA+D/1fMfohKEXTl9uAHOXS8Y8lEBKIm2/EB+7spBf
         fb5iqZH7W5BQCots2KWSLZiaow1pooMl4C5ZS81hoQa12toS9m13FHDzivogLz7LJLIH
         wRlQ==
X-Gm-Message-State: AOAM5321YWVxBdmpWer2paX/Uk1CsqPLzgWQoOD7nIiJf/wNwNFg6uF/
        LKj5PuzadSOmrrzQBBuP2E9RTw==
X-Google-Smtp-Source: ABdhPJxS12RDQPWttIcdupgm3d1Wzi/LNLZokeR0vGr6S9tYu8zkdExwTWBwwC5657iuSAPtHEJKbA==
X-Received: by 2002:a05:6402:18ec:: with SMTP id x44mr2745937edy.331.1631093415693;
        Wed, 08 Sep 2021 02:30:15 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id b2sm827257edt.74.2021.09.08.02.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:30:15 -0700 (PDT)
Date:   Wed, 8 Sep 2021 11:30:13 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Teng Qin <tqin@jumptrading.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [FUSE] notify_store usage: deadlocks with other read / write
 requests
Message-ID: <YTiCpY1nDXntelkc@miu.piliscsaba.redhat.com>
References: <CH2PR14MB410492CB0C3AB8EA0833F963D6C69@CH2PR14MB4104.namprd14.prod.outlook.com>
 <CH2PR14MB41040692ABC50334F500789ED6C89@CH2PR14MB4104.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR14MB41040692ABC50334F500789ED6C89@CH2PR14MB4104.namprd14.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 05:31:18PM +0000, Teng Qin wrote:
> I am developing a file system that has underlying block size way larger than the number of pages VFS would request to the FUSE daemon (2MB / 4MB vs 32 pages = 128K).
> I currently cache the block data in user space, but it would be more ideal to have Kernel manage this with page cache, and save round-trips between VFS and FUSE daemon. So I was looking at use FUSE_NOTIFY_STORE to proactively offer the data to Kernel. However, I found that the notify store often deadlocks with user read requests.
> 
> For example, say the user process is doing sequential read from offset 0.
> Kernel requests a 128K read to FUSE daemon and I fetch the 2MB block from underlying storage. After replying the read request, I would like to offer the rest of the 1920K data to Kernel from offset 128K. However, at this point Kernel most likely alraedy started the next read request also at offset 128K, and have those page locked:
> 
>   wait_on_page_locked_killable
>   generic_file_buffered_read
>   generic_file_read_iter
> 
> On the other hand, the notify store is also waiting on locking those pages:
> 
>   __lock_page
>   __find_lock_page
>   find_or_create_page
>   fuse_notify_store
> 
> This normally deadlocks the FUSE daemon.
> 
> The notify store is a pretty old feature so I'm not sure if this is really an issue or I'm using it wrong. I would be very grateful if anyone could help me with some insights on how this is intended to be used. On the other hand, I was thinking maybe we could support an async notify store requests. When the Kernel moduels gets the requests, if it can not acquire lock on the relevant pages, it could just store the user provided data in dis-attached page structs, add them to a background requetss, and try later. If people are OK with such ideas, I would be more than happy to try with an implementation.

Hi,

Simplest solution is to just skip locked pages in NOTIFY_STORE.  Can you try the
attached patch (untested)?

Thanks,
Miklos

---
 fs/fuse/dev.c             |   16 +++++++++++++---
 include/uapi/linux/fuse.h |    9 ++++++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1562,6 +1562,7 @@ static int fuse_notify_store(struct fuse
 	unsigned int num;
 	loff_t file_size;
 	loff_t end;
+	bool nowait;
 
 	err = -EINVAL;
 	if (size < sizeof(outarg))
@@ -1576,6 +1577,7 @@ static int fuse_notify_store(struct fuse
 		goto out_finish;
 
 	nodeid = outarg.nodeid;
+	nowait = outarg.flags & FUSE_NOTIFY_STORE_NOWAIT;
 
 	down_read(&fc->killsb);
 
@@ -1598,12 +1600,19 @@ static int fuse_notify_store(struct fuse
 	while (num) {
 		struct page *page;
 		unsigned int this_num;
+		int fgp_flags = FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
+
+		if (nowait)
+			fgp_flags |= FGP_NOWAIT;
 
 		err = -ENOMEM;
-		page = find_or_create_page(mapping, index,
-					   mapping_gfp_mask(mapping));
-		if (!page)
+		page = pagecache_get_page(mapping, index, fgp_flags,
+					  mapping_gfp_mask(mapping));
+		if (!page) {
+			if (nowait)
+				goto skip;
 			goto out_iput;
+		}
 
 		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
 		err = fuse_copy_page(cs, &page, offset, this_num, 0);
@@ -1616,6 +1625,7 @@ static int fuse_notify_store(struct fuse
 		if (err)
 			goto out_iput;
 
+skip:
 		num -= this_num;
 		offset = 0;
 		index++;
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -464,6 +464,13 @@ struct fuse_file_lock {
  */
 #define FUSE_SETXATTR_ACL_KILL_SGID	(1 << 0)
 
+
+/*
+ * notify_store flags
+ * FUSE_NOTIFY_STORE_NOWAIT: skip locked pages
+ */
+#define FUSE_NOTIFY_STORE_NOWAIT	(1 << 0)
+
 enum fuse_opcode {
 	FUSE_LOOKUP		= 1,
 	FUSE_FORGET		= 2,  /* no reply */
@@ -899,7 +906,7 @@ struct fuse_notify_store_out {
 	uint64_t	nodeid;
 	uint64_t	offset;
 	uint32_t	size;
-	uint32_t	padding;
+	uint32_t	flags;
 };
 
 struct fuse_notify_retrieve_out {
