Return-Path: <linux-fsdevel+bounces-46629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E35A9218D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 17:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776F116E82E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE47253F19;
	Thu, 17 Apr 2025 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxOptT3J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE73D253334;
	Thu, 17 Apr 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903707; cv=none; b=pgC1lfPv9yfe7sEy9EEl8R+MJrwpIGVTvwk6kBUxA6IkM2rPaYXPqthUX9f2+Rahx6AlF9CsQIoWnYtXqd7j5GiZGuYlnsrF+qvZUab9UjrnEHazTuZISzH9dU0gIrOEIeKDpsjAfGiqxFpU272RNqW+4lqE9L6TUbX3wXHAzWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903707; c=relaxed/simple;
	bh=xYq4gS9KGYhGn/zZP2bXarGqZJ3HdTPqu6OCZS2CE7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOT/ixfwIP5jLzEyI00GmyjKj/6dp5XCmUkON+Pykn6lS4xO9kgDhmpbrwpoR44Za2Ggyw6avimLRtJC0c2c6MpkCeOE42H+fUNQQkPCu7zJxxOsbZ0MiG56BoVGeKXs2mZJyM2ZzZd5WgHOEISAZqDCVYUaNjo82cD2laUiZZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxOptT3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8B6C4CEE4;
	Thu, 17 Apr 2025 15:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744903706;
	bh=xYq4gS9KGYhGn/zZP2bXarGqZJ3HdTPqu6OCZS2CE7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxOptT3JTq7VXqFRLgQVhdOc66VeKs/yVqwYTzY9WFWW5KnEAy7KxqSC9CS/rPEMe
	 E+ZdWwX8YgxY8l7ujCBaxr8hpDUoacLx73L7SWwmXhCs7Znrg4CGlc9cFdd1rDJNpW
	 1M8dk684aS4KMr/JGOH2gdQJpqZ57Jnglom1wTiIvA/tkMeTnoUF2XRNRGfKlfmQz+
	 qDcm5vZyfWjwjqdmB0LQPC0t/FeJi7KGVpvpixcPATLgU33tQMBYU8CvMrrKCHfLMp
	 QnLr3xO9UEm6bHpMLTvwnj+XvGw2Eq6sLtd5Vr1m3io1wT5yu0pMLbKg7CjvrYQHZU
	 zKrNeT+T2vBIA==
Date: Thu, 17 Apr 2025 17:28:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Mark Brown <broonie@kernel.org>, Eric Chanudet <echanude@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250417-zappeln-angesagt-f172a71839d3@brauner>
References: <20250408210350.749901-12-echanude@redhat.com>
 <fbbafa84-f86c-4ea4-8f41-e5ebb51173ed@sirena.org.uk>
 <20250417-wolfsrudel-zubewegt-10514f07d837@brauner>
 <fb566638-a739-41dc-bafc-aa8c74496fa4@themaw.net>
 <20250417-abartig-abfuhr-40e558b85f97@brauner>
 <20250417-outen-dreihundert-7a772f78f685@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250417-outen-dreihundert-7a772f78f685@brauner>

>     So if there's some userspace process with a broken NFS server and it
>     does umount(MNT_DETACH) it will end up hanging every other
>     umount(MNT_DETACH) on the system because the dealyed_mntput_work
>     workqueue (to my understanding) cannot make progress.

Ok, "to my understanding" has been updated after going back and reading
the delayed work code. Luckily it's not as bad as I thought it is
because it's queued on system_wq which is multi-threaded so it's at
least not causing everyone with MNT_DETACH to get stuck. I'm still
skeptical how safe this all is. 

