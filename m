Return-Path: <linux-fsdevel+bounces-63990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8638FBD54B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 18:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A1E9542069
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE19230DD28;
	Mon, 13 Oct 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="X61yc2R5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="URq7D/JX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8043126A8
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369998; cv=none; b=WlNB9e4sWg59lqS6cgPVDXL3r8by1DHjZlY9mVrvBlTKc8jzUzR3mwFRU5ohxWSUrU2rC82adq1XUAsr6Pyu61OGG2giIZ45hCRxxUsN16MdjcIMb61pi+/Rdy2k1aCNvsP0Ayl9Mf+ZZXW4+8ResPzdOhv967neqDmPzzHgT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369998; c=relaxed/simple;
	bh=ZnVJXxndGtcawSEVeG6IlKiIlW4Mf94lw5FE4Xia/PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOjyaxbaE7sX7jdMQRMdMjbzqNB5YF86OdhFfAOejX/lclTziRA1it43hymrSMCDqhMZ6HYif5enKemUasKBmLTc5UKkV718AmFEvPgvi89gvWKI+C0Mv0Y4w01ZbJp/bbJOxrxbUcic4K2By6/TyoL77MgYxjABO3peU8YmYTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=X61yc2R5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=URq7D/JX; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 74AEDEC00B4;
	Mon, 13 Oct 2025 11:39:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 13 Oct 2025 11:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760369994; x=
	1760456394; bh=uF1KlGoAqogLpaR4W/gOQCWLoChaSMDMreApSFugeQU=; b=X
	61yc2R5f2xNEaXdhgS8oDbgbh0XBurClm+MJMkSxYUfQw379JzBTh7wMONBkje2v
	mqVv9B2tVjTkfzMRXRmp+HqAMxyeAiL2UyNDRONPOWAOTEJmQwNavm3QDLv9opcE
	DW/jICkxalkQ4CqjWLwpdRHRhouDQ6Nvsk3XSx+OG3eeWPHxij1s5jaCwje+Egjd
	gUiH89STUBO8QTv4+5DTYZ0oR0oACN9tCe52ZvUkh09JB7PVzpNm2rOOXAFkZk1h
	oF4yEI4CJYUvEaEqWsRSOG0i8oay3FXDAAHjjb8N3TpX6HobkqhGx1Pf6TKDhtJ6
	Q/ahcFwlvqHL0pjJXDdFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760369994; x=1760456394; bh=uF1KlGoAqogLpaR4W/gOQCWLoChaSMDMreA
	pSFugeQU=; b=URq7D/JXpS4a9bzoV8ON6QPr0FHuv09AZt+QAFXwVJleCj3Xatv
	66i3l9xVwOATtQZy6aQMe3SgWArXyaMjkra//taI7uxE8CczxY50PoevlSZonjCx
	0t+jCTA0Ow7G/1fyIDd9dLCS4TY+Zv7MAkE8nmvEK9T55BPniFG/TeDMMJiw6Lfy
	qstkcI8M+E9bXOejZHh/M7L+ljwsYPi1sc6W1EjFrfQ+s47XMB6bHUKbL9LRTooo
	vOJS9uczK5XactBRrczXTwL6O38RxMYH855BMt72Ma10p1xPrFj6fKn12Aqoaer+
	yqwOaogLhAfRCfJOwEtuQkeBcHsKhR5eE1w==
X-ME-Sender: <xms:SR3taLwRrWGtF2FXKZftdUoAnwl8kcYja1KeyEeHDdWgqQBKQ9VxEA>
    <xme:SR3taGV2ZKZEg-FfWGxJsvIKqYLUohEu-I4TDzT7HNjckAwF9nv3tTZEeiNFaAB72
    vzqdshDUXUPnreboBL12qhXFmmFjNaqhtOOwd93RnyfA5uDZcFyWcjD>
X-ME-Received: <xmr:SR3taP_-XjKM-V3BeOCBqPSTjGMSddUdutjr0wev_LUq19YgM0x09DnKLDtwUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudektdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedu
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughssehlihhnuh
    igqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeifihhllhihsehinhhfrhgr
    uggvrggurdhorhhgpdhrtghpthhtohepmhgtghhrohhfsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SR3taBskotnGDUgG2fKyx4IRmfPMn37gWNACXhKYooKaJLE2kvaH9w>
    <xmx:SR3taH0KHp0pDfpiOYIscjK5KdFSz43vprCRucsUULnhgjA2IAFSxw>
    <xmx:SR3taOTV5LaKh4hoxUEGzB-lDb4E_cMXXjSFo7emBLYohS0wPMZFSg>
    <xmx:SR3taDesROeFhrFFwmoFzDZvluptlF37Iad3r2YVbQVX_k43AGM4YQ>
    <xmx:Sh3taIX0xKSx_ouQqTIgSz8Dyy8DxgcH0fdbVfC-jryL2QvdE9860l-N>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 11:39:53 -0400 (EDT)
