Return-Path: <linux-fsdevel+bounces-32339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B56E9A3C7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 13:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA2E1C22C1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 11:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9CC20402B;
	Fri, 18 Oct 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="N0fx2GuQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pKasBn9E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305E1202637;
	Fri, 18 Oct 2024 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248957; cv=none; b=m3o7+WqSCTEmLaE47aBK1Bcc+Whj04/rmDtpUv2FRqS+mmV6BTX8sS/lYAsN9/uZ1PeJRfeVma5lcJhkFvJsxZ11r8UizSUMX7h2fAhIb67O7DT9CtT3/jN9VwOB3XJNF1VYW7DPjkZq3lFXgv3HFr3MJtCTWgYyDczj1xgRq34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248957; c=relaxed/simple;
	bh=WSgETfgZ5zMNTJxJsQWuh7VPcZolGP0qiQQxBbZXOIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ju65blPwM9MzzBdNv+YCP8QdfGtNlDEp9HeEn0d/Ba31P26BUiIbf+aBYyFac9eHC/S8Hj85Dcbpmw+6MmxmLhtX65lCryvjNUjMiCECiTYlpaSeslZJ1LcHCIFjyRC3AtYqEARcQTXhjLYsoaROT+Wa8pFvKwJqm7gSdLgZYys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=N0fx2GuQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pKasBn9E; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F5B31380479;
	Fri, 18 Oct 2024 06:55:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 18 Oct 2024 06:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729248954; x=
	1729335354; bh=coMOZENDUaYWTXt7cXYmH0d3DtZlK6a7sVVMJT6B6Dc=; b=N
	0fx2GuQeMjXxyE4BUBl0q3/ytz/BAgihIyBjZPLF2jp4ogyk/5b0Hp67pA0qV1qk
	ho/AGR29sRNe7bJ2mSx7bbcTViyRVOYDtxZfhThD2jAN9oPHR7UK5ePZhIgsz07I
	I5In8z9Ha2hCmXg2maWyv5nS12G8qRc2dlrIl4SiQ01NPOJP/bw3KGeJc9wHOTrI
	sfBJ83erirJVTVjC9Y24J9EO6DdliZ9v68ktMbL5NKdqxzsLdf7tYPcCWypDdESb
	zx3VSVKRmPDzbKc+nu0qQhUS3hKPlPlMS4HvBzUqvH4ExOOPzzLZ5IB0pIF25ERO
	lMw9ucLkUmFPffHD+EOTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729248954; x=1729335354; bh=coMOZENDUaYWTXt7cXYmH0d3DtZl
	K6a7sVVMJT6B6Dc=; b=pKasBn9E20HLlGAMit47bAqeix+GvyTQ/e1M8hxjbYA0
	+V2MxZag79xhgd2PQRGr2I4hC3TSkIy8vwbqNPnfs38e5kA6C21HBi/6u8ulJigP
	OAZ/tf8AIiTLfBUTAIk6vr09R8CqkAc3kM9CuXchPH38nPlvgderDdP/T4flyiPa
	hOptzPnHTCsnNV0YnJQuiBCgGcirttXnbv17CJB5b221TMZlHt62dsGlzAXQtzOg
	dGFBD0/uzSaEwB2HxeIj+sMoaDu8VFLZDgnGMFXVh6palCTiaAFkQBqHk35mcsim
	DXuJrRSZQAg9Z4zBeByCnA22Fs8vyEp6ECTm3j7aAA==
X-ME-Sender: <xms:uT4SZ10i3Ks1HJ5ykMAgMDbhvt6ms7Dos6BPx07CZ-ISixRrw1jJHA>
    <xme:uT4SZ8FLTI_C8a-oL-8Xv8kwviGZMCJ_FYzu-KlBV9hTCoWqXhzOBw7sBmipWKiZ7
    RjVR9OBmpODRaZXR1Y>
