Return-Path: <linux-fsdevel+bounces-65083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FBCBFB468
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 12:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE677423989
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E95C30CD98;
	Wed, 22 Oct 2025 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="YeMYDZsQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zJXW95sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845431339A4;
	Wed, 22 Oct 2025 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127256; cv=none; b=mWixfp1+es6ZmawRnHm8YlJ2uv+1BNzp9FIe4gZU24IQCdf7sQsecCCPmGbdscks/WthtihcjvRfzt+AyMYaPq/SrNv8Irsvp1UsB2Va6upxl45W16f1GC9WDPj93WSVmM0T0HRSmc5SM9zfk3QMVdxi62I6HyQTq0nV+R2J6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127256; c=relaxed/simple;
	bh=Gv0atK9SGEvqczT3UY+eg+RSr+YZySJ9aE0Mnyfc67M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUogSAlxr1UPOW/WhAo93ix9rwhnvAZDkmu5/dlimvvN7TZZSOQ+530fFpQhyiuFIAKxlelr371UzGo1fzkKm42ZpabCvkGE82O2fmhGJHaBZTo5KonxX1KTu2aE7Avibri4eiNgKJZnCPvUP8ZjGqi4u5Jf+J6xC4Fetw9hFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=YeMYDZsQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zJXW95sw; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 051BA13011CA;
	Wed, 22 Oct 2025 06:00:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 22 Oct 2025 06:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761127251; x=
	1761134451; bh=8u8y4To0tEWw0CRRVqrcDDxwXTLXCbG926ERuBgD0nU=; b=Y
	eMYDZsQScFnkdFHzsx2yRGqx7FiBRYjbFbDwpTN9aTuwiJmZvdqb21f2yR67i2+I
	N/viBjZDK6hhsUTMLuoweq9HiPv0fWaAcCjEkDjUp+zU6gDEjE3VdqF0wnFKFm3g
	URotusj/ufAqK78MOMFyXzAs3UqnhdTzJ/g3Vh3qInpjzMOhwIcyfYLjUyuS2YDE
	G1knp9YDRFu/zI6uJgIs7pljcEr9/cHCCn5Q52+WAcRt/jUToQ9jfIQ0kF//PgB4
	BMx/mHgZ921d5qgWwoWtgZUAfUInk3lqT3KExUkjwNxURWBLjuInY4Kb4awhfNQ5
	V4KIip7tU1Qr5ixk7iiOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761127251; x=1761134451; bh=8u8y4To0tEWw0CRRVqrcDDxwXTLXCbG926E
	RuBgD0nU=; b=zJXW95sw7Ml0P0eQ0f6ppKw0/57o5+f9HNlyC+N7HE7XdE76UQ+
	nUWaTK/fM/FRGgDX6LGasuzlpyQRnIoOY44O55G0b5E+SHJtr6Iy6jNQAHjEi592
	1tWblmF62Ko5c9Dr9NKTUB/PIH0tZUGyDueS4bNtTA/g/pgKpyOfIjbiCZq3Rub5
	OExnteZ840Zi8ikTm63tZFfmhy0wuz7Q4aHjnVJ/YLR/xOCrmt78h756soKPIOEq
	kI1xKEdVckhdsjxE/SGXJclWOQN1UbqZm3WdVcDJpD87xDnxg/+l4ARgWpIs1B+f
	Y8BO+ZSnDjSb/lDqSB+D5D3RV/v7LYLB6lg==
X-ME-Sender: <xms:Uqv4aJ9_pipJeJZzEx7zSMAQrv1Jna9MFFwC49brqIWcqZtyiOtkjQ>
    <xme:Uqv4aCkkckpqUNXE0CGcECjwrJdcOAhzt44cdYsQjrCAx0djnTlEoljKCJY3t_pYR
    omqUIRMLRShv7VSMhrsF2wgBKu5bsVin1r22AFrjaHH3AzFcK1jqgo>
