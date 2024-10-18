Return-Path: <linux-fsdevel+bounces-32342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8D89A3CD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 13:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BDE1F22EEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 11:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C27204088;
	Fri, 18 Oct 2024 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="dcoCiM31";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nNFsDOP2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC7204084;
	Fri, 18 Oct 2024 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249543; cv=none; b=nGdmw8qYrg1nIHkHirMokpaoFTT7WC6K2Vsr1nJuHwFIYdl+yXOzzJXDjzcBHlltf++FKU2QhC3eVjaIDfDUEB/YohL23YPAVNYg7XOXsmKFaILO0BgMxSzMKZnN/uO1wccpuVLUQTSu1+EOorfzlbEl9bsguK3vXiSStL1d0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249543; c=relaxed/simple;
	bh=P5PdRsacF474EbWgmhc3hiD7lELGK1tzJ9hufbt3rB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJmLRfCaucm/o+pMk9VbC/cR87VyC6T/7RakujpLAy3rQdRdVGqpUNN/Syz0sO1HUjl0Nu9a+0P61tgSq8pEXaLYhYuXCLSOx8qNtQpIK3id+99UjBonnnpVE7vSRXWekmZDfop7dTmFn7sVugwnl3J8OQ1acSE+smodGL6bCUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=dcoCiM31; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nNFsDOP2; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 555442008EE;
	Fri, 18 Oct 2024 07:05:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 18 Oct 2024 07:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729249540; x=
	1729256740; bh=DfrWUeI7jSkiKLl3DUG7tVnejbJ3jmsGwSHJKF/avYA=; b=d
	coCiM31/zabNDU6R4RnsDb/1plhuAHiEF0Q80vQuqfE+bJSr2l8hUqp4h4bOEo+0
	siqhlildBZ9aRwdUXkP6bKYWCQI4CUtI4ESFeMNHjOMGCSOjwNTBGvf95/xvOHaE
	BuKDQivrJVwpUxoLOX3DjHJzctOno4J2XL3gcNAVfIqUpsk1VhXEX2P3qjwAuDRK
	qPTeHrXencJNxxnQ63tOmM+V/fOGDdREAUtvXBvyIFUEr68si/HG3iHgmm1mJIJk
	7x3KvB90ssS+3AuH5PewlgYZGkWK6EgoUlnR9naCY/GULiCqc3SMIbmwlPnox9K0
	JdvYhq9eCBaWWfuG33/xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729249540; x=1729256740; bh=DfrWUeI7jSkiKLl3DUG7tVnejbJ3
	jmsGwSHJKF/avYA=; b=nNFsDOP2Xp/fxhjCB/9xkSy4rU/Js1j6E0JYnmEbjGdt
	oeqVqGwYRsXYWJBbm+M3/P4CnRyNzH2MJPMEBU8E2WqhAHTvkwDVGyWJK7EKWxJN
	NU1NYytz+PukYpVWsKe25tu5cXr+fpKUuyLZ8hA4UIbyBpmVww109MbhUGVWJpID
	pdCoL9e+CVTYUxZqpBdHOdYWdMOlY7YpGRRESqWkzJqQnKm+dlkqqWWF3uQitH6u
	xiAxU1NkRZ/XhlGXpsh/wfySGQr9uhFGC03nM/cmu2OsMZD0YE+Ua+yYZuS21dzV
	+0JXqpuohBLWNzXMDryuGiPGJc3iOMDKiPluxytD/A==
X-ME-Sender: <xms:A0ESZ75jRzXbRLvvZQfDNzFob9LTd9-0p7m0LdT63zCDKO1jyMGLfg>
    <xme:A0ESZw5IINJO66CzsiZwtEP8HHf9A1Igue9O41ZlgzhZsZ_jMV0zfv2iesWL4othb
    hgyEdVev_w1-iM6BzU>
X-ME-Received: <xmr:A0ESZyeawwBfJ-CWrs2bYgQn6iEAuis3v-Ud2y7hqlpnmVudvoCBnZ-Leo9oXMSb2Q1kxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrtghomhdprhgtphht
    thhopehrohgsvghrthhordhsrghsshhusehhuhgrfigvihgtlhhouhgurdgtohhmpdhrtg
    hpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopegvsghp
    qhifvghrthihgeejvdduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhirhhilh
    hlrdhshhhuthgvmhhovheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeii
    ohhhrghrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepughmihhtrhihrdhkrg
    hsrghtkhhinhesghhmrghilhdrtghomhdprhgtphhtthhopegvrhhitgdrshhnohifsggv
    rhhgsehorhgrtghlvgdrtghomhdprhgtphhtthhopehjmhhorhhrihhssehnrghmvghird
    horhhg
