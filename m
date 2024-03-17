Return-Path: <linux-fsdevel+bounces-14675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A1387E0B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 23:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CBF28104B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 22:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16FC20B28;
	Sun, 17 Mar 2024 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="bScBcbnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14061E862
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710715558; cv=none; b=gYuapungfEXkedPl0LexNyCayoLSj/iIKQ3VGyi1kbJVaMwTBneJki075Hd28Q3GAUmeTqKy2F7SA7l4Zp/zD2Ck78MwmMPcmqoiAbEcznEi3cy6FPtkvslKQLo2RrydJ0Gw/fvBG1T7ggwRRWp7Pj9V6fl+Dv+Z9D66Ln3blso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710715558; c=relaxed/simple;
	bh=kwyXDiw+YmRDf21OZX7aoqqUKYq2VEvs+TgsZIZ3yUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJkLJMH1EuVP70FEbpn5E7Nyg6yRDPWh3iPdku01E18Rk3PH87t7WQIuK5nokdBwLsiGTEz+5iBA1mxs4x+gl/Qujku/m9I3sE9c8CwnesMtLEJjxnALEGoNc6lD0wXOMBpQHMj/Moo8w1Mr3kApGG5B6M5uBbMDAJGHhJq1xPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=bScBcbnh; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2778923a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 15:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710715556; x=1711320356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvQf0WHXJqA0y2473FjO9YeNzTMgVo6pogsCAEp4oGo=;
        b=bScBcbnh6irv3s3q7Ayqi75X0wB21FikIiTlgtN2vh8WdbqkuBUiyYgqQp0Hq3Ijxw
         cTQmHGn0wpH2acabp1MR11Se3XejiSaDPi/x+Vo4elUDoBP1ioGJ4o+DUl1JgGAAzCcw
         vC5AN/3qHVmpZJ4a+5EhQrgcbMT3/oZOI3AJzaIdD0ZyOh3jHFARbfFAPknV0tjM8Uu7
         Zur+drzjJMb3wa3nWjPZBtMhxT8oY2zH9rqr+WYMzTUsxjGLJmmIdX+jPZsrGUUbue4A
         vV3Vcz+i4XHH0vt94e5aoUsidO8haioAi57bgj5FzDtrv36IF0hH9DTzF4qmnp+MQTsQ
         B65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710715556; x=1711320356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvQf0WHXJqA0y2473FjO9YeNzTMgVo6pogsCAEp4oGo=;
        b=cMcLsZq0zLLULmfSxdrUZ95w8odvkhwM7uluHoZOY/t9GZKp2xEh22APPZdS1bEMDw
         HaB+CoWY1t9CBLKceHdG87ix6Umpfr3iPEYUJCL8UVJDGiWuTRBVfFtCptC/KJEc1MoJ
         Y9lmbbPSR3BmwdwuADhfuIyUs+giml0u8zjmKD19KEkF3c6RBv2IM5uM9bsrG2yu4VDy
         6FItHwyInPXtG5bRZ3/gEWkIUiGGIRQssam1He1ryTRFFoeeXA7r92oKxIb+CeFNPR5c
         RqAoYgOSz7lhTLzRKIE85mRJpBU6tJ4c/x764kbTkGf2jd602r4l83Q5M043cWv9KW7L
         QXkw==
X-Gm-Message-State: AOJu0Yzl+mAVyVZnveo44BzeMBQfb1auYrPINl4c1b81V0rJimGGz8hp
	lKGKKGckLAMFP/XEnirpnH5Ud7ssX8IEag2zfVEvjmt/1wIXEOmwz0ofWWPONOg=
X-Google-Smtp-Source: AGHT+IEqllOMfHUGt/yWxvRFt2bEwKKrFY14muZM1xh6ZmR9cX1p1d5hS5RxvyilAaPivCWb6IZ/1Q==
X-Received: by 2002:a05:6a20:3d12:b0:1a3:64a9:11e5 with SMTP id y18-20020a056a203d1200b001a364a911e5mr1355710pzi.50.1710715555791;
        Sun, 17 Mar 2024 15:45:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-185-123.pa.nsw.optusnet.com.au. [49.180.185.123])
        by smtp.gmail.com with ESMTPSA id oe14-20020a17090b394e00b0029fb85dca03sm121173pjb.25.2024.03.17.15.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 15:45:55 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rlzGK-003Lsm-1G;
	Mon, 18 Mar 2024 09:45:52 +1100
Date: Mon, 18 Mar 2024 09:45:52 +1100
From: Dave Chinner <david@fromorbit.com>
To: Phillip Susi <phill@thesusis.net>
Cc: linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Uneccesary flushes waking up suspended disks
Message-ID: <ZfdyoJ90mxRLzELg@dread.disaster.area>
References: <877cieqhaw.fsf@vps.thesusis.net>
 <Ze5fOTojI+BhgXOW@dread.disaster.area>
 <87h6h78uar.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6h78uar.fsf@vps.thesusis.net>

On Fri, Mar 15, 2024 at 10:05:16AM -0400, Phillip Susi wrote:
> Dave Chinner <david@fromorbit.com> writes:
> 
> > How do other filesystems behave? Is this a problem just on specific
> > filesystems?
> 
> I finally got around to testing other filesystems and surprisingly, it
> seems this is only a problem for ext4.

That's what I expected - I would have been surprised if you found
problems across multiple filesystems...

> I tried btrfs, f2fs, jfs, udf,
> and xfs.  xfs even uses the same jbd2 for journaling that ext4 does
> doesn't it?

.... because none of them share "journalling" code at all. They all
have their own independent mechanisms for ensuring data and metadata
integrity. ext4/jbd2 actually shares little code with other Linux
filesystems - ocfs2 is the only other linux filesystem that uses
jbd2.

> I just formatted a clean fs, synced, and ran blktrace, then synced
> again, and only ext4 emits a flush on the second sync.

So this really sounds like it's just a bug in ext4/jbd2 behaviour
and so there's no real general filesystem or infrastructure
problem that needs to be fixed here....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

