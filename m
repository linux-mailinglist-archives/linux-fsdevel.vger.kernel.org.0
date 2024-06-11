Return-Path: <linux-fsdevel+bounces-21476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BC19046A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 00:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248A41C237AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 22:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C24815383F;
	Tue, 11 Jun 2024 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="dHb/BvRh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9702D611
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718143247; cv=none; b=QcbTUN6NPSVFAuzDLB2/e8A3X3gObvBvkcMmSnK2Fpr+dTHIGrKnN+1LXhq5g2GU2BQSo5etjSHmn4U/+QPBQCUqF9RJNtub1xOzlCrZUSqRVoKL0oOY0co0KmkSLQbXGWay3QbjVGTUE/TqvurCc86n+zOXxuN+ZorkfuWH3DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718143247; c=relaxed/simple;
	bh=FtBOiWFncM3ovOqL8hAeZj1EPtQ9g2uHQfDy21bJETg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sgvte+0vjzHY5w5X+0dMUG/mmkN/1bLTJ69MEvYYMOona1bwCqLjEq//My5ayptlJ+3uwteKLzCLydRtjYtoGKxLHt3oltASaAgAkjIaVSF5/7weT8mKIt+gQz00wihhnILACt+JBwju7xnepTflq043R82kcAB0w+0ZX0MKYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=dHb/BvRh; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6e40d54e4a3so3396119a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 15:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1718143246; x=1718748046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHrOxF5RfsfEQJHgKoGMj8t4JaNF1ExxMJOzCNX5n2s=;
        b=dHb/BvRh/8ZNSf166kt4zvC5dYEu96yZdScsoTdMW2DV0jr2z4OTHZ0Ckgu9cf8aB+
         MXZmpCV/bSmpQ0HiF+8obYdIOTG366o1Bj4Q7bIKrJp6u8R7xT9ifI4VRJTUVzr4FTcf
         NfMYDlI1LjwTexZAA/T3tEL1luB62gzg1IWcJFzGXIjF/odsOukHpLKDzhAGAbydTOS+
         ssChMgheRl3gDJE2Yy1bkAbKTmMIAj3qygdX4rOV2k7aJbK++Fhj0ugIz915J0nMC0ZY
         cPPTgf5/n+g8BigGzoKf6gYZFGyRGvjEO29vebxksnQ8n9Rm05RfhcvYs0aXBddCxTxq
         7bxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718143246; x=1718748046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHrOxF5RfsfEQJHgKoGMj8t4JaNF1ExxMJOzCNX5n2s=;
        b=LhUqEXDKSnEAy9PjcK6X6XmntOOJ7Un9/+uNCwtoqhxDGN9zg93hCiBXr9NR4NEpW6
         xxb9bxCQbh3cRiYRPyGHrVvIvNd3pDtZgtLhedQQCVbxtB7R646M1F8gOZsgeWUgzS/I
         YWspFHJkZr347mKhIF2xIhNrXIXhFSbtNgzMLaS75lXnxXaDboRtcDmc0yZpzzIfCp6g
         hLjRgIsuyf8KU9AsnUkqnCgub+3kAMFwHuCa4h8dL4X1XSw0AFKexghX5aHCvt8rwrfj
         higCU8Pm++RGcwcbUDuof/Pin1NVm56lo29/4K03fWh6VYh6JazC4PVDenVafjhcqCmp
         2G5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwCQeyd66PgoWwyUwwG5pADB+TtsXqxRQ8Sog1ODAw8eQfIapUraPuhfh5h1JzZYEt/k49a74qlqDlyoDKileAoPR3PYSPn/fA5leECA==
X-Gm-Message-State: AOJu0YwonnIy3NgfzdwYrzncGARbOV7pdpCTmaZWrdBRo6axwFFDB8kP
	l4RVqgE8pgE0N+SxEO16t3xPSAyc7ny+mpG7pYtbQnV4SYI/1qk31TMV6wS/yS8=
X-Google-Smtp-Source: AGHT+IEEvku0qFLDSu5fmCz08QiHgFPcipPG93BRa/6a6lBcHoHCFRAqDEQiF6Oj6a+FswFCCBRqqw==
X-Received: by 2002:a17:902:ab88:b0:1f4:7a5c:65d4 with SMTP id d9443c01a7336-1f83b5e7089mr1607015ad.18.1718143245491;
        Tue, 11 Jun 2024 15:00:45 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f7178d6d40sm41000115ad.212.2024.06.11.15.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 15:00:44 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sH9Xm-00CdLe-1I;
	Wed, 12 Jun 2024 08:00:42 +1000
