Return-Path: <linux-fsdevel+bounces-8866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C1D83BD7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4DB28AFAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B9F1CA82;
	Thu, 25 Jan 2024 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwpki+gc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EA51C6AD;
	Thu, 25 Jan 2024 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175420; cv=none; b=LrEswRdT8IiqGwiNYOAaA/agmAxxJgpd8bF38RvlMQZh745Ex6N0ElPg/puuHeqCI2L5cD7QTN3Ff8AK3jHkUIwuCZw667aBGTuyli2q4p35zlaQbzjWMEho3PMVW2uGWxoraqrAJ0EiRUPKaafkhV1aW1CiCJR7H6dzuxO1gr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175420; c=relaxed/simple;
	bh=gr94+56P2kzJDDYJRH88M8lUAPhvUUKPfiyNI1RdoIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MP/sdbi1cEO1HfYZS0GiH9A1z6YlOW/iSwqZi6spSAoXwNEbvwDVueEz4y9IhuyRcmToJMZ9WgVcS+IRIcT+qPFd4+Ts+PaxTw/xXJU55MStAiFJfFwieK4kK1Xqb3wDEWXll7TK0E096mysDtJk+E08vthH/q4TB9oW/EL4CCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwpki+gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2154C433C7;
	Thu, 25 Jan 2024 09:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706175420;
	bh=gr94+56P2kzJDDYJRH88M8lUAPhvUUKPfiyNI1RdoIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwpki+gcKqJKaqfmZgMJ7UFiFnVP1doqvD1NAyxkVsTKDmQLRRQarzW/fEuRkdAvi
	 7NfCPwsIyhG1oOwHUUAU0c/faUk7GdbyfFPTU+VmUvyts+VhsCzV97cCgEFFN2cc8F
	 iQY/oCgkaWWxZVSrXsD8JqUOdHEUAFXGCpS+21U5jD//uVrK4KNg6IhoAW8r/Sj1Fv
	 8Ghl/QpvvIuLu6Hii4QqaN3dJ+95yJ2H+aggMBYLiE/5F7axNinkm6kiPiJn1ouHCa
	 T8NPJchz0ua0P0SFQWufV2Cn5XDZ9AQaehvdJvrMdqoNU/bgeG7TjafSaLtZXbvdPa
	 +B/iVsYKghDgQ==
Date: Thu, 25 Jan 2024 11:36:32 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lokesh Gidra <lokeshgidra@google.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, bgeffon@google.com,
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
	ngeoffray@google.com
Subject: Re: [PATCH] userfaultfd: fix mmap_changing checking in
 mfill_atomic_hugetlb
Message-ID: <ZbIroGI1kADrOTUB@kernel.org>
References: <20240117223729.1444522-1-lokeshgidra@google.com>
 <20240118135941.c7795d52881f486aa21aeea8@linux-foundation.org>
 <CAJHvVcgTk3Cf2i-ONx=jH_-dz9GktVMv1Sdqv3cCk6nP2k++iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVcgTk3Cf2i-ONx=jH_-dz9GktVMv1Sdqv3cCk6nP2k++iA@mail.gmail.com>

On Thu, Jan 18, 2024 at 03:17:14PM -0800, Axel Rasmussen wrote:
> 
> On Thu, Jan 18, 2024 at 1:59 PM Andrew Morton <akpm@linux-foundation.org>
> wrote:
> 
>     On Wed, 17 Jan 2024 14:37:29 -0800 Lokesh Gidra <lokeshgidra@google.com>
>     wrote:
> 
>     > In mfill_atomic_hugetlb(), mmap_changing isn't being checked
>     > again if we drop mmap_lock and reacquire it. When the lock is not held,
>     > mmap_changing could have been incremented. This is also inconsistent
>     > with the behavior in mfill_atomic().
> 
> 
> The change looks reasonable to me. I'm not sure I can conclusively say there
> isn't some other mechanism specific to hugetlbfs which means this isn't needed,
> though.
  
There's nothing specific to hugetlb, if a non-cooperative uffdio_copy races
with mremap/fork etc, the vma under it may change
 
>     Thanks. Could you and reviewers please consider
> 
>     - what might be the userspace-visible runtime effects?

For users of non-cooperative uffd with hugetlb, this would fix crashes
caused by races between uffd operations that update memory and the
operations that change the VM layout. Pretty much the same fix as
df2cc96e77011 ("userfaultfd: prevent non-cooperative events vs mcopy_atomic
races") for !hugetlb memory.

I doubt such users exist, though...
 
>     - Should the fix be backported into earlier kernels?
>     - A suitable Fixes: target?
> 
> Hmm, 60d4d2d2b40e4 added __mcopy_atomic_hugetlb without this. But, at that
> point in history, none of the other functions had mmap_changing either.
> 
> So, I think the right Fixes: target is df2cc96e77011 ("userfaultfd: prevent
> non-cooperative events vs mcopy_atomic races") ? It seems to have missed the
> hugetlb path. This was introduced in 4.18.
> 
> Based on that commit's message, essentially what can happen if the race
> "succeeds" is, memory can be accessed without userfaultfd being notified of
> this fact. Depending on what userfaultfd is being used for, from
> userspace's perspective this can appear like memory corruption for example. So,
> based on that it seems to me reasonable to backport this to stable kernels
> (4.19+).

I agree with Axel, 

Fixes: df2cc96e77011 ("userfaultfd: prevent non-cooperative events vs mcopy_atomic races")

seems appropriate.

-- 
Sincerely yours,
Mike.

