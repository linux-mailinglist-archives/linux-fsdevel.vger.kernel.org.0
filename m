Return-Path: <linux-fsdevel+bounces-41113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FA0A2B1E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 20:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A06F3ABAF2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE811A2557;
	Thu,  6 Feb 2025 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zabbo.net header.i=@zabbo.net header.b="pnJ3wqXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95E21A5BA8
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738868296; cv=none; b=QpntnO0AN/E6MBZMJeT3lrDAKAC1Y5mspTd+O4DZtnTYZeBcOnGYkMfUysHYk0wTYJSa2UEUqU6pFHuTI1qdiMeLJmkYGcwIq5cYA3QNkFjzEHPw7O+NBLss7yZtM+UD5UzlE4GEkZZ9n1puqFJrFptwG8OF+Z8FUFEpNvdbH2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738868296; c=relaxed/simple;
	bh=S6Sfy+Ln4YYGiIj3h4hozC6VtKWMZa/nuJx3S4vsAtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8QHKOH+/Ky3r7+RYtLdEWqAQT6hWf9A1kBCgZvyqL3iiGWpwVCYtslT0huOjz2m2d40vZMuDmw7NT+M7peFRUYwkBDOO6bkIB7TjQI6DUabD/gHDbVQjdpvMaraa7J4cb5ZZP/qoOn8tDV3quk4aQhId/kRS831dQUrXmyZPjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zabbo.net; spf=pass smtp.mailfrom=zabbo.net; dkim=pass (1024-bit key) header.d=zabbo.net header.i=@zabbo.net header.b=pnJ3wqXw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zabbo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zabbo.net
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f2cfd821eso23996535ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2025 10:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zabbo.net; s=google; t=1738868294; x=1739473094; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=103zskV8QY5MyuIberb00su1yeETuGyHM6u0tCk0U+8=;
        b=pnJ3wqXw1ZA2Rm+rV/nwXn4tGiFQyxRaMzc2nArq0sz2Y6lp7HAlrAsM/mLj/bES7B
         /MqhAJsdRXTrgWGBcO+QlipO9zs4N09YvSzMFQpqpmemIRmasoJuPrh5aTLsWbzGkVUt
         N4+rVK9fUbnhClfpHvQIqhXTMO6O9bAMevPsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738868294; x=1739473094;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=103zskV8QY5MyuIberb00su1yeETuGyHM6u0tCk0U+8=;
        b=viFkx3tuoPCZo9hb0u5WUTs5Pao6dHFcrqJSwnhZuNnRXTEO2fVqRT4tu0ln5aqZDN
         q9QS0/8oHcy+gsXwmCtyayRnpHtJr4b8cKYGs3kt7arImr0XE4Lazdcaq0uTEH/ygmdi
         By5kvaLsFI+ckwmm9l3W5Q3MSGjqYfDRnAU3KjVwtECL6cGnRvgbqQnN1cyQ9gufyzNZ
         LVNwzuwAhIXZSpGLmnM6xH8ac8S9I9p0xyI/PqG8BD51SR649dmfnnoy2DGXFuhCSSpN
         jSXXG91BsHYu/9ZZ2UfYsYXxjC+pglQf6S8Nm2GnSf4n4Q3SXg0akwF1ilTDbTT42srm
         CRVA==
X-Forwarded-Encrypted: i=1; AJvYcCUgbZPuKVKDpTFPTPjELm9gMxdFnS+fFV+gO0Kw2S5DLtd8bNuX2zxl20MHRbycY3MMzLCEqOpsakwHRgmL@vger.kernel.org
X-Gm-Message-State: AOJu0YxiU3GriqnTZl9aeGW/x0ksv12D1FxuXZRw7FPCYYF33/L8a10T
	dFGfC9hhB618QbwAh2rOKOgedmgbOYkgQlQOGBs9OZYVsSHuQqsHsV+4ktK/ULE=
