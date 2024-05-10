Return-Path: <linux-fsdevel+bounces-19237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915158C1C13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 03:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C217A1C2212D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 01:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7368413BC07;
	Fri, 10 May 2024 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmWHKpvo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7EC137928;
	Fri, 10 May 2024 01:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715304267; cv=none; b=a/a0qHjpDflZCitWeKtR2LHpFuuKGeUCfI741FEtlWI+fM6uTFplDB5uNNyAdMzgA5bz1yW5+4vlFZUnM7UJsRVAWZhUJs+MX/uUPy63KAzEVG+cvIGYlqFU3VXAMLQvJFF7mKesRn5RYcVt/pH3nnkREO/WbApBkgUJBlB2LJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715304267; c=relaxed/simple;
	bh=dMR4rNMP4Jcx6tRoPoJo4UFOm/KXq6CVgtCEiKRmYJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMf3ZkxfIKgsWr9SRrHbUXUFDbsqa9R9HvmF/eAT9SBqSdmD7ECX0TTPnHC2ZlggnEB+TY9LZAYlqdqdOTSMO08wWhjERPNT8N9+N22wKp3ydzuJYsszr7vMamSN9LhB2r/jU2DwW8zCjWBd3L+B40qzUWt0Dzx2kA6Dilvzank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmWHKpvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37998C116B1;
	Fri, 10 May 2024 01:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715304267;
	bh=dMR4rNMP4Jcx6tRoPoJo4UFOm/KXq6CVgtCEiKRmYJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmWHKpvo+C5HzCNnJV05leNR1+YkwK/zxI+CPQUuAAYF/C3dyJbTDjuq5nl1QRDLV
	 A0Se/n0Msq3QPlVf0hku/NuRTmXBIx+WxiaT8yZ92WS/3M5DGwGcC/5Q8IgWnYgGxX
	 OlyHcv3EllLJ+ESeg1a7MQBZ+qazfnR3bqLZlHKhZckWrkF1angURQOg0A1eb6uiY+
	 qOozR08OiNuLumFzbLkr1PYukoeree0YVLYi7TPhLAHXc5OBO1o8iaC6kD3Gm/CNbt
	 yHCv1xe/+oGSvUuO81w/xFD9/T8f6YsfDKFHdD5NhRqyNQ4svFdEYhQoBskyMLIzp9
	 iAJ1D066u2+vw==
Date: Fri, 10 May 2024 01:24:25 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v16 6/9] ext4: Log error when lookup of encoded dentry
 fails
Message-ID: <20240510012425.GE1110919@google.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-7-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-7-eugen.hristev@collabora.com>

On Fri, Apr 05, 2024 at 03:13:29PM +0300, Eugen Hristev wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> If the volume is in strict mode, ext4_ci_compare can report a broken
> encoding name.  This will not trigger on a bad lookup, which is caught
> earlier, only if the actual disk name is bad.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/ext4/namei.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

