Return-Path: <linux-fsdevel+bounces-63989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EE3BD513A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 18:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33EAF56485A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7543330FC16;
	Mon, 13 Oct 2025 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="RBVs3WAQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l/TBRaWJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233030FC09
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369723; cv=none; b=uG4/kHGahLvfOKIrrQv5eWFnCwElqFQe8pupvJ7E/lkcZnw9eTabB+zfPquV29Qzd+krIJns7oqb0Snzm2Ah7UFT1xfyo5IRaQbXMi3St2v8iLNIGzAPAbvsL6UBrsbc566l0ZbXopmCWP+OTu8QDhUxHWWiEwTY9kew+wZKKgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369723; c=relaxed/simple;
	bh=dxhEsAZrnI10hLr7EmSso60/R0XX/xY4whpvEJH0iDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE8z/D1ZdlrlhMad3TgUEr1bZyPbIqTerUskfRIMuMa7FfCx8Iv8lm5KE/HmN93W9Z/qWxE8DYoM6NvRvN4KKjP50ouk3U4rzMW2T8w7YsrxEwISRL1l3wm3gQKIyeEGr3YTXa72UFex+0Mn+8Tw5LIJXg9/f7cquzTMs7l1aZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=RBVs3WAQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l/TBRaWJ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 51000EC011D;
	Mon, 13 Oct 2025 11:35:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 13 Oct 2025 11:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760369720; x=
	1760456120; bh=OPB5SMW+lHPjunu0k1S6OSGIl+NjGPYXXkp++jujHjc=; b=R
	BVs3WAQOfMULREgtrtY1j2C54NlWnyRSygLSeH/5N/bc6jzLTuPF6O+N77hlfvNn
	Ehp0CGntcrwigT6+AjSynO/tJzra/14Tz0mcGWoWTsSIzxShBmzfjDtJflTHwNZ1
	aOz/x8vkyIMWfywtGgwQWmY1IITjkzUsix/gjS+1ogRRO9fV3BRlCIJDAM8+LzCb
	sUu5IrfApYPPMJDSveQVXTycbWVJeTeUgZzuiwbb5WXgp3mBXMqc0erOamjq0izf
	K4+D/deq0MHKt/pIheQ2LjeqKnKAxZExmCRCYA2pRm1KESNU4DcoA/cYHcWoOmTm
	y6dbdPbfL9/F4J3a3DylA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760369720; x=1760456120; bh=OPB5SMW+lHPjunu0k1S6OSGIl+NjGPYXXkp
	++jujHjc=; b=l/TBRaWJuuigxcBJNxOcA6I1Na0vy3c1+eYjELfG59/7EAIzDnS
	PzhoRmoEvN7YOaeQ3WdiqxhNu7pn05o5QHZpuS4tjSsykiXsMdsKNm3yDFS7ogG3
	1vnA2OyPwRQQHVdT99EFpltLPmk+9UUFLdtu4FWqd37NqXZ+XYtpHLnMfBRZLjzc
	VUST3LLvfSAKjnVzrSkaSRLGYWaO6zasM5KCs23g1OzKpYR4Y3qXCmeFs+xqDfRA
	G8dAOAEE3NRlK8ztZcdBx0MztIA0nk/AlMdgaPBE6NsENJqR4DVZW9bauJoYdoOV
	fX6AmsaIADiMI1RO5j7V5F/PkOUfbZfVzYQ==
X-ME-Sender: <xms:NxztaGDqSsKb-oWwzFjngsOQB4qUz4dl_h2XRl_qmzWYxm0T_MBIRQ>
    <xme:NxztaDkMbYkUHQHEzBsxUo_froeWWVFncgR2d2W4IUbMb4SO1FTw3rAJ8B3lAmB12
    0eNSbKbiIkOJ3UtzZO21H2nigdWRGbmST9oW-_JLMRRWMhQmle09Ec>
X-ME-Received: <xmr:NxztaENCE4vWkfdBYl3T25oyS9KIy7cqoPGPcSwxcgu_IjQ18hpj1eq3mrAapQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudektdefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:NxztaA_ggY1V5u_3sPrn8yB0vLlJhbrJFa0fLHDMOXeVbE8AtWWW6A>
    <xmx:NxztaGFJLhPYlT9eEOKCsTMdkqF4S7LshJp_Qs5PMBbZ5DuD1c-VTw>
    <xmx:NxztaPh0gEaDeGgeQ58fdeMZFCcqaFvTqwQlc-wy3usmrE1UgoFRqA>
    <xmx:NxztaLtf49s-ksGDkLL34_XkxC5-iljSp173jO89tKbkhDlJpGWRXA>
    <xmx:OBztaOlSgIhBOuCSrqqOxJFHDFWmdmbFnwqJOBBrj2GPJXuudhxTwSUR>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 11:35:19 -0400 (EDT)
