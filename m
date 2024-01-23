Return-Path: <linux-fsdevel+bounces-8500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7784837E61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 02:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED591F27471
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 01:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BF55FF0C;
	Tue, 23 Jan 2024 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ECR9Sedc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9625DF15
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 00:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970548; cv=none; b=n/EGC9tihZV2VjJX7Tv9/4ybti4CqCPCbCkwlL5Xn8g6x33efRw+aALMZbWRq/cSWj70M5k5G/YGriaLJ0YrMmxruPpuiDGP1tU8bD8UWFya4Yq2oALNSpEE04j9rx6c511vIVsr8soihVY/Fn1FBYLX2Kn1GaGCtXoljrnplnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970548; c=relaxed/simple;
	bh=M7U1cGu7aS9RwZouLbNcErYMaJZcmv28Ia6b7kg0HG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ux34yQ8fTpFd4pS8Ta4bw4lO+CYv0FHZubPjn8q8Pc6EmtUM9taNOOlrFN/UZ5vobMWdg3qpk/bAZZ91K/7nQ9BAE6On1aWffklxJHSN7/07iFjryELvwkxtPWAjSgFANnOxGsRYcYgnELWzPItGR/1r933dtBViTMIv7Dngpbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ECR9Sedc; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb53e20a43so2824596b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 16:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1705970546; x=1706575346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ/KMTxmbinFPSTe5EWCd4hdo6wOhA4XkQxlu3a3Gyk=;
        b=ECR9SedcqDvOF9sPKXvYETC3Df/wuadqrDHYnjlBG0oLL/WAmLrA4Qbt44Gcb0YusL
         iTjwXJ73m5eiL8TnupbRNJBDRA0It0kJI+OlReISDQy33yAKq9yL33uZKyrp3eBrd2NI
         FKJtxovyBOU55rzEYVvgZ6Nf4rGMJin8PxxEJZyoVtVpRo7+7CDI5aXojnT/ws5JaES3
         S0K0AumcubtYUljo3aNrjGmlba01YO77Om/7zWHofbWjRks3ZkNJra31ryaOrFBz4XAl
         HQ600Y2kmB/mvnYziV6avAT7SxFGapdall7oWx8r/QtZ2Wgf5RUgS632y7V+wDhJibna
         e9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970546; x=1706575346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ/KMTxmbinFPSTe5EWCd4hdo6wOhA4XkQxlu3a3Gyk=;
        b=xSV00qbHD8tQq5KK8pzTc31jlVbAEkC66R1j2dkn0RkMPh5wWvuC6CUCpmjZ2GuRfu
         2oeGWHVS9QhWP+d9Dse1gY4xWSUqenfNYQ0o+brZy2+jgeGf/Cuhrkc/hOD+xVeQXR2A
         FnSZc2BW0LVuOZWuIVEn1/vrRe2Lg4hQWcrAsIhFl+oCZszvSJK5aniJcNyWiHgrLwwt
         iNx8p1hQIuFfUruNOhAsl8ZgMQNufxrn/bSG+iUzEgQ824qXm2wXoP2PiXu1ti9usUvO
         R4iYLB+EzniE0Yw1X2erGUXxHE1bJyS9aMH1Yg3rBtq76bq8lU/bwUczslRQFa0HF7/5
         JLzw==
X-Gm-Message-State: AOJu0YyJskR/7D3PPh0uXc7R1tWhTpUKBiVkXIk7H50rPKbJwq1Cy9WV
	e1sO9JqxGOXoKHFP2gAZUUh1x4pU4nFjtQXuNABIDS7m4qKQlK2gbY5Z8vfyS3A=
X-Google-Smtp-Source: AGHT+IHZQ1DRLXyIkkuOSstqMxSNlG1DBiQn/ClIGY9BZemkx1tQXgP0dZgnaAkLQM5ih9nC3sb37g==
X-Received: by 2002:a05:6808:188e:b0:3bd:c2bd:21d3 with SMTP id bi14-20020a056808188e00b003bdc2bd21d3mr718344oib.29.1705970546330;
        Mon, 22 Jan 2024 16:42:26 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id s4-20020a62e704000000b006dbd59c126fsm3738787pfh.11.2024.01.22.16.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:42:25 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rS4ru-00Dzoo-1L;
	Tue, 23 Jan 2024 11:42:22 +1100
Date: Tue, 23 Jan 2024 11:42:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, bfoster@redhat.com,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: fix incorrect usage of REQ_OP_FLUSH
Message-ID: <Za8LbtBgIZgj1mcx@dread.disaster.area>
References: <20240111073655.2095423-1-hch@lst.de>
 <ueeqal442uw77vrmonr5crix5jehetzg266725shaqi2oim6h7@4q4tlcm2y6k7>
 <20240122063007.GA23991@lst.de>
 <eyyg26ls45xqdyjrvowm7hfusfr7ezr3pjve6ojikg4znys6dx@rd2ugzmo44r4>
 <20240122065038.GA24601@lst.de>
 <3cs7zhkf3gz7fmytpxqjvstr6oegvhy3ehwu3mzomfllvjqlmc@yaq6ophbgbfr>
 <20240122173809.GA5676@lst.de>
 <6jhgnewkmex25jgtw2s3fifyyje4w3yja2exdrnx2vesk6bp5w@gysfpght3cbo>
 <20240122184147.GA7072@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122184147.GA7072@lst.de>

On Mon, Jan 22, 2024 at 07:41:47PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 22, 2024 at 12:42:24PM -0500, Kent Overstreet wrote:
> > updating my tests for the MD_FAULTY removal, then will do. Is there
> > anything you want me to look for?
> 
> Nothing fancy.  Just that you do data integrity operations and do
> not see an error.
> 
> > considering most tests won't break or won't clearly break if flush/fua
> > is being dropped (even generic/388 was passing reliably, of course,
> > since virtual block devices aren't going to reorder writes...) maybe we
> > could do some print statement sanity checking...
> 
> Well, xfstests is not very good about power fail testing, because it
> can't inject a power fail..  Which is a problem in it's own, but
> would need hardware power failing or at least some pretty good VM
> emulation of the same outside the scope of the actual xfstests runner.

We do actually have stuff in fstests that checks write vs flush
ordering as issued by the filesystem. We use dm-logwrites for
tracking the writes and flushes and to be able to replay arbitrary
groups of writes between flushes.  generic/482 is one of those
tests.

These are the ordering problems that power failures expose,
so we do actually have tests that cover the same conditions that
pulling the power from a device would exercise.

I even wrote a debugging script (tools/dm-logwrite-replay) to
iterate write+fua groups in the test corpse to isolate the write
groups where the consistency failure occurs when doing work to
optimise flushes being issued by the XFS journal checkpoint writes.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

