Return-Path: <linux-fsdevel+bounces-63162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C85BB00ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 12:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EC71C0E99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 10:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EA62C08C0;
	Wed,  1 Oct 2025 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y7byy0Ki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477D9256C6C;
	Wed,  1 Oct 2025 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315817; cv=none; b=eaeEUNATZhhgGQSscVOMxNfDJSVMew0kIj8Zggy2x+QnNMC17lyfJSalh7W3E+wzFQEiTXZEkhXVOsLyzLuJqPsdp+Fv4fueVh6FoTOkrEEHsx7y4hK4RFIkw/u/bWzaVF1JkJrr+GgG8CqDtOM1s9K3YVqT9jg1/RJah4bL1s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315817; c=relaxed/simple;
	bh=hhvNi4BXC/oxjZ8wjfR0Blg8dvrF7jVgQ/eOAP7QG7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZmeiOv8Xt9gGDcq3Q5IswJmdt1xEAIba/EmD+wn2XKvwlCNah5TKwsglTO8BNI7TqTGiJ73dGo+SzN2gPgnm1XXdhUfwRteo+ZOj5CBivBg7GdkN3Ns29Ecjn2xvB5JxKiofHKJ1IX/YmU+eHWlWdEWX2PwcV/po/9+vluufPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y7byy0Ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42568C4CEF4;
	Wed,  1 Oct 2025 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759315816;
	bh=hhvNi4BXC/oxjZ8wjfR0Blg8dvrF7jVgQ/eOAP7QG7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y7byy0KiICFZvNXvebaDQaziQSJyHfBz2cSXui2H9SfN/RMOHb6jawoqmbmlZ8dMw
	 Xg6iLhKalepk7RnqKQSdEzAY6hb4h5eU7yQrpYpn+5ovyWukumSH583MqIaTsXoAcp
	 5gOTHzepVRolMSXymvlLTqasRtb4pvPcW5XKi3SY=
Date: Wed, 1 Oct 2025 12:50:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
	linux-block <linux-block@vger.kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: [PATCH 5.10 000/122] 5.10.245-rc1 review
Message-ID: <2025100105-strewn-waving-35de@gregkh>
References: <20250930143822.939301999@linuxfoundation.org>
 <CA+G9fYvhoeNWOsYMvWRh+BA5dKDkoSRRGBuw5aeFTRzR_ofCvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvhoeNWOsYMvWRh+BA5dKDkoSRRGBuw5aeFTRzR_ofCvg@mail.gmail.com>

On Wed, Oct 01, 2025 at 12:57:27AM +0530, Naresh Kamboju wrote:
> On Tue, 30 Sept 2025 at 20:24, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.10.245 release.
> > There are 122 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.245-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> The following LTP syscalls failed on stable-rc 5.10.
> Noticed on both 5.10.243-rc1 and 5.10.245-rc1
> 
> First seen on 5.10.243-rc1.
> 
>  ltp-syscalls
>   - fanotify13
>   - fanotify14
>   - fanotify15
>   - fanotify16
>   - fanotify21
>   - landlock04
>   - ioctl_ficlone02
> 
> Test regression: LTP syscalls fanotify13/14/15/16/21 TBROK: mkfs.vfat
> failed with exit code 1
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> We are investigating and running bisections.
> 
> ### Test log
> tst_test.c:1888: TINFO: === Testing on vfat ===
> tst_test.c:1217: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> mkfs.vfat: Partitions or virtual mappings on device '/dev/loop0', not
> making filesystem (use -I to override)
> tst_test.c:1217: TBROK: mkfs.vfat failed with exit code 1
> HINT: You _MAY_ be missing kernel fixes:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c285a2f01d69

You are not missing this "fix".

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bc2473c90fca

You are missing that one, but why is a overlayfs commit being cared
about for vfat?

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c45beebfde34a

Another overlayfs patch that is not backported that far.  Again, why is
this a hint for vfat?

thanks,

greg k-h

