Return-Path: <linux-fsdevel+bounces-53908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E15BAF8D07
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACBE564447
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F702F9490;
	Fri,  4 Jul 2025 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rN32kUOx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9B32DA768;
	Fri,  4 Jul 2025 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619066; cv=none; b=Pbf1AAstm/9zrkoF65UFA/qWrM1RMbVY64giINKtK/L3a6q9YxAZ/YpIDNz7Ygea/ym19rKQkYJTzvp8sXhu/h2vldKl/MaHZ9NxHaGzBwdhCax9FzFbJM/Or4n5fI3r3WGrGBOZj+UXgH0s+rzNgBw2mKGgUViE1GTTg5Wj4zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619066; c=relaxed/simple;
	bh=ydtoXrJjzWMNOe7CASykZsEGtmXlW0qfw12bl9BgrhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWgHmhSN6h4GRmG3K9xzvG0sjBq82TKYtJn0PTDkPmhkO5jEN/EImG2XA2uJTd46WtBK0WLpHUYRaryDYMiqxFCKBa/1rV8pUPP+5efvjfQN6eD6OGYzeimEqyy30KDmvF+tLvCJRg+u1Jv9uMVFRe2BJ/Yrw6+wa4/PHm/6YW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rN32kUOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD22C4CEE3;
	Fri,  4 Jul 2025 08:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751619065;
	bh=ydtoXrJjzWMNOe7CASykZsEGtmXlW0qfw12bl9BgrhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rN32kUOxysMqw9+APEHNh10GoLCRYJ0RB1BipeBb5johlpCARjP03yBUeHA+WSwOj
	 m5gYnYAewIPwON2yP+wCiI9FjPp8S+5e4L45cVB1yGZiJzPAFq1hZNb27QE75UvAvk
	 9tS7cmcpq3l/FG/mw5I4BLJN89Nwy1nf74olkvzu5vf6bjS6aep8m8PxG7PwsHsVh8
	 YXif2ASeAEDqOAFzGBJmoT6yiicp+KndSbMbB6IZ01qAfUOBqaDn/Le/c9UqPyPqpS
	 6WTYC4wNbbVNGuj3lxDteyVcbfn1qwTVBjkpzMTTia1bOkGE0mbetALJn+4ZruW2DV
	 MLep26v1TVOHQ==
Date: Fri, 4 Jul 2025 10:51:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Laura Brehm <laurajfbrehm@gmail.com>
Cc: linux-kernel@vger.kernel.org, Laura Brehm <laurabrehm@hey.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] coredump: fix race condition between connect and
 putting pidfs dentry
Message-ID: <20250704-ernten-fehlschlag-05a175183e12@brauner>
References: <20250703120244.96908-1-laurabrehm@hey.com>
 <20250703120244.96908-2-laurabrehm@hey.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250703120244.96908-2-laurabrehm@hey.com>

On Thu, Jul 03, 2025 at 02:02:43PM +0200, Laura Brehm wrote:
> In Commit 1d8db6fd698de1f73b1a7d72aea578fdd18d9a87 ("pidfs, coredump:
> add PIDFD_INFO_COREDUMP"), the coredump handling logic puts the pidfs
> entry right after `connect`, and states:
> 
>     Make sure to only put our reference after connect() took
>     its own reference keeping the pidfs entry alive ...
> 
> However, `connect` does not seem to take a reference to the pidfs
> entry, just the pid struct (please correct me if I'm wrong here).

kernel_connect()
-> sock->ops->connect::unix_stream_connect()
   -> prepare_peercred()
      -> pidfs_register_pid()

> Since the expectation is that the coredump server makes a
> PIDFD_GET_INFO ioctl to get the coredump info - see Commit
> a3b4ca60f93ff3e8b41fffbf63bb02ef3b169c5e ("coredump: add coredump
> socket"):
> 
>     The pidfd for the crashing task will contain information how the
>     task coredumps. The PIDFD_GET_INFO ioctl gained a new flag
>     PIDFD_INFO_COREDUMP which can be used to retreive the coredump
>     information.
> 
>     If the coredump gets a new coredump client connection the kernel
>     guarantees that PIDFD_INFO_COREDUMP information is available.
> 
> This seems to result in the coredump server racing with the kernel to
> get the pidfd before the kernel puts the pidfs entry, and if it loses
> it won't be able to retrieve the coredump information.

Honestly curious: is that something you actually observed or that you
think may happen or that an some coding assistant thinks might happen?

