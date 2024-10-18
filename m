Return-Path: <linux-fsdevel+bounces-32337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC559A3C41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 12:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C740AB2775D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 10:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AD52038AB;
	Fri, 18 Oct 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="SiMRMhqr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KljQwcUw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E3E2022FF;
	Fri, 18 Oct 2024 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248786; cv=none; b=OQ5Z8TupYsIsVkO+EqFbhdTBTTDqnc1ZBVO08STOWRdQ3whYTP+P831FvpVBfgalpcuHQymkFyVmjdTvp8Gd/k6RNuzoEFRvlKLximo4QqFwOU5R39ZjvuoFdk0v4cE7Cb3G9C7RUfuv7LoVrbz2pBbtx/f9ZjdBHvqS4BJCGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248786; c=relaxed/simple;
	bh=9IwJDYlPHXuWA3zR07NOmML8ZUzGebEPHTrPgcIv2Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX2u5Ur/x5eyO8YcVeBBzE9A+ZmVFSxbpIJ88OxsZeGn2MIXZOfrwuzuxg1X89cgtDdFukxsw/3OeZK1DbaK885f4rTfNQRmQfn3J5v3kZ2NaUCJANcZoo531cZNISyaMb7ajdH6XVwRAag3visv/5Om5dIhwjic64plgKkZk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=SiMRMhqr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KljQwcUw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A155113801DF;
	Fri, 18 Oct 2024 06:53:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 18 Oct 2024 06:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729248783; x=
	1729335183; bh=6W65sQqMDsurY8A/6Sm3d4ObWPw0596AaopS8zSdd6w=; b=S
	iMRMhqrpp9Jv+PjlcrogxZIb7ZKgWQZPfVJB4z1bDlu6lxgfRjUaKuRGmzbf1av8
	ZSo6MxcvTbTCzpX77RxjsUecDYqgz6e2T8LaHaTfcvbHUNCVSlsYV9/iUhnjwj4k
	EbYxcZhrj1nZdk2VmVIyUHbHs84U/LbvYuSJe3cDwwvpf8k2l55pMkUlCOuBXI2t
	3kieMbWHzbbAHSJzlabVqnOHK/2tJAoG9iIpRadOc2/TATPcjx3UvU24c+6t9I1W
	itlT1sOLOkx2iXZlfHcH0GczgK6rvz7CRJD8fS5frg9qjR4Ard/05gz/D9szZKEP
	MwJtF99tn9EOSucuZ8AwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729248783; x=1729335183; bh=6W65sQqMDsurY8A/6Sm3d4ObWPw0
	596AaopS8zSdd6w=; b=KljQwcUwq9bmyaW1/EvIWDgVw9ayiUtaLt0DysPnxNCA
	B8clPurdUYtmG4+e7pzGOppS9GOmmK9QKkNiOw/BnVy44eqfaJqsbrHxDn2bs+7E
	DOxnsU7VdfKcsFYEjH3IRFSX30Mqog6kciACE68iyG9wSpqKtAgjpPYhvL7Yoeow
	wPTx/21iGlWdKpuV/NIxF2gXFayDJ/NIXB50eOIUG3ZvwSQ8tkDs4o2h3Jq9ps2p
	0Fx+ABTOxxVHtRMLt/5fwJ9ong2cTSCni1sNBvN/HsoL/cJuglTL6vX+zuLCQXIB
	TapH9HWW7BST1go5VyiwG4eFacsDlYL0zZUe+x18LQ==
X-ME-Sender: <xms:Dj4SZ_s5cLjGzFpTumIKjXBE5YwEHXbsKTXLr85K25G2azGRTmhckw>
    <xme:Dj4SZwdOOsHRWuw_PV9hg_SGJWRfsGk0caWoZwwspA9fBQ1SpbTXJPF4xXYyTYDGN
    HBZSGXitHrk-e_gQn8>
