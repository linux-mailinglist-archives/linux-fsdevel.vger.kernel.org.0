Return-Path: <linux-fsdevel+bounces-23338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF62E92AC53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 01:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851B7282D9D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 23:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C41C1514F6;
	Mon,  8 Jul 2024 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="PlJEKTVV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483AB34545
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720479698; cv=none; b=p+0ORWV1B6t5kz9wjCxDO7W+d2e4RkzsajyvWVLIN26TSDQYDUtMhm1M+IBf5mQ0sf1V3k4XLzrgh63dy1YBWl7KSMaUYR+4AKXMwNnyx6bbjAYz1imjvX6i29uMugaMKO5WEb6EfCEAGC29uT05Rk+28C5RG/dPE2QgSARNr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720479698; c=relaxed/simple;
	bh=4mmW7YfFF+gsQRlC8oiLPu+TfhBSoeHJ9GMBIaEWDhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcLj+2E+W1w+mlVZ4lxZVbPv3Au0Oc0A0Odw5lfd6MpdPlZDnq2RZ5Tc9nobUDY2YbrJdxwPmtKABS2KIDKduI8HKxDg7rJMmGJntu6pGqnK/xhggEJyECt1afByN6vyjB5lB29p6lYpyWhu4oRXAEFYcTfy351/l2RVRh5Isfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=PlJEKTVV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b12572bd8so1964692b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2024 16:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720479696; x=1721084496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x5cu9RTdpEetTRtYJGCxvqzeg6gGlXm6jK4lXHnlKYE=;
        b=PlJEKTVV5xrkt9ENWOWHhAuAD2IjzP8IWDOSkOcKWbrrifz9Rz+RhVQM5cl75mrMPr
         566+sYsWdTnXmdQxkS8c38wLGL0Tggc6o696SwHZJS3yO6UGp7RFkKh6iW8kCsNqDKd6
         qyAKBdBTKY5KPZvhichDokJ6hbfqudEO/lSo7IUzg7ocuKLrvecKEoU2EW39454j4tEr
         ueyH7dQrudAYPdUYkTA/b7O81U919tFaROnVNFtLMr2xxON9yIoT2oEEuHUr6tWkMkZt
         xeFcvsVPOgEdxAcEDX0J5k86RuOcnvVDN16Vd+sko9w7yl+/ZSB+uMe2CVASNVK2ZjxM
         P5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720479696; x=1721084496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5cu9RTdpEetTRtYJGCxvqzeg6gGlXm6jK4lXHnlKYE=;
        b=jlf3HyIUuckB+GuaR3aA6HdlNvAGEfNf6bjSk6Zg5GdxV8YxFyz8x7uchxbvdpO4L5
         v8XFdOiwBU9Dm13Kn9PYAjI+YdEDNDqGyFP7T/HFcsokQ6sR6eVs0qx0k0KuebpqRfXS
         6Qb173kKZSmQ+OmwwfcchBzXOpBpjvtAWYW08OkXGCykVFXMdkKsG/BVBD3vK+UZeHHu
         /KCyzL16p3BRlsI9XI86ihMH4EtBtHb3I9IQF6wFGWVACAUGomfB7EK9Dl6z2VfzqfIs
         +tlq++i8z+nJ0GimOq7G30ku3QZbg+ZHzPYD6NErrtNCszB/zroMnsaUTjyFAWdyiKr0
         cOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzOFOwNsOSgf+/+X8REtpcaKM2rzqWMiQJQcLQphv2wenwHGrSr2VfTbqVGQlLuqiTqtOUnhhksAjF0qtEyKWL5VcTsUgQWc6if1pvEg==
X-Gm-Message-State: AOJu0Yw8d/VUceu4Gt3T2S7ckEM+OjeHmQrWI4bQbp10JOZ65IfoleMj
	J1JF5+i41RSXcAdY+CJ2njHDtcaPNi/uHkFz1ZvfnTUoc31X4iknkiCun2poRUY=
X-Google-Smtp-Source: AGHT+IH6RNZxAqDXMv0zOhu7Tw81IhoGG5N9YhzT4A9nMqKAP406Ux6SzAC2wf4QwiAKI2xXuKZ8wQ==
X-Received: by 2002:a05:6a00:893:b0:706:29d3:3c32 with SMTP id d2e1a72fcca58-70b4351fef3mr1419047b3a.2.1720479696539;
        Mon, 08 Jul 2024 16:01:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439ba1casm404582b3a.202.2024.07.08.16.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 16:01:36 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sQxMT-0092DB-22;
	Tue, 09 Jul 2024 09:01:33 +1000
