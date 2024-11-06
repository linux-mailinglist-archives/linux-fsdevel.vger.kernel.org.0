Return-Path: <linux-fsdevel+bounces-33731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5688B9BE30E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 10:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8812E1C225D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 09:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DE71DBB21;
	Wed,  6 Nov 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcScvpXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB85F1DA63F;
	Wed,  6 Nov 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886629; cv=none; b=h39O/SthVbfGD1hFFN+NshvzpUlwY5A8pf513JFZEm7snv35ZlR3X/RXjIUs7oTiGI7s7YCfDah9DleXtvrWf3ufJwkbaNl/7APXPW9vEcMx1yiiCo7nAaSIzcFGCbv4StoxJV/7tBVlFu3IuTzRf5eVFif9qPOkBarTlUTEaXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886629; c=relaxed/simple;
	bh=3IYck0Jb+qA3j7/LD2LcqSk3StFna7qHYLbxuaE47Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9tmUE8/XH+2gLj3Gkqnc1wEHXMzZYmZH2on1z+WfLXtkVUqCVRuQt9xybtNBAZalG9AIrLedsiWLNl/kooj4ycVGIVePFxuH0hP6Ri2L1yOVcn3uHQY6Vd6lKVW8Cb8FTJgLgC+NvvJ7Y6HQ3V5iwtc21ZCQ3wTJCqML2pl5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcScvpXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7378C4CED0;
	Wed,  6 Nov 2024 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730886629;
	bh=3IYck0Jb+qA3j7/LD2LcqSk3StFna7qHYLbxuaE47Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OcScvpXA2uD4UHi7gjOhG7xzBaRI313+k+xSFkx8gSeLcWoEDuKxJoQKA3+nXqdSa
	 Armr1qF0VqelXLFWdbzDqojj4q5zvoQOf+AMLGPoaCLUZeV9qYCuOYrmxJxSjqMKCY
	 +wq3xrCUi3mytHwGzjFMbOLR7W1kzqxtRpbBneivHLGaFXbXfDgaqIT6ohv62i3GLc
	 Bmlt9bT8Z40tGfDsEV9iHDV2D71Wt65eXWaUzxkxn1cQxjYjru1QyOJKSe3tkTReO1
	 IPMe7uoYBny66gSkHI4v7RJHEezSbSetI+x/KOn+eT4ZSA8k1l3MahHJWOvX9Xgd6v
	 lj/afQw9BPdhw==
Date: Wed, 6 Nov 2024 10:50:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	John Garry <john.g.garry@oracle.com>, Catherine Hoang <catherine.hoang@oracle.com>, 
	linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	linux-block@vger.kernel.org, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANNOUNCE v2] work tree for untorn filesystem writes
Message-ID: <20241106-zerkleinern-verzweifeln-7ec8173c56ad@brauner>
References: <20241106005740.GM2386201@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106005740.GM2386201@frogsfrogsfrogs>

On Tue, Nov 05, 2024 at 04:57:40PM -0800, Darrick J. Wong wrote:
> Hi everyone,
> 
> Here's a slightly updated working branch for the filesystem side of
> atomic write changes for 6.13:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fs-atomic_2024-11-05
> 
> This branch is, like yesterday's, based off of axboe's
> for-6.13/block-atomic branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block-atomic
> 
> The only difference is that I added Ojaswin's Tested-by: tags to the end
> of the xfs series.  I have done basic testing with the shell script at
> the end of this email and am satisfied that it at least seems to do the
> (limited) things that I think we're targeting for 6.13.
> 
> Christian: Could you pull this fs-atomic branch into your vfs.git work
> for 6.13, please?

Of course!

I did git pull fs-atomic_2024-11-05 from your tree. It should show up in
-next tomorrow.

