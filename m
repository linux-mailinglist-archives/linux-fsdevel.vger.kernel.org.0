Return-Path: <linux-fsdevel+bounces-42710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3216A466C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 17:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA01189D5C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544AA22069A;
	Wed, 26 Feb 2025 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M1xt+NJN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCCF21D599;
	Wed, 26 Feb 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586941; cv=none; b=SGzukg3Fc2Z3mmNolKuOpX+c4qWy5ohyRKCpTBjN95+ZultHg3tuJRw109Fp0l5lbYbpUjhFFnMRcRfd2ZDZ6vdECuIBBg5Nd8OuClBkQnbLSSzCZ9zzE/sd14g14supLooxEC4Si9AXhOhknsZ1PmqRnsTNO6AF98Ec/ivdEfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586941; c=relaxed/simple;
	bh=B6gilIoT9xVhIvC8ttWtPnP8FX+S+KHLrI0g12qku6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MT/iUzGUJ1d8w0bPMiHUVSoaBgjBOS8DwuIX6tYLGDIkt1xOhdywjjhQ9musn/h6aCPl5ihPslWm3roP6BJdfZ/Qw937tU0x1CydB8jjBjd7isYO4SLHNl1auWVt7qVQJQE1VXsBRQyIbGzI1pjzAdmzCsVh204wU44272lw6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M1xt+NJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070CBC4CED6;
	Wed, 26 Feb 2025 16:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740586941;
	bh=B6gilIoT9xVhIvC8ttWtPnP8FX+S+KHLrI0g12qku6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1xt+NJNubDw/FVWW03y2hZo95XeaMnSfkallJlteDpim69mLMA5Dz6XUasAMyoD3
	 snizzYgpU7jeqVI+nVWc91zdS/VCNUetVOxr4qTvEZu1QRdTHCWPHsNWYMzRrHBm6P
	 E1hhRykvgXxk3smn/L4l361/ikefDZkDJPqX3IrQ=
Date: Wed, 26 Feb 2025 08:21:11 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
Message-ID: <2025022621-worshiper-turtle-6eb1@gregkh>
References: <2025022644-blinked-broadness-c810@gregkh>
 <a7fe0eda-78e4-43bb-822b-c1dfa65ba4dd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7fe0eda-78e4-43bb-822b-c1dfa65ba4dd@oracle.com>

On Wed, Feb 26, 2025 at 10:57:48AM -0500, Chuck Lever wrote:
> On 2/26/25 9:29 AM, Greg Kroah-Hartman wrote:
> > This reverts commit b9b588f22a0c049a14885399e27625635ae6ef91.
> > 
> > There are reports of this commit breaking Chrome's rendering mode.  As
> > no one seems to want to do a root-cause, let's just revert it for now as
> > it is affecting people using the latest release as well as the stable
> > kernels that it has been backported to.
> 
> NACK. This re-introduces a CVE.

As I said elsewhere, when a commit that is assigned a CVE is reverted,
then the CVE gets revoked.  But I don't see this commit being assigned
to a CVE, so what CVE specifically are you referring to?

thanks,

greg k-h