Date: Tue, 9 Jul 2024 09:01:33 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Matthew Wilcox <willy@infradead.org>, chandan.babu@oracle.com,
	djwong@kernel.org, brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <ZoxvzXA1wcGDlQS2@dread.disaster.area>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>
 <Zoa9rQbEUam467-q@casper.infradead.org>
 <Zocc+6nIQzfUTPpd@dread.disaster.area>
 <Zoc2rCPC5thSIuoR@casper.infradead.org>
 <Zod3ZQizBL7MyWEA@dread.disaster.area>
 <20240705132418.gk7oeucdisat3sq5@quentin>
 <1e0e89ea-3130-42b0-810d-f52da2affe51@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e0e89ea-3130-42b0-810d-f52da2affe51@arm.com>

On Fri, Jul 05, 2024 at 02:31:08PM +0100, Ryan Roberts wrote:
> On 05/07/2024 14:24, Pankaj Raghav (Samsung) wrote:
> >>> I suggest you handle it better than this.  If the device is asking for a
> >>> blocksize > PMD_SIZE, you should fail to mount it.
> >>
> >> That's my point: we already do that.
> >>
> >> The largest block size we support is 64kB and that's way smaller
> >> than PMD_SIZE on all platforms and we always check for bs > ps 
> >> support at mount time when the filesystem bs > ps.
> >>
> >> Hence we're never going to set the min value to anything unsupported
> >> unless someone makes a massive programming mistake. At which point,
> >> we want a *hard, immediate fail* so the developer notices their
> >> mistake immediately. All filesystems and block devices need to
> >> behave this way so the limits should be encoded as asserts in the
> >> function to trigger such behaviour.
> > 
> > I agree, this kind of bug will be encountered only during developement 
> > and not during actual production due to the limit we have fs block size
> > in XFS.
> > 
> >>
> >>> If the device is
> >>> asking for a blocksize > PAGE_SIZE and CONFIG_TRANSPARENT_HUGEPAGE is
> >>> not set, you should also decline to mount the filesystem.
> >>
> >> What does CONFIG_TRANSPARENT_HUGEPAGE have to do with filesystems
> >> being able to use large folios?
> >>
> >> If that's an actual dependency of using large folios, then we're at
> >> the point where the mm side of large folios needs to be divorced
> >> from CONFIG_TRANSPARENT_HUGEPAGE and always supported.
> >> Alternatively, CONFIG_TRANSPARENT_HUGEPAGE needs to selected by the
> >> block layer and also every filesystem that wants to support
> >> sector/blocks sizes larger than PAGE_SIZE.  IOWs, large folio
> >> support needs to *always* be enabled on systems that say
> >> CONFIG_BLOCK=y.
> > 
> > Why CONFIG_BLOCK? I think it is enough if it comes from the FS side
> > right? And for now, the only FS that needs that sort of bs > ps 
> > guarantee is XFS with this series. Other filesystems such as bcachefs 
> > that call mapping_set_large_folios() only enable it as an optimization
> > and it is not needed for the filesystem to function.
> > 
> > So this is my conclusion from the conversation:
> > - Add a dependency in Kconfig on THP for XFS until we fix the dependency
> >   of large folios on THP
> 
> THP isn't supported on some arches, so isn't this effectively saying XFS can no
> longer be used with those arches, even if the bs <= ps?

I'm good with that - we're already long past the point where we try
to support XFS on every linux platform. Indeed, we've recent been
musing about making XFS depend on 64 bit only - 32 bit systems don't
have the memory capacity to run the full xfs tool chain (e.g.
xfs_repair) on filesystems over about a TB in size, and they are
greatly limited in kernel memory and vmap areas, both of which XFS
makes heavy use of. Basically, friends don't let friends use XFS on
32 bit systems, and that's been true for about 20 years now.

Our problem is the test matrix - if we now have to explicitly test
XFS both with and without large folios enabled to support these
platforms, we've just doubled our test matrix. The test matrix is
already far too large to robustly cover, so anything that requires
doubling the number of kernel configs we have to test is, IMO, a
non-starter.

That's why we really don't support XFS on 32 bit systems anymore and
why we're talking about making that official with a config option.
If we're at the point where XFS will now depend on large folios (i.e
THP), then we need to seriously consider reducing the supported
arches to just those that support both 64 bit and THP. If niche
arches want to support THP, or enable large folios without the need
for THP, then they can do that work and then they get XFS for
free.

Just because an arch might run a Linux kernel, it doesn't mean we
have to support XFS on it....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

