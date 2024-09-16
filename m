Return-Path: <linux-fsdevel+bounces-29425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C87A9799A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 02:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5291C21F73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 00:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441D1175AD;
	Mon, 16 Sep 2024 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="vzqR1C31"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E0713957B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726444825; cv=none; b=rrBk126PYfMVMsVig04sZXdWZ90h7kneUyZe9WtUdIOTdloSKduZM0ymtdYQciY9RMxFrhBpIqDR8KiY0dA89HJX1kR/arQYCOnmj3Izm0sNMjlUGRDOPtg7E48VD6VoydGp1AbxMzHAvcEQcViFZuRJKIQ/6yvB1aB5K5iTPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726444825; c=relaxed/simple;
	bh=Bk6VaLA8U1o7y/shFK8tVIvvxwhrWjMjA7XJdgB4N/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5QZrZQ/Ta6bUmHZXW0B2M9Qc0NuWsQZBZazBz4uWc6WlZ84NaCDsZxF/rZ5SsgjE1G5GDpQezqNA25e6FF9VshXjNdDIoInMvlolKRuOf4xXQqPdTwUF5fFZHOyo68i5yYiCqzFI73IHbA5JYiNHabOydtlA/NsBN/ekjpeemQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=vzqR1C31; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2057c6c57b5so23061695ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 17:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726444823; x=1727049623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yiTneBRUQz0c7oUx85pbwoHLabaV+URnFTxx3H0XSE8=;
        b=vzqR1C31Sg/hV/NjWigbAilwrJmsR5cWrqtjxhcEV0xyDmEm8cO/ObzAmNkKZmVLrp
         Zqd/GIe/AANdpQuocF9looSLsZxMxxrgImVK4jawbg0uYlTMDCx6yWddS1L+7LoMbBqh
         X2MQX+m5tGMUjyOrzDxA5m21JiiAUvIDEan8lZJKYss5RN1nT8GLN95OmLr586jiNA4c
         cvxbgOhs0nxZBJSqvuHOWd+TIKPWfSNk/mhlpMYC4pgYPxIAXqHlokgd3tZbzCVNAVfz
         Um5smzbm87vsfOcmz/lqiA/GWbl9P5Uz+xC/BdWw83Q4jPFMlvcVxjvcZwgKbktJJFaf
         qUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726444823; x=1727049623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiTneBRUQz0c7oUx85pbwoHLabaV+URnFTxx3H0XSE8=;
        b=kWS4y2cLh+55tDrK6oyG3zV7wgkRO7lk1w/THXhK8o9KEZrIAK7tAkAHrT26S8IxDE
         kvz94qA83lqlYU6cBcKuyGwifb2td4v48eBWgrQ01kBfWuzlwZIVD83Ldaovummhwd5n
         M/p/TlubpF27Hkty+iJBLbBXRWKF+NyOcR3XyqhCGmGuBiUc4MeWY0b8WNVSZdGuR6o9
         ZH7K/2NlUJQyd8WGh5ujMwt7FnpWGn/V3yTvaUBWnz4swtavd3JyBhcdixiaqIaHz8Zb
         et8Efs8tfbjHGc0/5nW1NmEG9mMDGjqRcglFBDA50SYqQTndCPqVRfpFEW5cBTPM7xj9
         MPDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6wZW82WTg0bukSdqBe95ORonNbs4YC273BxHk+OUMVR42d84xxfqv+8EUamzOF9+eQBfqg7SHbjG75hlW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9UdrGd4PhnKfiw7+hJekdf9Oc8YFXIPs10HHugoF4TiSbEbYV
	eYTS6Pumg61l9XFV++zc1UaeKSyU++VZVvP9oLevBlDnmuJyceQGNWy7QPlfxhL5+gtI6VOHA7Q
	y
X-Google-Smtp-Source: AGHT+IEL1eQKv3NuUXB18zqkV0UW1Ie5TJSdwTXsRLrQ2G5lCXlhwJhgyjhFRZZ66d6/+lADVVDKkA==
X-Received: by 2002:a17:902:ce92:b0:207:6d2:1aa5 with SMTP id d9443c01a7336-2076e591737mr218814085ad.13.1726444822748;
        Sun, 15 Sep 2024 17:00:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945dc76asm26908985ad.42.2024.09.15.17.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 17:00:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1spzAA-005hUa-2C;
	Mon, 16 Sep 2024 10:00:18 +1000
Date: Mon, 16 Sep 2024 10:00:18 +1000
From: Dave Chinner <david@fromorbit.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>, clm@meta.com,
	regressions@lists.linux.dev, regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <Zud1EhTnoWIRFPa/@dread.disaster.area>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>

On Thu, Sep 12, 2024 at 03:25:50PM -0700, Linus Torvalds wrote:
> On Thu, 12 Sept 2024 at 15:12, Jens Axboe <axboe@kernel.dk> wrote:
> Honestly, the fact that it hasn't been reverted after apparently
> people knowing about it for months is a bit shocking to me. Filesystem
> people tend to take unknown corruption issues as a big deal. What
> makes this so special? Is it because the XFS people don't consider it
> an XFS issue, so...

I don't think this is a data corruption/loss problem - it certainly
hasn't ever appeared that way to me.  The "data loss" appeared to be
in incomplete postgres dump files after the system was rebooted and
this is exactly what would happen when you randomly crash the
system. i.e. dirty data in memory is lost, and application data
being written at the time is in an inconsistent state after the
system recovers. IOWs, there was no clear evidence of actual data
corruption occuring, and data loss is definitely expected when the
page cache iteration hangs and the system is forcibly rebooted
without being able to sync or unmount the filesystems...

All the hangs seem to be caused by folio lookup getting stuck
on a rogue xarray entry in truncate or readahead. If we find an
invalid entry or a folio from a different mapping or with a
unexpected index, we skip it and try again.  Hence this does not
appear to be a data corruption vector, either - it results in a
livelock from endless retry because of the bad entry in the xarray.
This endless retry livelock appears to be what is being reported.

IOWs, there is no evidence of real runtime data corruption or loss
from this pagecache livelock bug.  We also haven't heard of any
random file data corruption events since we've enabled large folios
on XFS. Hence there really is no evidence to indicate that there is
a large folio xarray lookup bug that results in data corruption in
the existing code, and therefore there is no obvious reason for
turning off the functionality we are already building significant
new functionality on top of.

It's been 10 months since I asked Christain to help isolate a
reproducer so we can track this down. Nothing came from that, so
we're still at exactly where we were at back in november 2023 -
waiting for information on a way to reproduce this issue more
reliably.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

