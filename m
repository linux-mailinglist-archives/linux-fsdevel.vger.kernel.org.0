Return-Path: <linux-fsdevel+bounces-67113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE9CC35888
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C7414F395B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A683126D6;
	Wed,  5 Nov 2025 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYchl2ma"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB4B311979;
	Wed,  5 Nov 2025 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343654; cv=none; b=CZcUDRPT/U5rvgVLa+VAsQgEXMD9bucMPyOLd9BcWaEHVdL34Mh4XpTZKuNcpECfqmLG7yshHaxJBRmViWxS3iI2YDE7Vy1/MLr9GTC2PZwbzgQyMxW7q1EiZcuGhINu62F7qnXWyb3QXmHzx/RY107TdqJLtP9+jGfkIBTf3SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343654; c=relaxed/simple;
	bh=1yCSTLyQx+/w/apujRIHLWAJtkx3xpqUhrl0FfmC5Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWThmP7o5JvRnY3pO7Iy58cev9scM6qEi9F8SK7gdHuD9p/uxi7yVk8btlfdeAXDeBsytbk4jRj845hldU00/aw13IIlb/rC9GfrBB+dvX8mKOTzgw1PRhr9sijIyTUhTGfurRzorS7YgoXtlPY9UanjSKWspdEO3+UM3jcm1uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYchl2ma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79463C4CEF8;
	Wed,  5 Nov 2025 11:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762343654;
	bh=1yCSTLyQx+/w/apujRIHLWAJtkx3xpqUhrl0FfmC5Ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYchl2mafXql+860MVERf3aaXVigRjjVwePJ5W1kHiibyeG8JNxBTi9+y3jrAAP8z
	 fGwcLTXnPr/yz0AzMVluwYln1marJaGIFUbOtRIvHfzEvRqWrpspd7gV2X8HZWJlu4
	 kd5idylxMemsMOKJwpNJA2zhdKiisGxgyL6Vp6mRHXd+18NS5HFQO9k3alZFIccKU/
	 8oZQICj2fJx0JiLVXanPB2VnGLpP8JtU/4PB6iQa+P5347D68/oU8P9XhMzp2kpbV6
	 F8GSxRkjHM65u2mnYuEnulVwvV/PpfnXb+UEB5qYMeSw+pi8RvDAuaAWSAsl4HPWOa
	 bTvG/2MoEcdKQ==
Date: Wed, 5 Nov 2025 12:54:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: GuangFei Luo <luogf2025@163.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mount: fix duplicate mounts using the new mount API
Message-ID: <20251105-abbaden-unmerklich-6682a021d5a8@brauner>
References: <20251025024934.1350492-1-luogf2025@163.com>
 <20251025033601.GJ2441659@ZenIV>
 <788d8763-0c2c-458a-9b0b-a5634e50c029@163.com>
 <20251031-gerufen-rotkohl-7d86b0c3dfe2@brauner>
 <20251031184822.GC2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031184822.GC2441659@ZenIV>

On Fri, Oct 31, 2025 at 06:48:22PM +0000, Al Viro wrote:
> On Fri, Oct 31, 2025 at 01:54:27PM +0100, Christian Brauner wrote:
> 
> > > > I agree that it's a regression in mount(8) conversion to new API, but this
> > > > is not a fix.
> > > Thanks for the review. Perhaps fixing this in |move_mount| isn't the best
> > > approach, and I don’t have a good solution yet.
> > 
> > Sorry, no. This restriction never made any sense in the old mount api
> > and it certainly has no place in the new mount api. And it has been
> > _years_ since the new mount api was released. Any fix is likely to break
> > someone else that's already relying on that working.
> 
> Not quite...  I agree that it makes little sense to do that on syscall level,
> but conversion of mount(8) to new API is a different story - that's more recent
> than the introduction of new API itself and it does create a regression on
> the userland side.
> 
> IIRC, the original rationale had been "what if somebody keeps clicking on
> something in some kind of filemangler inturdface and gets a pile of overmounts
> there?", but however weak that might be, it is an established behaviour of
> mount(2), with userland callers of mount(2) expecting that semantics.
> 
> Blind conversion to new API has changed userland behaviour.  I would argue
> that it's a problem on the userland side, and the only question kernel-side
> is whether there is something we could provide to simplify the life of those
> who do such userland conversions.  A move_mount(2) flag, perhaps, defaulting
> to what we have move_mount(2) do now?

Maybe a flag but even then. I'm pretty sure that mount can just use
statmount() to figure out that someone is trying to mount the same fs
twice and simply abort. That should be close enough...