Date: Wed, 12 Jun 2024 08:00:42 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add rcu-based find_inode variants for iget ops
Message-ID: <ZmjJCpWKFNZC2YAQ@dread.disaster.area>
References: <20240606140515.216424-1-mjguzik@gmail.com>
 <ZmJqyrgPXXjY2Iem@dread.disaster.area>
 <bujynmx7n32tzl2xro7vz6zddt5p7lf5ultnaljaz2p2ler64c@acr7jih3wad7>
 <ZmgkLHa6LoV8yzab@dread.disaster.area>
 <20240611112846.qesh7qhhuk3qp4dy@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611112846.qesh7qhhuk3qp4dy@quack3>

On Tue, Jun 11, 2024 at 01:28:46PM +0200, Jan Kara wrote:
> On Tue 11-06-24 20:17:16, Dave Chinner wrote:
> > Your patch, however, just converts *some* of the lookup API
> > operations to use RCU. It adds complexity for things like inserts
> > which are going to need inode hash locking if the RCU lookup fails,
> > anyway.
> > 
> > Hence your patch optimises the case where the inode is in cache but
> > the dentry isn't, but we'll still get massive contention on lookup
> > when the RCU lookup on the inode cache and inserts are always going
> > to be required.
> > 
> > IOWs, even RCU lookups are not going to prevent inode hash lock
> > contention for parallel cold cache lookups. Hence, with RCU,
> > applications are going to see unpredictable contention behaviour
> > dependent on the memory footprint of the caches at the time of the
> > lookup. Users will have no way of predicting when the behaviour will
> > change, let alone have any way of mitigating it. Unpredictable
> > variable behaviour is the thing we want to avoid the most with core
> > OS caches.
> 
> I don't believe this is what Mateusz's patches do (but maybe I've terribly
> misread them). iget_locked() does:
> 
> 	spin_lock(&inode_hash_lock);
> 	inode = find_inode_fast(...);
> 	spin_unlock(&inode_hash_lock);
> 	if (inode)
> 		we are happy and return
> 	inode = alloc_inode(sb);
> 	spin_lock(&inode_hash_lock);
> 	old = find_inode_fast(...)
> 	the rest of insert code
> 	spin_unlock(&inode_hash_lock);
> 
> And Mateusz got rid of the first lock-unlock pair by teaching
> find_inode_fast() to *also* operate under RCU. The second lookup &
> insertion stays under inode_hash_lock as it is now.

Yes, I understand that. I also understand what that does to
performance characteristics when memory pressure causes the working
set cache footprint to change. This will result in currently 
workloads that hit the fast path falling off the fast path and
hitting contention and performing no better than they do today.

Remember, the inode has lock is taken when inode are evicted from
memory, too, so contention on the inode hash lock will be much worse
when we are cycling inodes through the cache compared to when we are
just doing hot cache lookups.

> So his optimization is
> orthogonal to your hash bit lock improvements AFAICT.

Not really. RCU for lookups is not necessary when hash-bl is used.
The new apis and conditional locking changes needed for RCU to work
are not needed with hash-bl. hash-bl scales and performs the same
regardless of whether the workload is cache hot or cache-cold.

And the work is almost all done already - it just needs someone with
time to polish it for merge.

> Sure his optimization
> just ~halves the lock hold time for uncached cases (for cached it
> completely eliminates the lock acquisition but I agree these are not that
> interesting) so it is not a fundamental scalability improvement but still
> it is a nice win for a contended lock AFAICT.

Yes, but my point is that it doesn't get rid of the scalability
problem - it just kicks it down the road for small machines and
people with big machines will continue to suffer from the global
lock contention cycling inodes through the inode cache causes...

That's kinda my point - adding RCU doesn't fix the scalability
problem, it simply hides a specific symptom of the problem *in some
environments* for *some worklaods*. hash-bl works for everyone,
everywhere and for all workloads, doesn't require new APIs or
conditional locking changes, and th work is mostly done. Why take a
poor solution when the same amount of verification effort would
finish off a complete solution?

The hash-bl patchset is out there - I don't have time to finish it,
so anyone who has time to work on inode hash lock scalability issues
is free to take it and work on it. I may have written it, but I
don't care who gets credit for getting it merged. Again: why take
a poor solution just because the person who wants the scalability
problem fixed won't pick up the almost finished work that has all
ready been done?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

