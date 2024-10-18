Return-Path: <linux-fsdevel+bounces-32346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B9D9A3D9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 13:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B975284C26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865AA1C6BE;
	Fri, 18 Oct 2024 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="fHvrGuin";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="af6y248P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1025BD530;
	Fri, 18 Oct 2024 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252490; cv=none; b=kte4J/cs8eA8HrgAIH/3VVotRVV2nH3nNVd5H4y+NslLXF7xaugAa91QQdbyTKk2hAdP37/pwpBEB1VNDRP7w8Brn09OU/kVdNNA76PK+LYoDQ+qnLvJMDbzG/Sc3yMXp/SThPYNJZY9z4nI46DWNJL+AYQ8gBQCiGtS6kmPd+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252490; c=relaxed/simple;
	bh=3Kg1Xi+DXZE0vzyVm6+Vi1g4v2Bi4KcxwBm1S2H4RbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfDDqV5Q2YLf45sypMJpIDhpmzrrVyvSkkx8thCZiF8odzueXN4FvumlfquQ98kbvZxVOEliPkqLtXvJ9kWhoQGLWe/VEgAJUZlrI/GpYDS7BODB56FftU30esIi3i5q3H1+ioyWN7BkK8aVYw496VzG5+n88NXn6neEVVOv6sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=fHvrGuin; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=af6y248P; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id D5F0720088D;
	Fri, 18 Oct 2024 07:54:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 18 Oct 2024 07:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729252486; x=
	1729259686; bh=62nSDetxREUwhFRwOeDWnAUvJJ8O2ro8jjslYBHI46M=; b=f
	HvrGuinqPO7FSLsMxXbhuacamOu+wnRmsFTsmmO8fHw7/XVL6sFGMFgN64NLXwiy
	cVKLFmCqS/A+McaGMRI8pTWbCMtSvN7M/qOMvtLAT0kQ1QGVjxXX+C0f8l8l0LpU
	sum4ol2gQbDtueHXCuyslwIdER5QOjS3mUVEKuDm0UQfTt0aW4Zjj+aIK6evgvrH
	7alCf1uy+2T1eZHYOX7H6kmPVS/iAimCC6efzmOrWuSCcXOntURcwjfskxOMK9X/
	yzQsjpyDOWINeou66X8ya1JUqinQX2AbKl0M2WWakkvejH7RFqdKJ1rhVq6wNz56
	99BoEWMoNTzjhE2oi6R2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729252486; x=1729259686; bh=62nSDetxREUwhFRwOeDWnAUvJJ8O
	2ro8jjslYBHI46M=; b=af6y248P4NufDYVeYnsoeKWrRD/c2i2ticskLruWSSBA
	4tS8UXpxQUEAx+zlOpH51cp8q5bxBTGEffbckF5trd1dB4coKoKzQqCT2bZuKtJP
	hqgZFdf6VEgfx79LZtoTFjdSe8Dz1NxnK2uQfa4olgYPC/Hq+wHM3v3yHm7EvGfO
	d5UWQBCNT9tIJvDvl6MSuU368DlbVhgZxY0UmOUtgxuTUZUxbVXdiK2OyLSodt9T
	6+Wqhl3wDXiD8Nlrmt/kHf0N5yxRUI90WiOciFbbt1imkMU3aZ4JpfkapyieOQ9p
	FQfDqkyVJlNOsk1B+ZZYL5WOiyvgOhsm2ebbQT9D0A==
X-ME-Sender: <xms:hUwSZwzjsLwHdJbqly5sD1xZRvvx5rTr0BWr96K4OathWqTix1VB7g>
    <xme:hUwSZ0SQU0IoqmHzEQy3Mqpo7sCXf5PM-mYZvYpNQxklX3WWdRIVRKS_luBjz1p8U
    v70PiSfI15wZMimu08>
X-ME-Received: <xmr:hUwSZyXdQT91quU11guyARdUILbHSiwO68nMKX4mOuoy4csO80fB86Qv7VXUtCCVtKMe1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehrohgsvghrthhordhsrghsshhusehhuhgrfigvihgtlhhouhgurdgtohhmpdhr
    tghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtg
    hpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopegvsghp
    qhifvghrthihgeejvdduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhirhhilh
    hlrdhshhhuthgvmhhovheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeii
    ohhhrghrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepughmihhtrhihrdhkrg
    hsrghtkhhinhesghhmrghilhdrtghomhdprhgtphhtthhopegvrhhitgdrshhnohifsggv
    rhhgsehorhgrtghlvgdrtghomhdprhgtphhtthhopehjmhhorhhrihhssehnrghmvghird
    horhhg
