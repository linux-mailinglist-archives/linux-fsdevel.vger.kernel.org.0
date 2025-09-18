Return-Path: <linux-fsdevel+bounces-62124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D905B84CAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D30A47B40E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E62630BB95;
	Thu, 18 Sep 2025 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="u85Qb97r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32251308F1C;
	Thu, 18 Sep 2025 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201973; cv=none; b=jhV2HnUgbU61IdGKuNIVeb0tCeyc4em3ip92v5OK5bDZKjbr6bBl2ocDUkl3mBkDjxk0ctz9uRRbSx6moDnep7NY7X3cvt3h2qW3vy3pIJ6zO+gg9YryBTUir874K8h3aR7/DRi5S5QlCr+0GYfX2/ypYqWRXDmbSJxOrui2094=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201973; c=relaxed/simple;
	bh=JJaZnKFvzFzwwGQlLyDmFyDesFr7wZ5v7/rhWsJxmLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2ROqdpytXKVbx87yzWSNHa+JYroaelOnJEzuIl/cHEThuHQQdr42SDrEnG+SYBbWKbe0w3zqDUOVFA5C0y6QqHRCyo/oe4Nhu0LyXyu5zRPsRrdEcvp7rGwokb1fcjfp07NqhMX2DbfoNucq2ZEaSrnTPA2w1hWOd2PYBaGqNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=u85Qb97r; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1758201631;
	bh=arm2FVaxIKWuIaKnTZrIgyT2B8qcACP+dOzi1yRrb5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u85Qb97rmznRYAKNnQQR25jMOvG+6E2E1PmsYqUkA8cjOWO51Oiwr9fbClX+WDHjt
	 HkzbkM6VU9oezBS990j7Rxxk6F7vmdIwnmjn66XTixwH97bxO+ijzS/gqxY2/FpFyP
	 TjTolrzuYImoACGa6VedOHroHoU3AM37r6aDZnYj7s8Y3LbWY0Ux4Wh4pVndmHzIOV
	 NDKcrPObGrD94xAWLJOmZlBvDrJ04is7Wqm9vN4yq+evJyVF9qy4fRqYem6UQ77MVq
	 pTH39+Eh4LzXqnF6IXsvrZb95NwQdHdPTaRJRDjqIGoBNGdNcF8CB2US5jVI7WsVMb
	 n+MRHAlbFv0bw==
Received: from localhost.localdomain (unknown [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4cSGTq6LKSzGqy;
	Thu, 18 Sep 2025 09:20:31 -0400 (EDT)
Date: Thu, 18 Sep 2025 09:20:30 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	kernel test robot <lkp@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2 3/6] uaccess: Provide scoped masked user access regions
Message-ID: <aMwHHkaSECBDjuir@localhost.localdomain>
References: <20250916163004.674341701@linutronix.de>
 <20250916163252.164475057@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916163252.164475057@linutronix.de>

On 16-Sep-2025 06:33:13 PM, Thomas Gleixner wrote:
> User space access regions are tedious and require similar code patterns all
> over the place:
> 
>      	if (!user_read_access_begin(from, sizeof(*from)))
> 		return -EFAULT;
> 	unsafe_get_user(val, from, Efault);
> 	user_read_access_end();
> 	return 0;
> Efault:
> 	user_read_access_end();
> 	return -EFAULT;
> 
> This got worse with the recend addition of masked user access, which
> optimizes the speculation prevention:
> 
> 	if (can_do_masked_user_access())
> 		from = masked_user_read_access_begin((from));
> 	else if (!user_read_access_begin(from, sizeof(*from)))
> 		return -EFAULT;
> 	unsafe_get_user(val, from, Efault);
> 	user_read_access_end();
> 	return 0;
> Efault:
> 	user_read_access_end();
> 	return -EFAULT;
> 
> There have been issues with using the wrong user_*_access_end() variant in
> the error path and other typical Copy&Pasta problems, e.g. using the wrong
> fault label in the user accessor which ends up using the wrong accesss end
> variant. 
> 
> These patterns beg for scopes with automatic cleanup. The resulting outcome
> is:
>     	scoped_masked_user_read_access(from, return -EFAULT,
> 		scoped_get_user(val, from); );
> 	return 0;

I find a few aspects of the proposed API odd:

- Explicitly implementing the error label within a macro parameter,
- Having the scoped code within another macro parameter.

I would rather expect something like this to mimick our expectations
in C:

int func(void __user *ptr, size_t len, char *val1, char *val2)
{
        int ret;

        scoped_masked_user_read_access(ptr, len, ret) {
                scoped_get_user(val1, ptr[0]);
                scoped_get_user(val2, ptr[0]);
        }
        return ret;
}

Where:

- ptr is the pointer at the beginning of the range where the userspace
  access will be done.
- len is the length of the range.
- ret is a variable used as output (set to -EFAULT on error, 0 on
  success). If the user needs to do something cleverer than
  get a -EFAULT on error, they can open-code it rather than use
  the scoped helper.
- The scope is presented similarly to a "for ()" loop scope.

Now I have no clue whether preprocessor limitations prevent achieving
this somehow, or if it would end up generating poor assembler.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

