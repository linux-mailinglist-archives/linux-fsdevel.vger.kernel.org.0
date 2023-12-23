Return-Path: <linux-fsdevel+bounces-6838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D2081D52D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 17:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BF92834E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5684912E60;
	Sat, 23 Dec 2023 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WCCl570W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6EC12E4C;
	Sat, 23 Dec 2023 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I/eFQM9OFj9mUmVjzXCK/VJEaJGdQdMdFIR0hwNMvZY=; b=WCCl570WZpNXZxA0H1eMYJhmNZ
	fWwhiO4bF5zkndDyquY6lslVyBip0vv5KO3QfTUJfywTHivnH5X1HLiE5T8O4L/4DwLIT3heVjOkz
	LLY7s4Oks/svjXGQOSBN6djfEJDD/bDAKwyYjeGYTzV+Sq+vyDQAXRkF5485h9uNwfC+fdW3fPhNJ
	gdhF6cTeozO6xslaFmFFRe7fFieoIBdybeQ3GNtZl8c41Z0hqYJEJnsn8QtzgxeIC2wEnZAjRik8N
	uekGh7L+dsMuzAR3az0iHWZtYz+8E7EYDF53wcz2Tv5qooQP2h8ZdDDwwbfU6Osqv5NQ9GxJWNHZK
	PjSmplJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rH5Iw-00BFGY-IN; Sat, 23 Dec 2023 16:56:50 +0000
Date: Sat, 23 Dec 2023 16:56:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/8] fs/ntfs3: Use kvmalloc instead of kmalloc(...
 __GFP_NOWARN)
Message-ID: <ZYcRUvZXiaKtiANz@casper.infradead.org>
References: <e41f6717-7c70-edf2-2d3a-8034840d14c5@paragon-software.com>
 <890222ac-1bd2-6817-7873-390801c5a172@paragon-software.com>
 <ZYZmFPnJAM3aJLlF@casper.infradead.org>
 <bca8d526-2397-4ca5-b1d6-5758c9334a81@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bca8d526-2397-4ca5-b1d6-5758c9334a81@I-love.SAKURA.ne.jp>

On Sat, Dec 23, 2023 at 10:33:11PM +0900, Tetsuo Handa wrote:
> But you can't replace GFP_NOFS with GFP_KERNEL anyway, for syzbot is also
> reporting GFP_KERNEL allocation with filesystem lock held
> at https://syzkaller.appspot.com/bug?extid=18f543fc90dd1194c616 .

Well, you _can_.  What _all_ filesystem authors should be doing is 
switching to memalloc_nofs_save/restore.  Generally when taking a lock
that's needed during reclaim.  In this specific case, soemthing like
this:

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 7b6423584eae..432905489a14 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -122,6 +122,7 @@ int mi_read(struct mft_inode *mi, bool is_mft)
 	struct ntfs_inode *mft_ni = sbi->mft.ni;
 	struct runs_tree *run = mft_ni ? &mft_ni->file.run : NULL;
 	struct rw_semaphore *rw_lock = NULL;
+	unsigned int memalloc = memalloc_nofs_save();
 
 	if (is_mounted(sbi)) {
 		if (!is_mft && mft_ni) {
@@ -177,6 +178,7 @@ int mi_read(struct mft_inode *mi, bool is_mft)
 		goto out;
 	}
 
+	memalloc_nofs_restore(memalloc);
 	return 0;
 
 out:
@@ -186,6 +188,7 @@ int mi_read(struct mft_inode *mi, bool is_mft)
 		err = -EINVAL;
 	}
 
+	memalloc_nofs_restore(memalloc);
 	return err;
 }
 

