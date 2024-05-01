Return-Path: <linux-fsdevel+bounces-18454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C750A8B91BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 00:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D70C1B210CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 22:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9197130A4E;
	Wed,  1 May 2024 22:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4maHPw+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1D62233A;
	Wed,  1 May 2024 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714603657; cv=none; b=QDfRgc3xEWUdaYqUPPNm83hWQb97vptd+O1F+CHrUIq/tp/4kb+GDMVf1uK/wAzEYu4oak5rcd9NAMtzu0qgMxmrVx/+21CWEYgM0VJErZgBrauWDkuKZ4Ynh9B7eGoQSzzxyTJmL0aTJbsl4zCFpq4CEi/jU6+SGUbZDBG6UwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714603657; c=relaxed/simple;
	bh=gylVs1f/iw+g/RGHqqOI+00NXcJ18FS46ngsKmUCcJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRN7VHwFXWAVX4SAnWZTwCf6AwtQbv4QE1C3ECGyrUxTPnRgrPXEtCkKTJD5J/tEKV47Eb3vUR8zQuWGRM/F0hr0qhEK1nl002HaZj/hY4b0RxS2aXozsdHx5T+GM4fsDC2d4qqzTG9B4oyB7cxVaUfFtCG5c/pZ9g1tWPnJoRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4maHPw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D518C072AA;
	Wed,  1 May 2024 22:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714603656;
	bh=gylVs1f/iw+g/RGHqqOI+00NXcJ18FS46ngsKmUCcJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4maHPw+ZngJrr7TVf6lC4ENz4/cjK4MhprAzJNeXeEfspE8vNfcpvdvVg205fAKY
	 mQnWQtJJBpdRBFpR3SNx+MC0C/DQ7PYWme1uCfFOBLQXMRqXi1DQmz8R+CoU9UM7je
	 4v/o5oMq7R18EspDKbu0UaMzWYmpAItnXekWRkEvQg37+9yZs1zCYiV6NxN6s8dHkd
	 LUESboM9YrX7dd+Q5hfKv7C5gP9XjWbbHp400rFkkB+75/GNKyOASC/lB/Chv512dy
	 9lXVPAMP/Qn6HQ1tNyvWSuwapn/xDTvHvRxNlDYqv84lvdeVCVjiXnBa4rDt3h53j/
	 Iceflya/Et44w==
Date: Wed, 1 May 2024 15:47:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/26] xfs: don't bother storing merkle tree blocks for
 zeroed data blocks
Message-ID: <20240501224736.GL360919@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680689.957659.7685497436750551477.stgit@frogsfrogsfrogs>
 <ZjHle-WDezhehB6a@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjHle-WDezhehB6a@infradead.org>

On Tue, Apr 30, 2024 at 11:47:23PM -0700, Christoph Hellwig wrote:
> On Mon, Apr 29, 2024 at 08:29:03PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Now that fsverity tells our merkle tree io functions about what a hash
> > of a data block full of zeroes looks like, we can use this information
> > to avoid writing out merkle tree blocks for sparse regions of the file.
> > For verified gold master images this can save quite a bit of overhead.
> 
> Is this something that fsverity should be doing in a generic way?

I don't think it's all that useful for ext4/f2fs because they always
write out full merkle tree blocks even if it's the zerohash over and
over again.  Old kernels aren't going to know how to deal with that.

> It feels odd to have XFS behave different from everyone else here,
> even if this does feel useful.  Do we also need any hash validation
> that no one tampered with the metadata and added a new extent, or
> is this out of scope for fsverity?

If they wrote a new extent with nonzero contents, then the validation
will fail, right?

If they added a new unwritten extent (or a written one full of zeroes),
then the file data hasn't changed and validation would still pass,
correct?

--D

