Return-Path: <linux-fsdevel+bounces-40463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C89A238A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 02:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED927A117E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 01:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9277433C8;
	Fri, 31 Jan 2025 01:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGNZKdvb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3DE28377;
	Fri, 31 Jan 2025 01:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738287260; cv=none; b=aElXmQNON5xQpspbOXuyLU85x/fvIILm3NL5fp5b2TG5kUiFSLHKiF8hHrtbMKN8Hhcim00AbmSf9uAO9OR7WGo4MzRBakLVM70ISMdxbdG+S8A8+AHR2ouxCDUMmRSTqKlQvte9x1/2TWGNptcMzAXRdRZbEVZ9LNYJYkdgAWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738287260; c=relaxed/simple;
	bh=aVGXiC4y4nMQNLzoXl1Kn6ix+nBLlrDRS2onLeXP7cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcD5hsdRlio40UQpC3MIGzxoZIytQqOLnNB7xrO+OwedGgrHSyBNE/JtJYrMOUCsPf4LjXDq2sY298cTOOzCqD8TYX/74QXLYjyp5dVHQd0DfwfqZW/4trlX6MiGlZQEckNL24DKNFQEdGsZHGGgtE0pqp+hCmSLQfHYouAbqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGNZKdvb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738287257; x=1769823257;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aVGXiC4y4nMQNLzoXl1Kn6ix+nBLlrDRS2onLeXP7cg=;
  b=IGNZKdvbJMCVhFDLo1s5yVu/sS9U3oFv172yYFdIVJCeaMSQ/i8FNF6h
   tWGGdSRwRHrE5QFYmhpyPEDc37m35Y7/+cVkzROHHhEUvliOlWUjvfKwT
   kQhK7jocXcUsPyYpjSkkPSogAJ8UIcxTkq2DG2KIEwKhzC69v2qWh0C5r
   uwEWcAsA0karPnU22WkUxqnyc/TDdAriXYirgwpB+FP1ZBjj0reAduwRb
   62qk/tw3GTn3fo2VuhUE7j1Wf1EG7lCHDFDGcre145EDZEjbMu1felgsu
   KopoVReNIzvo0oLZACAlaf6tCQ4SE+3uMdR5BDshunULKKcnw8dP5yu7F
   w==;
X-CSE-ConnectionGUID: 1Ec0InDzQ76NcD4vL/VPhQ==
X-CSE-MsgGUID: aAnsZTUYTbuaBfV9LzdGfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="61326561"
X-IronPort-AV: E=Sophos;i="6.13,247,1732608000"; 
   d="scan'208";a="61326561"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 17:34:16 -0800
X-CSE-ConnectionGUID: pT6CSxBYT3aZyZhH5ZtypA==
X-CSE-MsgGUID: bP5fE04RTLuh87xyvRLPCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146682500"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.230]) ([10.125.108.230])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 17:34:16 -0800
Message-ID: <562e4bdc-d0f3-4a4d-8443-174c716daaa0@intel.com>
Date: Thu, 30 Jan 2025 17:34:18 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Move prefaulting into write slow paths
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
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
 <f35aa9a2-edac-4ada-b10b-8a560460d358@intel.com>
 <t7rjw6a462k5sm2tdviyd7sq6n44uxb3haai566m4hm7dvvlpi@btt3blanouck>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <t7rjw6a462k5sm2tdviyd7sq6n44uxb3haai566m4hm7dvvlpi@btt3blanouck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/25 16:56, Kent Overstreet wrote:
> On Thu, Jan 30, 2025 at 08:04:49AM -0800, Dave Hansen wrote:...
>> Any suggestions for fully describing the situation? I tried to sprinkle
>> comments liberally but I'm also painfully aware that I'm not doing a
>> perfect job of talking about the fs code.
> 
> The critical thing to cover is the fact that mmap means that page faults
> can recurse into arbitrary filesystem code, thus blowing a hole in all
> our carefully crafted lock ordering if we allow that while holding
> locks - you didn't mention that at all.

What I've got today is this:

              /*
               * This needs to be atomic because actually handling page
               * faults on 'i' can deadlock if the copy targets a
               * userspace mapping of 'folio'.
               */
	      copied = copy_folio_from_iter_atomic(...);

Are you saying you'd prefer that this be something more like:

		/*
		 * Faults here on mmap()s can recurse into arbitrary
		 * filesystem code. Lots of locks are held that can
		 * deadlock. Use an atomic copy to avoid deadlocking
		 * in page fault handling.
		 */

?

>>> I do agree on moving it to the slowpath - I think we can expect the case
>>> where the process's immediate workingset is faulted out while it's
>>> running to be vanishingly small.
>>
>> Great! I'm glad we're on the same page there.
>>
>> For bcachefs specifically, how should we move forward? If you're happy
>> with the concept, would you prefer that I do some manual bcachefs
>> testing? Or leave a branch sitting there for a week and pray the robots
>> test it?
> 
> No to the sit and pray. If I see one more "testing? that's something
> other people do" conversation I'll blow another gasket.
> 
> xfstests supports bcachefs, and if you need a really easy way to run it
> locally on all the various filesystems, I have a solution for that:
> 
> https://evilpiepirate.org/git/ktest.git/
> 
> If you want access to my CI that runs all that in parallel across 120
> VMs with the nice dashboard - shoot me an email and I'll outline server
> costs and we can work something out.

That _sounds_ a bit heavyweight to me for this patch:

 b/fs/bcachefs/fs-io-buffered.c |   30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

Is that the the kind of testing (120 VMs) that is needed to get a patch
into bcachefs?

Or are you saying that running xfstests on bcachefs with this patch
applied would be sufficient?

On the x86 side, I'm usually pretty happy to know that someone has
compiled a patch and at least executed the code at runtime a time or
two. So this process is a bit unfamiliar to me.

