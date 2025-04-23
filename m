Return-Path: <linux-fsdevel+bounces-47052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE216A98154
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D4C3A98AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 07:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D84C266F0A;
	Wed, 23 Apr 2025 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rWPYlumt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB1223DC8
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394055; cv=none; b=QVDCG0Ve1P5EygnbnW3E0DDvELWGg9Vfu4guvGvn2+LKbBwKNlbg9n84vhdb7h/AdG2FORtowYYD9vcMp/+zA72rl2OYN1znxlA4/2fs6JN3PePQQE6QyBIGtvMrM4UtR7wu1gINJ8geKOD8WmYMfM4+oQ8Hb+cxw19cdzC9Dp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394055; c=relaxed/simple;
	bh=EfBoZXjXTtDKEalbqy9SvEPvJ54c1ATM6Bo5yO9zALA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiQlu2hVfDQ2LbrNOosDCQUoukbSNpTEmcFTj0g/aMAhrVUr5p0p97RJ4C8S7UkvqLOaUXmknYt+hQ7UJ5roD8ZE0s6mvT93o/LcQW7b6XsSy4kn5HnYv5ZITGiXuGdtY+2Onxt1m4TfKllzcpCO9rzBrBh6geWu560sh86gY6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rWPYlumt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tZ9GDyJ+omWmtLR6nVAZpdYReReTCnKrzNWIFZor5Fo=; b=rWPYlumtzGwCZ8eW4KoUSDVgvK
	FQVjzgZWyJrN3XyFbcaeN9vqvTj7Gj5Uy+zpdOSc532fC6hJVF8m0BA2Zh4sef8Q5+qc2+fjOKRzy
	htIV+5KewjwKvXVjACET/UQ8742y7lEz3zJes1kZwSt2DWV0EmHWWDf5DSyTJUgUEdRfCp2h1FoG6
	YvYx8UgCaGRv3tcSZ/gU/ojhxP/D0iALVqH3B9rMsC5QY/OEgXoQc+21lt2xeWL/tYVFGLEdl97HF
	fMOeqhRoRckr5y+UUdTi6iEU8yRKJl9uaZENmdAX8qNZIy1Yq+a9yvhKFChxgjRHPl7BUoM4T8GKu
	XC6fC6Qg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Uil-00000009Dg0-2pCZ;
	Wed, 23 Apr 2025 07:40:39 +0000
Date: Wed, 23 Apr 2025 08:40:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Tobin C. Harding" <tobin@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Rik van Riel <riel@surriel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Michal Hocko <mhocko@kernel.org>, Byungchul Park <byungchul@sk.com>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [DISCUSSION] Revisiting Slab Movable Objects
Message-ID: <20250423074039.GE2023217@ZenIV>
References: <aAZMe21Ic2sDIAtY@harry>
 <aAa-gCSHDFcNS3HS@dread.disaster.area>
 <20250423014732.GC2023217@ZenIV>
 <aAiUtCKJOdWjYxDZ@harry>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAiUtCKJOdWjYxDZ@harry>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 23, 2025 at 04:20:20PM +0900, Harry Yoo wrote:

> If we can't migrate or reclaim dentries with a nonzero refcount,
> can we at least prevent slab pages from containing a mix of dentries
> with zero and nonzero refcounts?
> 
> An idea: "Migrate a dentry (and inode?) _before_ it becomes unrelocatable"
> This is somewhat similar to "Migrate a page out of the movable area before
> pinning it" in MM.
> 
> For example, suppose we have two slab caches for dentry:
> dentry_cache_unref and dentry_cache_ref.
> 
> When a dentry with a zero refcount is about to have its refcount
> incremented, the VFS allocates a new object from dentry_cache_ref, copies
> the dentry into it, frees the original dentry back to
> dentry_cache_unref, and returns the newly allocated object.
> 
> Similarly when a dentry with a nonzero refcount drops to zero,
> it is migrated to dentry_cache_unref. This should be handled on the VFS
> side rather than by the slab allocator.
> 
> This approach could, at least, help reduce fragmentation.

No.  This is utterly insane - you'd need to insert RCU delay on each
of those transitions and that is not to mention the frequency with
which those will happen on a lot of loads (any kind of builds included).
Not a chance.

