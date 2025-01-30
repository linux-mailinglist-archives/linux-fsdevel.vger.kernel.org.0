Return-Path: <linux-fsdevel+bounces-40402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD685A23176
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83553A7117
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6817B1EE031;
	Thu, 30 Jan 2025 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mm8ukA87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B531E8837;
	Thu, 30 Jan 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738253091; cv=none; b=PPHIxHtVFp6n3V93Y0t6auG5dqTL6ehUkHbD8yVWQIw+XoS0uQufiHhxXpPFkowbYLhIV0YwNSdfJywvqAYZwS/KH/8GicjRjqpWqVyWOysVDOA7B5HlicNF84ahbJL8FKhJCiCUIiQllpPdFHxPHDm0Ng7SrGSAlvWSVAIfBAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738253091; c=relaxed/simple;
	bh=4ZRTirV/qMXGv1lhHQu9Z2RIqCSCgFSwedbKpogvN08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Se7ys2vVeEGpf7L+lO3hxMkSBq9DOyahCFIQv8IIWuukH/jePsKKQ09u/C5MwF1nqcRqGgbVCvX0N7XJNxxvCdLFeVXu57sQbOU4xOJhohs7G348xbpeneYVVlCtPYCB5H7W1GcPbKnJoUN5si7GwxdF3oB1m8zHYXRT8YJEdFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mm8ukA87; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738253090; x=1769789090;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4ZRTirV/qMXGv1lhHQu9Z2RIqCSCgFSwedbKpogvN08=;
  b=mm8ukA87Yc9p/oRcSNkT8uEQmAmZKONiuEffNztQPbaqWZjDO/tkG/0o
   LnYAyOuUP4AomQcJVGNKRwIP9MZLUWC5o623i5g3BtR+ZQdHOEbsahEP1
   jSvXflKgNFg4m0Zc2ccPALg16KvbQ2xxlQx6NQjE4x5fHOoEyckDSsEE6
   5fGU8IJJe7vxpYBCK5MNQyoTJJRIknN/4y7jF6nUbHa3ftdZxgJwBidXO
   9fHhqlpGhDDdWTjIUqi2baw0h/fxhcCqm9KOtgyJ5tBI5deT0qnn2LxSC
   pQTo2uCvlHdhp6Xii2b6wcEqZJsCWYIetVKBSRuh7+MWhaYFRDLQayVFS
   A==;
X-CSE-ConnectionGUID: UagTAG2ERnKWf1HOrwL2QA==
X-CSE-MsgGUID: Or29WqiVTyuYcSTb3T1jmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="41636911"
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="41636911"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 08:04:49 -0800
X-CSE-ConnectionGUID: UwYGh57xR/yTBqzQLoyWlA==
X-CSE-MsgGUID: RzBbKHHaRvSoK3Av6eDkLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="109965833"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.230]) ([10.125.108.230])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 08:04:48 -0800
Message-ID: <f35aa9a2-edac-4ada-b10b-8a560460d358@intel.com>
Date: Thu, 30 Jan 2025 08:04:49 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Move prefaulting into write slow paths
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Ted Ts'o <tytso@mit.edu>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev,
 miklos@szeredi.hu, linux-bcachefs@vger.kernel.org, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
 dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
 <qpeao3ezywdn5ojpcvchaza7gd6qeb57kvvgbxt2j4qsk4qoey@vrf4oy2icixd>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <qpeao3ezywdn5ojpcvchaza7gd6qeb57kvvgbxt2j4qsk4qoey@vrf4oy2icixd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/25 23:44, Kent Overstreet wrote:
