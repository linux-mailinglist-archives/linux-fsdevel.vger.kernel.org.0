Return-Path: <linux-fsdevel+bounces-29096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C52BC9754A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 15:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C8B8B28EFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A86F1A0716;
	Wed, 11 Sep 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeyCdeiW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A6119E96A;
	Wed, 11 Sep 2024 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062703; cv=none; b=ra4undIwXsq/jk2dwXOk4BDvRYwe5MqIyOzE/ZS9yWxAyXksRP7li7IB1+8hk5v3Yx1U6ACB4+fEZV8eBBLu2sXwWuPQQvABFX92pI9iw6LONKljDu/Bw1lYBb49FeQVHyj8M1qvp5YtP9jba/BNXp6WsziInpPi6QYS9iIA2ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062703; c=relaxed/simple;
	bh=esTHwqZQY89z5c47Uj1ctm3mtoh1ZJVRwU7dALV134M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GbN9fkg8t+RGSgi7dkBL/4/eO4z94+MQ1OizVDjD0V8SMCfbqfyI8FyKodvEWnKkrwDTD+KSIG0IsE8jOfC2fA+1YtHJ6uWM455odU5sjBvdDzLLP3Sacp0CtuJxRNhSz0G3aX6Vix2azNdyR/C8AaVm9Q4UP3ITaGwnnBUKnqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeyCdeiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF906C4CEC0;
	Wed, 11 Sep 2024 13:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726062703;
	bh=esTHwqZQY89z5c47Uj1ctm3mtoh1ZJVRwU7dALV134M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NeyCdeiWUHf3IhSEPWgn2DkGBpDRb6SsxBs0RlFNx4Fczo9SA+YQUAs7N7MXjnlwH
	 Gyy1v26ZHQEufa0y5X3aD8gjYfMyeELL8qUE+3IT4CaETrivxjLh7SrcITxVwztza/
	 VA8AFfg3ajOY04ThGUNZAC11cVEBrJTzICSAA12u+teMxc4mbJA/QuYMUZvA8W15uv
	 whxc0cB3MSr0cZpm7J0awJF375VohEBUdzt/+7tvxuNOcCOiwPY4NzvlReDT3hx+/W
	 B6u9ooKkI5apaP5bHY5GrIGwL9AX47T3mdgiRO06TIrTHWAd4q8mOybhrqk7+Zjwyv
	 MiK8XtH8RPkVw==
Date: Wed, 11 Sep 2024 08:51:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, linux-mm@kvack.org, vishal.l.verma@intel.com,
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
	will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	david@fromorbit.com
Subject: Re: [PATCH 02/12] pci/p2pdma: Don't initialise page refcount to one
Message-ID: <20240911135141.GA629523@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r09rgfjj.fsf@nvdebian.thelocal>

On Wed, Sep 11, 2024 at 11:07:51AM +1000, Alistair Popple wrote:
> 
> >> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> >> index 4f47a13..210b9f4 100644
> >> --- a/drivers/pci/p2pdma.c
> >> +++ b/drivers/pci/p2pdma.c
> >> @@ -129,6 +129,12 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
> >>  	}
> >>  
> >>  	/*
> >> +	 * Initialise the refcount for the freshly allocated page. As we have
> >> +	 * just allocated the page no one else should be using it.
> >> +	 */
> >> +	set_page_count(virt_to_page(kaddr), 1);
> >
> > No doubt the subject line is true in some overall context, but it does
> > seem to say the opposite of what happens here.
> 
> Fair. It made sense to me from the mm context I was coming from (it was
> being initialised to 1 there) but not overall. Something like "move page
> refcount initialisation to p2pdma driver" would make more sense?

Definitely would, thanks.

