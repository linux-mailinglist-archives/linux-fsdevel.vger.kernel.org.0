Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039EE7BD165
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 02:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjJIAP4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Oct 2023 20:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjJIAPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 20:15:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E703B6
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Oct 2023 17:15:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c88b467ef8so21709635ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Oct 2023 17:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696810551; x=1697415351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5pMbdaei/dF0n16cuejvm6nYTMm6wJ9kYRo603Y9tXY=;
        b=QdmKix3yy3E1Ui3bJJ0ES5EF0MArsMkQ6sjKQpgbckyBkn8y88kvYo4oJY3F/U6JJc
         9f7WCXSdpD6M/dOXuDhKaBKD/f4mCiwLsjHz7X6pRFM9V9xo9rPyOgAOEb3XJYQ0wP5B
         gh2ZxL+ryUMigElWCKzn4JSoZQfq5CZOhuENpI4AyqqYk+GsSAeyrMiFssyRK8wtQOT/
         dwsZsAUAZ8bS0Mpe3eswW9Ed5rCtu2FwT6eI8blDryhOiG4XR2/+EsJ0AurVlQJ4apml
         UlvIMSj58bMqPqK/n+HzA/63/nA9/yHeeTANgqO02AK4A615h1R9npV0TJyERfkOOsOr
         vVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696810551; x=1697415351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pMbdaei/dF0n16cuejvm6nYTMm6wJ9kYRo603Y9tXY=;
        b=RWmvaJNTu7vpterHeXAc9OKh5H37M+fPDfAp/CwepStrQ04GC483C13sA4NFnavcyD
         FaOgDmwHFm0qL/qD+Jc94adG6XVCxV5/j+MDIXKy4eJE7ojgK0GZWD0I1AqH19T40Vld
         Zs19qJg+EpGGsnVgN0/LxrbqE/VA4jcIulCLN/f8BGFq6rFMDquKO9sRMhTK1CbXNN84
         Cy/H1HJlLTMm/mkWxg4uGnv3AE2U+YE4KcDWRTR6rls2ZCtQ+MWO1zK4HLy5vVlcj7sL
         afMGndP3w+9Q/T+lmA/+dMuXchpjlBd6PT3JJdntM8ZBAFTSb1gWYlNzsg7S7zvfsmKY
         h9iQ==
X-Gm-Message-State: AOJu0YyliF5ot460nCTbi8Om9ODbFN6SDjsqhXAJcABlIcNVxI3NssyI
        Nb0kA51vlVn9GlBE2iSvrLxHMA==
X-Google-Smtp-Source: AGHT+IGJkPv/XYegx4s9UEyZ39lWpjWST9+uJFQQhOB9GWsqna9kS2F0bIydpa24vxmPrUY9+UdkaQ==
X-Received: by 2002:a05:6a21:6d9f:b0:13f:b028:7892 with SMTP id wl31-20020a056a216d9f00b0013fb0287892mr14836860pzb.2.1696810550803;
        Sun, 08 Oct 2023 17:15:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id ix1-20020a170902f80100b001b53953f306sm8122275plb.178.2023.10.08.17.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 17:15:50 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qpdw2-00BIkj-31;
        Mon, 09 Oct 2023 11:15:46 +1100
Date:   Mon, 9 Oct 2023 11:15:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 8/8] shmem,percpu_counter: add _limited_add(fbc, limit,
 amount)
Message-ID: <ZSNGMvICWWaKAaJL@dread.disaster.area>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
 <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com>
 <ZR3wzVJ019gH0DvS@dread.disaster.area>
 <2451f678-38b3-46c7-82fe-8eaf4d50a3a6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2451f678-38b3-46c7-82fe-8eaf4d50a3a6@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 05, 2023 at 10:35:33PM -0700, Hugh Dickins wrote:
