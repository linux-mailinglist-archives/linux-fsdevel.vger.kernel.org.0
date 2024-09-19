Return-Path: <linux-fsdevel+bounces-29708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5DB97C99E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 15:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA92B1C220DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 13:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B6419DF65;
	Thu, 19 Sep 2024 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXBTaOBF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB0194C61
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751004; cv=none; b=hoXFNk5S2T2CG/D5pIIFfmbczQ6E/8zPGJVvrAobHJ8kzerq5D3WzV3kWbBmPT3HTddMh4N4LMGSKD8RHpb4qQEhRT/Y7wKjM02sxN5nItXt+Bw1BA6SVLOi6jdFD46V314ByQxy9ZqJ0mHZbQQ2TcEJXg76qrARNyUzequz7ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751004; c=relaxed/simple;
	bh=5JupYiLyAcxtraBV+cRKeZsV/ciAgBLAoTEXTnVJYzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEZugQXbaOwqs82AYS8NhRUhGVeXpMlgduoyg5YE5jxtiUNK4KE0neeqHYs69tsMNaN0FJCNXcaVYG7a4yGYfKK+giUJzn2BHjpBf1412s9bc31TJj1tByAb44rGOt8ufzBU7qOHxZjcdSYp/W53P1iaye9HXavGd99eweWKOdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXBTaOBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745ACC4CEC4;
	Thu, 19 Sep 2024 13:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726751003;
	bh=5JupYiLyAcxtraBV+cRKeZsV/ciAgBLAoTEXTnVJYzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXBTaOBFLvmmccn2MC+jhannwEUYm+X/LgOXQcGRXLjsz5SjidbvXv5HQnXfSuhjV
	 xI7wLbJ2ZxH9b28WEnfZ1/Zsw8eP8w4WNaGVOXI0g41xtXfEwB7G9Htve9TkjKK7j0
	 dtbqgMPQAeX5JYxAwpuYVJJkGnPo5qoPhpk9MJRnCzIFyl38Vcf9CJVfuev0g+4vSy
	 kY42VXnqIqQkXttKd7XQHQXL3/tu157l6Nb+rKJz14MKREVreMvEu77r8RSyUNf0YK
	 4RUNDgRKR1HpnkPPELSnGWtcsWvHpYOShviKH51YN/ASc+qMiNtxThtYyNru4k2kqm
	 nqfAyEWUOxGjA==
Date: Thu, 19 Sep 2024 15:03:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: move FMODE_UNSIGNED_OFFSET to fop_flags
Message-ID: <20240919-kollabieren-seeweg-f780e1d5e9f8@brauner>
References: <ZurYXipwj7jv4gy_@e110455-lin.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZurYXipwj7jv4gy_@e110455-lin.cambridge.arm.com>

On Wed, Sep 18, 2024 at 02:40:46PM GMT, Liviu Dudau wrote:
> Hi Christian,
> 
> > This is another flag that is statically set and doesn't need to use up
> > an FMODE_* bit. Move it to ->fop_flags and free up another FMODE_* bit.
> > 
> > (1) mem_open() used from proc_mem_operations
> > (2) adi_open() used from adi_fops
> > (3) drm_open_helper():
> >     (3.1) accel_open() used from DRM_ACCEL_FOPS
> >     (3.2) drm_open() used from
> >     (3.2.1) amdgpu_driver_kms_fops
> >     (3.2.2) psb_gem_fops
> >     (3.2.3) i915_driver_fops
> >     (3.2.4) nouveau_driver_fops
> >     (3.2.5) panthor_drm_driver_fops
> >     (3.2.6) radeon_driver_kms_fops
> >     (3.2.7) tegra_drm_fops
> >     (3.2.8) vmwgfx_driver_fops
> >     (3.2.9) xe_driver_fops
> >     (3.2.10) DRM_GEM_FOPS
> >     (3.2.11) DEFINE_DRM_GEM_DMA_FOPS
> > (4) struct memdev sets fmode flags based on type of device opened. For
> >     devices using struct mem_fops unsigned offset is used.
> > 
> > Mark all these file operations as FOP_UNSIGNED_OFFSET and add asserts
> > into the open helper to ensure that the flag is always set.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Your patch seems to be missing the panthor_drm_driver_fops changes. I've
> discovered that on linux-next your patch triggers a WARN() during my testing.

Yeah, I've added a WARN_ON_ONCE() to catch such cases. Good that it worked.

> 
> I've added the following change to my local tree to fix the warning.

I would send a fixes PR soon. Do you want me to send a fix for this
along with this or are you taking this upstream soon yourself?

