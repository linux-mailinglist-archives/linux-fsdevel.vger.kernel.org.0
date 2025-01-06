Return-Path: <linux-fsdevel+bounces-38446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ED3A02B29
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3938616581A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A318B46A;
	Mon,  6 Jan 2025 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PerTtid3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A014A617;
	Mon,  6 Jan 2025 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178032; cv=none; b=RYt4x0f0BSa6wKjTcQHGkoV39nVsIrehSvZW0xgbQ2zFVcG5GViBanpYGDgpUW4OlJvsOZY7A/uepDFWfdb0XQsi51uQ0OhEtb2+Pl+Yu4h8wSTo2WGWAONz19F5HrMz2OQMS7r3Y0uSg2wmQLoGkBLWrCoaV5HNwOKwuu9Bo20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178032; c=relaxed/simple;
	bh=jU0ucL6VEdkgd09RDvrMuXZW66i2YNt0mhd63oqPxLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPWAoyGgnmEYkras8jmEtd4uY+3gE1EVIxPx6Ki/XnyU+mdUHQJhm5AUSkYqui++XH0eRxTJwMHYTg6Q7GLAIDUZxBAyA3b4i4BU0RCaMF8ucKW6tRqhmDZo/wmJv/d3RNTbpIbvcL0LkQ06LZZTGXSw8gSPXBIw5/dknMmuBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PerTtid3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2924C4CED2;
	Mon,  6 Jan 2025 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178032;
	bh=jU0ucL6VEdkgd09RDvrMuXZW66i2YNt0mhd63oqPxLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PerTtid3hNXLOSCFjOxMVjuGPhFR8j1aszxJRFm0uPK8gdSUJCu4n5jNqOQNMQEoE
	 Kj6lybfWriIonrvd4omj/EWoUw6xFwZBFRMJ2/4kvonkHxcTF0RHPFlxiEVtLumK2R
	 jmMu6t4Ybjg0UoqGO41lj3RAOM35OOzUpMA0vlDk=
Date: Mon, 6 Jan 2025 16:39:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Kujau <lists@nerdbynature.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vbox: Enable VBOXGUEST and VBOXSF_FS on ARM64
Message-ID: <2025010630-enclose-reassign-3ac6@gregkh>
References: <7384d96c-2a77-39b0-2306-90129bae9342@nerdbynature.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7384d96c-2a77-39b0-2306-90129bae9342@nerdbynature.de>

On Mon, Jan 06, 2025 at 04:32:05PM +0100, Christian Kujau wrote:
> Now that VirtualBox is able to run as a host on arm64 (e.g. the Apple M3 
> processors) we can enable VBOXSF_FS (and in turn VBOXGUEST) for this 
> architecture. Tested with various runs of bonnie++ and dbench on an Apple 
> MacBook Pro with the latest Virtualbox 7.1.4 r165100 installed.
> 
> Signed-off-by: Christian Kujau <lists@nerdbynature.de>
> ---
>  drivers/virt/vboxguest/Kconfig | 2 +-
>  fs/vboxsf/Kconfig              | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virt/vboxguest/Kconfig b/drivers/virt/vboxguest/Kconfig
> index cc329887bfae..11b153e7454e 100644
> --- a/drivers/virt/vboxguest/Kconfig
> +++ b/drivers/virt/vboxguest/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config VBOXGUEST
>  	tristate "Virtual Box Guest integration support"
> -	depends on X86 && PCI && INPUT
> +	depends on (ARM64 || X86) && PCI && INPUT
>  	help
>  	  This is a driver for the Virtual Box Guest PCI device used in
>  	  Virtual Box virtual machines. Enabling this driver will add
> diff --git a/fs/vboxsf/Kconfig b/fs/vboxsf/Kconfig
> index b84586ae08b3..d4694026db8b 100644
> --- a/fs/vboxsf/Kconfig
> +++ b/fs/vboxsf/Kconfig
> @@ -1,6 +1,6 @@
>  config VBOXSF_FS
>  	tristate "VirtualBox guest shared folder (vboxsf) support"
> -	depends on X86 && VBOXGUEST
> +	depends on (ARM64 || X86) && VBOXGUEST
>  	select NLS
>  	help
>  	  VirtualBox hosts can share folders with guests, this driver
> 
> -- 
> BOFH excuse #76:
> 
> Unoptimized hard drive

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

