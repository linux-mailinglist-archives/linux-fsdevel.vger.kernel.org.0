Return-Path: <linux-fsdevel+bounces-50306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD1AACAB6F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31883B85A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666921DED78;
	Mon,  2 Jun 2025 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SnuDzSsX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B71CDFD5
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748856767; cv=none; b=ZPJ8mgnySg3/jQKVzsVn+Z2JsZIayANv11Fc/GQVnqF/P82MS/iF0JcBnieAY0zTiHRJ1bv2UIjSq39ZpufTmMXBcVmLZx68Fis6HVz5X2sirVlScN5hKenLRSCnsGMDsl8Ky1MEogv2uHaWXDjEm6S9Ekyhl9djmEKIsoaSkig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748856767; c=relaxed/simple;
	bh=1X4L7u/3s7ZJTyFnSRfmV19dbdOdnbPxBE8rxS+z6HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE04tmxHSlcEKS+zf6o5ojR+skUflYyFFwKVZN3A05e9y7UuVubQW5V8KmndklK/4og5H7MtQmBRlSucOyZUa7n45S7/LYDlIPI2nDp1VAhBmxiQ2jEiu0T2yS4STtK2fy/76idnpgdvQB3fKG/nz+PcBmffYkEbLZnpyp112N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SnuDzSsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFEFC4CEEB;
	Mon,  2 Jun 2025 09:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748856767;
	bh=1X4L7u/3s7ZJTyFnSRfmV19dbdOdnbPxBE8rxS+z6HY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SnuDzSsXDF5lcPy7XXtUZhnS43moNRjo+Bi2x56NDJkDWHnGFLDdqg7ncrIywMhqP
	 OeUdJ9rsT580IdYA0a/FlHNIv2Yt6GJtADQypLqH6r7o3KEfnVshz30K651FWbbYXS
	 /exaRk+BvospWnmK6MbYwxKbY+cSYSBisKrHYiBo=
Date: Mon, 2 Jun 2025 11:32:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Luca Boccassi <bluca@debian.org>, stable@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: Please consider backporting coredump %F patch to stable kernels
Message-ID: <2025060211-egotistic-overnight-9d10@gregkh>
References: <CAMw=ZnT4KSk_+Z422mEZVzfAkTueKvzdw=r9ZB2JKg5-1t6BDw@mail.gmail.com>
 <20250602-vulkan-wandbild-fb6a495c3fc3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-vulkan-wandbild-fb6a495c3fc3@brauner>

On Mon, Jun 02, 2025 at 11:09:05AM +0200, Christian Brauner wrote:
> On Fri, May 30, 2025 at 10:44:16AM +0100, Luca Boccassi wrote:
> > Dear stable maintainer(s),
> > 
> > The following series was merged for 6.16:
> > 
> > https://lore.kernel.org/all/20250414-work-coredump-v2-0-685bf231f828@kernel.org/
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c57f07b235871c9e5bffaccd458dca2d9a62b164
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95c5f43181fe9c1b5e5a4bd3281c857a5259991f
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b5325b2a270fcaf7b2a9a0f23d422ca8a5a8bdea
> > 
> > This allows the userspace coredump handler to get a PIDFD referencing
> > the crashed process.
> > 
> > We have discovered that there are real world exploits that can be used
> > to trick coredump handling userspace software to act on foreign
> > processes due to PID reuse attacks:
> > 
> > https://security-tracker.debian.org/tracker/CVE-2025-4598
> > 
> > We have fixed the worst case scenario, but to really and
> > comprehensively fix the whole problem we need this new %F option. We
> > have backported the userspace side to the systemd stable branch. Would
> > it be possible to backport the above 3 patches to at least the 6.12
> > series, so that the next Debian stable can be fully covered? The first
> > two are small bug fixes so it would be good to have them, and the
> > third one is quite small and unless explicitly configured in the
> > core_pattern, it will be inert, so risk should be low.
> 
> I agree that we should try and backport this if Greg agrees we can do
> this. v6.15 will be easy to do. Further back might need some custom work
> though. Let's see what Greg thinks.

Yes, seems like a good thing to backport to at least 6.12.y if possible.

Is it just the above 3 commits?

thanks,

greg k-h