X-ME-Received: <xmr:Dj4SZyzbwZ9c0Z2A3pqXxs8AxWHj5dAjPwqziKQKam9jkt7XPdj8R1TG2pq1FnPPlPAtFQ>
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
X-ME-Proxy: <xmx:Dj4SZ-NF56mIbMU0gQtYhlUvRt40iAbFkG94HGVA343IU8aDF30tmQ>
    <xmx:Dz4SZ_93yqNzN3JaEjkpUOw9g2ajvx9wJI6t16C_3VZcS8a6LM_DTQ>
    <xmx:Dz4SZ-XN_ubDKc6jL3xHsh9XXyteSPUxN1AUG9lpYUgxfZmMyRBaOA>
    <xmx:Dz4SZwf6Mh8Z9qe6VStEzcmsrCx-hYczMT-P7H-ziZX6zMicCr9qMg>
    <xmx:Dz4SZ-isaczioFKVCk0773wJSgkNNCH4uxl1dk3_7bWqXYqTFjAxFHH->
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 06:52:56 -0400 (EDT)
Date: Fri, 18 Oct 2024 13:52:52 +0300
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
Message-ID: <o55v47og6tgpoatvlfam54mxnom2le6isrf2k4c33s7tkyp2nx@tb225uwtytnn>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
 <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
 <7358f12d852964d9209492e337d33b8880234b74.camel@huaweicloud.com>
 <593282dbc9f48673c8f3b8e0f28e100f34141115.camel@huaweicloud.com>
 <15bb94a306d3432de55c0a12f29e7ed2b5fa3ba1.camel@huaweicloud.com>
 <c1e47882720fe45aa9d04d663f5a6fd39a046bcb.camel@huaweicloud.com>
 <b498e3b004bedc460991e167c154cc88d568f587.camel@huaweicloud.com>
 <ggvucjixgiuelt6vjz6oawgyobmzrhifaozqqvupwfso65ia7c@bauvfqtvq6lv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ggvucjixgiuelt6vjz6oawgyobmzrhifaozqqvupwfso65ia7c@bauvfqtvq6lv>

On Fri, Oct 18, 2024 at 01:49:21PM +0300, Kirill A. Shutemov wrote:
> On Fri, Oct 18, 2024 at 11:24:06AM +0200, Roberto Sassu wrote:
> > Probably it is hard, @Kirill would there be any way to safely move
> > security_mmap_file() out of the mmap_lock lock?
> 
> What about something like this (untested):
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dd4b35a25aeb..03473e77d356 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1646,6 +1646,26 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
>  		return ret;
>  
> +	if (mmap_read_lock_killable(mm))
> +		return -EINTR;
> +
> +	vma = vma_lookup(mm, start);
> +
> +	if (!vma || !(vma->vm_flags & VM_SHARED)) {
> +		mmap_read_unlock(mm);
> +		return -EINVAL;
> +	}
> +
> +	file = get_file(vma->vm_file);
> +
> +	mmap_read_unlock(mm);
> +
> +	ret = security_mmap_file(vma->vm_file, prot, flags);
> +	if (ret) {
> +		fput(file);
> +		return ret;
> +	}
> +

Emm. We need to restore 'ret' to -EINVAL here:

+ 
+  	ret = -EINVAL;
+ 

>  	if (mmap_write_lock_killable(mm))
>  		return -EINTR;
>  
> @@ -1654,6 +1674,9 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  	if (!vma || !(vma->vm_flags & VM_SHARED))
>  		goto out;
>  
> +	if (vma->vm_file != file)
> +		goto out;
> +
>  	if (start + size > vma->vm_end) {
>  		VMA_ITERATOR(vmi, mm, vma->vm_end);
>  		struct vm_area_struct *next, *prev = vma;
> @@ -1688,16 +1711,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  	if (vma->vm_flags & VM_LOCKED)
>  		flags |= MAP_LOCKED;
>  
> -	file = get_file(vma->vm_file);
> -	ret = security_mmap_file(vma->vm_file, prot, flags);
> -	if (ret)
> -		goto out_fput;
>  	ret = do_mmap(vma->vm_file, start, size,
>  			prot, flags, 0, pgoff, &populate, NULL);
> -out_fput:
> -	fput(file);
>  out:
>  	mmap_write_unlock(mm);
> +	fput(file);
>  	if (populate)
>  		mm_populate(ret, populate);
>  	if (!IS_ERR_VALUE(ret))
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

