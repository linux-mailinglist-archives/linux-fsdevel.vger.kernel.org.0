Return-Path: <linux-fsdevel+bounces-40767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73086A27475
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 15:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8833A3FA6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 14:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD102135CD;
	Tue,  4 Feb 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k1DAeIpH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBB72D057;
	Tue,  4 Feb 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738679651; cv=none; b=A91sw3ebmXYRxiqADQfR0ggZU2iwucd8zzMIo04cGdrOWj22+N4SrYlyzQDCrpSUgTWdiiW3BhQnYbANX/gwYtFrsQZXJY/2aaPf2DATdJpIN5USpjlwkY/ZaL2THU91wOVN+uRzNYrHsR4AtWXioE2iezKcZMOGI3ZhDCB9vw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738679651; c=relaxed/simple;
	bh=wX2ySe7VqWW1BjiCUKINCwvPd8y9tsH2Iy3KDfXkRMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3XG/Xam+SF4XOF7R748UgXEc/ZvT+SYTH0pKHZ3qcD+enWO7OoOm6kczA+lCUi6P1ataIrr5gJF0ECj6LLltuagPF8r51IDIpuAnifgCL7SaTuBS6rPs63P2k6C+tQcIRhQYm9jRli+GobYAAxIuhNcxJY8AQK7otYe48a3do8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k1DAeIpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493CDC4CEDF;
	Tue,  4 Feb 2025 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738679650;
	bh=wX2ySe7VqWW1BjiCUKINCwvPd8y9tsH2Iy3KDfXkRMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1DAeIpHtWYpVNE/6/wa1hMfVoF7A6ycd7BUlttN9+9CTEoF7vVMeUJm56LtTNL5F
	 ijmsiWSJS8wdtlIb1JDOhBCnrvzMIerUflFJ+0ui+Aaf5scN8CbcPl79aNxaG7HtqI
	 g1SuPxG17TDc2YnILminmaEivmjn495JOWu+t54Y=
Date: Tue, 4 Feb 2025 15:34:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pidfs: improve ioctl handling
Message-ID: <2025020455-gimmick-arose-806b@gregkh>
References: <20250204-work-pidfs-ioctl-v1-1-04987d239575@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-work-pidfs-ioctl-v1-1-04987d239575@kernel.org>

On Tue, Feb 04, 2025 at 02:51:20PM +0100, Christian Brauner wrote:
> Pidfs supports extensible and non-extensible ioctls. The extensible
> ioctls need to check for the ioctl number itself not just the ioctl
> command otherwise both backward- and forward compatibility are broken.
> 
> The pidfs ioctl handler also needs to look at the type of the ioctl
> command to guard against cases where "[...] a daemon receives some
> random file descriptor from a (potentially less privileged) client and
> expects the FD to be of some specific type, it might call ioctl() on
> this FD with some type-specific command and expect the call to fail if
> the FD is of the wrong type; but due to the missing type check, the
> kernel instead performs some action that userspace didn't expect."
> (cf. [1]]
> 
> Reported-by: Jann Horn <jannh@google.com>
> Cc: stable@vger.kernel.org # v6.13
> Fixes: https://lore.kernel.org/r/CAG48ez2K9A5GwtgqO31u9ZL292we8ZwAA=TJwwEv7wRuJ3j4Lw@mail.gmail.com [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Hey,
> 
> Jann reported that the pidfs extensible ioctl checking has two issues:
> 
> (1) We check for the ioctl command, not the number breaking forward and
>     backward compatibility.
> 
> (2) We don't verify the type encoded in the ioctl to guard against
>     ioctl number collisions.
> 
> This adresses both.
> 
> Greg, when this patch (or a version thereof) lands upstream then it
> needs to please be backported to v6.13 together with the already
> upstream commit 8ce352818820 ("pidfs: check for valid ioctl commands").

Will do, thanks for the heads up.

greg k-h

