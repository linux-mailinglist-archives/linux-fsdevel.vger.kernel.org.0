Return-Path: <linux-fsdevel+bounces-68763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 668FCC65A6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F318A4E4AE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 18:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA543064B3;
	Mon, 17 Nov 2025 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eHaFn+bN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE082848AA;
	Mon, 17 Nov 2025 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763402628; cv=none; b=JwYVbDFkOpuXTr4Ah2ffJBFoHGO7P14fXfvWw/v01R0kttGJUt7lu0T+HDNeNbvD1PKzFixs6ACDw/eeDYOP67yC4AnPR61YX+A4RKbblPmnH/t5gB5mP/dcOyNjplfD7aIVJeRzaU+gOXvwA/tYCd4YsaXxBJMkNATT2NpPxFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763402628; c=relaxed/simple;
	bh=9uMwZN9krUdS78DbjxNt+iqrRQ4nPzVTYJyUwBnvW5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjCKNRW8jFslMuAPZmhWFNJu3HrORXhtKtC4wL2px+kKkNw6YDAI+iVwHbAZW2wQoT62Gp+7ZevKrjuep5rtulYhK20vmWRqOZ6R/av57hgA9QBPiMxEaSK5Tdzbj8pX8HhJzObK/OcmEbNDZDxqk8Q838Gv6J8npRW97iSbahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eHaFn+bN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U5Cie80ik2JSvccL39+8gipzyyJCojAXux/hEMXLbb0=; b=eHaFn+bNRcbBqqPbDECTU1nha+
	8ki4ktpeVqfjrOojFTJy4b9CsRE7DSDpiExAIK3uzWeofkrlLPwdhdwxMXhHe3VZW8PtST3ZW88Pl
	Mb8itCOIMTljNTR12RzQJWDMna902aYOJpxvJyIfpZR96OFCALwZxEM3RMHkbiIXpi8azElvRRL+o
	LNuvhXUzES1FgnU8cEMpzaBUqAB9XoqOY0mI7SKxuGXU1HMnorWwn+3kNsON1xIn/WQynngm2/gsM
	s8xKMfEQlUL7uY19UD0Cmucf9uEgC4IVsl3h+psRtvvDS6i942u/P+P+TZbpHXhiD2VdxV8kzrBle
	XxvP7Akg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL3Zl-0000000EEaq-0Kni;
	Mon, 17 Nov 2025 18:03:41 +0000
Date: Mon, 17 Nov 2025 18:03:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>, akpm@linux-foundation.org,
	shakeel.butt@linux.dev, eddyz87@gmail.com, andrii@kernel.org,
	ast@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/filemap: fix NULL pointer dereference in
 do_read_cache_folio()
Message-ID: <aRtjfN7sC6_Bv4bx@casper.infradead.org>
References: <20251114193729.251892-1-ssranevjti@gmail.com>
 <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
 <aRpQ7LTZDP-Xz-Sr@casper.infradead.org>
 <20251117164155.GB196362@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117164155.GB196362@frogsfrogsfrogs>

On Mon, Nov 17, 2025 at 08:41:55AM -0800, Darrick J. Wong wrote:
> I wondered why this whole thing opencodes kernel_read, but then I
> noticed zero fstests for it and decid*******************************
> *****.

I wondered the same thing!  And the answer is that it's special BPF
stuff:

        /* if sleeping is allowed, wait for the page, if necessary */
        if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate(r->folio))) {
                filemap_invalidate_lock_shared(r->file->f_mapping);
                r->folio = read_cache_folio(r->file->f_mapping, file_off >> PAGE_SHIFT,
                                            NULL, r->file);
                filemap_invalidate_unlock_shared(r->file->f_mapping);
        }

if 'may_fault' (a misnomer since it really means "may sleep"), then we
essentially do kernel_read().

Now, maybe the right thing to do here is rip out almost all of
lib/buildid.c and replace it with an iocb with IOCB_NOWAIT set (or not).
I was hesitant to suggest this earlier as it's a bit of a big ask of
someone who was just trying to submit a one-line change.  But now that
"it's also shmem" has entered the picture, I'm leaning more towards this
approach anyway.

Looking at it though, it's a bit weird that we don't have a
kiocb_read().  It feels like __kernel_read() needs to be split into
half like:

diff --git a/fs/read_write.c b/fs/read_write.c
index 833bae068770..a3bf962836a7 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -503,14 +503,29 @@ static int warn_unsupported(struct file *file, const char *op)
 	return -EINVAL;
 }
 
-ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
+ssize_t kiocb_read(struct kiocb *iocb, void *buf, size_t count)
 {
+	struct file *file = iocb->ki_filp;
 	struct kvec iov = {
 		.iov_base	= buf,
 		.iov_len	= min_t(size_t, count, MAX_RW_COUNT),
 	};
-	struct kiocb kiocb;
 	struct iov_iter iter;
+	int ret;
+
+	iov_iter_kvec(&iter, ITER_DEST, &iov, 1, iov.iov_len);
+	ret = file->f_op->read_iter(iocb, &iter);
+	if (ret > 0) {
+		fsnotify_access(file);
+		add_rchar(current, ret);
+	}
+	inc_syscr(current);
+	return ret;
+}
+
+ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
+{
+	struct kiocb kiocb;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_READ)))
@@ -526,15 +541,9 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = pos ? *pos : 0;
-	iov_iter_kvec(&iter, ITER_DEST, &iov, 1, iov.iov_len);
-	ret = file->f_op->read_iter(&kiocb, &iter);
-	if (ret > 0) {
-		if (pos)
-			*pos = kiocb.ki_pos;
-		fsnotify_access(file);
-		add_rchar(current, ret);
-	}
-	inc_syscr(current);
+	ret = kiocb_read(&kiocb, buf, count);
+	if (pos && ret > 0)
+		*pos = kiocb.ki_pos;
 	return ret;
 }
 

