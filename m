Return-Path: <linux-fsdevel+bounces-24956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0705F94709E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 23:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308B91C20835
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 21:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F4C139D13;
	Sun,  4 Aug 2024 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RFc9LAuV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD6AD59
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722806008; cv=none; b=R9JQ66MKrUi5pvs1GqKdDIo7VVP8Lvi5Wb3rIJzieothkZIjlvz/WqE9tL2bxtFXvLK/2UWg/YSB28RNrMBhpz76clrpDVwq1EcSy3A8qgyQigPnH9OLWXiArmePcx/ZpclQGkV8Ze7HZ7/c7bxNxCJE8xRwSOF9FPiVshvr8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722806008; c=relaxed/simple;
	bh=+GeISNPwhgcj7l5w33ijUvwoMV8O9/0RoBfS/JLCrjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCYeqFVYU1uq9zBO2mzmHgYp70yMaPoJqPcxR8ybYSF3xImTNEh9r+JUynJL+40CD2cL2pqFJwANNPXAIL1/lCGi8BnaysjKfnTp3fQzMWvezbBZIIOxRNW9DDG2nWjR7/+U44JStly2nX18yVIdrrRoVPyyFOmbU4eD1PPQ8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RFc9LAuV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/SuZmhzCIUM3ZeO9G1RBpQX5N2WkFMVYtvGT+6W1Q1s=; b=RFc9LAuVsT1+MxbDwUs3hRA1iF
	Wjb2oxYSYxD9oY2FJfE7jdL6Zaqll5DVq88spPx5l6tvodTvJbJt6PuTryHPEsESQp05yEAyTNvjC
	FZHOQ2DPKmvv71DoVCm5EDvDrewhtKZUgT6v6+TUPuVb+WPxKzK+SFNxoKr5tYIZEK87xOqBejlNT
	Kwe78FDDrGoR7SxJX6qYBAeg44zl/hdEozL/qtEiFIqf1LvQn08AoMIrrpzTo0O0KYAHIcc/8WFG4
	hoGsnevV34ZJDKax0Isuhyl2bZRgl2BfP3LwcadvO171/MdEbgKQJx1kvW2arIm79Etdge8ujhtiV
	yirz2N+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1saiXa-00000001aoa-1FcU;
	Sun, 04 Aug 2024 21:13:22 +0000
Date: Sun, 4 Aug 2024 22:13:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix bitmap corruption on close_range() with
 CLOSE_RANGE_UNSHARE
Message-ID: <20240804211322.GD5334@ZenIV>
References: <20240803225054.GY5334@ZenIV>
 <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
 <20240804003405.GA5334@ZenIV>
 <20240804034739.GB5334@ZenIV>
 <CAHk-=wgH=M9G02hhgPL36cN3g21MmGbg7zAeS6HtN9LarY_PYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgH=M9G02hhgPL36cN3g21MmGbg7zAeS6HtN9LarY_PYg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Aug 04, 2024 at 08:18:14AM -0700, Linus Torvalds wrote:
> On Sat, 3 Aug 2024 at 20:47, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         bitmap_copy_and_extend(nfdt->open_fds, ofdt->open_fds,
> >                         copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
> 
> Ok, thinking about it, I like this interface, since it looks like the
> compiler would see that it's in BITS_PER_LONG chunks if we inline it
> and decide it's important.
> 
> So make it so.

FWIW, what I'm testing right now is the patch below; it does fix the reproducer
and it seems to be having no problems with xfstests so far.  Needs profiling;
again, no visible slowdowns on xfstests, but...


diff --git a/fs/file.c b/fs/file.c
index a11e59b5d602..655338effe9c 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -46,27 +46,23 @@ static void free_fdtable_rcu(struct rcu_head *rcu)
 #define BITBIT_NR(nr)	BITS_TO_LONGS(BITS_TO_LONGS(nr))
 #define BITBIT_SIZE(nr)	(BITBIT_NR(nr) * sizeof(long))
 
+#define fdt_words(fdt) ((fdt)->max_fds / BITS_PER_LONG) // words in ->open_fds
 /*
  * Copy 'count' fd bits from the old table to the new table and clear the extra
  * space if any.  This does not copy the file pointers.  Called with the files
  * spinlock held for write.
  */
-static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
-			    unsigned int count)
+static inline void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
+			    unsigned int copy_words)
 {
-	unsigned int cpy, set;
-
-	cpy = count / BITS_PER_BYTE;
-	set = (nfdt->max_fds - count) / BITS_PER_BYTE;
-	memcpy(nfdt->open_fds, ofdt->open_fds, cpy);
-	memset((char *)nfdt->open_fds + cpy, 0, set);
-	memcpy(nfdt->close_on_exec, ofdt->close_on_exec, cpy);
-	memset((char *)nfdt->close_on_exec + cpy, 0, set);
-
-	cpy = BITBIT_SIZE(count);
-	set = BITBIT_SIZE(nfdt->max_fds) - cpy;
-	memcpy(nfdt->full_fds_bits, ofdt->full_fds_bits, cpy);
-	memset((char *)nfdt->full_fds_bits + cpy, 0, set);
+	unsigned int nwords = fdt_words(nfdt);
+
+	bitmap_copy_and_extend(nfdt->open_fds, ofdt->open_fds,
+			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
+	bitmap_copy_and_extend(nfdt->close_on_exec, ofdt->close_on_exec,
+			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
+	bitmap_copy_and_extend(nfdt->full_fds_bits, ofdt->full_fds_bits,
+			copy_words, nwords);
 }
 
 /*
@@ -84,7 +80,7 @@ static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
 	memcpy(nfdt->fd, ofdt->fd, cpy);
 	memset((char *)nfdt->fd + cpy, 0, set);
 
-	copy_fd_bitmaps(nfdt, ofdt, ofdt->max_fds);
+	copy_fd_bitmaps(nfdt, ofdt, fdt_words(ofdt));
 }
 
 /*
@@ -379,7 +375,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 		open_files = sane_fdtable_size(old_fdt, max_fds);
 	}
 
-	copy_fd_bitmaps(new_fdt, old_fdt, open_files);
+	copy_fd_bitmaps(new_fdt, old_fdt, open_files / BITS_PER_LONG);
 
 	old_fds = old_fdt->fd;
 	new_fds = new_fdt->fd;
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 8c4768c44a01..d3b66d77df7a 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -270,6 +270,18 @@ static inline void bitmap_copy_clear_tail(unsigned long *dst,
 		dst[nbits / BITS_PER_LONG] &= BITMAP_LAST_WORD_MASK(nbits);
 }
 
+static inline void bitmap_copy_and_extend(unsigned long *to,
+					  const unsigned long *from,
+					  unsigned int count, unsigned int size)
+{
+	unsigned int copy = BITS_TO_LONGS(count);
+
+	memcpy(to, from, copy * sizeof(long));
+	if (count % BITS_PER_LONG)
+		to[copy - 1] &= BITMAP_LAST_WORD_MASK(count);
+	memset(to + copy, 0, bitmap_size(size) - copy * sizeof(long));
+}
+
 /*
  * On 32-bit systems bitmaps are represented as u32 arrays internally. On LE64
  * machines the order of hi and lo parts of numbers match the bitmap structure.

