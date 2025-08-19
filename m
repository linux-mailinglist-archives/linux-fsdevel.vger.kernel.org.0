Return-Path: <linux-fsdevel+bounces-58312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3827CB2C75E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 16:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394DB3BD2BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0E82797AE;
	Tue, 19 Aug 2025 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THPhSrsA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937FC2AE66;
	Tue, 19 Aug 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614628; cv=none; b=lqZbqJ0SEZNRV+QoDJyCXkK8ZtFdbARqyL4CGsOHZ5xXoM9sICzqitY9CRt+N/64bFtfZk5wAz79C8SepZN95v+kZG/WrsHFLM7dmbLXaZECaRM5Eyq8pHcLqngBmzle3K5G4Lm18S/ifeFpdiiQIDppHsbCAOKOEOAOdaHTyiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614628; c=relaxed/simple;
	bh=RkD04FQVIfKeJgPUl+3UuGZz11Eg8h6L0G2LPJcuVVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUFMfKYbJWOpmrLE4CXLhgKZ2LGuRjeZ+WcOQLBksXSMzQK1+Qn6rRyAH4UuVXNCMs93/gUzhIAc7mWlrgk7CjQ59kmZi9IfAu1CggRllO1uc+qEi4qAHfqBxFs3B7sqmztDG5JgnWzfntH9ourjous0wMpKx3Soi29P087+Oa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THPhSrsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD56C4CEF1;
	Tue, 19 Aug 2025 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755614628;
	bh=RkD04FQVIfKeJgPUl+3UuGZz11Eg8h6L0G2LPJcuVVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THPhSrsA3AiA6DI/j5UFDKpwA/dyDnJpVueaM0Tx0MNM5kzyW/nqRfIMVAtdnIuOb
	 vPaqnDZolWS3cVMT55/M8rJfnSLiD9v+jiMCDlKjg8OrFC72reEi/p32Ud4AZbddyN
	 8ja5hffrsQunlVUAQ8vy8Mtb6NV7Mspcb1M+Jhx4ubLxK1kegO0lwO+tI1Kdg+/IFB
	 oSRP7fGsGLEHBdsufk/qup3/xjfuJvFzJfr/0tuk8KCY/HzmJGw+VqQ4jhclPfBKf/
	 Xk2sGvECXYqMHWBx4jQd2lYQOAuZEW1vWbT11l3wCdyHfpapKKMf/BYqm+npwyZWRh
	 JB77f2be2VbHA==
Date: Tue, 19 Aug 2025 07:43:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250819144347.GC7942@frogsfrogsfrogs>
References: <20250714131713.GA8742@lst.de>
 <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
 <aHULEGt3d0niAz2e@infradead.org>
 <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
 <20250715060247.GC18349@lst.de>
 <072b174d-8efe-49d6-a7e3-c23481fdb3fc@oracle.com>
 <20250715090357.GA21818@lst.de>
 <bd7b1eea-18bc-431e-bc29-42b780ff3c31@oracle.com>
 <20250819133932.GA16857@lst.de>
 <59a0d2df-a633-4f82-8b11-147ba88b7bcb@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59a0d2df-a633-4f82-8b11-147ba88b7bcb@oracle.com>

On Tue, Aug 19, 2025 at 03:36:33PM +0100, John Garry wrote:
> On 19/08/2025 14:39, Christoph Hellwig wrote:
> > On Tue, Aug 19, 2025 at 12:42:01PM +0100, John Garry wrote:
> > > nothing has been happening on this thread for a while. I figure that it is
> > > because we have no good or obvious options.
> > > 
> > > I think that it's better deal with the NVMe driver handling of AWUPF first,
> > > as this applies to block fops as well.
> > > 
> > > As for the suggestion to have an opt-in to use AWUPF, you wrote above that
> > > users may not know when to enable this opt-in or not.
> > > 
> > > It seems to me that we can give the option, but clearly label that it is
> > > potentially dangerous. Hopefully the $RANDOMUSER with the $CHEAPO SSD will
> > > be wise and steer clear.
> > > 
> > > If we always ignore AWUPF, I fear that lots of sound NVMe implementations
> > > will be excluded from HW atomics.
> > 
> > I think ignoring AWUPF is a good idea, but I've also hard some folks
> > not liking that.
> 
> Disabling reading AWUPF would be the best way to know that for sure :)

What is the likelihood of convincing the nvme standards folks to add a
new command for write-untorn that doesn't just silently fail if you get
the parameters wrong?

> > The reason why I prefer a mount option is because we add that to fstab
> > and the kernel command line easily.  For block layer or driver options
> > we'd either need a sysfs file which is always annoying to apply at boot
> > time,

(Yuck, mount options, look how poorly that went for dax= ;))

> Could system-udev auto enable for us via sysfs file or ioctl?

Userspace controllable sysfs configuration knobs like discard_max_bytes
and discard_max_hw_bytes work well with that model.  The nvme layer can
set atomic_write_bytes to zero by default, and a udev rule can change it
up to atomic_write_max_hw_bytes.

That's not /so/ bad if you can either get the udev rulefile merged into
systemd, or dropped in via clod-init or something.

--D

> > or a module option which has the downside of applying to all
> > devices.
> 
> About the mount option, I suppose that it won't do much harm - it's just a
> bit of extra work to configure.
> 
> I just fear that admins will miss enabling it or not enable it out of doubt
> and users won't see the benefit of HW atomics.
> 
> 
> 

