Return-Path: <linux-fsdevel+bounces-44230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102A8A66410
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 01:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C643C7A9E0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 00:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B745C14;
	Tue, 18 Mar 2025 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="U6fXmtTo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2F62E62C
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 00:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258616; cv=none; b=Jb/TAmOVH1hiWBLMLC3cslH0ymQkFxuYiHTiOH7vGwOrMn/dNzTmRYAN2rnjwWn6GiCWeMF8vYgw3l/OOdH4G2+s3N4Pc909GxfBx2Id1GaORSZ9pNgq4IaOhjOo2bCuHcMwL+Mn36i3s0fCksrYZb76kcKy7GqGTfGltN122b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258616; c=relaxed/simple;
	bh=w29BhJqQzuRcVIETH6oSX4A0cP6qYWWIdguFoCMWO6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbkKovLPvSiRO5kBXd4zYhNa3p/yHjCbqwieE0bBdkfVNmM0cJfO2UYSRRz5MvpnzuNEqbNRzHMSC1IxuiyKd5sS9LvqfSm5vV0v6z/3EIQkOESbTypjGGzqmEBpoKIjJfbsNoD/J0m3vUzn3DuY+FXEcnNqYLZVh29ezTDaD18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=U6fXmtTo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22548a28d0cso138064895ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 17:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1742258613; x=1742863413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jxCs1+ldC/reIzUbUw3Ji2xhPawqyhgThPM8fN/x0aY=;
        b=U6fXmtTo3O7+Qam0rRC5+8pBlyfqMbTRnQQrFzzcF6MSbbrIVxJb3SZVBqugFPBGtC
         xXfN0eq7XfRx8mGEUuDVdSSL8T/9TvkWRUtYHEohXsK7QMNIC+jsiBLPxZ7aDZQU1c/f
         TbonNp/1lVuJJ6qWGXUXgYoCsPW3/dX0xjBmKcy4wRMua60UNMnA4cmtlfvFkfldEzz3
         /yrZdyaBTw2sFbE6IU/bmpC6SpYQ2bEYN8p40Ia95+j60NNe073pIF2O35pi3DDl3y7F
         T3ko038arAAjX//+SR0MIgoXmXKasv1enG31cb4WmmsjRdctK2gr1EchFs/B9xL7ppCh
         kbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742258613; x=1742863413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxCs1+ldC/reIzUbUw3Ji2xhPawqyhgThPM8fN/x0aY=;
        b=F4x/N9xtGkUIL4QuPZja1NARh34SG/QOH95y/eIMU7kcoE6i7JqKnm6Zq5Hhd1izcb
         8I1Aig45DFR5KCMEUwJuMHGyHH4Vt2h2LYPUcFMbJj5pCZuOcuRmVnQMR4Li+cRB45db
         P+hQsuzZ9Atf/Gfsg646eL3p7DwajpTwQaMfvOItd/WT8P1vbCS9mWLpTM44DMW8j3O2
         pxfjjOm3ggEvwYMQfgpcx6LnpLXpxDGKwY4TRz6BUFiTjzhkFUHzZODoCjXO6kpTPAA5
         bFGkDXUdjoavDZEMDyxgfgfLGUlg7xeht4hGYkTr88Nek9Igr6CpRNXtDYWS1bCIvWm5
         I7ug==
X-Forwarded-Encrypted: i=1; AJvYcCUkzxGwY9EDxEtWQSY2jMaxtTOOvJ1xE+E9M9GfTTr25Rb+oJHfkWBRz1XyISsJaQW44az5RKNWnNdYpMf3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8t7a9KzTuKXa+nv+QOFc7NM48On+FMCcjKll0rgV2UPVncwMh
	m9hFEqh3PJc6KEuieIwobxzzwLQNHM5tXnJC+2Ees3A3lHsrSYn5dkCNBvC2Opo=
X-Gm-Gg: ASbGnctqObrvwlKVZsgH5kkPTgXAthnPHwAtMNSMqplHKDlJlzd4AsjiqBS5je0F9lm
	6z1GS3bB+T7IvRpoHL0wxGUBtCVLXw/x3P3XHsIYFW8TBd3Bg/vYAG6kygKikKjFO8QUjDMMMkH
	ypiTfKSGkskcr20Aqze83XZ4u+TBem5egXAsOgbU2h1JLsynoUjd179UvVaP46LAbgmWE5mysJO
	N+TIN5aI+TgBFvZYwsL5HG2NpYcUfBZglKnZrDID44yFQLXn+wa68iBNnt02ie5s98u0DvNFQ5Y
	qpxIaQ6LiCzPnKfImS/vkj2dmLyteQmG1CMBwp33OIbNXGsmn+wdDuuP2oub0qwEcMKApJkKUbx
	D4i1cO0W7GplU76ZSunU6
