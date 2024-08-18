Return-Path: <linux-fsdevel+bounces-26203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2A1955AB4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2024 05:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAD71C20A83
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2024 03:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D231944F;
	Sun, 18 Aug 2024 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFOwn/7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7AC748D;
	Sun, 18 Aug 2024 03:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723953501; cv=none; b=s74+3dm0308wQHhaBRL92O/QxBFEBcMPzIELEmM063QBaES+TdGzZoOEi+Ei7tcfn46VGTqeP5qQTLc7Jvyte5gXJCYGbC/sDwhtbHXVhHf17J97fOT2HElA/NWicdGebcRWffcEZGa5EQMxu3nWdnTpPp8qN3dQn2nvNXwC+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723953501; c=relaxed/simple;
	bh=L9oJBUC516q+ejSs4MQDSm90WpWXosKx1wQ5yOBnEq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj/TTaK6olpE0p9RY3SpvVVu5eqe6j0BozpnQv4YQRVn6hVBfLxBHtif9xo9YQyivec3UEB03PMBXgioE2w7RmoHQOcIh6HFp5WAaugUXEXdyTJWDgLRvke2Neie2zu/5r0BiBOSGM2LZTV8nOihkG34OVQ3O0UkuesI7t0of8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFOwn/7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356DBC32786;
	Sun, 18 Aug 2024 03:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723953500;
	bh=L9oJBUC516q+ejSs4MQDSm90WpWXosKx1wQ5yOBnEq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFOwn/7c2x2YWhkYlDvtta1Rcl8axckpl3SGPQQ9X4KZzjL5hdaEr3T2j7OJP1Rc7
	 Ubcq8Vz/6dXUGmeHw8e6DDcU1S+XXVdpV4+TF8xEnhxBSX+kWobJs71VwYG7z3kNwc
	 egQaStHzciEZY+g0Rv03F8HHpLOy1VRJ3bYi1HBCphKNaiRKwHlNxu4ADg6yP01wWh
	 qbqfTu3p/YDqzmD0IrkDfjm/3fwGzOikPY/djYZbN8wINfE4SZA80sq9dek92sbtcY
	 fzRnaNuSVpoc3eixOVSWJc9IM+E2ts8thyKDNs8JEBzeCKwq+2+eh1VgF6K3V+aV6s
	 ZbKFm7jXUfzVQ==
Date: Sat, 17 Aug 2024 20:58:18 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>, Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] pidfd: prevent creation of pidfds for kthreads
Message-ID: <20240818035818.GA1929@sol.localdomain>
References: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>

Hi Christian,

On Wed, Jul 31, 2024 at 12:01:12PM +0200, Christian Brauner wrote:
> It's currently possible to create pidfds for kthreads but it is unclear
> what that is supposed to mean. Until we have use-cases for it and we
> figured out what behavior we want block the creation of pidfds for
> kthreads.
> 
> Fixes: 32fcb426ec00 ("pid: add pidfd_open()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  kernel/fork.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)

Unfortunately this commit broke systemd-shutdown's ability to kill processes,
which makes some filesystems no longer get unmounted at shutdown.

It looks like systemd-shutdown relies on being able to create a pidfd for any
process listed in /proc (even a kthread), and if it gets EINVAL it treats it a
fatal error and stops looking for more processes...

This is what shows up in the system log:

    systemd[1]: Shutting down.
    systemd-shutdown[1]: Syncing filesystems and block devices.
    systemd-shutdown[1]: Sending SIGTERM to remaining processes...
    systemd-shutdown[1]: Failed to enumerate /proc/: Invalid argument
    systemd-shutdown[1]: Sending SIGKILL to remaining processes...
    systemd-shutdown[1]: Failed to enumerate /proc/: Invalid argument
    systemd-shutdown[1]: Unmounting file systems.
    (sd-umount)[17359]: Unmounting '/run/credentials/systemd-vconsole-setup.service'.
    (sd-umount)[17360]: Unmounting '/run/credentials/systemd-journald.service'.
    (sd-remount)[17361]: Remounting '/' read-only with options ''.
    (sd-remount)[17361]: Failed to remount '/' read-only: Device or resource busy
    (sd-remount)[17362]: Remounting '/' read-only with options ''.
    (sd-remount)[17362]: Failed to remount '/' read-only: Device or resource busy
    systemd-shutdown[1]: Not all file systems unmounted, 1 left.

- Eric