Date: Mon, 13 Oct 2025 16:35:17 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Optimizing small reads
Message-ID: <jzpbwmoygmjsltnqfdgnq4p75tg74bdamq3hne7t32mof4m5xo@lcw3afbr4daf>
References: <CAHk-=wiTqdaadro3ACg6vJWtazNn6sKyLuHHMn=1va2+DVPafw@mail.gmail.com>
 <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
 <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com>
 <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp>
 <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
 <CAHk-=wi42ad9s1fUg7cC3XkVwjWFakPp53z9P0_xj87pr+AbqA@mail.gmail.com>
 <nhrb37zzltn5hi3h5phwprtmkj2z2wb4gchvp725bwcnsgvjyf@eohezc2gouwr>
 <CAHk-=wi1rrcijcD0i7V7JD6bLL-yKHUX-hcxtLx=BUd34phdug@mail.gmail.com>
 <qasdw5uxymstppbxvqrfs5nquf2rqczmzu5yhbvn6brqm5w6sw@ax6o4q2xkh3t>
 <CAHk-=wg0r_xsB0RQ+35WPHwPb9b9drJEfGL-hByBZRmPbSy0rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg0r_xsB0RQ+35WPHwPb9b9drJEfGL-hByBZRmPbSy0rQ@mail.gmail.com>

On Fri, Oct 10, 2025 at 10:51:40AM -0700, Linus Torvalds wrote:
> Sounds like a plan?

The patch is below. Can I use your Signed-off-by for it?

Here's some numbers. I cannot explain some of this. Like, there should
be zero changes for block size above 256, but...

I am not confident enough in these measurements and will work on making
them reproducible. Looks like there's sizable boot-to-boot difference.

I also need to run xfstests. Unless someone can help me with this?
I don't have ready-to-go setup.

16 threads, reads from 4k file(s), MiB/s

 ---------------------------------------------------------
| Block | Baseline  | Baseline   | Patched   |  Patched   |
| size  | same file | diff files | same file | diff files |
 ---------------------------------------------------------
|     1 |      11.6 |       27.6 |      33.5 |       33.4 |
|    32 |     375   |      880   |    1027   |     1028   |
|   256 |    2940   |     6932   |    7872   |     7884   |
|  1024 |   11500   |    26900   |   11400   |    28300   |
|  4096 |   46500   |   103000   |   45700   |   108000   |
 ---------------------------------------------------------


16 threads, reads from 1M file(s), MiB/s

 ---------------------------------------------------------
| Block | Baseline  | Baseline   | Patched   |  Patched   |
| size  | same file | diff files | same file | diff files |
 ---------------------------------------------------------
|     1 |      26.8 |       27.4 |      32.0 |       32.2 |
|    32 |     840   |      872   |    1034   |     1033   |
|   256 |    6606   |     6904   |    7872   |     7919   |
|  1024 |   25700   |    26600   |   25300   |    28300   |
|  4096 |   96900   |    99000   |  103000   |   106000   |
 ---------------------------------------------------------

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
index 751838ef05e5..8c39a9445471 100644
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
@@ -2659,6 +2661,92 @@ static void filemap_end_dropbehind_read(struct folio *folio)
 	}
 }
 
