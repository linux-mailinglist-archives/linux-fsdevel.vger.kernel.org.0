Return-Path: <linux-fsdevel+bounces-13409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D20A986F7F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 01:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1721F2117E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 00:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352D739B;
	Mon,  4 Mar 2024 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="iB0iIaaT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E919A
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709511633; cv=none; b=HVSbz0MQUpfz2wy6vjVtyFGMBNoUP0HuPL85Kbfd/Z9kfYjm1NDTCm+5jSoy4xAYWB3kCVZneYwO8/gXXqiPU6Nsf+tWHxW38TVw9gvUuM8BJ7a+aLFVmAgxYuPKOjS9Pt8YvM8VUanZgXQJmTQZZ51Tm53IpxclXeVSUQlot4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709511633; c=relaxed/simple;
	bh=jbz/t0FGNIlndJAFHHzGsafV2kRcP0Hs2QghqcKZZqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ/2iSZ+BIjhaNBdc1jpnHaXQkYS2pjZDDizMpYx4OKs8ivJ0nmemuEksyaLq5xPv3PnxjHsvzkbY3FD+7h/QqdzLVTMGrzuInCRVIDCG45GD8aPUAGujzsZArB+XuuiUsXNhNjyJVTsMWJqC9PD3rEr7Xw78Y/pazynOG8B5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=iB0iIaaT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc75972f25so31927025ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Mar 2024 16:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709511631; x=1710116431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7+u96xPcBF8UnwMQsi6zps3kKJmqNLYGPjj0sLBatY=;
        b=iB0iIaaTuMCKAXoD1p4LtpZ/zxucJ8NMAwqhIkikG8udxXJYOYG8u7CvQM0Z4fm+7G
         4pgDZvlk0PW42YmcoF6sP3Hr0AlvNNTa8XK6tc+SItkd0Eb+uChqskqat3bmEdH9WUfe
         /l46ROYGSLtcwIueG3qGviBGO3NwEcHGdcThoquwNltQi41mW2vbfryifyoJtSFPKCI5
         ZFn0LGbYe36j5V1IelKLrULjAHkqTDr4kU/c+nEMU8HFpd0TYgAwTosolfBt+LR0OQrY
         cBTNVY6DL6ozHL0HQk++Uz4LMmyxVgK4ZLVhUDU2nA+ye0tghxMm0SIBRgfAMc8S8xHY
         OwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709511631; x=1710116431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7+u96xPcBF8UnwMQsi6zps3kKJmqNLYGPjj0sLBatY=;
        b=Um2p6MnGkMe35zhHkn+M/jx6k3MniXzIWT82lgJyDQFpsUkmN/NfVQAaH7o1Dt4Lh/
         f/IZ8lwniQhbfGTuPcwy3QruH6bK3RWKI3dkpd9h9YO4I5a823fu8HEOc99J7lDcr4/Z
         Ddl9gcpFbSIjcSoEwT78krREWJXqpWsrwxWk3i4I74LJZJU9U+slMDYE0an6NilcVxQC
         8vL9y/9eEolwk2J7OnSbHES3yduW7WG0TdsmA3p1AnD6hhtVX10/IDU+OG76yT7HpdIk
         N56asbG2HK2zpjK/P1UNKdKCdAFanD7m7Z5hxVOYkqQJcWKaD1Z+zZMDTZyEeZ27uYUh
         Z6cw==
X-Forwarded-Encrypted: i=1; AJvYcCWZO8BXnvvAfBfbhNHv4HMmQd8bROOYNcT5efsTpA3p8mPZcLhWb9rSU9gMC+XOW+pTe3afCuSFWLeCg41Fr+YGWvDwmHFSwEAzQQ8UkQ==
X-Gm-Message-State: AOJu0Yyr2N1HHWeHGPBnDt83pos5/wC9FNbc8HO3B+I+DdCYVHvn2s7T
	MvDmyCI6uELSeT2IINbno1WIbYvrfZYo3OTLsWcaGqGdQwP9OiM7ANgZdfzujP8=
