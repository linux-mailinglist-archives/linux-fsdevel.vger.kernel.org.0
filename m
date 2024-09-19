Return-Path: <linux-fsdevel+bounces-29728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDA797CF6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 01:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4935728490C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 23:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABB619A28F;
	Thu, 19 Sep 2024 23:56:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E982868B
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726790167; cv=none; b=DV9/8Lz5hByg+XHyAJRqFAFgcjPwMKTWjTI2vznEU3YjzIxUHD89FmogbPmnsUoDVK3XAyLzHRkiacmjTwfNt8kzYmh2ZGMnWTevBAmA2+eNv6E5jFiM1YofXe/RYWCPS76rd158wv7eKMt87OolXhArk/YmGcUNlEJEkzNUdCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726790167; c=relaxed/simple;
	bh=sRTCmP1M02Bpf558vUr/tF5q1Lx6824vi1YxbTqk8l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mi6WkEoMcRBo78FO92ClxEHJ0VoogPwEDDR5n8y3Q9tWZ2kfAgMANYVcIm4IszGuVEBkFSOtvhRP04X163fm4EPHiWDGiYQP4nR0sKgkker9bZr5+/KziV730zTIMX+pD1vDTskKguZN9AlguZ2T1crE2Y83DnmwwX91AqiH4kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85844FEC
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 16:56:33 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C76993F71A
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 16:56:03 -0700 (PDT)
Date: Fri, 20 Sep 2024 00:55:57 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: move FMODE_UNSIGNED_OFFSET to fop_flags
Message-ID: <Zuy6Daji_OFn8NFf@e110455-lin.cambridge.arm.com>
References: <ZurYXipwj7jv4gy_@e110455-lin.cambridge.arm.com>
 <20240919-kollabieren-seeweg-f780e1d5e9f8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240919-kollabieren-seeweg-f780e1d5e9f8@brauner>

On Thu, Sep 19, 2024 at 03:03:19PM +0200, Christian Brauner wrote:
> On Wed, Sep 18, 2024 at 02:40:46PM GMT, Liviu Dudau wrote:
> > Hi Christian,
> > 
> > > This is another flag that is statically set and doesn't need to use up
> > > an FMODE_* bit. Move it to ->fop_flags and free up another FMODE_* bit.
> > > 
> > > (1) mem_open() used from proc_mem_operations
> > > (2) adi_open() used from adi_fops
> > > (3) drm_open_helper():
> > >     (3.1) accel_open() used from DRM_ACCEL_FOPS
> > >     (3.2) drm_open() used from
> > >     (3.2.1) amdgpu_driver_kms_fops
> > >     (3.2.2) psb_gem_fops
> > >     (3.2.3) i915_driver_fops
> > >     (3.2.4) nouveau_driver_fops
> > >     (3.2.5) panthor_drm_driver_fops
> > >     (3.2.6) radeon_driver_kms_fops
> > >     (3.2.7) tegra_drm_fops
> > >     (3.2.8) vmwgfx_driver_fops
> > >     (3.2.9) xe_driver_fops
> > >     (3.2.10) DRM_GEM_FOPS
> > >     (3.2.11) DEFINE_DRM_GEM_DMA_FOPS
> > > (4) struct memdev sets fmode flags based on type of device opened. For
> > >     devices using struct mem_fops unsigned offset is used.
> > > 
> > > Mark all these file operations as FOP_UNSIGNED_OFFSET and add asserts
> > > into the open helper to ensure that the flag is always set.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > Your patch seems to be missing the panthor_drm_driver_fops changes. I've
> > discovered that on linux-next your patch triggers a WARN() during my testing.
> 
> Yeah, I've added a WARN_ON_ONCE() to catch such cases. Good that it worked.
> 
> > 
> > I've added the following change to my local tree to fix the warning.
> 
> I would send a fixes PR soon. Do you want me to send a fix for this
> along with this or are you taking this upstream soon yourself?

Was your series pulled into v6.12?

I will send a patch and once reviewed I will push it into the relevant drm-misc branch.

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