+static inline unsigned long filemap_read_fast_rcu(struct address_space *mapping,
+						  loff_t pos, char *buffer,
+						  size_t size)
+{
+	XA_STATE(xas, &mapping->i_pages, pos >> PAGE_SHIFT);
+	struct folio *folio;
+	loff_t file_size;
+	unsigned int seq;
+
+	lockdep_assert_in_rcu_read_lock();
+
+	seq = read_seqcount_begin(&mapping->i_pages_delete_seqcnt);
+
+	xas_reset(&xas);
+	folio = xas_load(&xas);
+	if (xas_retry(&xas, folio))
+		return 0;
+
+	if (!folio || xa_is_value(folio))
+		return 0;
+
+	if (!folio_test_uptodate(folio))
+		return 0;
+
+	/* No fast-case if readahead is supposed to started */
+	if (folio_test_readahead(folio))
+		return 0;
+	/* .. or mark it accessed */
+	if (!folio_test_referenced(folio))
+		return 0;
+
+	/* i_size check must be after folio_test_uptodate() */
+	file_size = i_size_read(mapping->host);
+	if (unlikely(pos >= file_size))
+		return 0;
+	if (size > file_size - pos)
+		size = file_size - pos;
+
+	/* Do the data copy */
+	size = memcpy_from_file_folio(buffer, folio, pos, size);
+	if (!size)
+		return 0;
+
+	/* Give up and go to slow path if raced with page_cache_delete() */
+	if (read_seqcount_retry(&mapping->i_pages_delete_seqcnt, seq))
+		return 0;
+
+	return size;
+}
+
+static inline bool filemap_read_fast(struct kiocb *iocb, struct iov_iter *iter,
+				ssize_t *already_read,
+				char *buffer, size_t buffer_size)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	struct file_ra_state *ra = &iocb->ki_filp->f_ra;
+	size_t count;
+
+	if (ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE)
+		return false;
+
+	if (iov_iter_count(iter) > buffer_size)
+		return false;
+
+	count = iov_iter_count(iter);
+
+	/* Let's see if we can just do the read under RCU */
+	rcu_read_lock();
+	count = filemap_read_fast_rcu(mapping, iocb->ki_pos, buffer, count);
+	rcu_read_unlock();
+
+	if (!count)
+		return false;
+
+	count = copy_to_iter(buffer, count, iter);
+	if (unlikely(!count))
+		return false;
+
+	iocb->ki_pos += count;
+	ra->prev_pos = iocb->ki_pos;
+	file_accessed(iocb->ki_filp);
+	*already_read += count;
+
+	return !iov_iter_count(iter);
+}
+
 /**
  * filemap_read - Read data from the page cache.
  * @iocb: The iocb to read.
@@ -2679,7 +2767,10 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	struct file_ra_state *ra = &filp->f_ra;
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
-	struct folio_batch fbatch;
+	union {
+		struct folio_batch fbatch;
+		__DECLARE_FLEX_ARRAY(char, buffer);
+	} area __uninitialized;
 	int i, error = 0;
 	bool writably_mapped;
 	loff_t isize, end_offset;
@@ -2693,7 +2784,20 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		return 0;
 
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes - iocb->ki_pos);
-	folio_batch_init(&fbatch);
+
+	/*
+	 * Try a quick lockless read into the 'area' union. Note that
+	 * this union is intentionally marked "__uninitialized", because
+	 * any compiler initialization would be pointless since this
+	 * can fill it will garbage.
+	 */
+	if (filemap_read_fast(iocb, iter, &already_read, area.buffer, sizeof(area)))
+	    return already_read;
+
+	/*
+	 * This actually properly initializes the fbatch for the slow case
+	 */
+	folio_batch_init(&area.fbatch);
 
 	do {
 		cond_resched();
@@ -2709,7 +2813,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		if (unlikely(iocb->ki_pos >= i_size_read(inode)))
 			break;
 
-		error = filemap_get_pages(iocb, iter->count, &fbatch, false);
+		error = filemap_get_pages(iocb, iter->count, &area.fbatch, false);
 		if (error < 0)
 			break;
 
@@ -2737,11 +2841,11 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		 * mark it as accessed the first time.
 		 */
 		if (!pos_same_folio(iocb->ki_pos, last_pos - 1,
-				    fbatch.folios[0]))
-			folio_mark_accessed(fbatch.folios[0]);
+				    area.fbatch.folios[0]))
+			folio_mark_accessed(area.fbatch.folios[0]);
 
-		for (i = 0; i < folio_batch_count(&fbatch); i++) {
-			struct folio *folio = fbatch.folios[i];
+		for (i = 0; i < folio_batch_count(&area.fbatch); i++) {
+			struct folio *folio = area.fbatch.folios[i];
 			size_t fsize = folio_size(folio);
 			size_t offset = iocb->ki_pos & (fsize - 1);
 			size_t bytes = min_t(loff_t, end_offset - iocb->ki_pos,
@@ -2772,13 +2876,13 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			}
 		}
 put_folios:
-		for (i = 0; i < folio_batch_count(&fbatch); i++) {
-			struct folio *folio = fbatch.folios[i];
+		for (i = 0; i < folio_batch_count(&area.fbatch); i++) {
+			struct folio *folio = area.fbatch.folios[i];
 
 			filemap_end_dropbehind_read(folio);
 			folio_put(folio);
 		}
-		folio_batch_init(&fbatch);
+		folio_batch_init(&area.fbatch);
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
 	file_accessed(filp);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

