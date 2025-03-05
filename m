Return-Path: <linux-fsdevel+bounces-43274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308B3A50412
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 17:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 039547A96B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 15:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345B7250C12;
	Wed,  5 Mar 2025 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cuebFD0f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142FB250BEE;
	Wed,  5 Mar 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190378; cv=none; b=Jzv9Gog95gfAxItxDnwkfitWhzHNv8fR+5LY8yXfTgR+n6wfbyGZRILTnDsEq4WVM8H3OFQTwhvELXYZgZTljUnjqMYtzGPsy6z6CYBIlkNQPHdO3lEkL8SFzRNC98945EhNRaCE2qoQkOAv1mgLsFyXZ2HfXHvNR/vdFr/k+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190378; c=relaxed/simple;
	bh=dVrd3bxbvY+FsSevRcyAihaMyt5R8GgUmLf0kNFsQ6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUXeb6PdxwUWLUcKbN4SVeXK6jHQGhjU1hlyXTZlCQw3UEkJ/qyWuw/j03++8C52BeuhZ65l6iVJm+fV7vt1AezQEapehvuqYIBFocAa1jbupyXLXCYakWX2WACR5ApEOL/g5gNK8ghDqvMPVsRpVtzDkM16PNMfhhw1pSa3kJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cuebFD0f; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7Y2iYOEFpNWqetRFh3zM7CAI67w9Q6a6A/VNoZkwi3s=; b=cuebFD0f3VLMeu0TXyDdxu1vVM
	U8gApbbelpc2C51zn9IG5PffrLZyy8/9L80Ok4B475uNs2O7F85ae8kVA5vhDMIXJT/YCDkO/N9sd
	MJaPV9rQ9F1c3TKkWM55Sc6hZRtZnLIP/Jl6EAB5JRLOQF+YD7MHr1Tf4IvwqaWiPpaBCKXcMA2ej
	yyvvrEaFCRS+fAlAfChk+1rUCovmf1Qxzyt/9p3N4/mCI32EAZ4hyzBuUBws8ri/82y/1aI9NIe26
	kXVz5JAD23Zz5heneqv6Z9sIRvdRznU6oda9hymsTcdMfJHbIRJpOtcSoJDSaBPiTjDXt0NIVXBxV
	4jVPjBPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpr9c-00000005oQd-46ye;
	Wed, 05 Mar 2025 15:59:29 +0000
Date: Wed, 5 Mar 2025 15:59:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: introduce anon_vma flags, reduce kernel
 allocs
Message-ID: <Z8h04F4b_YVMhXCM@casper.infradead.org>
References: <cover.1741185865.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741185865.git.lorenzo.stoakes@oracle.com>

On Wed, Mar 05, 2025 at 02:55:06PM +0000, Lorenzo Stoakes wrote:
> So adding additional fields is generally unviable, and VMA flags are
> equally as contended, and prevent VMA merge, further impacting overhead.
> 
> We can however make use of the time-honoured kernel tradition of grabbing
> bits where we can.
> 
> Since we can rely upon anon_vma allocations being at least system
> word-aligned, we have a handful of bits in the vma->anon_vma available to
> use as flags.

I'm not a huge fan when there's a much better solution.  It's an
unsigned long, but we can only use the first 32 bits because of 32-bit
compatibility?  This is a noose we've made for our own neck.

(there are many more places to fix up; this is illustrative):

diff --git a/include/linux/hugetlb_inline.h b/include/linux/hugetlb_inline.h
index 0660a03d37d9..c6ea81ff4afe 100644
--- a/include/linux/hugetlb_inline.h
+++ b/include/linux/hugetlb_inline.h
@@ -8,7 +8,7 @@
 
 static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
 {
-	return !!(vma->vm_flags & VM_HUGETLB);
+	return test_bit(VM_HUGETLB, vma->vm_flags);
 }
 
 #else
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0ca9feec67b8..763210ba70b6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -571,7 +571,8 @@ static inline void *folio_get_private(struct folio *folio)
 	return folio->private;
 }
 
-typedef unsigned long vm_flags_t;
+#define VM_FLAGS_COUNT	(8 / sizeof(unsigned long))
+typedef unsigned long vm_flags_t[VM_FLAGS_COUNT];
 
 /*
  * A region containing a mapping of a non-memory backed file under NOMMU

