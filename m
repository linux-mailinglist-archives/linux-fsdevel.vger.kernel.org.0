Return-Path: <linux-fsdevel+bounces-16152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121108993B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 05:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7311F233DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 03:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C4F1BDDB;
	Fri,  5 Apr 2024 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1C0cjYT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74C21862C;
	Fri,  5 Apr 2024 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287008; cv=none; b=awVV9K1altvoebJ5iD5twORkqZ8luJeaZDIkWlgSOR9A+4y921bYJRJY69+rLXyZTD87gaEfJqgSug91zh/CpvxekdD9Cy7VsXHvdjbVI1xwzynAvSdnf2xw48cQ/aQ7XJt19caUkRBIhs490snqFftuR65xZ0BLvcqsGr074tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287008; c=relaxed/simple;
	bh=H3JTTAdviOSpNPmfWeC/U00wBINd+/YykOErV/QWVo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRhi/STaYRR5cYNYT63xid55FsdtDHmC2O2mEFLbDxmgb/J2nujaKEK0K5NRhmYGisHncW+VdPmQDwEpXsGRoIZtBlvJHPIWQ7XJ+IO3ZJTElsY3C6mBjfZGB2jjgt+JAIm+xMO72TRhxl+H3t7SpV/HlqtW9Rf+L44OnidIDp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1C0cjYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF35C433F1;
	Fri,  5 Apr 2024 03:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712287008;
	bh=H3JTTAdviOSpNPmfWeC/U00wBINd+/YykOErV/QWVo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a1C0cjYTCw/WO2qziYupT4cBn9oTQomrUrJpQIohoPxrgGFUaKSdkxYunFDToI7UN
	 g8Y+IQWGoKtdWy2GnZVu8BLfn/0emGvmN2AjtcFosTS2969kP9grYUPv/G5Xq8okyd
	 2N00w+d/jObkmaslRochU0RT6vopAWPOtc96LB7HWw1USxgVaflHx1VtKlnRMxvzWr
	 QvuX0BSsl21wEgSRGp2UJOApVJRyjIG9Es04zsc6ITYhKKQICmf3PwIuEvMPSWdv5s
	 JzTpblQ/MqATSIHjw2p2q6rkescvnW+tGaqE7QBM/RwbqplQPNeB1p/iiOlEvh/ost
	 PI2nXFzuqdKCg==
Date: Thu, 4 Apr 2024 23:16:46 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 14/29] xfs: create a per-mount shrinker for verity inodes
 merkle tree blocks
Message-ID: <20240405031646.GK1958@quark.localdomain>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175868793.1988170.8461136895877903082.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175868793.1988170.8461136895877903082.stgit@frogsfrogsfrogs>

On Fri, Mar 29, 2024 at 05:39:43PM -0700, Darrick J. Wong wrote:
> +/* Count the merkle tree blocks that we might be able to reclaim. */
> +static unsigned long
> +xfs_fsverity_shrinker_count(
> +	struct shrinker		*shrink,
> +	struct shrink_control	*sc)
> +{
> +	struct xfs_mount	*mp = shrink->private_data;
> +	s64			count;
> +
> +	if (!xfs_has_verity(mp))
> +		return SHRINK_EMPTY;
> +
> +	count = percpu_counter_sum_positive(&mp->m_verity_blocks);
> +
> +	trace_xfs_fsverity_shrinker_count(mp, count, _RET_IP_);
> +	return min_t(s64, ULONG_MAX, count);

On 64-bit systems this always returns ULONG_MAX.

- Eric

