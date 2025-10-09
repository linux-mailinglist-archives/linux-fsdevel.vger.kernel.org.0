Return-Path: <linux-fsdevel+bounces-63670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA99BCA2C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 18:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0591884D6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 16:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470B202976;
	Thu,  9 Oct 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="d9ttPxE/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QVpu+eMF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CCE178372
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026940; cv=none; b=W0zHHd0iAxUiWI5fDqCpj/BInAorijIaq9MoQTC3IIngtSHIdcXrtJ1wWiNIuYL57kDfZgMjpqDc7kvJcpNW1C+nk+AkzkueptCni6lv0VmMfiLxK7nWvq5algWClhk1/RtD3/tc0IpVWiaLvPG2xRy6yD3MK4tor4KHTunnPX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026940; c=relaxed/simple;
	bh=h6JZusk1EGT35wMfCYIxotCO9fqHGDZ/LMknJKpG20Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOpgMJCXfvgKIO3jp3w3mJD9RIj3ybw0La+bka06SyJHoECj+sFw2ne7yG1mFUZSi/MabF3i7IcWPnnu2cEzWY2t84wsmeeS5B8FApkaErqzSaE0G/+AktKQZdPr55Zo1T5Z0j1oxnGURky8SkTXn6m2AdtRvAJANfRww+aGDb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=d9ttPxE/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QVpu+eMF; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA9E57A00A4;
	Thu,  9 Oct 2025 12:22:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 09 Oct 2025 12:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760026936; x=
	1760113336; bh=egk7Oe6IWqbN1+isawtTksqL1RtsIJ0Y3N3WpC9pjfs=; b=d
	9ttPxE/fNAYDf16LWN9s2Bn3iFoiqg8trr7Zl9T86ZwoakQBfwWEn78Iu6kn8O+x
	6dBNqeJ1QnqZuOE6Fi8YkIrwd7XAwo3UXTfS/4c7d9dNqoWrkEJLTk7g4KjWuIxi
	XwtZiEsbBvuB/s6Te14UeUCx8lWoA1LrpoXDIQ9pYF8ke36g+igfiBavFTb+wDvX
	VxB17Nl9QiPvth6FTMHFJG7oullYVonyVnZa7pj0WFrm4Ag60iEbnTcfgaxYCSOi
	YGEFUTOUWWFbjvHrteamR210hnCF68VuA28tZ4TUIaD9ApUNUTy8YdSoCbARpZkA
	iS3vRT+F0c2F3QHJjBODw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760026936; x=1760113336; bh=egk7Oe6IWqbN1+isawtTksqL1RtsIJ0Y3N3
	WpC9pjfs=; b=QVpu+eMFixBnn7GVxFdGsHOzlA0ul5Nd4HRlaRWea3uVy6ejC9P
	jk5nQ9cI2YgEyELHuh9ODaw0VdxcghlywKyyvwESL7qruCJ8/zIwEFDxJGCr8s0v
	egPazDO6ws2DdfKqzGsaEf/KoSXtoB3AnGreG/dQU/YTKaspZaqe9v7L0ztlvFYZ
	uFS3ToauiOcXMudoPA9I9Q5yzUa28iGvsiuyeUFeyRg1QQVYuoBunIi0fws9A7VL
	wHoWziSVVVGAYtVy2zasAUOogI+pl9hUZkXmftjFhoMYrxM3fFM+KpGb4kmLp7Oz
	+sqLpk1rvA9aoGMb6jnw17ZbCTVYJWFR8mg==
X-ME-Sender: <xms:OOHnaF4pjWnFFKIhkjU6-5lTu_BZ5meteBQbb9HYceGhO0xiDeQllg>
    <xme:OOHnaATpCsf53hrlmdFCy7VNRaC6t8HEtxJJb-bNijsj0TFfx5LRdFYxuh-Y7jZMC
    6jT-8KujD8jca3fHgGLvulJGtr4K43r1hsllan01X0nGd0xuZHfY7g>
X-ME-Received: <xmr:OOHnaDxGsa2TNBAr5owoed4WwDVbjuwe0IDAudqs5b78GMynJmcgV-9wq9JBoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeiieehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:OOHnaIo4pZQXjV-r4LDkfAz-LeJNGNfalvOTyGe54UyDYRUm9E8Zcg>
    <xmx:OOHnaG0fz0jUFB-qsVFJybbe1nWWGs98PPAY8IgDn4hvkTYWbt3JnQ>
    <xmx:OOHnaIwRYx62yzHA1ml-qzRGBTTVa5TefFJLJpQR3fzTBAzvFulrHA>
    <xmx:OOHnaKjGeumwiIaxJbMmPnWb2PuvNfH-vEvmpNGU8FVa7K2RwaovlQ>
    <xmx:OOHnaCsV4PszXl-ggSlFE5hpVrFPImXOv6zkNQ-Wk9ShDaCVn41yNEdY>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 12:22:16 -0400 (EDT)
