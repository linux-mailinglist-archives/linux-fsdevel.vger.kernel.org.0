Return-Path: <linux-fsdevel+bounces-14695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5449787E2C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 05:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052161F2140A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 04:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5C3208B6;
	Mon, 18 Mar 2024 04:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwpVZ3Qp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9D44C84;
	Mon, 18 Mar 2024 04:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710736246; cv=none; b=hS8eaRnZ1NkFBgYPz90SweU8es2+IkhAX9jsAdHqvjhdjiKA3FcbDsfejarnwIkP1ORPSVAnr/8BrEunt5qFfXFn4gzjWEOjZCbhNj3HS/e3gXLfmUWFNJtwJ+TURovgiIdOOP6ZKb/+a2WSld/YQtIqQlSHhyNWSejNXBP4R8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710736246; c=relaxed/simple;
	bh=OoEglyXCIBb+hsmWdgthoIQl796eGQzCE54LqyV1wKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlO+l/3LwH2V0M22FcHyXzlNDM62Ut9hK4q3MM34Gy8xFK4m3KKtQ8/ur5F5p+1+al/KrtzkNrsv6EKydA+ry4WqsRLXjUHlRYmACgL3yAGdmQm32Ju8YoFLhy1ZjzdRw8VL+o/PQa4xTCHxC75VKdNJq/YFH6ahptMfYsYtH2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwpVZ3Qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B90C433F1;
	Mon, 18 Mar 2024 04:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710736245;
	bh=OoEglyXCIBb+hsmWdgthoIQl796eGQzCE54LqyV1wKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwpVZ3QpTsGNJseLk/1DvqpnxiRQoVk9tTYl+qN+warMNH1jGLn+EdodsHbr9J9h/
	 8lPfzw1AtO3M8RHYeI1aO6S4QK1yYtXZxed36onqs/tgSLeXHI0cxK49pxdFmMADss
	 7ux1RqMpLgfA2xd/kIh9Lh4PySQWDMEqqvLP+bFYJbm3Q9aPG8qLgtu53+vcOllF1S
	 1jT4HbxykPV2UFOe0MUCEUaca8S6uIg55+i2k8vQXvJeHYKiXg6AYdhl7/AMc4rlbN
	 j16R+zyelx4Oa8bu2Aa2F3axCcS0+xifmVpClU2RTXBIyO2yHeKTMT1TIPBeurcPmh
	 VFLrFU3mgtIKg==
Date: Sun, 17 Mar 2024 21:30:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCHBOMB v5.3] fs-verity support for XFS
Message-ID: <20240318043044.GG1927156@frogsfrogsfrogs>
References: <20240317161954.GC1927156@frogsfrogsfrogs>
 <ZfebRH_fGx8EoRfu@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfebRH_fGx8EoRfu@infradead.org>

On Sun, Mar 17, 2024 at 06:39:16PM -0700, Christoph Hellwig wrote:
> On Sun, Mar 17, 2024 at 09:19:54AM -0700, Darrick J. Wong wrote:
> > Note that metadump is kinda broken and xfs_scrub media scans do not yet
> > know how to read verity files.  All that is actually fixed in the
> > version that's lodged in my development trees, but since Andrey's base
> > is the 6.9 for-next branch plus only a few of the parent pointers
> > patches, none of that stuff was easy to port to make a short dev branch.
> 
> Maybe we'll need to put the verity work back and do a good review cycle
> on the parent pointers first?
> 
> Can you send out what your currently have?

Ok, I'll do that tomorrow.

--D