X-Google-Smtp-Source: AGHT+IHHqRVwbzhDqGZzQPZTKp/5e8rUMV/ODbLbXFp89J0IezoxnX3dyYeolNS6GNZvX2KpejwDhQ==
X-Received: by 2002:a17:902:e746:b0:1db:7052:2f45 with SMTP id p6-20020a170902e74600b001db70522f45mr9138784plf.61.1709511631245;
        Sun, 03 Mar 2024 16:20:31 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902ceca00b001db9c3d6506sm7119202plg.209.2024.03.03.16.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 16:20:30 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rgw4B-00Efo9-39;
	Mon, 04 Mar 2024 11:20:27 +1100
Date: Mon, 4 Mar 2024 11:20:27 +1100
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <ZeUTyxYFS6kGoM1h@dread.disaster.area>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170950594802.24797.17587526251920021411@noble.neil.brown.name>

On Mon, Mar 04, 2024 at 09:45:48AM +1100, NeilBrown wrote:
> I have in mind a more explicit statement of how much waiting is
> acceptable.
> 
> GFP_NOFAIL - wait indefinitely

Make this the default, and we don't need a flag for it at all.

> GFP_KILLABLE - wait indefinitely unless fatal signal is pending.
> GFP_RETRY - may retry but deadlock, though unlikely, is possible.  So
>             don't wait indefinitely.  May abort more quickly if fatal
>             signal is pending.

KILLABLE and RETRY are the same thing from the caller POV.
Effectively "GFP_MAY_FAIL", where it will try really hard, but if it
there is a risk of deadlock or a fatal signal pending, it will fail.

> GFP_NO_RETRY - only try things once.  This may sleep, but will give up
>             fairly quickly.  Either deadlock is a significant
>             possibility, or alternate strategy is fairly cheap.
> GFP_ATOMIC - don't sleep - same as current.

We're talking about wait semantics, so GFP_ATOMIC should be named
GFP_NO_WAIT and described as "same as NO_RETRY but will not sleep".

That gives us three modifying flags to the default behaviour of
sleeping until success: GFP_MAY_FAIL, GFP_NO_RETRY and GFP_NO_WAIT.

I will note there is one more case callers might really want to
avoid: direct reclaim. That sort of behaviour might be worth folding
into GFP_NO_WAIT, as there are cases where we want the allocation
attempt to fail without trying to reclaim memory because it's *much*
faster to simply use the fallback mechanism than it is to attempt
memory reclaim (e.g.  xlog_kvmalloc()).

> I don't see how "GFP_KERNEL" fits into that spectrum.

Agreed.

> The definition of
> "this will try really hard, but might fail and we can't really tell you
> what circumstances it might fail in" isn't fun to work with.

Yup, XFS was designed for NO_FAIL and MAY_FAIL behaviour, and in more
recent times we also use NO_RECLAIM to provide our own kvmalloc
semantics because the current kvmalloc API really only supports
"GFP_KERNEL" allocation.

> > Deprecating GFP_NOFS and GFP_NOIO would be wonderful - those should
> > really just be PF_MEMALLOC_NOFS and PF_MEMALLOC_NOIO, now that we're
> > pushing for memalloc_flags_(save|restore) more.

This is largely now subsystem maintenance work - the infrastructure
is there, and some subsystems have been converted over entirely to
use it. The remaining work either needs to be mandated or have
someone explicitly tasked with completing that work.

IOWs, the process in which we change APIs and then leave the long
tail of conversions to subsystem maintainers is just a mechanism for
creating technical debt that takes forever to clean up...

> > Getting rid of those would be a really nice cleanup beacuse then gfp
> > flags would mostly just be:
> >  - the type of memory to allocate (highmem, zeroed, etc.)
> >  - how hard to try (don't block at all, block some, block forever)

Yup, would be a very good improvement.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