> On Wed, Jan 29, 2025 at 10:17:49AM -0800, Dave Hansen wrote:
>> tl;dr: The VFS and several filesystems have some suspect prefaulting
>> code. It is unnecessarily slow for the common case where a write's
>> source buffer is resident and does not need to be faulted in.
>>
>> Move these "prefaulting" operations to slow paths where they ensure
>> forward progress but they do not slow down the fast paths. This
>> optimizes the fast path to touch userspace once instead of twice.
>>
>> Also update somewhat dubious comments about the need for prefaulting.
>>
>> This has been very lightly tested. I have not tested any of the fs/
>> code explicitly.
> 
> Q: what is preventing us from posting code to the list that's been
> properly tested?
> 
> I just got another bcachefs patch series that blew up immediately when I
> threw it at my CI.
> 
> This is getting _utterly ridiculous_.

In this case, I started with a single patch for generic code that I knew
I could test. In fact, I even had the 9-year-old binary sitting on my
test box.

Dave Chinner suggested that I take the generic pattern go look a _bit_
more widely in the tree for a similar pattern. That search paid off, I
think. But I ended up touching corners of the tree I don't know well and
don't have test cases for.

> I built multiuser test infrastructure with a nice dashboard that anyone
> can use, and the only response I've gotten from the old guard is Ted
> jumping in every time I talk about it to say "no, we just don't want to
> rewrite our stuff on _your_ stuff!". Real helpful, that.

Sounds pretty cool! Is this something that I could have and should have
used to test the bcachefs patch?  I see some trees in here:

	https://evilpiepirate.org/~testdashboard/ci

But I'm not sure how to submit patches to it. Do you need to add users
manually? I wonder, though, how we could make it easier to find. I
didn't see anything Documentation/filesystems/bcachefs/ about this.

>>  1. Deadlock avoidance if the source and target are the same
>>     folios.
>>  2. To check the user address that copy_folio_from_iter_atomic()
>>     will touch because atomic user copies do not check the address.
>>  3. "Optimization"
>>
>> I'm not sure any of these are actually valid reasons.
>>
>> The "atomic" user copy functions disable page fault handling because
>> page faults are not very atomic. This makes them naturally resistant
>> to deadlocking in page fault handling. They take the page fault
>> itself but short-circuit any handling.
> 
> #1 is emphatically valid: the deadlock avoidance is in _both_ using
> _atomic when we have locks held, and doing the actual faulting with
> locks dropped... either alone would be a buggy incomplete solution.

I was (badly) attempting to separate out the two different problems:

	1. Doing lock_page() twice, which I was mostly calling the
	   "deadlock"
	2. Retrying the copy_folio_from_iter_atomic() forever which I
	   was calling the "livelock"

Disabling page faults fixes #1.
Doing faulting outside the locks somewhere fixes #2.

So when I was talking about "Deadlock avoidance" in the cover letter, I
was trying to focus on the double lock_page() problem.

> This needs to be reflected and fully described in the comments, since
> it's subtle and a lot of people don't fully grok what's going on.

Any suggestions for fully describing the situation? I tried to sprinkle
comments liberally but I'm also painfully aware that I'm not doing a
perfect job of talking about the fs code.

> I'm fairly certain we have ioctl code where this is mishandled and thus
> buggy, because it takes some fairly particular testing for lockdep to
> spot it.

Yeah, I wouldn't be surprised. It was having a little chuckle thinking
about how many engineers have discovered and fixed this problem
independently over the years in all the file system code in all the OSes.

>> copy_folio_from_iter_atomic() also *does* have user address checking.
>> I get a little lost in the iov_iter code, but it does know when it's
>> dealing with userspace versus kernel addresses and does seem to know
>> when to do things like copy_from_user_iter() (which does access_ok())
>> versus memcpy_from_iter().[1]
>>
>> The "optimization" is for the case where 'source' is not faulted in.
>> It can avoid the cost of a "failed" page fault (it will fail to be
>> handled because of the atomic copy) and then needing to drop locks and
>> repeat the fault.
> 
> I do agree on moving it to the slowpath - I think we can expect the case
> where the process's immediate workingset is faulted out while it's
> running to be vanishingly small.

Great! I'm glad we're on the same page there.

For bcachefs specifically, how should we move forward? If you're happy
with the concept, would you prefer that I do some manual bcachefs
testing? Or leave a branch sitting there for a week and pray the robots
test it?