X-ME-Proxy: <xmx:hUwSZ-jSuVQb9-z_SPFiNp0CBd8GMy7fjAlGKFvflr0bVjaDiP10AQ>
    <xmx:hUwSZyABv-CQQC6MuVUPcCHF0zEg63VaVkyabd22fdiJCU_NuXXGog>
    <xmx:hUwSZ_LWvJZfrTPKF3X7hn1bOoooM3ITDPzTSOuS0of-oe_kdVg7-A>
    <xmx:hUwSZ5CCOk0lsEMXPYAubX5UXnEtY8_5C0084j8l0DElFCkBHxvYjw>
    <xmx:hkwSZ67MHyHFr9eVztuBGQtSv7sOTjtAmOjOQlbIQ0WHAPhSitYhu7iu>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 07:54:38 -0400 (EDT)
Date: Fri, 18 Oct 2024 14:54:33 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, ebpqwerty472123@gmail.com, kirill.shutemov@linux.intel.com, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz, 
	linux-fsdevel@vger.kernel.org, Liam Howlett <liam.howlett@oracle.com>, 
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
Message-ID: <dg6qpjgqggq6lfehfosy6vtrhl6ddez3mg4vkpxgqoo2vytq4i@l4g6rx64ovcg>
References: <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
 <7358f12d852964d9209492e337d33b8880234b74.camel@huaweicloud.com>
 <593282dbc9f48673c8f3b8e0f28e100f34141115.camel@huaweicloud.com>
 <15bb94a306d3432de55c0a12f29e7ed2b5fa3ba1.camel@huaweicloud.com>
 <c1e47882720fe45aa9d04d663f5a6fd39a046bcb.camel@huaweicloud.com>
 <b498e3b004bedc460991e167c154cc88d568f587.camel@huaweicloud.com>
 <ggvucjixgiuelt6vjz6oawgyobmzrhifaozqqvupwfso65ia7c@bauvfqtvq6lv>
 <e89f6b61-a57f-4848-87f1-8e2282bc5aea@lucifer.local>
 <gl4pf7gezpjtvnbp4lzyb65wqaiw3xzjjrs3476j5odxsfzvsj@oouue73v3cgr>
 <b7155b2fa47f17e587b73620e86ef019a5efa7e1.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7155b2fa47f17e587b73620e86ef019a5efa7e1.camel@huaweicloud.com>

On Fri, Oct 18, 2024 at 01:22:35PM +0200, Roberto Sassu wrote:
> On Fri, 2024-10-18 at 14:05 +0300, Kirill A. Shutemov wrote:
> > On Fri, Oct 18, 2024 at 12:00:22PM +0100, Lorenzo Stoakes wrote:
> > > + Liam, Jann
> > > 
> > > On Fri, Oct 18, 2024 at 01:49:06PM +0300, Kirill A. Shutemov wrote:
> > > > On Fri, Oct 18, 2024 at 11:24:06AM +0200, Roberto Sassu wrote:
> > > > > Probably it is hard, @Kirill would there be any way to safely move
> > > > > security_mmap_file() out of the mmap_lock lock?
> > > > 
> > > > What about something like this (untested):
> > > > 
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index dd4b35a25aeb..03473e77d356 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -1646,6 +1646,26 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
> > > >  	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
> > > >  		return ret;
> > > > 
> > > > +	if (mmap_read_lock_killable(mm))
> > > > +		return -EINTR;
> > > > +
> > > > +	vma = vma_lookup(mm, start);
> > > > +
> > > > +	if (!vma || !(vma->vm_flags & VM_SHARED)) {
> > > > +		mmap_read_unlock(mm);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	file = get_file(vma->vm_file);
> > > > +
> > > > +	mmap_read_unlock(mm);
> > > > +
> > > > +	ret = security_mmap_file(vma->vm_file, prot, flags);
> > > 
> > > Accessing VMA fields without any kind of lock is... very much not advised.
> > > 
> > > I'm guessing you meant to say:
> > > 
> > > 	ret = security_mmap_file(file, prot, flags);
> > > 
> > > Here? :)
> > 
> > Sure. My bad.
> > 
> > Patch with all fixups:
> 
> Thanks a lot! Let's wait a bit until the others have a chance to
> comment. Meanwhile, I will test it.
> 
> Do you want me to do the final patch, or will you be proposing it?

You can post it if it works:

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