Date: Mon, 13 Oct 2025 16:39:51 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Optimizing small reads
Message-ID: <dz7pcqi5ytmb35r6kojuetdipjp7xdjlnyzcu5qb6d4cdo6vq5@3b62gfzcxszo>
References: <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
 <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com>
 <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp>
 <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
 <CAHk-=wi42ad9s1fUg7cC3XkVwjWFakPp53z9P0_xj87pr+AbqA@mail.gmail.com>
 <nhrb37zzltn5hi3h5phwprtmkj2z2wb4gchvp725bwcnsgvjyf@eohezc2gouwr>
 <CAHk-=wi1rrcijcD0i7V7JD6bLL-yKHUX-hcxtLx=BUd34phdug@mail.gmail.com>
 <qasdw5uxymstppbxvqrfs5nquf2rqczmzu5yhbvn6brqm5w6sw@ax6o4q2xkh3t>
 <CAHk-=wg0r_xsB0RQ+35WPHwPb9b9drJEfGL-hByBZRmPbSy0rQ@mail.gmail.com>
 <jzpbwmoygmjsltnqfdgnq4p75tg74bdamq3hne7t32mof4m5xo@lcw3afbr4daf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jzpbwmoygmjsltnqfdgnq4p75tg74bdamq3hne7t32mof4m5xo@lcw3afbr4daf>

On Mon, Oct 13, 2025 at 04:35:20PM +0100, Kiryl Shutsemau wrote:
> On Fri, Oct 10, 2025 at 10:51:40AM -0700, Linus Torvalds wrote:
> > Sounds like a plan?
> 
> The patch is below. Can I use your Signed-off-by for it?

And, for archiving purposes, here is the last version of the patch that
supports large blocks.

Do you think it makes sense to submit unsafe_copy_to_user() optimization
as a standalone thingy?

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c1a441..48bd31bac20e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -607,15 +607,24 @@ _label:									\
 		len -= sizeof(type);						\
 	}
 
-#define unsafe_copy_to_user(_dst,_src,_len,label)			\
-do {									\
-	char __user *__ucu_dst = (_dst);				\
-	const char *__ucu_src = (_src);					\
-	size_t __ucu_len = (_len);					\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
+#define unsafe_copy_to_user(_dst,_src,_len,label)				\
+do {										\
+	char __user *__ucu_dst = (_dst);					\
+	const char *__ucu_src = (_src);						\
+	size_t __ucu_len = (_len);						\
+	if (cpu_feature_enabled(X86_FEATURE_FSRM)) {				\
+		asm goto(							\
+			     "1:	rep movsb\n"				\
+			     _ASM_EXTABLE_UA(1b, %l[label])			\
+			     : "+D" (__ucu_dst), "+S" (__ucu_src),		\
+			       "+c" (__ucu_len)					\
+			     : : "memory" : label);				\
+	} else {								\
+		unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);  \
+		unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);  \
+		unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);  \
+		unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);   \
+	}									\
 } while (0)
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
diff --git a/fs/inode.c b/fs/inode.c
index ec9339024ac3..52163d28d630 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -482,6 +482,8 @@ EXPORT_SYMBOL(inc_nlink);
 static void __address_space_init_once(struct address_space *mapping)
 {
 	xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
+	seqcount_spinlock_init(&mapping->i_pages_delete_seqcnt,
+			       &mapping->i_pages->xa_lock);
 	init_rwsem(&mapping->i_mmap_rwsem);
 	INIT_LIST_HEAD(&mapping->i_private_list);
 	spin_lock_init(&mapping->i_private_lock);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9e9d7c757efe..a900214f0f3a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -522,6 +522,7 @@ struct address_space {
 	struct list_head	i_private_list;
 	struct rw_semaphore	i_mmap_rwsem;
 	void *			i_private_data;
+	seqcount_spinlock_t	i_pages_delete_seqcnt;
 } __attribute__((aligned(sizeof(long)))) __randomize_layout;
 	/*
 	 * On most architectures that alignment is already the case; but
diff --git a/mm/filemap.c b/mm/filemap.c
index 751838ef05e5..08ace2cca696 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -138,8 +138,10 @@ static void page_cache_delete(struct address_space *mapping,
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
+	write_seqcount_begin(&mapping->i_pages_delete_seqcnt);
 	xas_store(&xas, shadow);
 	xas_init_marks(&xas);
+	write_seqcount_end(&mapping->i_pages_delete_seqcnt);
 
 	folio->mapping = NULL;
 	/* Leave folio->index set: truncation lookup relies upon it */
@@ -2659,41 +2661,132 @@ static void filemap_end_dropbehind_read(struct folio *folio)
 	}
 }
 