X-ME-Received: <xmr:uT4SZ17_17p3U7jVZJtdT8oz6akMjo10095I0SkiGx_XhasWH2RGTosF07BTf5cL1CQDRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehrohgsvghrthhordhsrghsshhusehhuhgrfigvihgtlhhouhgurdgtohhmpdhr
    tghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopegvsg
    hpqhifvghrthihgeejvdduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhirhhi
    lhhlrdhshhhuthgvmhhovheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    iiohhhrghrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepughmihhtrhihrdhk
    rghsrghtkhhinhesghhmrghilhdrtghomhdprhgtphhtthhopegvrhhitgdrshhnohifsg
    gvrhhgsehorhgrtghlvgdrtghomhdprhgtphhtthhopehjmhhorhhrihhssehnrghmvghi
    rdhorhhgpdhrtghpthhtohepshgvrhhgvgeshhgrlhhlhihnrdgtohhm
X-ME-Proxy: <xmx:uT4SZy2b8dDyF-ysB-9Qf8gvringXHAa2uLIuA_0llRQoJLL_eR9Dw>
    <xmx:uT4SZ4FECVhFM5feQIhXOC5ynrlBiIVzaqkQVJk8iCqlJv0GAv1HWQ>
    <xmx:uT4SZz-tUFVU_ey0AbDSri82_pMkqVbKbNFSEteTWBYg87f0L5gDLA>
    <xmx:uT4SZ1nvsZm0Bic1TVtxCVeq_aFzMu7aN4sONmWHLmmE6-NCGdoRzw>
    <xmx:uj4SZwK4B3aaJcZ9NyAlSfM2H_Uu6pTGQRH8V4uY9UP6Iu_wISH5EMiZ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 06:55:46 -0400 (EDT)
Date: Fri, 18 Oct 2024 13:55:42 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Paul Moore <paul@paul-moore.com>, ebpqwerty472123@gmail.com, 
	kirill.shutemov@linux.intel.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jmorris@namei.org, serge@hallyn.com, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, 
	linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] ima: Remove inode lock
Message-ID: <ux7jzkh4qcnldneer26gbajssjfeyqhcz7t26d7otri357xpa5@srgguo7dloqq>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
 <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
 <7358f12d852964d9209492e337d33b8880234b74.camel@huaweicloud.com>
 <593282dbc9f48673c8f3b8e0f28e100f34141115.camel@huaweicloud.com>
 <15bb94a306d3432de55c0a12f29e7ed2b5fa3ba1.camel@huaweicloud.com>
 <c1e47882720fe45aa9d04d663f5a6fd39a046bcb.camel@huaweicloud.com>
 <b498e3b004bedc460991e167c154cc88d568f587.camel@huaweicloud.com>
 <ggvucjixgiuelt6vjz6oawgyobmzrhifaozqqvupwfso65ia7c@bauvfqtvq6lv>
 <o55v47og6tgpoatvlfam54mxnom2le6isrf2k4c33s7tkyp2nx@tb225uwtytnn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o55v47og6tgpoatvlfam54mxnom2le6isrf2k4c33s7tkyp2nx@tb225uwtytnn>

On Fri, Oct 18, 2024 at 01:53:03PM +0300, Kirill A. Shutemov wrote:
> > +	mmap_read_unlock(mm);
> > +
> > +	ret = security_mmap_file(vma->vm_file, prot, flags);
> > +	if (ret) {
> > +		fput(file);
> > +		return ret;
> > +	}
> > +
> 
> Emm. We need to restore 'ret' to -EINVAL here:
> 
> + 
> +  	ret = -EINVAL;
> + 
> 
> >  	if (mmap_write_lock_killable(mm))
> >  		return -EINTR;
> >  

And fput() here on error.

Updated patch:

diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..7c1b73a79937 100644
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
+	ret = security_mmap_file(vma->vm_file, prot, flags);
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
 	If (!IS_ERR_VALUE(ret))
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

