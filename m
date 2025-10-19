Return-Path: <linux-fsdevel+bounces-64621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B7EBEE48D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 14:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43D0934A22F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 12:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA3A2E54DE;
	Sun, 19 Oct 2025 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gL3sa5/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224A57483;
	Sun, 19 Oct 2025 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760875921; cv=none; b=OaTBaQjsoLyO2EhClhWUQlgIjpxSbpAKJuFmbDBk/Wb3KImYZil4zhcY7bXUXZ5uJSEvh/iUvwuiuqhyPjyeVP2zrEf1kp2aHypTszUe/fBMxE+/ZvSl93SakCefUe0YAgMHAHbY6D0LrIAth2Xt80/V5JKxKp752K9GTwJKoqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760875921; c=relaxed/simple;
	bh=8vWmE0sPx5mW45VnhxkEigxmOSJZRj9yWOEt+sYwPxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoNNQMnVGCDCPbkhRhsrtRndie8/MS4reIzHQIFnieP1DopVgmyCl3m1/OoGLHEqnAoQhFIEjCHu0lMMSVOgC28mxNrkJ2jrUIh9JrpwrLaDkRDlQeQgG3nGvDDHeBNKYhRZVDewYOSTbQrw5GD44UF2QRoIuIfOVdeLfcayqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gL3sa5/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D7DC4CEE7;
	Sun, 19 Oct 2025 12:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760875920;
	bh=8vWmE0sPx5mW45VnhxkEigxmOSJZRj9yWOEt+sYwPxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gL3sa5/c+20+urFNMo6uqS4zG494FcyAbqJs6n1tmVH+g3JWcRSS/jA/7dz+rc9Xd
	 UXfnylg7/tkhaXYfLcLpGW9MYIpGPJprV7Kw38uOaLIYDLBaBwFLPQzZPW5rXs9zr8
	 1s6BuCVosIGFqLNvL8KYJhzaEhex6/qazTVlRjgc=
Date: Sun, 19 Oct 2025 14:11:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: [PATCH 6.12 000/277] 6.12.54-rc1 review
Message-ID: <2025101931-frenzy-proponent-1df3@gregkh>
References: <20251017145147.138822285@linuxfoundation.org>
 <CA+G9fYs1jVE3OGhp5QMr=XZ0NzmCXV-izshW2scAtSy+v4T17g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs1jVE3OGhp5QMr=XZ0NzmCXV-izshW2scAtSy+v4T17g@mail.gmail.com>

On Sat, Oct 18, 2025 at 11:36:20AM +0530, Naresh Kamboju wrote:
> On Fri, 17 Oct 2025 at 20:45, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.12.54 release.
> > There are 277 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.54-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> The following kernel crash noticed on the stable-rc 6.12.54-rc1 while running
> LTP syscalls listmount04 test case.
> 
> This is a known regression on the Linux next and reported [1] and fixed [2].
> 
> This was caused by,
> listmount: don't call path_put() under namespace semaphore
> commit c1f86d0ac322c7e77f6f8dbd216c65d39358ffc0 upstream.
> 
> And there is a follow up patch to fix this.
> 
> mount: handle NULL values in mnt_ns_release()
> [ Upstream commit 6c7ca6a02f8f9549a438a08a23c6327580ecf3d6 ]
> 
> When calling in listmount() mnt_ns_release() may be passed a NULL
> pointer. Handle that case gracefully.
> 
> Christian Brauner <brauner@kernel.org>
> 
> First seen on 6.12.54-rc1
> Good: v6.12.53
> Bad: 6.12.54-rc1
> 
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> Test regression: 6.12.54-rc1 Internal error: Oops: mnt_ns_release
> __arm64_sys_listmount (fs/namespace.c:5526)
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thanks, I've queued that up now, it required some manual work which is
why it didn't make it originally to 6.12.y

thanks,

greg k-h

