Return-Path: <linux-fsdevel+bounces-43849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B75DDA5E7B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 23:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E622E7AB209
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF1D1F12F2;
	Wed, 12 Mar 2025 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oas0inYH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E931D5CC6;
	Wed, 12 Mar 2025 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820124; cv=none; b=CvsiuDj5T+9rxxaE7RI05gBJuKX8VaX52cHLFQUO5iYVdWW1V8ppFlXk09W2zLOhPZW7fz/5ztgZIT924mucdduWE3zTFOvvlcHLjVE7c73qzuBzK7Gfrl8kb94wHjB8rxTyUHz+PyYp8Bjp/z1lWbWvFQLA/w8S7Q3Wh4u7Vg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820124; c=relaxed/simple;
	bh=5vlsMdt2TygEzISoWcSompquV4QZk86+b8voRCk7dmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xhdr0TOtdVy66U+80BBhvj1DAvR5wEiUKevJhG2fXlAJtvTg+KZujCfDHTeapr0uFnnvYpyeCYquUg81mPdyXD0eF9Ak5vcPP9RA+bFxqh9H5mclwrgP4yGua+ac/V4OoLQ3DuhKo7SFRE4zBITzthVxM7b02rw8xhdYO6L9t6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oas0inYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB685C4CEDD;
	Wed, 12 Mar 2025 22:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741820123;
	bh=5vlsMdt2TygEzISoWcSompquV4QZk86+b8voRCk7dmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oas0inYHVCnWLg7xAvyeRWsOR5CRk1fxMxNIag5HJhM3WhEWRGOScFsCsk1YzyEnA
	 SPZMTT76hm7TvfC7yErJQFZZkeTuhxkLMPGJsZymkKdkDq67Ug64pIDCih4inhUTuA
	 dYwMzKgL61biV/ppDhJbIL6xc+jGSNiR69W67V/zSB09o5Oaix5rJAEKs2DkxepaHb
	 Zri4LtCKwj1TrLnxEZP1m6SJ8cyeu3OS+yMWZcKVyzRuh4Slc2MONSVF/G5mAYb8Rc
	 j8YVJYB781m3wEVV22Ty/qMVNcoU93JQZqpx0mKo++vpW7l+20J6ZjoMb+dfGMSDYY
	 41VpWgs0K9ZWA==
Date: Wed, 12 Mar 2025 15:55:22 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Ruiwu Chen <rwchen404@gmail.com>, corbet@lwn.net, keescook@chromium.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	zachwade.k@gmail.com
Subject: Re: [PATCH v2] drop_caches: re-enable message after disabling
Message-ID: <Z9IQ2jam9hkXnPhg@bombadil.infradead.org>
References: <Z7tZTCsQop1Oxk_O@bombadil.infradead.org>
 <20250308080549.14464-1-rwchen404@gmail.com>
 <zaiqpjvkekhgipcs7smqhbb7hqt5dcneyoyndycofjepitxznf@q22hsykugpme>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zaiqpjvkekhgipcs7smqhbb7hqt5dcneyoyndycofjepitxznf@q22hsykugpme>

On Mon, Mar 10, 2025 at 02:51:11PM +0100, Joel Granados wrote:
> On Sat, Mar 08, 2025 at 04:05:49PM +0800, Ruiwu Chen wrote:
> > >> When 'echo 4 > /proc/sys/vm/drop_caches' the message is disabled,
> > >> but there is no interface to enable the message, only by restarting
> > >> the way, so add the 'echo 0 > /proc/sys/vm/drop_caches' way to
> > >> enabled the message again.
> > >> 
> > >> Signed-off-by: Ruiwu Chen <rwchen404@gmail.com>
> > >
> > > You are overcomplicating things, if you just want to re-enable messages
> > > you can just use:
> > >
> > > -		stfu |= sysctl_drop_caches & 4;
> > > +		stfu = sysctl_drop_caches & 4;
> > >
> > > The bool is there as 4 is intended as a bit flag, you can can figure
> > > out what values you want and just append 4 to it to get the expected
> > > result.
> > >
> > >  Luis
> > 
> > Is that what you mean ?
> > 
> > -               stfu |= sysctl_drop_caches & 4;
> > +               stfu ^= sysctl_drop_caches & 4;
> > 
> > 'echo 4 > /sys/kernel/vm/drop_caches' can disable or open messages,
> > This is what I originally thought, but there is uncertainty that when different operators execute the command,
> > It is not possible to determine whether this time is enabled or turned on unless you operate it twice.
> 
> So can you use ^= or not?

No,  ^= does not work, see a boolean truth table.

> And what does operate it twice mean?

I think the reporter meant an "sysadmin", say two folks admining a system.
Since we this as a flag to enable disabling it easily we can just
always check for the flag as I suggested:

stfu = sysctl_drop_caches & 4

  Luis