X-Gm-Gg: ASbGncuDB05ipV1SRLFUX4opVc+3O0QVuYrP2I82Cway3eL47T8MPBtHlRcqFrFkxTx
	+HrCYresPZE6W7bi+T572sg2g232EHbE4wrSIWRKnHLbEhWaciiKNf1sxCISG9kUrKFtRI340J9
	FlgQQz1eIdPsQmLNcNkeNbiS/LiclIpNdmpHImIGm5ozxVTBC+3AcHm3dDWqiZrRrlFS3pVxZGA
	VkMxUC/+kF5k/j0zNfJaWQ7pblfhFLvkLn+59VXljIH8jijNa8ElpNKUnfZ9l8=
X-Google-Smtp-Source: AGHT+IESUbSC8HBGqcqJFju9vdtVi+6iPeDEbypPgahQsatRVrvCqek0RHxdgpxLveBt0+/WgLTJzQ==
X-Received: by 2002:a17:902:e802:b0:21f:db8:262d with SMTP id d9443c01a7336-21f4e7636c0mr4630435ad.35.1738868293796;
        Thu, 06 Feb 2025 10:58:13 -0800 (PST)
Received: from localhost ([2603:3004:18:5e00::1c76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ce16sm16451085ad.9.2025.02.06.10.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 10:58:13 -0800 (PST)
Date: Thu, 6 Feb 2025 10:58:12 -0800
From: Zach Brown <zab@zabbo.net>
To: Amir Goldstein <amir73il@gmail.com>
Cc: RIc Wheeler <ricwheeler@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Design challenges for a new file system that
 needs to support multiple billions of file
Message-ID: <20250206185812.GA413506@localhost.localdomain>
References: <048dc2db-3d1f-4ada-ac4b-b54bf7080275@gmail.com>
 <CAOQ4uxjN5oedNhZ2kCJC2XLncdkSFMYJOWmSEC3=a-uGjd=w7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjN5oedNhZ2kCJC2XLncdkSFMYJOWmSEC3=a-uGjd=w7Q@mail.gmail.com>


(Yay, back from travel!)

On Mon, Feb 03, 2025 at 04:22:59PM +0100, Amir Goldstein wrote:
> On Sun, Feb 2, 2025 at 10:40 PM RIc Wheeler <ricwheeler@gmail.com> wrote:
> >
> > Zach Brown is leading a new project on ngnfs (FOSDEM talk this year gave
> > a good background on this -
> > https://www.fosdem.org/2025/schedule/speaker/zach_brown/).  We are
> > looking at taking advantage of modern low latency NVME devices and
> > today's networks to implement a distributed file system that provides
> > better concurrency that high object counts need and still have the
> > bandwidth needed to support the backend archival systems we feed.
> >
> 
> I heard this talk and it was very interesting.
> Here's a direct link to slides from people who may be too lazy to
> follow 3 clicks:
> https://www.fosdem.org/2025/events/attachments/fosdem-2025-5471-ngnfs-a-distributed-file-system-using-block-granular-consistency/slides/236150/zach-brow_aqVkVuI.pdf
> 
> I was both very impressed by the cache coherent rename example
> and very puzzled - I do not know any filesystem where rename can be
> synchronized on a single block io, and looking up ancestors is usually
> done on in-memory dentries, so I may not have understood the example.

The meat of that talk was about how ngnfs uses its distributed block
cache as a serializing/coherence/consistency mechanism.  That specific
example was about how we can get concurrent rename between different
mounts without needing some global equivelant of rename mutex.

The core of the mechanism is that code paths that implement operations
have a transactional object that holds on to cached block references
which have a given access mode granted over the network.  In this rename
case, the ancestor walk holds on to all the blocks for the duration of
the walk.  (Can be a lot of blocks!).  If another mount somewhere else
tried to modify those ancestor blocks, that mount would need to revoke
the cached read access to be granted their write access.  That'd wait
for the first rename to finish and release the read refs.  This gives us
specific serialization of access to the blocks in question rather than
relying on a global serializing object over all renames.

That's the idea, anyway.  I'm implementing the first bits of this now.

It's sort of a silly example, because who puts cross-directory rename in
the fast path?  (Historically some s3<->posix servers implemented
CompleteMultipartUpload be renaming from tmp dirs to visible bucket
dirs, hrmph).  But it illustrates the pattern of shrinking contention
down to the block level.

- z

