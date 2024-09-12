Return-Path: <linux-fsdevel+bounces-29163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2E976931
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 14:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6C91C21A33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B402C1A4F25;
	Thu, 12 Sep 2024 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S17ZxcQW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95F1A0BC5;
	Thu, 12 Sep 2024 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726144274; cv=none; b=El4+8s/7g+deTuz5fi3ZajIVipUTaO0GmGlcQdP/uc/nx8FbKW065nlI7wUxiv4SP1tzfzx5PjHOBjXsSuT0/RhzhjSowGks8DZkd5rBJH0vMJwLo+dSZucfgKH60bXV+zIoGIeOQ/L6uQ+l1qWEwilcNSGP7N7Nlco0UdFcloU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726144274; c=relaxed/simple;
	bh=RG4/DO14+83EnTRa5Tu7bJ6oLvaUL6eO3E3nASHcqFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2W/5ro8Vk0LhLmCJV+Y0CT9s22mUwcJKhRh25XL6n/DGxVmhnwjLvzSa8h1WgAfnXayfFJ6LYxKEb/XIuxzLT/Iay9njDyo0UK9hME9E4JBf0lByD/iMRTQ8oCWo3JJC4M+etnrQNjbE++mSps5nZRdR1mbkGjEXHk4sEmJGNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S17ZxcQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D59EC4CECC;
	Thu, 12 Sep 2024 12:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726144273;
	bh=RG4/DO14+83EnTRa5Tu7bJ6oLvaUL6eO3E3nASHcqFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S17ZxcQWE5NclQFsT5wCfebdYxKFa2AIyKBLxkn3hZ9OQAKeMd6f3cx4kPHHjGOfZ
	 8jj2jHRbjg4ehYedJTVGNha/7CKUa3RMex2SgkKnR9pA2Emg36LPHRfGPWF4LSGTF0
	 vOxWj1BrJufOn1lTAwT0eabwlKg488bM4XacHTzqmWbnCzcnsY0VAjiZRHQNWuBuPp
	 R5pcgRZfUkHedmB8qMJ6UJIgY/hRnxunjgEVbbfBRnPnbuXU4iusoZWDp0g7M6MKst
	 70p1Barw99woO1TUq+8s1w5JtfXnkkrjkbptPEWvOR3Y/gkrFSWR9EtgQhqD5hngaZ
	 OOuE6GZGB2zhQ==
Date: Thu, 12 Sep 2024 14:31:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] timekeeping: move multigrain ctime floor handling into
 timekeeper
Message-ID: <20240912-korallen-rasant-d612bd138207@brauner>
References: <20240911-mgtime-v1-1-e4aedf1d0d15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911-mgtime-v1-1-e4aedf1d0d15@kernel.org>

On Wed, Sep 11, 2024 at 08:56:56AM GMT, Jeff Layton wrote:
> The kernel test robot reported a performance regression in some
> will-it-scale tests due to the multigrain timestamp patches. The data
> showed that coarse_ctime() was slowing down current_time(), which is
> called frequently in the I/O path.
> 
> Add ktime_get_coarse_real_ts64_with_floor(), which returns either the
> coarse time or the floor as a realtime value. This avoids some of the
> conversion overhead of coarse_ctime(), and recovers some of the
> performance in these tests.
> 
> The will-it-scale pipe1_threads microbenchmark shows these averages on
> my test rig:
> 
> 	v6.11-rc7:			83830660 (baseline)
> 	v6.11-rc7 + mgtime series:	77631748 (93% of baseline)
> 	v6.11-rc7 + mgtime + this:	81620228 (97% of baseline)
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409091303.31b2b713-oliver.sang@intel.com
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Arnd suggested moving this into the timekeeper when reviewing an earlier
> version of this series, and that turns out to be better for performance.
> 
> I'm not sure how this should go in (if acceptable). The multigrain
> timestamp patches that this would affect are in Christian's tree, so
> that may be best if the timekeeper maintainers are OK with this
> approach.

We will need this as otherwise we can't really merge the multigrain
timestamp work with known performance regressions?