X-ME-Proxy: <xmx:A0ESZ8IYn0K0oMAIMHEMPAGeChgFhXRKE1MXmz5TFTySYvy1S-wrVA>
    <xmx:A0ESZ_KaF5l77BShpny3V7R5x3_-4BaJmGhSybClo6FKEKsTb1fEYw>
    <xmx:A0ESZ1wBQZgu77wJW-LApmzqL7gM8ugNX-BZ1ICA9Ka0fXNN_yK_VA>
    <xmx:A0ESZ7LNU7aXGheO5AGArP71cuQUcqDpPIgPbk4U7jJV9sL4NJ8a9w>
    <xmx:BEESZ0C36_eKafwilCyEkSRmOul-aD1SXQltohfGtkB8zkdqg6NX8KQ6>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 07:05:32 -0400 (EDT)
Date: Fri, 18 Oct 2024 14:05:27 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Paul Moore <paul@paul-moore.com>, ebpqwerty472123@gmail.com, kirill.shutemov@linux.intel.com, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz, 
	linux-fsdevel@vger.kernel.org, Liam Howlett <liam.howlett@oracle.com>, 
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
Message-ID: <gl4pf7gezpjtvnbp4lzyb65wqaiw3xzjjrs3476j5odxsfzvsj@oouue73v3cgr>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
 <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
 <7358f12d852964d9209492e337d33b8880234b74.camel@huaweicloud.com>
 <593282dbc9f48673c8f3b8e0f28e100f34141115.camel@huaweicloud.com>
 <15bb94a306d3432de55c0a12f29e7ed2b5fa3ba1.camel@huaweicloud.com>
 <c1e47882720fe45aa9d04d663f5a6fd39a046bcb.camel@huaweicloud.com>
 <b498e3b004bedc460991e167c154cc88d568f587.camel@huaweicloud.com>
 <ggvucjixgiuelt6vjz6oawgyobmzrhifaozqqvupwfso65ia7c@bauvfqtvq6lv>
 <e89f6b61-a57f-4848-87f1-8e2282bc5aea@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89f6b61-a57f-4848-87f1-8e2282bc5aea@lucifer.local>

On Fri, Oct 18, 2024 at 12:00:22PM +0100, Lorenzo Stoakes wrote:
> + Liam, Jann
> 
> On Fri, Oct 18, 2024 at 01:49:06PM +0300, Kirill A. Shutemov wrote:
> > On Fri, Oct 18, 2024 at 11:24:06AM +0200, Roberto Sassu wrote:
> > > Probably it is hard, @Kirill would there be any way to safely move
> > > security_mmap_file() out of the mmap_lock lock?
> >
> > What about something like this (untested):
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index dd4b35a25aeb..03473e77d356 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1646,6 +1646,26 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
> >  	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
> >  		return ret;
> >
> > +	if (mmap_read_lock_killable(mm))
> > +		return -EINTR;
> > +
> > +	vma = vma_lookup(mm, start);
> > +
> > +	if (!vma || !(vma->vm_flags & VM_SHARED)) {
> > +		mmap_read_unlock(mm);
> > +		return -EINVAL;
> > +	}
> > +
> > +	file = get_file(vma->vm_file);
> > +
> > +	mmap_read_unlock(mm);
> > +
> > +	ret = security_mmap_file(vma->vm_file, prot, flags);
> 
> Accessing VMA fields without any kind of lock is... very much not advised.
> 
> I'm guessing you meant to say:
> 
> 	ret = security_mmap_file(file, prot, flags);
> 
> Here? :)

Sure. My bad.

Patch with all fixups:

diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..541787d526b6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1646,14 +1646,41 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
 		return ret;
 
-	if (mmap_write_lock_killable(mm))
+	if (mmap_read_lock_killable(mm))
 		return -EINTR;
 
 	vma = vma_lookup(mm, start);
 
+	if (!vma || !(vma->vm_flags & VM_SHARED)) {
+		mmap_read_unlock(mm);
+		return -EINVAL;
+	}
+
+	file = get_file(vma->vm_file);
+
+	mmap_read_unlock(mm);
+
+	ret = security_mmap_file(file, prot, flags);
+	if (ret) {
+		fput(file);
+		return ret;
+	}
+
+	ret = -EINVAL;
+
+	if (mmap_write_lock_killable(mm)) {
+		fput(file);
+		return -EINTR;
+	}
+
+	vma = vma_lookup(mm, start);
+
 	if (!vma || !(vma->vm_flags & VM_SHARED))
 		goto out;
 
+	if (vma->vm_file != file)
+		goto out;
+
 	if (start + size > vma->vm_end) {
 		VMA_ITERATOR(vmi, mm, vma->vm_end);
 		struct vm_area_struct *next, *prev = vma;
@@ -1688,16 +1715,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	if (vma->vm_flags & VM_LOCKED)
 		flags |= MAP_LOCKED;
 
-	file = get_file(vma->vm_file);
-	ret = security_mmap_file(vma->vm_file, prot, flags);
-	if (ret)
-		goto out_fput;
 	ret = do_mmap(vma->vm_file, start, size,
 			prot, flags, 0, pgoff, &populate, NULL);
-out_fput:
-	fput(file);
 out:
 	mmap_write_unlock(mm);
+	fput(file);
 	if (populate)
 		mm_populate(ret, populate);
 	if (!IS_ERR_VALUE(ret))
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