X-ME-Received: <xmr:Uqv4aElMDnujjHu-WBvBp8PsZ5GVb-5JP3DXQWy6ahiTKCSqDIqmhP4uTcFgUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeefvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhfrghltggrthhosehsuhhsvg
    druggvpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihho
    nhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrd
    horhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    fihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehvihhrohesiigvnh
    hivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheplh
    hinhhugidqmhhmsehkvhgrtghkrdhorhhg
X-ME-Proxy: <xmx:Uqv4aPjgjuuGBEii7mqfbLzuv9prb0mNFZL58i9IuE9B0a1x-RVFXg>
    <xmx:Uqv4aNXy3LroYwNprzGQ9JZZekfZ67SrQzeq1uEvFBXRhJ9UAqJnSQ>
    <xmx:Uqv4aBgKxXLw8qdx8pKwgxTxsBp2-aHhvBhMnfDlOL9fKOG0j44-nA>
    <xmx:Uqv4aB4c1EtXZtt9qu8JG7J2jjvnnq57AvdHFTFkXZanDr_5YVS6TQ>
    <xmx:U6v4aBM_z9nVkV-txhieRu5kcE2C8ckrvIMcP4fVw6TRrsJzCb_Xj7aC>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 06:00:50 -0400 (EDT)
Date: Wed, 22 Oct 2025 11:00:48 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <djnlhsgjokfx53nvtdhosdfwcoxdl6aaqsmy22ywe22daamsue@uvsbyygxjrhp>
References: <20251017141536.577466-1-kirill@shutemov.name>
 <zuzs6ucmgxujim4fb67tw5izp3w2t5k6dzk2ktntqyuwjva73d@tqgwkk6stpgz>
 <CAHk-=wgw8oZwA6k8rVuzczkZUP26P2MAtFmM4k8TqdtfDr9eTg@mail.gmail.com>
 <2dyj6zrxbd2wjnor2wswis5p5z7brtfgzjnhbexhjsd3kqnvx2@y6i2wnvr6gdr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dyj6zrxbd2wjnor2wswis5p5z7brtfgzjnhbexhjsd3kqnvx2@y6i2wnvr6gdr>

On Wed, Oct 22, 2025 at 08:38:30AM +0100, Pedro Falcato wrote:
> On Tue, Oct 21, 2025 at 09:13:28PM -1000, Linus Torvalds wrote:
> > On Tue, 21 Oct 2025 at 21:08, Pedro Falcato <pfalcato@suse.de> wrote:
> > >
> > > I think we may still have a problematic (rare, possibly theoretical) race here where:
> > >
> > >    T0                                           T1                                              T3
> > > filemap_read_fast_rcu()    |                                                    |
> > >   folio = xas_load(&xas);  |                                                    |
> > >   /* ... */                |  /* truncate or reclaim frees folio, bumps delete  |
> > >                            |     seq */                                         |       folio_alloc() from e.g secretmem
> > >                            |                                                    |       set_direct_map_invalid_noflush(!!)
> > > memcpy_from_file_folio()   |                                                    |
> > >
> > > We may have to use copy_from_kernel_nofault() here? Or is something else stopping this from happening?
> > 
> > Explain how the sequence count doesn't catch this?
> > 
> > We read the sequence count before we do the xas_load(), and we verify
> > it after we've done the memcpy_from_folio.
> > 
> > The whole *point* is that the copy itself is not race-free. That's
> > *why* we do the sequence count.
> > 
> > And only after the sequence count has been verified do we then copy
> > the result to user space.
> > 
> > So the "maybe this buffer content is garbage" happens, but it only
> > happens in the temporary kernel on-stack buffer, not visibly to the
> > user.
> 
> The problem isn't that the contents might be garbage, but that the direct map
> may be swept from under us, as we don't have a reference to the folio. So the
> folio can be transparently freed under us (as designed), but some user can
> call fun stuff like set_direct_map_invalid_noflush() and we're not handling
> any "oopsie we faulted reading the folio" here. The sequence count doesn't
> help here, because we, uhh, faulted. Does this make sense?
> 
> TL;DR I don't think it's safe to touch the direct map of folios we don't own
> without the seatbelt of a copy_from_kernel_nofault or so.

Makes sense. Thanks for catching this!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

