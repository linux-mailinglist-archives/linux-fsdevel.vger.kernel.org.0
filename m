Return-Path: <linux-fsdevel+bounces-14087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A91D87794C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 01:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6F11C20C31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 00:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D0E7EC;
	Mon, 11 Mar 2024 00:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="tTpsvZuv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4AC628
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710116793; cv=none; b=YPgKYgZVS+isAKDjaUxFsoBXMLaLewQ/iR647odNvseGl2Wg4pHGOgb6O6rNbEQgjbOyStcrYbc9NwQG8XbLv1AwkUZgi+aqsK2SkicEpPF/dbpY50YJ7/he4h/NslarbG3mhWbeoWSv2CK2VlKKr0ijIeUweuypBvyQwrAPo1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710116793; c=relaxed/simple;
	bh=iBKjjTrnOHzNOegJJQGLP50ZpI68uONSIDUMvj2s3Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XipWfqWFKaJFeCWfjhExj2Z/GndRKzUlYcFooNR/wAaG/Q9w3tSDi+jIGiB8FFolywpkZHK5OSYOqmg+yjAbwrqFQItYW6iVJ7g6PzU3EfyiV2u33tqmVFbxdjQsGptKSlD6GMdkAvVJ4HEWouIM2f85XhSTnqQ5IIyNoIhb/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=tTpsvZuv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dd8f7d50c6so3513765ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Mar 2024 17:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710116788; x=1710721588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r+ZDbxeIcvt8eupuU3iHpjDH4gBEwZMYuiYtlmL76Eo=;
        b=tTpsvZuvNS81KlgYcgGMdbodetSb3JKjdc1wXrfhG/eXGZRPmZXw09rKKwcmC+jA8D
         pyg3Ddyjv8xYnpIlbvWQ41zCoopZNhwpnf/blxPz+PUBzqaxLpt4QwCWsaJur5DxN4zz
         UcDqe5vHJNzE9WUgLjtXJOjtc/j2syPP9PKnkOfnZqa5KXjnd5S6M0k5phMvLSQPYJ7F
         rsg00rVvPyyGWtl1PkYLQNjD8KvquxSfrzB8WZZyFuldzKMTwacBjSGIBhvqPKkYzv90
         kNXFiivwTNGOcLVeAHz+6MmZXaINwmJeDXLPZggQZCMp+JHaApD6DlL1a5pyfhIsFKx8
         lUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710116788; x=1710721588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+ZDbxeIcvt8eupuU3iHpjDH4gBEwZMYuiYtlmL76Eo=;
        b=Lozgz30UvlhWrwIj61zSZXxS+wg0wPOYBKwI/Y+7Vn3fVLtFsWPZtz1wX5EJyFIo+Z
         mraEak39maxWSMwRiGTrgeiAJmsq0QF+7k725/v/1gJm1noee8tFpjJw25YVkk9Zr5vP
         IaQtAEbsPCAoi9BxDHQROKhqiNlolwcooHvNsE1j9QK0G8VRm3xk89BakjcqvxeEcICW
         xkfF7ozHlndJG5bm0vh6+GbmVZmpMxTxv4MVgQNX7tMD706g8r3jJ/H23XYLlcSIf2Dh
         u/muldi8/RYgYITM5/vNfChfhQctHMxAmfQ1mPzzeTufuegTlJcIoMnQZCIJq0tBv+/I
         rm7g==
X-Forwarded-Encrypted: i=1; AJvYcCUFgzKhSvVgDB0OJZ/z7ERKFMr2ZmXQuRyeNyuJU9Gj8YrrKaUe4/0IOQCpq01tfxUMDIG4kAl1BnJSGcziowmg8alqwuWihF9pLvZ9+Q==
X-Gm-Message-State: AOJu0Yxe7XHKNERJeo5MVW6vRZ87nx2O6eATrX/5IAAn8UQxGVNcDuvC
	G/IUgmjhK2blGezyXsreJteKIG1PzqMveUE2UnPx1CkD8L5jsFZ3L7VKRDlRey8=
X-Google-Smtp-Source: AGHT+IHzV7FprUI1FoXB5iJZCu3Lbc002VzAsroztma0cmpHQA1DeV9d9zr30wWO4FIBCVe1xGGJhQ==
X-Received: by 2002:a17:902:e88c:b0:1dd:4cb:cc57 with SMTP id w12-20020a170902e88c00b001dd04cbcc57mr6011101plg.0.1710116788118;
        Sun, 10 Mar 2024 17:26:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c3c600b001dd5f5b1ca4sm3232768plj.309.2024.03.10.17.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 17:26:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rjTUm-000EB4-1C;
	Mon, 11 Mar 2024 11:26:24 +1100
