Return-Path: <linux-fsdevel+bounces-25416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A73794BD8F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 14:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D541F222D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1776018CBFD;
	Thu,  8 Aug 2024 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0Am9fW9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680118CBE3;
	Thu,  8 Aug 2024 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120370; cv=none; b=ueMcEJq0nbnajun32CSwlXUQ+2ieTTJdyVeyOBTLdOiFUhd5D9NQ0g9mD55ex3jzuGSPukdWfeDUEa5wy6CBmEHdF72YAcUep7lAQ3DHu7R6ONZIc8aG0aY2cFEoVbi9ZcN0fgki3uPn8sgLiqENkoQ5ZHW8DYHskZ98vR9iqNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120370; c=relaxed/simple;
	bh=I1y7ApPC+6Lm0KO1l7URJvxaoS1M7Wfxhu5/fFgqq9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omaRWCDtf69h6U6EScegvF9XTDf4ib8JoZlEe46h4Pja1g3/JetQZL8kwo8yvoB0eVf79iKYRl3khgiHstoRG4qBX0/9yOVUOuom7Jbd8fV/xAh6PRKWxUM8FM1LJhTR0O0Hft4woZTSFEm1KYE5YfueiWdXAjIWAZxtyDDMWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0Am9fW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DD9C4AF1B;
	Thu,  8 Aug 2024 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723120369;
	bh=I1y7ApPC+6Lm0KO1l7URJvxaoS1M7Wfxhu5/fFgqq9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0Am9fW9KndUrYNnmwQ+jyH5ShhDnBrk0XSMzScqGKWBj0/AnJTiklKfrzjqU1vgT
	 ZcVsIVPT4rtL1luv+VtLxHKIim/nRxQ1f0KV3gmn1nADjztDBz8nw5zFoHCq8/Lc1e
	 vwb9mtbFcrY0frDdslNf5T56T/5Wg93kmt/xVEW/8izynsq0t8WRyKCmPGPwuYjgqK
	 wjHS3B022qXwepNy36bga1xjMX6KNqtjDf+cAfXZbGfuHC0YSyG8S3BTgoXc1N6NmA
	 bgyx+8D/+dctJ2XdmO/d5WfybJ5mp+kEC26Ebqjx28eYSf+I5pT5oOX9MQK0lYyn66
	 0VwsPvGgJ4uNw==
Date: Thu, 8 Aug 2024 14:32:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Morten Hein Tiljeset <morten@tiljeset.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Debugging stuck mount
Message-ID: <20240808-hangar-jobverlust-2235f6ef0ccb@brauner>
References: <22578d44-b822-40ff-87fb-e50b961fab15@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22578d44-b822-40ff-87fb-e50b961fab15@app.fastmail.com>

On Thu, Aug 08, 2024 at 11:40:07AM GMT, Morten Hein Tiljeset wrote:
> Hi folks,
> 
> I'm trying to debug an issue that occurs sporadically in production where the
> ext4 filesystem on a device, say dm-1, is never fully closed. This is visible
> from userspace only via the existence of /sys/fs/ext4/dm-1 which cryptsetup
> uses to determine that the device is still mounted.
> 
> My initial thought was that it was mounted in some mount namespace, but this is
> not the case. I've used a debugger (drgn) on /proc/kcore to find the
> superblock. I can see that this is kept alive by a single mount which looks
> like this (leaving out all fields that are NULL/empty lists):
> 
> *(struct mount *)0xffff888af92c5cc0 = {
> 	.mnt_parent = (struct mount *)0xffff888af92c5cc0,
> 	.mnt_mountpoint = (struct dentry *)0xffff888850331980,  // an application defined path
> 	.mnt = (struct vfsmount){
> 		.mnt_root = (struct dentry *)0xffff888850331980,    // note: same path as path as mnt_mountpoint
> 		.mnt_sb = (struct super_block *)0xffff88a89f7bc800, // points to the superblock I want cleaned up
> 		.mnt_flags = (int)134217760,                        // 0x8000020 = MNT_UMOUNT | MNT_RELATIME
> 		.mnt_userns = (struct user_namespace *)init_user_ns+0x0 = 0xffffffffb384b400,
> 	},
> 	.mnt_pcp = (struct mnt_pcp *)0x37dfbfa2c338,
> 	.mnt_instance = (struct list_head){
> 		.next = (struct list_head *)0xffff88a89f7bc8d0,
> 		.prev = (struct list_head *)0xffff88a89f7bc8d0,
> 	},
> 	.mnt_devname = (const char *)0xffff88a7d0fe7cc0 = "/dev/mapper/<my device>_crypt", // maps to /dev/dm-1
> 	.mnt_id = (int)3605,
> }

That's the root mount of the filesystem here.

> 
> In particular I notice that the mount namespace is NULL. As far as I understand
> the only way to get this state is through a lazy unmount (MNT_DETACH). I can at
> least manage to create a similar state by lazily unmounting but keeping the
> mount alive with a shell with CWD inside the mountpoint.
> 
> I've tried to search for the superblock pointer on cwd/root of all tasks, which
> works in my synthetic example but not for the real case. I've had similar
> results searching for the superblock pointer using drgn's fsrefs.py script[1]
> which has support for searching additional kernel data structures.

It's likely held alive by some random file descriptor someone has open.
IOW, try and walk all /proc/<pid>/fd/<nr> in that case and see whether
anything keeps it alive.

