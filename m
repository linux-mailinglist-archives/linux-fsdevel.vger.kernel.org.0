Return-Path: <linux-fsdevel+bounces-20982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9AC8FBC3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 21:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F10C1C236BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A589C14AD2E;
	Tue,  4 Jun 2024 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D2F9bKLj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197D814A0B8
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528214; cv=none; b=gPSChgD6FCPwDRY+KS9oW5F3GHLZ+iwoFs4HPA7f0SVvULEbd7zAx49c2G58MvSYC5p++UFWSb4nXenqng/KxJV2zYe3TIvUpNNieI55+u6aSwmQRdd6/3GBy29Mv1pQ6rzCm7lHBOssZz2Z5PY0ZkeBG+hYijJTZRZjP/Q4O5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528214; c=relaxed/simple;
	bh=4CikYP4jmAUB+KrxGF5v6pAp4wJ8Hh5iY1lGPfLmS/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHYt54v7e6+m7DN+qiw5F4OoVEGjdyqA/3v1O9YTcDQfJoRG5sScocBvffrs2ea/wFwhnCBAGavHBvulOB+Oio5OR6H7nFpZ6UmouwYkNEKUCSrkMNKZX74idC/Y5s3Ot3Sa92aXeBKyKdgPhXQutFgHwK/r/cPUS+x9JlnK0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=D2F9bKLj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EKsNoF0MywpqT/TZQS7gCYk1zUr/B3b14dN+nOLsCxA=; b=D2F9bKLjQnk7HuVdWJZ5UkK2UP
	R22lvglnquTB7YQ5tih1nFbAjhp4KkgsmiDvSNSpnTpPCaKDqCK1eKgwjzZNqAMY/PY+Nz7eITxtb
	pMSU3hilQ5tKPE+TSD1B6QicaIyNjSMDGEdvj59Iwd/VXx3NGf8b3UfAnqamJp9fxlgFYGmsZ3sVo
	gpycLP3HiYbhl2a8AXnAaBbmaQsvYiLRqphxK+MBDgyQLhocZsUEo+Z49vvEL2Wg8zqhYcwUc2GyR
	HPJpqnsgn5xW3F7CjvujX7BlBjdb8toFzbdnt8BBIvvy0G7GnA0Ok/A+u8kxX9UHFwO97Z3eoH8Er
	AGIgVPfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sEZXo-00E0aS-2U;
	Tue, 04 Jun 2024 19:10:05 +0000
Date: Tue, 4 Jun 2024 20:10:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2][RFC] amdgpu: fix a race in kfd_mem_export_dmabuf()
Message-ID: <20240604191004.GR1629371@ZenIV>
References: <20240604021255.GO1629371@ZenIV>
 <20240604021354.GA3053943@ZenIV>
 <611b4f6e-e91b-4759-a170-fb43819000ce@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <611b4f6e-e91b-4759-a170-fb43819000ce@amd.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 04, 2024 at 02:08:30PM -0400, Felix Kuehling wrote:
> > +int drm_gem_prime_handle_to_fd(struct drm_device *dev,
> > +			       struct drm_file *file_priv, uint32_t handle,
> > +			       uint32_t flags,
> > +			       int *prime_fd)
> > +{
> > +	struct dma_buf *dmabuf;
> > +	int fd = get_unused_fd_flags(flags);
> > +
> > +	if (fd < 0)
> > +		return fd;
> > +
> > +	dmabuf = drm_gem_prime_handle_to_dmabuf(dev, file_priv, handle, flags);
> > +	if (IS_ERR(dmabuf))
> > +		return PTR_ERR(dmabuf);

That ought to be
	if (IS_ERR(dmabuf)) {
		put_unused_fd(fd);
		return PTR_ERR(dmabuf);
	}
or we'll leak an allocated descriptor.  Will fix and repost...

