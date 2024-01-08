Return-Path: <linux-fsdevel+bounces-7553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A6A8271FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 15:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC3E2843AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72574778E;
	Mon,  8 Jan 2024 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="FIDDlGFi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FB47780;
	Mon,  8 Jan 2024 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4T7xyB4mGJz9stX;
	Mon,  8 Jan 2024 15:58:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1704725890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XcOQZGwoIn5kkIIANZy6IMFdl96tzX2varVM4O162Fo=;
	b=FIDDlGFi0sWUUnrGD2rmZC9aAqhMgwM5lu8ol3DXN622el7ZATFZLhCpM3E0W/YFMyYuL8
	wsg1XoctGiwuWF/AM50FTF9zZnK+nHHcDlc2ZKOyXWhYXbJHqyVGcqdZHkF5fWui3qBlEu
	xwYNLMvTgcu4o5NUB/l05Z6K5szJ8NDTejBq8w+tHOaHlstgjqh1+Lnc4xKURQj1ct+XJN
	6oMqxVs2Mp1BUPDIUPZX0/Lleol501Fho/av5i2f+MDZVLuOVB5ovOtv11+GejB7032ZF8
	cLjVynM37Ut1+pxqXd/bGmMtNq3KVtJFCm5zKxDIVNcv8eatzUBLkMBWQhbgyg==
Date: Mon, 8 Jan 2024 15:58:08 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] buffer: Fix __bread() kernel-doc
Message-ID: <20240108145808.2k4rob3ntdknrkp3@localhost>
References: <20240104163652.3705753-1-willy@infradead.org>
 <20240104163652.3705753-5-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104163652.3705753-5-willy@infradead.org>
X-Rspamd-Queue-Id: 4T7xyB4mGJz9stX

On Thu, Jan 04, 2024 at 04:36:51PM +0000, Matthew Wilcox (Oracle) wrote:
> The extra indentation confused the kernel-doc parser, so remove it.
> Fix some other wording while I'm here, and advise the user they need to
> call brelse() on this buffer.
> 
It looks like __bread_gfp has the same problem:

diff --git a/fs/buffer.c b/fs/buffer.c
index 967f34b70aa8..cfdf45cc290a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1446,16 +1446,18 @@ void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
 EXPORT_SYMBOL(__breadahead);
 
 /**
- *  __bread_gfp() - reads a specified block and returns the bh
- *  @bdev: the block_device to read from
- *  @block: number of block
- *  @size: size (in bytes) to read
- *  @gfp: page allocation flag
+ * __bread_gfp() - Read a block.
+ * @bdev: The block device to read from.
+ * @block: Block number in units of block size.
+ * @size: Block size in bytes.
  *
- *  Reads a specified block, and returns buffer head that contains it.
- *  The page cache can be allocated from non-movable area
- *  not to prevent page migration if you set gfp to zero.
- *  It returns NULL if the block was unreadable.
+ * Read a specified block, and return the buffer head that refers to it.
+ * The memory can be allocated from a non-movable area to not to prevent
+ * page migration if you set gfp to zero. The buffer head has its
+ * refcount elevated and the caller should call brelse() when it has
+ * finished with the buffer.
+ *
+ * Return: NULL if the block was unreadable.
  */
 struct buffer_head *
 __bread_gfp(struct block_device *bdev, sector_t block,
(END)

Another option is to just change this in __bread_gfp() and add a See
__bread_gfp() in __bread()?