Date: Thu, 9 Oct 2025 17:22:13 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Optimizing small reads
Message-ID: <nhrb37zzltn5hi3h5phwprtmkj2z2wb4gchvp725bwcnsgvjyf@eohezc2gouwr>
References: <4bjh23pk56gtnhutt4i46magq74zx3nlkuo4ym2tkn54rv4gjl@rhxb6t6ncewp>
 <CAHk-=wi4Cma0HL2DVLWRrvte5NDpcb2A6VZNwUc0riBr2=7TXw@mail.gmail.com>
 <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka>
 <CAHk-=wjDvkQ9H9kEv-wWKTzdBsnCWpwgnvkaknv4rjSdLErG0g@mail.gmail.com>
 <CAHk-=wiTqdaadro3ACg6vJWtazNn6sKyLuHHMn=1va2+DVPafw@mail.gmail.com>
 <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
 <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com>
 <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp>
 <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
 <CAHk-=wi42ad9s1fUg7cC3XkVwjWFakPp53z9P0_xj87pr+AbqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi42ad9s1fUg7cC3XkVwjWFakPp53z9P0_xj87pr+AbqA@mail.gmail.com>

On Wed, Oct 08, 2025 at 10:03:47AM -0700, Linus Torvalds wrote:
> On Wed, 8 Oct 2025 at 09:27, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, 8 Oct 2025 at 07:54, Kiryl Shutsemau <kirill@shutemov.name> wrote:
> > >
> > > Disabling SMAP (clearcpuid=smap) makes it 45.7GiB/s for mine patch and
> > > 50.9GiB/s for yours. So it cannot be fully attributed to SMAP.
> >
> > It's not just smap. It's the iov iterator overheads I mentioned.
> 
> I also suspect that if the smap and iov overhead are fixed, the next
> thing in line is the folio lookup.

Below is the patch I currently have.

I went for more clear separation of fast and slow path.

Objtool is not happy about calling random stuff within UACCESS. I
ignored it for now.

I am not sure if I use user_access_begin()/_end() correctly. Let me know
if I misunderstood or misimplemented your idea.

This patch brings 4k reads from 512k files to ~60GiB/s. Making the
buffer 4k, brings it ~95GiB/s (baseline is 100GiB/s).

I tried to optimized folio walk, but it got slower for some reason. I
don't yet understand why. Maybe something silly. Will play with it more.

Any other ideas?

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
index 751838ef05e5..732756116b6a 100644
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
@@ -2659,41 +2661,106 @@ static void filemap_end_dropbehind_read(struct folio *folio)
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
+static bool filemap_read_fast(struct kiocb *iocb, struct iov_iter *iter,
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
+	if (!user_access_begin(iter->ubuf + iter->iov_offset, iter->count))
+		return false;
+
+	rcu_read_lock();
+	pagefault_disable();
+
+	do {
+		size_t to_read, read;
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
+		do {
+			if (unlikely(iocb->ki_pos >= file_size))
+				goto out;
+
+			to_read = min(iov_iter_count(iter), buffer_size);
+			if (to_read > file_size - iocb->ki_pos)
+				to_read = file_size - iocb->ki_pos;
+
+			read = memcpy_from_file_folio(buffer, folio, iocb->ki_pos, to_read);
+
+			/* Give up and go to slow path if raced with page_cache_delete() */
+			if (read_seqcount_retry(&mapping->i_pages_delete_seqcnt, seq))
+				goto out;
+
+			unsafe_copy_to_user(iter->ubuf + iter->iov_offset, buffer,
+					    read, out);
+
+			iter->iov_offset += read;
+			iter->count -= read;
+			*already_read += read;
+			iocb->ki_pos += read;
+			last_pos = iocb->ki_pos;
+		} while (iov_iter_count(iter) && iocb->ki_pos % folio_size(folio));
+	} while (iov_iter_count(iter));
+out:
+	pagefault_enable();
+	rcu_read_unlock();
+	user_access_end();
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
@@ -2709,7 +2776,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		if (unlikely(iocb->ki_pos >= i_size_read(inode)))
 			break;
 
-		error = filemap_get_pages(iocb, iter->count, &fbatch, false);
+		error = filemap_get_pages(iocb, iter->count, fbatch, false);
 		if (error < 0)
 			break;
 
@@ -2737,11 +2804,11 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
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
@@ -2772,19 +2839,57 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
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

