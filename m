Return-Path: <linux-fsdevel+bounces-3541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 329637F6271
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 16:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B211C20A79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C3D35EE9;
	Thu, 23 Nov 2023 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HOhCtuGp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666E9D5E
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 07:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ixFCDoOJRDQK7q6wBU3fCHj+H3ZXxFBhWaFFOEbIZ8o=; b=HOhCtuGp/Qm2n27LeG2CwSpdOz
	wJ9iody4lYeDwrqS49CeWOye9Ce8wImQ1LrmJttxp3zcQMzj3C0wLL2dR40wxBmps2quOsEp2A8pY
	Cc+O3u7WhLRq0VsIwlSGiOAd44+t/FCyhucXMOCs+oDwUdEup3xyH8GAZNstAY7P4JMwOFxDU0G7o
	UD4ZjbShBUgXPBUfO3xuGgKvy7jrcdYIZQ4ja+ZaRUoS+D9eaSTT7M3PODLvpXymRySBCDM0MgrnE
	e3pDg+ZV6xf684dixeKow+re7QXJgObrBclyPhGETt6OkYdGwQpYXpNw037kdUYk8izzN26/2PigJ
	e8YUSU8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6BPK-0057cd-03;
	Thu, 23 Nov 2023 15:14:22 +0000
Date: Thu, 23 Nov 2023 07:14:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/16] splice: remove permission hook from
 iter_file_splice_write()
Message-ID: <ZV9sTfUfM9PU1IFw@infradead.org>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-6-amir73il@gmail.com>
 <ZV8Dk7UOLejEhzQN@infradead.org>
 <CAOQ4uxhxG_G6pjVTikakuUpru1XfaJoKWs4+HwNxCE5PxGTq_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhxG_G6pjVTikakuUpru1XfaJoKWs4+HwNxCE5PxGTq_Q@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 23, 2023 at 01:20:13PM +0200, Amir Goldstein wrote:
> >  - first obviously the name, based on the other functions it probably
> >    should be in the __kernel_* namespace unless I'm missing something.
> 
> Not sure about the best name.
> I just derived the name from do_iter_readv_writev(), which would be the
> name of this helper if we split up do_iter_readv_writev() as you suggested.

Well, I don't think do_iter_readv_writev is a particular good name
even now, but certainly not once it is more than just a static helper
with two callers.

I can't say __kernel is an all that great name either, but it seems
to match the existing ones. 

That being said - it just is a tiny wrapper anyway, what about just
open coding it instead of bike shedding?  See below for a patch,
this actually seems pretty reasonable and very readable.

---
diff --git a/fs/splice.c b/fs/splice.c
index d983d375ff1130..982a0872fa03e9 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -684,6 +684,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 	splice_from_pipe_begin(&sd);
 	while (sd.total_len) {
+		struct kiocb kiocb;
 		struct iov_iter from;
 		unsigned int head, tail, mask;
 		size_t left;
@@ -733,7 +734,10 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		}
 
 		iov_iter_bvec(&from, ITER_SOURCE, array, n, sd.total_len - left);
-		ret = vfs_iter_write(out, &from, &sd.pos, 0);
+		init_sync_kiocb(&kiocb, out);
+		kiocb.ki_pos = sd.pos;
+		ret = out->f_op->write_iter(&kiocb, &from);
+		sd.pos = kiocb.ki_pos;
 		if (ret <= 0)
 			break;
 

