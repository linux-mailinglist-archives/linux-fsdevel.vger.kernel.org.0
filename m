Return-Path: <linux-fsdevel+bounces-54949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6434B059DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE0916F98C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFE02DA750;
	Tue, 15 Jul 2025 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzZNBylO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F092CCC5;
	Tue, 15 Jul 2025 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582041; cv=none; b=shpogM62T4ZH9rMiQT/5rC/9cZOhyrmBIB11A2GXczjvHOuBIL3FXjHf9vJvDms+WwRBEjRF1zbui2LDKMh0X/Xsl18eKRDpjqM4MupM6SHukKFPJ2pcCSmj6JsgTAOtTBWS65VVS5FaEYvEsB9J09kLbKaxH5ep05MZToMNacY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582041; c=relaxed/simple;
	bh=tMl1JvlwlYhUCWAJRzNllyLX2xjK9CnGH96Qoit7K4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/EsgYzxAdjRM3J0N/wcEG6DOSX9LNBv9L88vn3MnIu6E9WH1y8K6kGfQpoSRU+2AOGpOsZqcyBj5upFJVKBgoQRNwffQ1jvcCZ0CgrUt92xvO76kKoC07oR3LPJJmbD+oP8bURtcm4RSRWgQVx3eOVaA249b8aO72Mm3bTlkEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzZNBylO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CDEC4CEE3;
	Tue, 15 Jul 2025 12:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752582041;
	bh=tMl1JvlwlYhUCWAJRzNllyLX2xjK9CnGH96Qoit7K4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzZNBylOhtaXDKpYwRumyL4AAGY6tVlnbwOdsYIS8EypLyTy3KxtuC/R4rZiHxD9t
	 dBOCAsI+w41ty6KcfglTwCv2GwgEm4cVvSamDN2wJ3Pgmh+b4XC2VaFIE7GoEVQJha
	 GFQhcxa490toVKN3yXsydwKx/Rh7IEkT5fLieqa2KcSzq1BQkfWXi/U4d3rCP3UaPp
	 MRRtlnKyYWWMNdGhfwRaesKaWvq3glrI1vZ4K5r3eYeFFhu6u+Gl7rd6aNQVkFIOqO
	 IKoQjOpJuifXqHNUh1+O7oGPETsDEdt4V9l7IX/w0Ro2FgBOQM05ijKCPwhuUxsRrd
	 dnmKYyY/xUkuA==
Date: Tue, 15 Jul 2025 14:20:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, 
	Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715-gekapert-einsam-4645671c7555@brauner>
References: <20250714131713.GA8742@lst.de>
 <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
 <aHULEGt3d0niAz2e@infradead.org>
 <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
 <20250715060247.GC18349@lst.de>
 <20250715-rundreise-resignieren-34550a8d92e3@brauner>
 <20250715112952.GA23935@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715112952.GA23935@lst.de>

On Tue, Jul 15, 2025 at 01:29:52PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 15, 2025 at 12:02:06PM +0200, Christian Brauner wrote:
> > > I'm not sure a XFLAG is all that useful.  It's not really a per-file
> > > persistent thing.  It's more of a mount option, or better persistent
> > > mount-option attr like we did for autofsck.
> > 
> > If we were to make this a mount option it would be really really ugly.
> > Either it is a filesystem specific mount option and then we have the
> > problem that we're ending up with different mount option names
> > per-filesystem.
> 
> Not that I'm arguing for a mount option (this should be sticky), but
> we've had plenty of fs parsed mount options with common semantics.
> 
> > It feels like this is something that needs to be done on the block
> > layer. IOW, maybe add generic block layer ioctls or a per-device sysfs
> > entry that allows to turn atomic writes on or off. That information
> > would then also potentially available to the filesystem to e.g.,
> > generate an info message during mount that hardware atomics are used or
> > aren't used. Because ultimately the block layer is where the decision
> > needs to be made.
> 
> The block layer just passes things through.

We already have bdev_can_atomic_write() which checks whether the
underlying device is capable of hardware assisted atomic writes. If
that's the case the filesystem currently just uses them, fine.