X-Google-Smtp-Source: AGHT+IE8OsE6HgPjTeAy9p47YdWtvXUbWVrbbOGF4Q9zHkp00HJ9HRbHg+fTuQKbY0WQdTzulXiAEA==
X-Received: by 2002:a17:902:f689:b0:223:4b88:780f with SMTP id d9443c01a7336-225e0a3ae99mr153283535ad.17.1742258613560;
        Mon, 17 Mar 2025 17:43:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-36-239.pa.vic.optusnet.com.au. [49.186.36.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba710dsm82157305ad.128.2025.03.17.17.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 17:43:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tuL3K-0000000EUvw-0cEY;
	Tue, 18 Mar 2025 11:43:30 +1100
Date: Tue, 18 Mar 2025 11:43:30 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 03/10] xfs: Refactor xfs_reflink_end_cow_extent()
Message-ID: <Z9jBsrMM3V5Z7rGT@dread.disaster.area>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-4-john.g.garry@oracle.com>
 <Z9E2kSQs-wL2a074@infradead.org>
 <589f2ce0-2fd8-47f6-bbd3-28705e306b68@oracle.com>
 <Z9FHSyZ7miJL7ZQM@infradead.org>
 <20250312154636.GX2803749@frogsfrogsfrogs>
 <Z9I0Ab5TyBEdkC32@dread.disaster.area>
 <20250313045121.GE2803730@frogsfrogsfrogs>
 <68adae58-459e-488a-951c-127cc472f123@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68adae58-459e-488a-951c-127cc472f123@oracle.com>

On Thu, Mar 13, 2025 at 06:11:12AM +0000, John Garry wrote:
> On 13/03/2025 04:51, Darrick J. Wong wrote:
> > > Hence if we are walking a range of extents in the BMBT to unmap
> > > them, then we should only be generating 2 intents per loop - a BUI
> > > for the BMBT removal and a CUI for the shared refcount decrease.
> > > That means we should be able to run at least a thousand iterations
> > > of that loop per transaction without getting anywhere near the
> > > transaction reservation limits.
> > > 
> > > *However!*
> > > 
> > > We have to relog every intent we haven't processed in the deferred
> > > batch every-so-often to prevent the outstanding intents from pinning
> > > the tail of the log. Hence the larger the number of intents in the
> > > initial batch, the more work we have to do later on (and the more
> > > overall log space and bandwidth they will consume) to relog them
> > > them over and over again until they pop to the head of the
> > > processing queue.
> > > 
> > > Hence there is no real perforamce advantage to creating massive intent
> > > batches because we end up doing more work later on to relog those
> > > intents to prevent journal space deadlocks. It also doesn't speed up
> > > processing, because we still process the intent chains one at a time
> > > from start to completion before moving on to the next high level
> > > intent chain that needs to be processed.
> > > 
> > > Further, after the first couple of intent chains have been
> > > processed, the initial log space reservation will have run out, and
> > > we are now asking for a new resrevation on every transaction roll we
> > > do. i.e. we now are now doing a log space reservation on every
> > > transaction roll in the processing chain instead of only doing it
> > > once per high level intent chain.
> > > 
> > > Hence from a log space accounting perspective (the hottest code path
> > > in the journal), it is far more efficient to perform a single high
> > > level transaction per extent unmap operation than it is to batch
> > > intents into a single high level transaction.
> > > 
> > > My advice is this: we should never batch high level iterative
> > > intent-based operations into a single transaction because it's a
> > > false optimisation.  It might look like it is an efficiency
> > > improvement from the high level, but it ends up hammering the hot,
> > > performance critical paths in the transaction subsystem much, much
> > > harder and so will end up being slower than the single transaction
> > > per intent-based operation algorithm when it matters most....
> > How specifically do you propose remapping all the extents in a file
> > range after an untorn write?  The regular cow ioend does a single
> > transaction per extent across the entire ioend range and cannot deliver
> > untorn writes.  This latest proposal does, but now you've torn that idea
> > down too.
> > 
> > At this point I have run out of ideas and conclude that can only submit
> > to your superior intellect.
> > 
> > --D
> 
> I'm hearing that we can fit thousands without getting anywhere the limits -
> this is good.
> 
> But then also it is not optimal in terms of performance to batch, right?
> Performance is not so important here. This is for a software fallback, which
> we should not frequently hit. And even if we do, we're still typically not
> going to have many extents.
> 
> For our specific purpose, we want 16KB atomic writes - that is max of 4
> extents. So this does not really sound like something to be concerned with
> for these atomic write sizes.

Apart from the fact that we should not be overloading some other
transaction reservation definition for this special case? Saying
"it should work" does not justify not thinking about constraints,
layered design, application exposure to error cases, overruns, etc.

i.e. the whole point of the software fallback is to make atomic
writes largely generic. Saying "if we limit them to 16kB" it's not
really generic, is it?

> We can add some arbitrary FS awu max, like 64KB, if that makes people feel
> more comfortable.

I was thinking more like 4-16MB as a usable maximum size for atomic
writes. i.e. allow for whole file atomic overwrites for small-medium
sized files, and decent IO sizes for performance when overwriting
large files.

If we set the max at 4MB, that's 1024 extents on a 4kB
block size filesystem. That gives us 2048 intents in a single unmap
operation which we can directly calculate the transaction
reservation size it will need. We need to do this as two separate
reservation steps with a max() calculation, because the processing
reservation size reduces with filesystem block size but the extent
unmap intent overhead goes up as the block count increases with
decreasing block size. i.e. the two components of the transacation
reservation scale in different directions.

If we are adding a new atomic transaction, we really need to design
it properly from the ground up, not hack around an existing
transaction reservation whilst handwaving about how "it should be
enough".

This "maximum size" is going to be exposed directly to userspace,
hence we need to think carefully about what the maximum supported
limits are going to be and how we can support them with a minimum of
effort long into the future. Hacking around the existing write
transaction isn't the way to do this, especially as that may change
in future as we modify internal allocation behaviour over time.

Saying "we only need 16kB right now, so that's all we should
support" isn't the right approach to take here....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

