Return-Path: <linux-fsdevel+bounces-43854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D97A5E969
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 02:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FFF17AACAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 01:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90A02868B;
	Thu, 13 Mar 2025 01:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="V120Vi2M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53CD8C1E
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 01:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741829127; cv=none; b=PhPZ70TcCtDPqpOAnIEVISgs4s2iXZmviJQ48VvLJ++PzpDWmzisMYmVifkTOPoUXUKLUYXs+NibZmDqgsCpayoiqVp0lEY/hB4qAMAMacnpFvHjundDVLIcNy9BSr6ArruUcgKT+x5xI3rQD4bMGx11z90R7Ciea7cZj9587RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741829127; c=relaxed/simple;
	bh=h/Ugb2wptsQIMENRnFBhTS1WCGZkf5moORc0K+sdwMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6vRO/iLKu8rWqh3YHlnCUU9CqlPt9HUCmR2kuU6Hts7Io9eo+THbL3CWgGoLPvDqg0uaSzRlKMsrXVFWcKq6Mw8lSydgIMCBfgpHQOQsHd/bOVOjAOBh7LxL/k3cioQT2G+K1o5/L8cK4O+qOfjBpk/2c+3OOVx5UfN0h9QlXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=V120Vi2M; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fef5c978ccso798891a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 18:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741829125; x=1742433925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zHbOQiom4kiVHLmxXFl6+bExJ+6jLT2xvKjM7Gchos=;
        b=V120Vi2M50FFPm2XwDVxnzmhQxH9G+kpvzisIbpf7rhss5KBIwdVV53mBynSUquhJg
         OxsTBkoEsMRwp6siTRX/mEVj6igRLj+/FhrDkpI6kd5M8MDgB+bfi3BHgFD5SQPJaemf
         EmOgQvd+1cVpZE/75jaZjj8OgRJWBrLcAVETjrhh47qS9H5osKwVP83mgyyfKwBMIbeH
         DFch16Skg0AIQq1m04Hve+ZG0m/w7YOZBiar1GxeBPKwZe/v3+fE85oh3Dbc/Pj2FM9u
         ysazX/zIBArl+ckzlTWUML17axzS/qAhri5T0ywHmrY08s4HWLIhVqOp47Ai0knwC8WT
         IzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741829125; x=1742433925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zHbOQiom4kiVHLmxXFl6+bExJ+6jLT2xvKjM7Gchos=;
        b=kWyYRlifxUqB+xTqWVpgxARvy5BTZtqWAxLjUG2IhjM6BnjsX/Y73/kmOgei22b4h/
         6RWHeCWcWBgFO1lpLyod5qYmtwxCZAaAojV6AQOrRi7UHLpXontHAAgGjEXoGgkStj9E
         cmd6f+sn9MLgcxDlHfer5EncLe1zQLrn/g3N7E4OsMPD0c7P2TPX1w8O4oUZddHJl99m
         XjHAlYvY8etprTY3JlSBH49CIUkffm19yXBPPRDNF+A9jPbK/+oLH7HMEx7KOE3ynZfn
         qjThL3QxdA/Da5FYiWW/btCZhltRd6MxUpF3wNP+lGEv8XZGN7C9E5r7i4yswRuu7+U6
         YyTw==
X-Forwarded-Encrypted: i=1; AJvYcCVxMeMoAaBSJkRldbzKT8LB12KXTpy2TwTWwshuU+Xv8Fftg3znLoSnJwy4rzy0WlwgAY/DQhPK87OVyIF0@vger.kernel.org
X-Gm-Message-State: AOJu0YwIX62nrxJy5vt7bly8D2UIsHRPXhDEIK90eyW4AquHMGBFRgOt
	kewgvReHqJ0aL8/EXPXp4Ch6ybD1v9wAUMkrQ3l7XWyYineWL2cWz0oEfZ4PzGc=
X-Gm-Gg: ASbGncv2WoW2VmobGbbvjjTZq6uOv2vWmPbeqgFDwu0t9H3l9U0m9D/LzWl20vrf1cm
	EF9f6marHvFLgA2OfmvPEY8MJZri2unSgINsQQVgJLcgyH3BSDNHXTcLoXTmvDA3i7snpRdDrLI
	ZdTahfRCZ3mfadXSzLFM+U3H399+w2tCzpBn2GqF12LQ5nURZxZiTAQ9fa6DM/nhP0tuSp8f8j0
	foRvWH0Ram6vGO7k8GYF8Y9psUWe8dZ233r7Q9gNj2YoLt8FOd0X2LXQrhI1gGRwsTeXAabo4Js
	/WruGql9z3eOARr2a+ltMAZRPM/akGAEO3HVzNJRg8mvbFg9y55ZZm8L7f8iyc1ESeZ5IKlu/gR
	ea1T/cn8zuQ==
X-Google-Smtp-Source: AGHT+IGyj4oBnrPOUXCm7aHzwU7QxPPlJajw237NzAa34xKCgxu/l2WrTQSi/az+Ci/KcOqkNz1yrQ==
X-Received: by 2002:a17:90b:164f:b0:2fe:baa3:b8b9 with SMTP id 98e67ed59e1d1-2ff7ce4f306mr32732496a91.4.1741829124656;
        Wed, 12 Mar 2025 18:25:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30138b3b5f1sm126965a91.8.2025.03.12.18.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:25:24 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tsXK5-0000000CNaw-30mS;
	Thu, 13 Mar 2025 12:25:21 +1100
