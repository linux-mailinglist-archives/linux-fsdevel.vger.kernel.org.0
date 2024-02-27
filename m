Return-Path: <linux-fsdevel+bounces-12903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482C868518
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 01:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39881F221DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 00:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C9C17FF;
	Tue, 27 Feb 2024 00:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="0v7lbKHh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31555136A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994614; cv=none; b=AUKCAtxfg193IRtE2iQmkA/jtskvzmQr6tUPMtVhVJB+k7nbQIYxX5Sl/L8Eg0BgMgQq7zcszcJzXujfPi1M0OOJF0ADerfBHT++N4BmhL2sg6i7UN/7/C/y2ejuTnTHw71/SU9zspx9jrBsjuK8xZZTcko1jWRSPpWcPY1rEUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994614; c=relaxed/simple;
	bh=XOlyNOoh1TkfQV5qhDvxvQaMXP9o7Q79qLk7PCpp4MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAUvW05dufvVB1p1+c9mWuaRvCJDQieSocddHPEGvevaJrIBmcvQBRuRmnEjHy6eSugsqpsVROEGzYmXHPWUK0XRyxBKrBHfJGVt7tycLXaTb99ZORIk0z+4XfBBm2QJiKphCDghjbVc4xyALbNETTokT4/dRNm2jYHXswd5S+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=0v7lbKHh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso3199946b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 16:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708994612; x=1709599412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrngvPKRu7DYWkRTK5Ps5V2RuXh9L2ADzFSIUkVyZxA=;
        b=0v7lbKHhWTNx76BHwkHeuHYye+jRqW5yetpUPJSmS91hO5oJD8JKxkWH/m9LecMVtX
         4PlMe/JiU2p1Jpxa4W+1QJqQME2vMebLGWg1pWRhZYJAan8/d4XlsR4+gvlPnKiHOiPR
         WivS4oogyS1SQHjM0WW2qjbWOyAbRf+KnzgMtjt5ZXjEXs6HBLIhzN0JU2oMFUWfNj2l
         iwCTvB//S1/5xWZxBwwGGqF18uiEJa1F8SQZNXsQuTSSGWJazUa4YymD68UbN/Za3MKC
         AvZ/UTpab+IySQOxdGqkrGrOTRaqh97KzFxM+3BW+pjdq0jcy6XGPRvURJJo87tjrJup
         SL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708994612; x=1709599412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrngvPKRu7DYWkRTK5Ps5V2RuXh9L2ADzFSIUkVyZxA=;
        b=g5iZSG/FHbbF3VzEmiSEak0BP5fZPBeTom79Cv3fqvaUL2sAXfPxRCkvGjqoFzzfDy
         uYwBkl8lxyKOKF8HIF5xzLGkE7neWTonO/ud2Vobmp6WTAA9nsSo1HUfnvZy/InzeodK
         RAbjmYVurkdDxuLs1Y6f1Dp8VicETbw8Z1tSM1X/Nb4DFP+4DE8EfCfTI6JLu+qAQPA9
         eRHvSWOsYyEgyKMRWSsC+2dgq1eCyv6EBEYiaH6aWGiW48QICIIvex9OEWVAdeGBmNDj
         8lP8R+gvW00wfSzN4E49DJpcUb6QbO8E2GDz1kpO2+YaO97V7NSk0PB4s9sWaykZjB6J
         e5xw==
X-Forwarded-Encrypted: i=1; AJvYcCXWhCTg0gYIgmLQAHVCafPoAuhSWMT/PhXSv2yPi199mn/IkVrnh31C0SgDY14xQ1HmjSzmctEuqCfi5X+2/r5TlvdrMf2VNb+mDNluiw==
X-Gm-Message-State: AOJu0Yw6s0BXohOx0m0aF6FZCKZeyvj7/oAoDKwx3nasVtkRDo6AUSFK
	U+Nc0TST0EjMYpvwYPTPbFORTHlO/oVNjbCgCsAguAW01oXr8FnHkSX4zdpVJao=
