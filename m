Return-Path: <linux-fsdevel+bounces-42354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9208A40D54
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 09:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F56189AE5E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 08:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14CB1FC7F2;
	Sun, 23 Feb 2025 08:08:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E6761FFE
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740298097; cv=none; b=fIhyyoiNKQjW2YQx2fHMYz3EJqByJEqFmdkLZMGLJn5fb+tPzkf7iXVVv7neOgz4cVJwyZYSxN1RwY+C7KnzGX4FXqGAh8vI9VgTW+Vk2YbAZu3xJV15a0il6zdOlEdwlMoJ3a7xrw9zgOE/Zw2hMgltmOUcQ7b0y7580RExP1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740298097; c=relaxed/simple;
	bh=e+jNrwO7W2yy7A9xR/o9Rll9JRv0r88VfQhsJJEFvSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kx4HfIvA+Y0gzth9HvhIXOpfr3L6RPnSFrkuAWNBT65jtSN19Sxt5lldtXCMyNQMDRGi2LeYZmbjuZYUz2plpM+yFbx7trAC+tq9IjealEoFV9T430OkVz7DxwV66edZiUY5sUOfPp0fldgoh2RR3is/mJhuUImP4ctucttuntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3D74176A;
	Sun, 23 Feb 2025 00:08:30 -0800 (PST)
Received: from [10.163.40.63] (unknown [10.163.40.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 306AC3F5A1;
	Sun, 23 Feb 2025 00:08:11 -0800 (PST)
Message-ID: <8763a109-a687-4e1e-a6d8-9b163031b77d@arm.com>
Date: Sun, 23 Feb 2025 13:38:08 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] The future of anon_vma
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <c87f41ff-a49c-4476-8153-37ff667f47b9@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <c87f41ff-a49c-4476-8153-37ff667f47b9@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/01/25 3:53 am, Lorenzo Stoakes wrote:
> Hi all,
> 
> Since time immemorial the kernel has maintained two separate realms within
> mm - that of file-backed mappings and that of anonymous mappings.
> 
> Each of these require a reverse mapping from folio to VMA, utilising
> interval trees from an intermediate object referenced by folio->mapping
> back to the VMAs which map it.
> 
> In the case of a file-backed mapping, this 'intermediate object' is the
> shared page cache entry, of type struct address_space. It is non-CoW which
> keep things simple(-ish) and the concept is straight-forward - both the
> folio and the VMAs which map the page cache object reference it.
> 
> In the case of anonymous memory, things are not quite as simple, as a
> result of CoW. This is further complicated by forking and the very many
> different combinations of CoW'd and non-CoW'd folios that can exist within
> a mapping.
> 
> This kind of mapping utilises struct anon_vma objects which as a result of
> this complexity are pretty well entirely concerned with maintaining the
> notion of an anon_vma object rather than describing the underlying memory
> in any way.
> 
> Of course we can enter further realms of insan^W^W^W^W^Wcomplexity by
> maintaining a MAP_PRIVATE file-backed mapping where we can experience both
> at once!
> 
> The fact that we can have both CoW'd and non-CoW'd folios referencing a VMA
> means that we require -yet another- type, a struct anon_vma_chain,
> maintained on a linked list, to abstract the link between anon_vma objects
> and VMAs, and to provide a means by which one can manage and traverse
> anon_vma objects from the VMA as well as looking them up from the reverse
> mapping.
> 
> Maintaining all of this correctly is very fragile, error-prone and
> confusing, not to mention the concerns around maintaining correct locking
> semantics, correctly propagating anonymous VMA state on fork, and trying to
> reuse state to avoid allocating unnecessary memory to maintain all of this
> infrastructure.
> 
> An additional consequence of maintaining these two realms is that that
> which straddles them - shmem - becomes something of an enigma -
> file-backed, but existing on the anonymous LRU list and requiring a lot of
> very specific handling.
> 
> It is obvious that there is some isomorphism between the representation of
> file systems and anonymous memory, less the CoW handling. However there is
> a concept which exists within file systems which can somewhat bridge the gap
>   - reflinks.
> 
> A future where we unify anonymous and file-backed memory mappings would be
> one in which a reflinks were implemented at a general level rather than, as
> they are now, implemented individually within file systems.
> 
> I'd like to discuss how feasible doing so might be, whether this is a sane
> line of thought at all, and how a roadmap for working towards the
> elimination of anon_vma as it stands might look.
> 
> As with my other proposal, I will gather more concrete information before
> LSF to ensure the discussion is specific, and of course I would be
> interested to discuss the topic in this thread also!
> 
> Thanks!
> 

Thanks for this, as a beginner I have tried understanding the rmap code 
a million times, after forgetting it a million times, thanks to the 
sheer complexity of the anon_vma and anon_vma_chain. Whenever I read it 
again, the first thought is "surely there has to be some better way, 
someone must figure it out" :)