Date: Mon, 11 Mar 2024 11:26:24 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, ebiggers@kernel.org
Subject: Re: [PATCH v5 11/24] xfs: add XBF_VERITY_SEEN xfs_buf flag
Message-ID: <Ze5PsMopkWqZZ1NX@dread.disaster.area>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-13-aalbersh@redhat.com>
 <20240307224654.GB1927156@frogsfrogsfrogs>
 <ZepxHObVLb3JLCl/@dread.disaster.area>
 <20240308033138.GN6184@frogsfrogsfrogs>
 <20240309162828.GQ1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309162828.GQ1927156@frogsfrogsfrogs>

On Sat, Mar 09, 2024 at 08:28:28AM -0800, Darrick J. Wong wrote:
> On Thu, Mar 07, 2024 at 07:31:38PM -0800, Darrick J. Wong wrote:
> > On Fri, Mar 08, 2024 at 12:59:56PM +1100, Dave Chinner wrote:
> > > > (Ab)using the fsbuf code did indeed work (and passed all the fstests -g
> > > > verity tests), so now I know the idea is reasonable.  Patches 11, 12,
> > > > 14, and 15 become unnecessary.  However, this solution is itself grossly
> > > > overengineered, since all we want are the following operations:
> > > > 
> > > > peek(key): returns an fsbuf if there's any data cached for key
> > > > 
> > > > get(key): returns an fsbuf for key, regardless of state
> > > > 
> > > > store(fsbuf, p): attach a memory buffer p to fsbuf
> > > > 
> > > > Then the xfs ->read_merkle_tree_block function becomes:
> > > > 
> > > > 	bp = peek(key)
> > > > 	if (bp)
> > > > 		/* return bp data up to verity */
> > > > 
> > > > 	p = xfs_attr_get(key)
> > > > 	if (!p)
> > > > 		/* error */
> > > > 
> > > > 	bp = get(key)
> > > > 	store(bp, p)
> > > 
> > > Ok, that looks good - it definitely gets rid of a lot of the
> > > nastiness, but I have to ask: why does it need to be based on
> > > xfs_bufs?
> > 
> > (copying from IRC) It was still warm in my brain L2 after all the xfile
> > buftarg cleaning and merging that just got done a few weeks ago.   So I
> > went with the simplest thing I could rig up to test my ideas, and now
> > we're at the madly iterate until exhaustion stage. ;)
> > 
> > >            That's just wasting 300 bytes of memory on a handle to
> > > store a key and a opaque blob in a rhashtable.
> > 
> > Yep.  The fsbufs implementation was a lot more slender, but a bunch more
> > code.  I agree that I ought to go look at xarrays or something that's
> > more of a direct mapping as a next step.  However, i wanted to get
> > Andrey's feedback on this general approach first.
> > 
> > > IIUC, the key here is a sequential index, so an xarray would be a
> > > much better choice as it doesn't require internal storage of the
> > > key.
> > 
> > I wonder, what are the access patterns for merkle blobs?  Is it actually
> > sequential, or is more like 0 -> N -> N*N as we walk towards leaves?

I think the leaf level (i.e. individual record) access patterns
largely match data access patterns, so I'd just treat it like as if
it's a normal file being accessed....

> > Also -- the fsverity block interfaces pass in a "u64 pos" argument.  Was
> > that done because merkle trees may some day have more than 2^32 blocks
> > in them?  That won't play well with things like xarrays on 32-bit
> > machines.
> > 
> > (Granted we've been talking about deprecating XFS on 32-bit for a while
> > now but we're not the whole world)
> > 
> > > i.e.
> > > 
> > > 	p = xa_load(key);
> > > 	if (p)
> > > 		return p;
> > > 
> > > 	xfs_attr_get(key);
> > > 	if (!args->value)
> > > 		/* error */
> > > 
> > > 	/*
> > > 	 * store the current value, freeing any old value that we
> > > 	 * replaced at this key. Don't care about failure to store,
> > > 	 * this is optimistic caching.
> > > 	 */
> > > 	p = xa_store(key, args->value, GFP_NOFS);
> > > 	if (p)
> > > 		kvfree(p);
> > > 	return args->value;
> > 
> > Attractive.  Will have to take a look at that tomorrow.
> 
> Done.  I think.  Not sure that I actually got all the interactions
> between the shrinker and the xarray correct though.  KASAN and lockdep
> don't have any complaints running fstests, so that's a start.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity-cleanups-6.9_2024-03-09

My initial impression is "over-engineered".

I personally would have just allocated the xattr value buffer with a
little extra size and added all the external cache information (a
reference counter is all we need as these are fixed sized blocks) to
the tail of the blob we actually pass to fsverity. If we tag the
inode in the radix tree as having verity blobs that can be freed, we
can then just extend the existing fs sueprblock shrinker callout to
also walk all the verity inodes with cached data to try to reclaim
some objects...

But, if a generic blob cache is what it takes to move this forwards,
so be it.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