-/**
- * filemap_read - Read data from the page cache.
- * @iocb: The iocb to read.
- * @iter: Destination for the data.
- * @already_read: Number of bytes already read by the caller.
- *
- * Copies data from the page cache.  If the data is not currently present,
- * uses the readahead and read_folio address_space operations to fetch it.
- *
- * Return: Total number of bytes copied, including those already read by
- * the caller.  If an error happens before any bytes are copied, returns
- * a negative error number.
- */
-ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
-		ssize_t already_read)
+static size_t inner_read_loop(struct kiocb *iocb, struct folio *folio,
+				void __user *dst, size_t dst_size,
+				char *buffer, size_t buffer_size,
+				struct address_space *mapping, unsigned int seq)
+{
+	size_t read = 0;
+
+	if (can_do_masked_user_access())
+		dst = masked_user_access_begin(dst);
+	else if (!user_access_begin(dst, dst_size))
+		return 0;
+
+	do {
+		size_t to_read = min(dst_size, buffer_size);
+
+		to_read = memcpy_from_file_folio(buffer, folio, iocb->ki_pos, to_read);
+
+		/* Give up and go to slow path if raced with page_cache_delete() */
+		if (read_seqcount_retry(&mapping->i_pages_delete_seqcnt, seq))
+			break;
+
+		unsafe_copy_to_user(dst, buffer, to_read, Efault);
+
+		dst += to_read;
+		dst_size -= to_read;
+
+		iocb->ki_pos += to_read;
+		read += to_read;
+	} while (dst_size && iocb->ki_pos % folio_size(folio));
+
+Efault:
+	user_access_end();
+	return read;
+}
+
+static bool noinline filemap_read_fast(struct kiocb *iocb, struct iov_iter *iter,
+			      char *buffer, size_t buffer_size,
+			      ssize_t *already_read)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	struct file_ra_state *ra = &iocb->ki_filp->f_ra;
+	loff_t last_pos = ra->prev_pos;
+	struct folio *folio;
+	loff_t file_size;
+	unsigned int seq;
+
+	/* Don't bother with flush_dcache_folio() */
+	if (ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE)
+		return false;
+
+	if (!iter_is_ubuf(iter))
+		return false;
+
+	/* Give up and go to slow path if raced with page_cache_delete() */
+	if (!raw_seqcount_try_begin(&mapping->i_pages_delete_seqcnt, seq))
+		return false;
+
+	rcu_read_lock();
+	pagefault_disable();
+
+	do {
+		size_t to_read, read;
+		void __user *dst;
+		XA_STATE(xas, &mapping->i_pages, iocb->ki_pos >> PAGE_SHIFT);
+
+		xas_reset(&xas);
+		folio = xas_load(&xas);
+		if (xas_retry(&xas, folio))
+			break;
+
+		if (!folio || xa_is_value(folio))
+			break;
+
+		if (!folio_test_uptodate(folio))
+			break;
+
+		/* No fast-case if readahead is supposed to started */
+		if (folio_test_readahead(folio))
+			break;
+		/* .. or mark it accessed */
+		if (!folio_test_referenced(folio))
+			break;
+
+		/* i_size check must be after folio_test_uptodate() */
+		file_size = i_size_read(mapping->host);
+
+		if (unlikely(iocb->ki_pos >= file_size))
+			break;
+		file_size -= iocb->ki_pos;
+		to_read = iov_iter_count(iter);
+		if (to_read > file_size)
+			to_read = file_size;
+
+		dst = iter->ubuf + iter->iov_offset;
+		read = inner_read_loop(iocb, folio,
+			dst, to_read, buffer, buffer_size,
+			mapping, seq);
+		if (!read)
+			break;
+		iter->iov_offset += read;
+		iter->count -= read;
+		*already_read += read;
+		last_pos = iocb->ki_pos;
+	} while (iov_iter_count(iter));
+
+	pagefault_enable();
+	rcu_read_unlock();
+
+	file_accessed(iocb->ki_filp);
+	ra->prev_pos = last_pos;
+	return !iov_iter_count(iter);
+}
+
+static ssize_t filemap_read_slow(struct kiocb *iocb, struct iov_iter *iter,
+			      struct folio_batch *fbatch, ssize_t already_read)
 {
 	struct file *filp = iocb->ki_filp;
 	struct file_ra_state *ra = &filp->f_ra;
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
-	struct folio_batch fbatch;
 	int i, error = 0;
 	bool writably_mapped;
 	loff_t isize, end_offset;
 	loff_t last_pos = ra->prev_pos;
 
-	if (unlikely(iocb->ki_pos < 0))
-		return -EINVAL;
-	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
-		return 0;
-	if (unlikely(!iov_iter_count(iter)))
-		return 0;
-
-	iov_iter_truncate(iter, inode->i_sb->s_maxbytes - iocb->ki_pos);
-	folio_batch_init(&fbatch);
+	folio_batch_init(fbatch);
 
 	do {
 		cond_resched();
@@ -2709,7 +2802,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		if (unlikely(iocb->ki_pos >= i_size_read(inode)))
 			break;
 
-		error = filemap_get_pages(iocb, iter->count, &fbatch, false);
+		error = filemap_get_pages(iocb, iter->count, fbatch, false);
 		if (error < 0)
 			break;
 
@@ -2737,11 +2830,11 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		 * mark it as accessed the first time.
 		 */
 		if (!pos_same_folio(iocb->ki_pos, last_pos - 1,
-				    fbatch.folios[0]))
-			folio_mark_accessed(fbatch.folios[0]);
+				    fbatch->folios[0]))
+			folio_mark_accessed(fbatch->folios[0]);
 
