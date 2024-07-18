Return-Path: <linux-fsdevel+bounces-23959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D15937014
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 23:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38AE11C21AA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 21:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D14145B0F;
	Thu, 18 Jul 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NUvhwkVr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CBF77107;
	Thu, 18 Jul 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338044; cv=none; b=lYkcxlQiie0sMxgUbL0PJpIix4X4ol5SpzUhZNyUMPZzw87TzoZiMBlSttwe591swnmOoUqwW9MzvAbYwGrdQ79dGYpbRTNf+AeOdLNGUUSqCHY8CaKp9JdlHW5vp4oFXaZol3P4gIwKpzVj87PZWRsDBKsAsofntMGwklpnFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338044; c=relaxed/simple;
	bh=ljF7qPahvmPN+jQ666ak5bdqgC1Rb1vkJsw5r2RDcq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOpmGlqU7pZVqEatGD1VGhgOQUrOXJXDgWpwklpT2Uu4Jw5niNKXH+52mKdzC9awTwUlI3HatJ2a3Gv99UfAnAG2m1INRh3cf/6NS+Ywgj+tCO+ofvbnreGmI011pzqrVDq+PcdUo/4NvFzIRCr9pmixJdPf0xgeOINeYcdipGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NUvhwkVr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4CYbVCprgYBXSc+P4gFK127u7ObHmJCwV+eBXVuumXk=; b=NUvhwkVryN6eFXcYXlKfjExdqu
	eZAd84/hMuYwLFQRu6i8uGy/x7UIokIUx9eFsE04J7qq8dCz0nG1nyp8iQLqYUUJ0J8PppMSQ4lwX
	qtzXXuRYrSdaFEij4Xr6M7fdKWXoSsEMDjHp51zaSGv2WTXlxnpQTWhHHSbIfSaTZJ68Wk007b28H
	0o+MGdMdDn4VjcAMvxAOGgp/nQLWqnvOg7BFbIWwPNPTtpSU5Yisn3iN/niErZL1zpVx3/PifYTBc
	HIWi1msm6lS39u4/0Rq+ZZCEea/ys31ScNuuUt/3YKARmTYjmBpFTj0/YZGiVRwt69fene16hofK+
	hwfmSWKg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUYek-00000002LaN-38XU;
	Thu, 18 Jul 2024 21:27:18 +0000
Date: Thu, 18 Jul 2024 22:27:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.11
Message-ID: <ZpmItplPA5_zmAmC@casper.infradead.org>
References: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
 <CAHk-=wigjHuE2OPyuT6GK66BcQSAukSp0sm8vYvVJeB7+V+ecQ@mail.gmail.com>
 <5ypgzehnp2b3z2e5qfu2ezdtyk4dc4gnlvme54hm77aypl3flj@xlpjs7dbmkwu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ypgzehnp2b3z2e5qfu2ezdtyk4dc4gnlvme54hm77aypl3flj@xlpjs7dbmkwu>

On Thu, Jul 18, 2024 at 05:20:54PM -0400, Kent Overstreet wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> Date: Thu, 18 Jul 2024 17:17:10 -0400
> Subject: [PATCH] lockdep: Add comments for lockdep_set_no{validate,track}_class()
> 
> Cc: Waiman Long <longman@redhat.com>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> 
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index b76f1bcd2f7f..bdfbdb210fd7 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -178,9 +178,22 @@ static inline void lockdep_init_map(struct lockdep_map *lock, const char *name,
>  			      (lock)->dep_map.wait_type_outer,		\
>  			      (lock)->dep_map.lock_type)
>  
> +/**
> + * lockdep_set_novalidate_class: disable checking of lock ordering on a given
> + * lock
> + *
> + * Lockdep will still record that this lock has been taken, and print held
> + * instances when dumping locks
> + */

Might want to run this through kernel-doc.  I'm pretty sure it wants
macro comments to be formatted like function comments.  ie:

/**
 * lockdep_set_novalidate_class - Disable lock order checks on this lock.
 * @lock: The lock to disable order checks for.
 *
 * Lockdep will still record that this lock has been taken, and print held
 * instances when dumping locks.
 */

>  #define lockdep_set_novalidate_class(lock) \
>  	lockdep_set_class_and_name(lock, &__lockdep_no_validate__, #lock)