> On Thu, 5 Oct 2023, Dave Chinner wrote:
> > On Fri, Sep 29, 2023 at 08:42:45PM -0700, Hugh Dickins wrote:
> > > Percpu counter's compare and add are separate functions: without locking
> > > around them (which would defeat their purpose), it has been possible to
> > > overflow the intended limit.  Imagine all the other CPUs fallocating
> > > tmpfs huge pages to the limit, in between this CPU's compare and its add.
> > > 
> > > I have not seen reports of that happening; but tmpfs's recent addition
> > > of dquot_alloc_block_nodirty() in between the compare and the add makes
> > > it even more likely, and I'd be uncomfortable to leave it unfixed.
> > > 
> > > Introduce percpu_counter_limited_add(fbc, limit, amount) to prevent it.
> > > 
> > > I believe this implementation is correct, and slightly more efficient
> > > than the combination of compare and add (taking the lock once rather
> > > than twice when nearing full - the last 128MiB of a tmpfs volume on a
> > > machine with 128 CPUs and 4KiB pages); but it does beg for a better
> > > design - when nearing full, there is no new batching, but the costly
> > > percpu counter sum across CPUs still has to be done, while locked.
> > > 
> > > Follow __percpu_counter_sum()'s example, including cpu_dying_mask as
> > > well as cpu_online_mask: but shouldn't __percpu_counter_compare() and
> > > __percpu_counter_limited_add() then be adding a num_dying_cpus() to
> > > num_online_cpus(), when they calculate the maximum which could be held
> > > across CPUs?  But the times when it matters would be vanishingly rare.
> > > 
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > Cc: Tim Chen <tim.c.chen@intel.com>
> > > Cc: Dave Chinner <dchinner@redhat.com>
> > > Cc: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > > Tim, Dave, Darrick: I didn't want to waste your time on patches 1-7,
> > > which are just internal to shmem, and do not affect this patch (which
> > > applies to v6.6-rc and linux-next as is): but want to run this by you.
> > 
> > Hmmmm. IIUC, this only works for addition that approaches the limit
> > from below?
> 
> That's certainly how I was thinking about it, and what I need for tmpfs.
> Precisely what its limitations (haha) are, I'll have to take care to
> spell out.
> 
> (IIRC - it's a while since I wrote it - it can be used for subtraction,
> but goes the very slow way when it could go the fast way - uncompared
> percpu_counter_sub() much better for that.  You might be proposing that
> a tweak could adjust it to going the fast way when coming down from the
> "limit", but going the slow way as it approaches 0 - that would be neat,
> but I've not yet looked into whether it's feasily done.)
> 
> > 
> > So if we are approaching the limit from above (i.e. add of a
> > negative amount, limit is zero) then this code doesn't work the same
> > as the open-coded compare+add operation would?
> 
> To it and to me, a limit of 0 means nothing positive can be added
> (and it immediately returns false for that case); and adding anything
> negative would be an error since the positive would not have been allowed.
> 
> Would a negative limit have any use?

I don't have any use for it, but the XFS case is decrementing free
space to determine if ENOSPC has been hit. It's the opposite
implemention to shmem, which increments used space to determine if
ENOSPC is hit.

> It's definitely not allowing all the possibilities that you could arrange
> with a separate compare and add; whether it's ruling out some useful
> possibilities to which it can easily be generalized, I'm not sure.
> 
> Well worth a look - but it'll be easier for me to break it than get
> it right, so I might just stick to adding some comments.
> 
> I might find that actually I prefer your way round: getting slower
> as approaching 0, without any need for specifying a limit??  That the
> tmpfs case pushed it in this direction, when it's better reversed?  Or
> that might be an embarrassing delusion which I'll regret having mentioned.

I think there's cases for both approaching and upper limit from
before and a lower limit from above. Both are the same "compare and
add" algorithm, just with minor logic differences...

> > Hence I think this looks like a "add if result is less than"
> > operation, which is distinct from then "add if result is greater
> > than" operation that we use this same pattern for in XFS and ext4.
> > Perhaps a better name is in order?
> 
> The name still seems good to me, but a comment above it on its
> assumptions/limitations well worth adding.
> 
> I didn't find a percpu_counter_compare() in ext4, and haven't got

Go search for EXT4_FREECLUSTERS_WATERMARK....

> far yet with understanding the XFS ones: tomorrow...

XFS detects being near ENOSPC to change the batch update size so
taht when near ENOSPC the percpu counter always aggregates to the
global sum on every modification. i.e. it becomes more accurate (but
slower) near the ENOSPC threshold. Then if the result of the
subtraction ends up being less than zero, it takes a lock (i.e. goes
even slower!), undoes the subtraction that took it below zero, and
determines if it can dip into the reserve pool or ENOSPC should be
reported.

Some of that could be optimised, but we need that external "lock and
undo" mechanism to manage the reserve pool space atomically at
ENOSPC...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