-		for (i = 0; i < folio_batch_count(&fbatch); i++) {
-			struct folio *folio = fbatch.folios[i];
+		for (i = 0; i < folio_batch_count(fbatch); i++) {
+			struct folio *folio = fbatch->folios[i];
 			size_t fsize = folio_size(folio);
 			size_t offset = iocb->ki_pos & (fsize - 1);
 			size_t bytes = min_t(loff_t, end_offset - iocb->ki_pos,
@@ -2772,19 +2865,57 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			}
 		}
 put_folios:
-		for (i = 0; i < folio_batch_count(&fbatch); i++) {
-			struct folio *folio = fbatch.folios[i];
+		for (i = 0; i < folio_batch_count(fbatch); i++) {
+			struct folio *folio = fbatch->folios[i];
 
 			filemap_end_dropbehind_read(folio);
 			folio_put(folio);
 		}
-		folio_batch_init(&fbatch);
+		folio_batch_init(fbatch);
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
 	file_accessed(filp);
 	ra->prev_pos = last_pos;
 	return already_read ? already_read : error;
 }
+
+/**
+ * filemap_read - Read data from the page cache.
+ * @iocb: The iocb to read.
+ * @iter: Destination for the data.
+ * @already_read: Number of bytes already read by the caller.
+ *
+ * Copies data from the page cache.  If the data is not currently present,
+ * uses the readahead and read_folio address_space operations to fetch it.
+ *
+ * Return: Total number of bytes copied, including those already read by
+ * the caller.  If an error happens before any bytes are copied, returns
+ * a negative error number.
+ */
+ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
+		ssize_t already_read)
+{
+	struct inode *inode = iocb->ki_filp->f_mapping->host;
+	union {
+		struct folio_batch fbatch;
+		__DECLARE_FLEX_ARRAY(char, buffer);
+		//char __buffer[4096];
+	} area __uninitialized;
+
+	if (unlikely(iocb->ki_pos < 0))
+		return -EINVAL;
+	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
+		return 0;
+	if (unlikely(!iov_iter_count(iter)))
+		return 0;
+
+	iov_iter_truncate(iter, inode->i_sb->s_maxbytes - iocb->ki_pos);
+
+	if (filemap_read_fast(iocb, iter, area.buffer, sizeof(area), &already_read))
+		return already_read;
+
+	return filemap_read_slow(iocb, iter, &area.fbatch, already_read);
+}
 EXPORT_SYMBOL_GPL(filemap_read);
 
 int kiocb_write_and_wait(struct kiocb *iocb, size_t count)
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

