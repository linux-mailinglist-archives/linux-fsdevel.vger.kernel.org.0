Return-Path: <linux-fsdevel+bounces-33569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF9C9BA25E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 21:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE585B21A47
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 20:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535B31ABEA0;
	Sat,  2 Nov 2024 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmSPfQO0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A882D13BAF1;
	Sat,  2 Nov 2024 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577910; cv=none; b=uje+a6pORoTXgSIKnQGlUvX1G2p0Wzlv2m++O1BoCdKsEoOnIaHARV5g8ln4E6xPKvU0COBUYQrOCcU32zsjGNEEWFMlVEBHCOMn7BC525jr5PVajhgWGl7KlfAwFDnH3V/kUL4PDiZsw6GOvsXaZk/o7c+OIJs5VEImbE4cUQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577910; c=relaxed/simple;
	bh=og5/86guEHpjoFP2YlMCVaTKnP4xAWzMQlf3A7a6Eh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltyDy4ywd78bBhFlAF9MOqKGQ5a7DDCYmOipWZXRZpIovhpdt4S7EmTMIzw5Fu2O0c6nNvfY776LNxOeMIE7ObJEDlEd4AQksOuJcRK6KG/wgvOqy29V4xvmyaami001dxXRtIkW2tOsRCvUozyNtn7DEa73JHpt0/y48qC5nlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmSPfQO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C267C4CEC3;
	Sat,  2 Nov 2024 20:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730577909;
	bh=og5/86guEHpjoFP2YlMCVaTKnP4xAWzMQlf3A7a6Eh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gmSPfQO0EnQiXyPxCzWf85/qh/j4fXOnbVG9PJS6Q70+5R/nwUA9NnByvjVCjVv2c
	 s6uLYR+7f6FUoERsA+YmpJ5qcmMNf+WUiF/8z+iuuHky99enZ7zFIreeQeAIA2yzTn
	 opKFirQHCJnpEOu/6mBb5oN8NROhG5ZBHkCWUZic1QXnIQLKs3cuXM0C3MU+rFx3S8
	 uHjwNDC+uSi7TqqizPpTaHyaUhnhbN2w9ln7Odjd1lpu8z49Y1C1QoJ+mXH8UtD2vQ
	 Wzn7vCnh/+ztxfpVCq7uSQlj2ti58EizeVcFSIChP69d4mtB58Y0etWuchXlWsqsuj
	 X3KdKFvHcN02w==
Date: Sat, 2 Nov 2024 13:05:06 -0700
From: Kees Cook <kees@kernel.org>
To: nir@lichtman.org
Cc: ebiederm@xmission.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: move warning of null argv to be next to the
 relevant code
Message-ID: <202411021304.1B1E0DBD@keescook>
References: <ZyYUgiPc8A8i_3FH@nirs-laptop.>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyYUgiPc8A8i_3FH@nirs-laptop.>

On Sat, Nov 02, 2024 at 02:01:22PM +0200, nir@lichtman.org wrote:
> Problem: The warning is currently printed where it is detected that the
> arg count is zero but the action is only taken place later in the flow
> even though the warning is written as if the action is taken place in
> the time of print
> 
> This could be problematic since there could be a failure between the
> print and the code that takes action which would deem this warning
> misleading
> 
> Solution: Move the warning print after the action of adding an empty
> string as the first argument is successful
> 
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> ---
> 
> Side note: I have noticed that currently the warn once variant is used
> for reporting this problem, which I guess is to reduce clutter that
> could go to dmesg, but wouldn't it be better to have this call the
> regular warn instead to better aid catching this type of bug?

We try to avoid having trivial ways to allow userspace to spam the
kernel dmesg log, so pr_warn_once() tends to be sufficient to catch this
relatively unlikely case.

-- 
Kees Cook

