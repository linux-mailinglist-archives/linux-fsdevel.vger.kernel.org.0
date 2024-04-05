Return-Path: <linux-fsdevel+bounces-16151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6518993AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 05:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1092879D6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 03:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B95C1AAD7;
	Fri,  5 Apr 2024 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayWFfU4e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56AC134A9;
	Fri,  5 Apr 2024 03:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286850; cv=none; b=V/pVReFEcosFcrPHaNClHAT35ewCQ/XmGNsFWwdiUY3782mGEINBXllx360XZncM0fzHwDFI6/+SbXngQtEM7tlgGTCZ8Tu8dJDulQ0Y3fKcNUC5hvM8gu7ZGTMrWSyHkuWJVXwBNQBZFbO0mSBZPTDGLEHLbCgkDHq4aWc3P54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286850; c=relaxed/simple;
	bh=dIObJ7WS0CwqAe0iS2BAIOM6FAqFGPL/ik27zunW53g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElIz+tQj5TTxvDFuEC9EiBFSHOVQ56eyor+eVIVfUc7FiNhhG9kzkatc0E3C+IEEwY/5ePOaoYqEzSAH2LhEEF2p+bfa8JXoRsDCs0xhgjT2OC9qsowBobwTezBOaviLTmm362STAOc3V7El5Yd/K2T2DkiDy247ZxieOJBYicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayWFfU4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDC0C433F1;
	Fri,  5 Apr 2024 03:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712286850;
	bh=dIObJ7WS0CwqAe0iS2BAIOM6FAqFGPL/ik27zunW53g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayWFfU4emXqwZEXyw1LAPTEe5sdlsyURuF5dHfBiQQlz5BmvT0aA1VzaLkowBWycp
	 soJi0+6HOYEluWsCMt0026zEwzmgqm+iLXiArBu01LVHHdypKFbY3a60/NGPjQ29bY
	 ZxcO2GX7YQXBCwgkfQSEnqPrKZF906AyRQm/jgcFS3SWUqs+qti/2RGJds2b/yXcIk
	 XXsa6ChPMsrETMWKoX829hprP4mQGpY1dxp4RJKpTL1JEp87kmzUyoh0xTfkjZGDJo
	 VWOtpaoS9Lt4TAre56vsU70UpbGiPpT8g3P3v9caDMf4eDU1nXtVTlV6s/3NjipwJ1
	 4KopBqW8ekXuA==
Date: Thu, 4 Apr 2024 23:14:07 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 12/13] fsverity: remove system-wide workqueue
Message-ID: <20240405031407.GJ1958@quark.localdomain>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868064.1987804.7068231057141413548.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175868064.1987804.7068231057141413548.stgit@frogsfrogsfrogs>

On Fri, Mar 29, 2024 at 05:35:48PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Now that we've made the verity workqueue per-superblock, we don't need
> the systemwide workqueue.  Get rid of the old implementation.

This commit message needs to be rephrased because this commit isn't just
removing unused code.  It's also converting ext4 and f2fs over to the new
workqueue type.  (Maybe these two parts belong as separate patches?)

Also, if there are any changes in the workqueue flags that are being used for
ext4 and f2fs, that needs to be documented.

- Eric

