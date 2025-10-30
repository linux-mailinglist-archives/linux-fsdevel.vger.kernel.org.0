Return-Path: <linux-fsdevel+bounces-66456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9307C1FC9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 12:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F9B3B06B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7DD351FCF;
	Thu, 30 Oct 2025 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FATxVZY5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22CA2E6CD1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823208; cv=none; b=cckjHgsXySIVpH76kMCuDMdt8JBA3X7D7sCUAcoMZJ77c4iYIDayTrzzVQSykpCghYSL1tTSrHybIB0aksuf9VouhL1gCtPNnnHduwywpdjrI+csJ+zizZFvC01Pzg4SB3Hyn8jn4Ig1ceOQ2YAPbbrOAMrq8waBLJFb/7/kJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823208; c=relaxed/simple;
	bh=B71bbQUME6bPFSPnTl2rUk+zM8rJpRXJqWB0RdN61nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9jkS79JmsMJgz95o5/zlYtuvItQEKR9gPppKqBLuZ/IzQ2PVLDS64j9aZuZRo1NeldpV5vB5D3+/gUWiBGLQ4GNkvd+DvcckxOQOab9dLEAB4caTqdKuDwTdHfPSK1BZyHA1zSB7W+0heGW7hHJ71iUOY+k1GNNk8ZGR7r5rwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FATxVZY5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781206cce18so1142903b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761823206; x=1762428006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNDVGLdLslRPQnKZM2E9zoqPqU4j8KmV4lXjwMAwzP8=;
        b=FATxVZY52eiue2vTxnTXS9XbrgsPWcr82oXbq5fsVvXrS6fYt5UiVwU0LotBphrnXZ
         gHYM4G9IRmiF7UaIj72aKzZnX6KklO9uQfDfb6nQCBIiHHuFduw7Ar2I6qeoBkbSodZz
         09PNJ4tssChmILY10vyK0YUnBTH1Syl95PAmh9fgI/+icc/04QpDT1qekgpKZd4WLD63
         ZmUTKWelBL8CzoRZki9MU5nC0BT+qE4eChtXTbX3fHyt5WC9PXp3SrQo3zWnPlBYrfCl
         YBLv/58eGx3eWztGvRBsy7RARPcA7ewb8Y5vuFT8oRD+14CXLTNCF+2JpfnUvr04TRRq
         rk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823206; x=1762428006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNDVGLdLslRPQnKZM2E9zoqPqU4j8KmV4lXjwMAwzP8=;
        b=WaTn5YDOHwxm/07MoRowJVgWYFii+pvzB/RF540HoEEFe/hFwZGnefjk34pXPkuV08
         mfJ1XutQYQ5hVgUIU2xGMmoSZyL4FIazA8FO/0IIeruICMwpCYoxAa7egO5D3ugsnqo/
         Yg682QJeHbZShYTyT67qAByTVYm92W/ZmrCZ+dU6/wN2+S4S0XuxR5GtGY2Lgqh3n2jk
         nrqrj9OwbixLe0wjuI+2dc8m6SEVi+62HXI1KeM4w36tVYVU50oAJzaaL/OjrRJ8as7s
         heyTWygcUJdlmpT3xBt6dZUnqV5Co57piI2g2SFd3GEAa+lOCJ1ugixDAOd4zy4fwaNT
         yinA==
X-Forwarded-Encrypted: i=1; AJvYcCVoth4xa9jmVASGlNdNX4iyCCboWZ6jBfryWn5wsHy+aFHq39EEO707DoTZW2H9XWDbHbtqbbGhSrGlUZxi@vger.kernel.org
X-Gm-Message-State: AOJu0YzThTXNgvIza+v76Lu1wJMBuCiNKpDiuYdD2IO05EDOVKnCP3tl
	VM+dnABoLJKUomngPMfd6bY5bdgJpitwIiRXawq7air0aOdqdKTQWcKXpeNpbtsBXtQ=
X-Gm-Gg: ASbGncthvvSRfqhKvL9bJ8ErBktbVbLECDaNJBG2b/bQPbUQml8PWhXRbBlGsyZZWcV
	HlKJuVfE8Hyu+W4krqK0iOmDQ1D1STQx0KpfyBI2DhqwNa5JyqwyJicsvBF2372KuMFkYpZ4iho
	wJ5SX27SWu7rvFpmSFQqHj5cG06e1ouj7Bc/Th4C9xpl5wii/RNPUmkMTxAFhfWlMjM41A2Y+/M
	iRCkUZFWa2oE4rZoRV63PVvPlYnZmba97yLrpUtOteN4+YdVC946zYZ/75vLvg/KwRdeaRjLKRf
	KJj1BW9Zg1UVZ0mTqOsTC8r7ok7F8YrJdYJ885dW2PLlk0BRrh8IsVSI/893a0paEfRqDgt21Rt
	KrnQcS3MP9zdYhem/N7Ou9kI8cBn5xj9DcyeO2wbn7xVo7slIjM8Ug+tMAfNUJKGDEXxzagGZ7b
	Rw3ZGEEmZ3TK0qKe7T6BoWSWF1xUpQqzMY9bcKHDl5Or6NNzjTQP1Zqcorg/zveQ==
X-Google-Smtp-Source: AGHT+IF/l5E8cKKK2vFaTAZgp/ZGb4MjtxoPBEtVt6VeAi8ECm9tlqHfB9lmTROZ9cINQrgWB7grkQ==
X-Received: by 2002:a05:6a00:9507:b0:7a4:24af:e16f with SMTP id d2e1a72fcca58-7a612eb8487mr3627141b3a.3.1761823205858;
        Thu, 30 Oct 2025 04:20:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a51bbc1b6csm5620722b3a.10.2025.10.30.04.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:20:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vEQhG-000000044v1-299E;
	Thu, 30 Oct 2025 22:20:02 +1100
Date: Thu, 30 Oct 2025 22:20:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
References: <20251029071537.1127397-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029071537.1127397-1-hch@lst.de>

On Wed, Oct 29, 2025 at 08:15:01AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> we've had a long standing issue that direct I/O to and from devices that
> require stable writes can corrupt data because the user memory can be
> modified while in flight.  This series tries to address this by falling
> back to uncached buffered I/O.  Given that this requires an extra copy it
> is usually going to be a slow down, especially for very high bandwith
> use cases, so I'm not exactly happy about.

How many applications actually have this problem? I've not heard of
anyone encoutnering such RAID corruption problems on production
XFS filesystems -ever-, so it cannot be a common thing.

So, what applications are actually tripping over this, and why can't
these rare instances be fixed instead of penalising the vast
majority of users who -don't have a problem to begin with-?

> I suspect we need a way to opt out of this for applications that know
> what they are doing, and I can think of a few ways to do that:

....

> In other words, they are all kinda horrible.

Forcing a performance regression on users, then telling them "you
need to work around the performance regression" is a pretty horrible
thing to do in the first place. Given that none of the workarounds
are any better, perhaps this approach should be discarded and some
other way of addressin the problem be considered?

How about we do it the other way around? If the application is known
to corrupt stable page based block devices, then perhaps they should
be setting a "DIO is not supported" option somewhere. None of them
are pretty, but instead of affecting the whole world, it only
affects the rare applications that trigger this DIO issue.

That seems like a much better way to deal with the issue to me;
most users are completely unaffected, and never have to worry about
(or even know about) this workaround for a very specific type of
weird application behaviour...

-Dave.

-- 
Dave Chinner
david@fromorbit.com

