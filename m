Return-Path: <linux-fsdevel+bounces-64676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB5BF0B7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 13:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D9174F31F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69582F6191;
	Mon, 20 Oct 2025 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="KQ6/Lan2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B2B4UIf+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D5224E4C3;
	Mon, 20 Oct 2025 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958207; cv=none; b=tOfnxqMW1ub2kPuRhDnK14n+ZfGvJHgWziZqHKmXeaMeuA8zKIsj8Z/+GdEu2PH+t+Nab+EM2WNd+M/23wG0EQt3S9SB/Q1tv0kDubHL8uZHmpYf46n4Sfk4kerH1rxLiEpMLj/I9bFSuCVUNF1TFj+lHpQOW2UNHJ2qoESNmtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958207; c=relaxed/simple;
	bh=ayF1i2iD1GhrzNTKKehinAMWa6Vi9YZzyjGXIhUg73U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRJbZpDNSkgpwi0GgwkDDdKErf+ca1w6aD7V04yPAl1B06HcY7OzvaFPb+jFldbOzeQ58lmgei40qRBBrN7nW0X2h9nMxhf8xJjhsmHjsMOhy85tg5mCdwOvkX7izJACz3N/Mj24Ddcg8irM/o9Y1GmfT7FEuUxewcyy3kLNfag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=KQ6/Lan2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B2B4UIf+; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B47BC7A0084;
	Mon, 20 Oct 2025 07:03:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 20 Oct 2025 07:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1760958203; x=
	1761044603; bh=DHnlJgCY+BcwVzCJL3u2NoFmsd7fzUk54TShq+8Hw/Q=; b=K
	Q6/Lan23VJ6Ce3zU/AHzPubMJ9AftWfrxL38CjvzWS4fyD9wk3Myxw4KOl6W7CtW
	2qInLiXoUzdnMOMwE6BhcKnTeuoQG7xjB6jbXhelhz9U6IjFpfZK5T7KdDmQ3tKS
	vLgv2G2wxJ1qrWgkHY9LKCNWhm5/Sly16j5ABinZdqJ3ZEeMgNajIUkC2NADHH3u
	pTMFE03RxjoKoxw4UJRk7ep3SWu3cPBtYLfI/xBjAOom8JcS4sd9GeN4OgfAdOhg
	SNEVPWz+656SD1Yd3wBEPC5KTJXDVuqxRO/dDAq9Fc+NmIQ4daTKLpG5tWWqS+HW
	CMk0RUUD+VueRMMup7wgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760958203; x=1761044603; bh=DHnlJgCY+BcwVzCJL3u2NoFmsd7fzUk54TS
	hq+8Hw/Q=; b=B2B4UIf+K0dMdDDJJzLUHrIjBZvism2roI2+kQZb6KrkfX1KMf9
	nIBnhx3SKYbgLYOKnI1TAvv2C9o3OH8NFAkqcD56X8ugW38o/zdSZBabvu99CC2M
	2IEA0Fmvv0ncl/F7bse1BRKsevasZgMrAsHtzxNwlnwvwbW5AQMo5mTEXoy4v8vx
	KIY7Poxye4MAm4wKcMj+eyvOXkTMHjxXi+SeInX4c3FckvEJ/JT9W4/DtwDcLqe5
	RP1HRz4NT/UKN+UrWXQ4vvWjZOZN3zd8VlNFxs0SvtIMSf1HSRXYw5vdrrezuTer
	QsSfEOT4HQ6VqpPZEuyXjdOgPLDhN4TTKCg==
X-ME-Sender: <xms:-Rb2aE95kqo0YoMNdxI6MXyxVljMheqWCPsHhOQnlMlSUBuTBLSwjQ>
    <xme:-Rb2aOBRAC71rF7e828MnY_AckmLK9eolwPJz0SD0yVOpTgaTm0V7n3BoWPbLm1pc
    id_y_08nCzMcI_yXVptokqAcYa-mdQb92O1hq2gy7QoS24McSRzqT8>
X-ME-Received: <xmr:-Rb2aOogYTX0NabHDV6FusGbYblXHo_ApMbYyghSlMJgSFSC91POb6S-Qk-cuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughssehlihhnuh
    igqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidq
    fhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrd
    gtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphht
    thhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsg
    hrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdr
    tgiipdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-Rb2aHLnYOxc_97YeUZzbMpdb8bwVde-55zUlnGsRXbqN5E2XUxVYw>
    <xmx:-Rb2aAKVcDSSFCwkvuB930eGLtrHF0JDDhfnxO-MAzMQtn9jPi7Rdg>
    <xmx:-Rb2aAkFFK-41lOORdZfp0iHV9ps55ecgDAugO8Dp_vCmrQGbALxJA>
    <xmx:-Rb2aGJ-Fs_ZauAUoHQe2YZCcvi5Ps4C43vZPHeCcOfYukj0HxDeuA>
    <xmx:-xb2aPjFOg5xJRQW4h8_rPIlfbfCMvfKzNXKtqLV0GNdXLAh3kZ-9_DH>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 07:03:21 -0400 (EDT)
Date: Mon, 20 Oct 2025 12:03:18 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <xsrbm3qilii5cpfbnya2u5dleigbxej4ewctp2yj7i7avkkkkq@yknrffjv2bju>
References: <20251017141536.577466-1-kirill@shutemov.name>
 <CAHk-=wgijo0ThKoYZeypuZb2YHCL_3vdyzjALnONdQoubRmN3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgijo0ThKoYZeypuZb2YHCL_3vdyzjALnONdQoubRmN3A@mail.gmail.com>

On Sat, Oct 18, 2025 at 07:56:48AM -1000, Linus Torvalds wrote:
> On Fri, 17 Oct 2025 at 04:15, Kiryl Shutsemau <kirill@shutemov.name> wrote:
> >
> > To address this issue, introduce i_pages_delete_seqcnt, which increments
> > each time a folio is deleted from the page cache and implement a modified
> > page cache lookup protocol for short reads:
> 
> So this patch looks good to me, but to avoid the stack size warnings,
> let's just make FAST_READ_BUF_SIZE be 768 bytes or something like
> that, not the full 1k.
> 
> It really shouldn't make much of a difference, and we do have that
> stack size limit check for a reason.

My reasoning is that we are at the leaf of the call chain. Slow path
goes much deeper to I/O.

Reducing the buffer size would invalidate my benchmarking :/
It took time.

What about disabling the warning for the function?

@@ -2750,6 +2750,8 @@ static inline unsigned long filemap_read_fast_rcu(struct address_space *mapping,

 #define FAST_READ_BUF_SIZE 1024

+__diag_push();
+__diag_ignore_all("-Wframe-larger-than=", "Allow on-stack buffer for fast read");
 static noinline bool filemap_read_fast(struct kiocb *iocb, struct iov_iter *iter,
                                       ssize_t *already_read)
 {
@@ -2785,6 +2787,7 @@ static noinline bool filemap_read_fast(struct kiocb *iocb, struct iov_iter *iter

        return !iov_iter_count(iter);
 }
+__diag_pop();

 static noinline ssize_t filemap_read_slow(struct kiocb *iocb,
                                          struct iov_iter *iter,

> 
> And obviously
> 
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > +       seqcount_spinlock_init(&mapping->i_pages_delete_seqcnt,
> > +                              &mapping->i_pages->xa_lock);
> 
> will need to use '&mapping->i_pages.xa_lock', since mapping->i_pages
> is the embedded xarray, not a pointer to it.

Doh!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