Date: Thu, 13 Mar 2025 12:25:21 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 03/10] xfs: Refactor xfs_reflink_end_cow_extent()
Message-ID: <Z9I0Ab5TyBEdkC32@dread.disaster.area>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-4-john.g.garry@oracle.com>
 <Z9E2kSQs-wL2a074@infradead.org>
 <589f2ce0-2fd8-47f6-bbd3-28705e306b68@oracle.com>
 <Z9FHSyZ7miJL7ZQM@infradead.org>
 <20250312154636.GX2803749@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312154636.GX2803749@frogsfrogsfrogs>

On Wed, Mar 12, 2025 at 08:46:36AM -0700, Darrick J. Wong wrote:
> On Wed, Mar 12, 2025 at 01:35:23AM -0700, Christoph Hellwig wrote:
> > On Wed, Mar 12, 2025 at 08:27:05AM +0000, John Garry wrote:
> > > On 12/03/2025 07:24, Christoph Hellwig wrote:
> > > > On Mon, Mar 10, 2025 at 06:39:39PM +0000, John Garry wrote:
> > > > > Refactor xfs_reflink_end_cow_extent() into separate parts which process
> > > > > the CoW range and commit the transaction.
> > > > > 
> > > > > This refactoring will be used in future for when it is required to commit
> > > > > a range of extents as a single transaction, similar to how it was done
> > > > > pre-commit d6f215f359637.
> > > > 
> > > > Darrick pointed out that if you do more than just a tiny number
> > > > of extents per transactions you run out of log reservations very
> > > > quickly here:
> > > > 
> > > > https://urldefense.com/v3/__https://lore.kernel.org/all/20240329162936.GI6390@frogsfrogsfrogs/__;!!ACWV5N9M2RV99hQ!PWLcBof1tKimKUObvCj4vOhljWjFmjtzVHLx9apcU5Rah1xZnmp_3PIq6eSwx6TdEXzMLYYyBfmZLgvj$
> > > > 
> > > > how does your scheme deal with that?
> > > > 
> > > The resblks calculation in xfs_reflink_end_atomic_cow() takes care of this,
> > > right? Or does the log reservation have a hard size limit, regardless of
> > > that calculation?
> > 
> > The resblks calculated there are the reserved disk blocks

Used for btree block allocations that might be needed during the
processing of the transaction.

> > and have
> > nothing to do with the log reservations, which comes from the
> > tr_write field passed in.  There is some kind of upper limited to it
> > obviously by the log size, although I'm not sure if we've formalized
> > that somewhere.  Dave might be the right person to ask about that.
> 
> The (very very rough) upper limit for how many intent items you can
> attach to a tr_write transaction is:
> 
> per_extent_cost = (cui_size + rui_size + bui_size + efi_size + ili_size)
> max_blocks = tr_write::tr_logres / per_extent_cost
> 
> (ili_size is the inode log item size)

That doesn't sound right. The number of intents we can log is not
dependent on the aggregated size of all intent types. We do not log
all those intent types in a single transaction, nor do we process
more than one type of intent in a given transaction. Also, we only
log the inode once per transaction, so that is not a per-extent
overhead.

Realistically, the tr_write transaction is goign to be at least a
100kB because it has to be big enough to log full splits of multiple
btrees (e.g. BMBT + both free space trees). Yeah, a small 4kB
filesystem spits out:

xfs_trans_resv_calc:  dev 7:0 type 0 logres 193528 logcount 5 flags 0x4

About 190kB.

However, intents are typically very small - around 32 bytes in size
plus another 12 bytes for the log region ophdr.

This implies that we can fit thousands of individual intents in a
single tr_write log reservation on any given filesystem, and the
number of loop iterations in a transaction is therefore dependent
largely on how many intents are logged per iteration.

Hence if we are walking a range of extents in the BMBT to unmap
them, then we should only be generating 2 intents per loop - a BUI
for the BMBT removal and a CUI for the shared refcount decrease.
That means we should be able to run at least a thousand iterations
of that loop per transaction without getting anywhere near the
transaction reservation limits.

*However!*

We have to relog every intent we haven't processed in the deferred
batch every-so-often to prevent the outstanding intents from pinning
the tail of the log. Hence the larger the number of intents in the
initial batch, the more work we have to do later on (and the more
overall log space and bandwidth they will consume) to relog them
them over and over again until they pop to the head of the
processing queue.

Hence there is no real perforamce advantage to creating massive intent
batches because we end up doing more work later on to relog those
intents to prevent journal space deadlocks. It also doesn't speed up
processing, because we still process the intent chains one at a time
from start to completion before moving on to the next high level
intent chain that needs to be processed.

Further, after the first couple of intent chains have been
processed, the initial log space reservation will have run out, and
we are now asking for a new resrevation on every transaction roll we
do. i.e. we now are now doing a log space reservation on every
transaction roll in the processing chain instead of only doing it
once per high level intent chain.

Hence from a log space accounting perspective (the hottest code path
in the journal), it is far more efficient to perform a single high
level transaction per extent unmap operation than it is to batch
intents into a single high level transaction.

My advice is this: we should never batch high level iterative
intent-based operations into a single transaction because it's a
false optimisation.  It might look like it is an efficiency
improvement from the high level, but it ends up hammering the hot,
performance critical paths in the transaction subsystem much, much
harder and so will end up being slower than the single transaction
per intent-based operation algorithm when it matters most....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