X-Google-Smtp-Source: AGHT+IF8FLEW5uhlJVJSeS+3Q6ieOhlDW+d89tKJv6iRDVhfnxjTJO9Q8GfP9tJ9ZP+BT/0s1SJomw==
X-Received: by 2002:a05:6a00:808:b0:6e5:2633:5d78 with SMTP id m8-20020a056a00080800b006e526335d78mr6008961pfk.4.1708994612450;
        Mon, 26 Feb 2024 16:43:32 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id jw8-20020a056a00928800b006e4e4c80e3fsm4124770pfb.29.2024.02.26.16.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:43:32 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1relZB-00Bz3U-2I;
	Tue, 27 Feb 2024 11:43:29 +1100
Date: Tue, 27 Feb 2024 11:43:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zd0wMYvju4Z/HZye@dread.disaster.area>
References: <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home>
 <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <Zdz9p_Kn0puI1KEL@casper.infradead.org>
 <znixgiqxzoksfwwzggmzsu6hwpqfszigjh5k6hx273qil7dx5t@5dxcovjdaypk>
 <upnvhnqaitifuwwbxcpa4zgf2hribfrtqzxtcrv5djbyjs2ond@axetql2wrwnt>
 <fb4d944e-fde7-423b-a376-25db0b317398@paulmck-laptop>
 <5c6ueuv5vlyir76yssuwmfmfuof3ukxz6h5hkyzfvsm2wkncrl@7wvkfpmvy2gp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c6ueuv5vlyir76yssuwmfmfuof3ukxz6h5hkyzfvsm2wkncrl@7wvkfpmvy2gp>

On Mon, Feb 26, 2024 at 06:29:43PM -0500, Kent Overstreet wrote:
> On Mon, Feb 26, 2024 at 01:55:10PM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 26, 2024 at 04:19:14PM -0500, Kent Overstreet wrote:
> > > > RCU allocating and freeing of memory can already be fairly significant
> > > > depending on workload, and I'd expect that to grow - we really just need
> > > > a way for reclaim to kick RCU when needed (and probably add a percpu
> > > > counter for "amount of memory stranded until the next RCU grace
> > > > period").
> > 
> > There are some APIs for that, though the are sharp-edged and mainly
> > intended for rcutorture, and there are some hooks for a CI Kconfig
> > option called RCU_STRICT_GRACE_PERIOD that could be organized into
> > something useful.
> > 
> > Of course, if there is a long-running RCU reader, there is nothing
> > RCU can do.  By definition, it must wait on all pre-existing readers,
> > no exceptions.
> > 
> > But my guess is that you instead are thinking of memory-exhaustion
> > emergencies where you would like RCU to burn more CPU than usual to
> > reduce grace-period latency, there are definitely things that can be done.
> > 
> > I am sure that there are more questions that I should ask, but the one
> > that comes immediately to mind is "Is this API call an occasional thing,
> > or does RCU need to tolerate many CPUs hammering it frequently?"
> > Either answer is fine, I just need to know.  ;-)
> 
> Well, we won't want it getting hammered on continuously - we should be
> able to tune reclaim so that doesn't happen.

If we are under sustained memory pressure, there will be a
relatively steady state of "stranded memory" - every rcu grace
period will be stranding and freeing roughly the same amount of
memory because that reclaim progress across all caches won't change
significantly from grace period to grace period.

I really haven't seen "stranded memory" from reclaimable slab caches
(like inodes and dentries) ever causing issues with allocation or
causing OOM kills.  Hence I'm not sure that there is any real need
for expediting the freeing of RCU memory in the general case - it's
probably only when we get near OOM (i.e. reclaim priority is
approaching 0) that expediting rcu_free()d memory may make any
difference to allocation success...

> I think getting numbers on the amount of memory stranded waiting for RCU
> is probably first order of business - minor tweak to kfree_rcu() et all
> for that; there's APIs they can query to maintain that counter.

Yes, please. Get some numbers that show there is an actual problem
here that needs solving.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

