Return-Path: <linux-fsdevel+bounces-70304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF30C96415
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 09:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD1F64E1324
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 08:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750142F9984;
	Mon,  1 Dec 2025 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="erzJpngu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC152FE06D;
	Mon,  1 Dec 2025 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579071; cv=none; b=lENtfAz5idzsH7Ir6DfOMbUfvTFULORK/WPe4EGjFYrFGNhXHIjmiGVYVECDDt9/0Px9JS3n9+BwsPOFBIjdsaYHExK4tOBUn7FO2dOe9yYKV5A+jgAeJNtwU9IUyLDjK5nhEUWc81FveClR7WfLs99Na5iQDSB+7mqeyc+pOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579071; c=relaxed/simple;
	bh=pdnGNmS5fr7Mzo9/GofkTRMMC5L+pZZn6Yst5rtW/6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwjVNpYwzMj8pNFx5Kx5fIUcI51oico8Kw/tz04dIHs4guYZ57CPzTNe5RZleluVyoLu7i0cX7YPiTIzz/XDFUmcPrmzkCuokCXqMyKaZNIEY4r+VlMP7IgECCUm0itQg2lUQl6dHx5y8wxS3SQKAk1cS/dFH5SptlNTU5M0pwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=erzJpngu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A0wXrpLaXBbo0cIPW4iVFFWuMmfB9mBGidKyhDZ5Nzw=; b=erzJpnguil2eUAUIKyssWQfuIO
	jJ3del2gRKQvmoRANIvnU/cjyhgRGEGJRZQ8PYSNHO984RThhseP1nzmCOz79SGQ1gLBNXltJuwFX
	5waC3ch4F7gtHWxQF8rXfi8Ay36+3bUWGEomNp5qLUQEI1Iu1h1ANqdI1VyMJMBZ80f1fFCG3efSS
	vCJ89EyenHq0hsuGam2f9DECpJP8uS/w5scVrn/pUuKZvoStPseBMzowFSBvOn3ir+ix4VVj/nDCH
	Bj9BvJtltknVDKc7w65wo4SxJp9v7eh7laqWOeRDKSHA9ojCJOvhklyBlE1aro2XuP3mmTrOLiViV
	xgwkk1mA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vPzcr-0000000C3V6-1CIf;
	Mon, 01 Dec 2025 08:51:17 +0000
Date: Mon, 1 Dec 2025 08:51:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: hide names_cache behind runtime const machinery
Message-ID: <20251201085117.GB3538@ZenIV>
References: <20251201083226.268846-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201083226.268846-1-mjguzik@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 01, 2025 at 09:32:26AM +0100, Mateusz Guzik wrote:
> s/names_cachep/names_cache/ for consistency with dentry cache.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> v2:
> - rebased on top of work.filename-refcnt
> 
> ACHTUNG: there is a change queued for 6.19 merge window which treats
> dentry cache the same way:
> commit 21b561dab1406e63740ebe240c7b69f19e1bcf58
> Author: Mateusz Guzik <mjguzik@gmail.com>
> Date:   Wed Nov 5 16:36:22 2025 +0100
> 
>     fs: hide dentry_cache behind runtime const machinery
> 
> which would result in a merge conflict in vmlinux.lds.h. thus I
> cherry-picked before generating the diff to avoid the issue for later.

*shrug*
For now I'm working on top of v6.18; rebase to -rc1 will happen at the
end of window...

Anyway, not a problem; applied with obvious massage.  Will push tomorrow
once I sort the linearization out.