So it is possible to implement an ioctl() that allows an administrator
to mark a device as untrusted for hardware assisted atomic writes.

This is also nice is because this can be integrated with udev easily. If
a device is know to have broken hardware assisted atomic writes then add
the device into systemd-udev's hardware database (hwdb).

When systemd-udev sees that device show up during boot it will
automatically mark that device as having broken atomic write support and
any mount of that device will have the filesystem immediately see the
broken hardware assisted atomic write support in bdev_can_atomic_write()
and not use it.

Fwiw, this pattern is already used for other stuff. For example for the
iocost stuff that udev will auto-apply if known. The broken atomic write
stuff would fit very well in there. Either it's an allowlist or a
denylist.

commit 6b8e90545e918a4653281b3672a873e948f12b65
Author:     Gustavo Noronha Silva <gustavo.noronha@collabora.com>
AuthorDate: Mon May 2 14:02:23 2022 -0300
Commit:     Lennart Poettering <lennart@poettering.net>
CommitDate: Thu Apr 20 16:45:57 2023 +0200

    Apply known iocost solutions to block devices

    Meta's resource control demo project[0] includes a benchmark tool that can
    be used to calculate the best iocost solutions for a given SSD.

      [0]: https://github.com/facebookexperimental/resctl-demo

    A project[1] has now been started to create a publicly available database
    of results that can be used to apply them automatically.

      [1]: https://github.com/iocost-benchmark/iocost-benchmarks

    This change adds a new tool that gets triggered by a udev rule for any
    block device and queries the hwdb for known solutions. The format for
    the hwdb file that is currently generated by the github action looks like
    this:

      # This file was auto-generated on Tue, 23 Aug 2022 13:03:57 +0000.
      # From the following commit:
      # https://github.com/iocost-benchmark/iocost-benchmarks/commit/ca82acfe93c40f21d3b513c055779f43f1126f88
      #
      # Match key format:
      # block:<devpath>:name:<model name>:

      # 12 points, MOF=[1.346,1.346], aMOF=[1.249,1.249]
      block:*:name:HFS256GD9TNG-62A0A:fwver:*:
        IOCOST_SOLUTIONS=isolation isolated-bandwidth bandwidth naive
        IOCOST_MODEL_ISOLATION=rbps=1091439492 rseqiops=52286 rrandiops=63784 wbps=192329466 wseqiops=12309 wrandiops=16119
        IOCOST_QOS_ISOLATION=rpct=0.00 rlat=8807 wpct=0.00 wlat=59023 min=100.00 max=100.00
        IOCOST_MODEL_ISOLATED_BANDWIDTH=rbps=1091439492 rseqiops=52286 rrandiops=63784 wbps=192329466 wseqiops=12309 wrandiops=16119
        IOCOST_QOS_ISOLATED_BANDWIDTH=rpct=0.00 rlat=8807 wpct=0.00 wlat=59023 min=100.00 max=100.00
        IOCOST_MODEL_BANDWIDTH=rbps=1091439492 rseqiops=52286 rrandiops=63784 wbps=192329466 wseqiops=12309 wrandiops=16119
        IOCOST_QOS_BANDWIDTH=rpct=0.00 rlat=8807 wpct=0.00 wlat=59023 min=100.00 max=100.00
        IOCOST_MODEL_NAIVE=rbps=1091439492 rseqiops=52286 rrandiops=63784 wbps=192329466 wseqiops=12309 wrandiops=16119
        IOCOST_QOS_NAIVE=rpct=99.00 rlat=8807 wpct=99.00 wlat=59023 min=75.00 max=100.00

    The IOCOST_SOLUTIONS key lists the solutions available for that device
    in the preferred order for higher isolation, which is a reasonable
    default for most client systems. This can be overriden to choose better
    defaults for custom use cases, like the various data center workloads.

    The tool can also be used to query the known solutions for a specific
    device or to apply a non-default solution (say, isolation or bandwidth).

    Co-authored-by: Santosh Mahto <santosh.mahto@collabora.com>

