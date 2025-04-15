Return-Path: <linux-fsdevel+bounces-46517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD00A8AB4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 00:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C53441F35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 22:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D73D296D15;
	Tue, 15 Apr 2025 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4wyp2S0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8593161310;
	Tue, 15 Apr 2025 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744756499; cv=none; b=icVeHKPsVeHJuPmjD3FCs2AFBzuIsH5NyS+bBgkGDYIYbTpVL/eoFZtDLBi+u10MXxGtYxt2j3W/07lSKIW7zNd9Jr0toMMR1f93BkCeT4nwLe/hdSEZaPvWgqttlUb14LYT2HSxhlNBTlPmrwW6I6xWUyzmiWgUm4ZMevUErOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744756499; c=relaxed/simple;
	bh=VmIV3RHtlFUmpEdd8thZJkxy2MBdLnxOH3eQWaoWXyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVsbKRZOCMTzzVnvzE4ew+J13JHBQYrsXFEVO7Hy2rLua7gKbAdeTLSlZmvzvC2t79quuV1X9zDlL265/fM0KeYrkXv2dLB30ZhDM9fQJApcCGbl4m4QazEqmlYPc78cUDyLXnIN3MTlJ4z0aIpyyAHIjHas0rsUMhtTmeGcYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4wyp2S0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565EEC4CEE7;
	Tue, 15 Apr 2025 22:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744756499;
	bh=VmIV3RHtlFUmpEdd8thZJkxy2MBdLnxOH3eQWaoWXyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4wyp2S0/kMUxc+JX6/EpU/KSp7L7Em3MZfV40Tq9mKsGhbi26e59x9GuRaeIy3nP
	 pUlezhzTICb6Rw/AloJADQd/s9wIMkX3WLnuVv3+3zzhPFGS29mSJHHffPF+Zospfu
	 oP+YdKakT2uqx6T7wVgecA3JubIKVC6gQz3HSO1DyVb2fWvvse10NgGYIp3YbCWfIQ
	 e63n0gfeMpaZBBkA9vo6sE2EKiNmYk8slCFRbLq6sWPsEYp1TfoRlnb0OkOzmMTO/l
	 kOR4fR05Xcj66HxecqMmA1Ax5SojZFaCHhODMxZMK7rxzW3+uvUdQl1pEmVZ0pV3De
	 tCWWRUuLVvfWA==
Date: Tue, 15 Apr 2025 15:34:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org,
	Peter Ziljstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/2] pidfs: ensure consistent ENOENT/ESRCH reporting
Message-ID: <20250415223454.GA1852104@ax162>
References: <20250411-work-pidfs-enoent-v2-0-60b2d3bb545f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-work-pidfs-enoent-v2-0-60b2d3bb545f@kernel.org>

Hi Christian,

On Fri, Apr 11, 2025 at 03:22:43PM +0200, Christian Brauner wrote:
> In a prior patch series we tried to cleanly differentiate between:
> 
> (1) The task has already been reaped.
> (2) The caller requested a pidfd for a thread-group leader but the pid
> actually references a struct pid that isn't used as a thread-group
> leader.
> 
> as this was causing issues for non-threaded workloads.
> 
> But there's cases where the current simple logic is wrong. Specifically,
> if the pid was a leader pid and the check races with __unhash_process().
> Stabilize this by using the pidfd waitqueue lock.

After the recent work in vfs-6.16.pidfs (I tested at
a9d7de0f68b79e5e481967fc605698915a37ac13), I am seeing issues with using
'machinectl shell' to connect to a systemd-nspawn container on one of my
machines running Fedora 41 (the container is using Rawhide).

  $ machinectl shell -q nathan@$DEV_IMG $SHELL -l
  Failed to get shell PTY: Connection timed out

My initial bisect attempt landed on the merge of the first series
(1e940fff9437), which does not make much sense because 4fc3f73c16d was
allegedly good in my test, but I did not investigate that too hard since
I have lost enough time on this as it is heh. It never reproduces at
6.15-rc1 and it consistently reproduces at a9d7de0f68b so I figured I
would report it here since you mention this series is a fix for the
first one. If there is any other information I can provide or patches I
can test (either as fixes or for debugging), I am more than happy to do
so.

Cheers,
Nathan

