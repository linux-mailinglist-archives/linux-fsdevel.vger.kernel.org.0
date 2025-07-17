Return-Path: <linux-fsdevel+bounces-55234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65451B08976
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95784A410B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB89B28A414;
	Thu, 17 Jul 2025 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q805g09k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50100635;
	Thu, 17 Jul 2025 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745146; cv=none; b=ipm+M3xjbrpdn5yPYPAOasIvE+utTaD3VNIsgtCvw0qyQu6shMyKgcIB9zU0qdzxqnernlhv2Y3t2sM9z3Fp7+mVfS8eyPvYRImLZNvau/loY8PxoFsgmiwaXTqSNthOFjgAdjt06BjzVezI8VGWEgslk3KQuKdB6KsVJKx2OLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745146; c=relaxed/simple;
	bh=9uI15GL8gVspXEZVKQI3SAdKV/w7tSf4KXFJRdUExB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDvgp007qGVluHqylIoFYAt5dz5oTA8Vr/Pzno+Rb3Lccz10q5H8Q9P8F9p0FLb129aKmSCHU8hiGUNirWHEvpUAxtKMI4hCVygW2vEhMQcA29oDYdy5f3oJX9QH+Jk0R53sGxZMwCV55KqiaGWsI+6IlnnO32ulw8rsndCucsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q805g09k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FE7C4CEE3;
	Thu, 17 Jul 2025 09:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752745145;
	bh=9uI15GL8gVspXEZVKQI3SAdKV/w7tSf4KXFJRdUExB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q805g09kb9jP5uXTxCqyKS/f50AQe3cWZA1S2mUjHl8AnLP2gxEXNCbZjqv6avCzx
	 sV7FfjoN8JQP5zmULyfSCqGcR8iafgZqaZSwrPV8B1yCay67tKR53bG6kckj53Be/y
	 m3SuUmZjfmd/3/FK0YtQxIroEGpqVuFpUDKtTGJWHhteBBBWQ7IX1mZIh72+grqpqA
	 3+FeW597Ckg26RxFq7d/C/jj1xpMBrNuU0waRQhPduZYR3x/YM/8J3irbdpjSMLUQk
	 RbE/HQ0Ru/nNTe7T7i2ISgMSOMflhRoxzVUuzx3c/EdhIk4lZQXbiW7nCqKjf1ecdC
	 26hzgwHEwpLww==
Date: Thu, 17 Jul 2025 11:39:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Zizhi Wo <wozizhi@huawei.com>, hch@lst.de
Cc: jack@suse.com, axboe@kernel.dk, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [bug report] A filesystem abnormal mount issue
Message-ID: <20250717-friseur-aufrollen-60e89dbd9c89@brauner>
References: <20250717091150.2156842-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717091150.2156842-1-wozizhi@huawei.com>

On Thu, Jul 17, 2025 at 05:11:50PM +0800, Zizhi Wo wrote:
> Currently, we have the following test scenario:
> 
> disk_container=$(
>     ${docker} run...kata-runtime...io.kubernets.docker.type=container...
> )
> docker_id=$(
>     ${docker} run...kata-runtime...io.kubernets.docker.type=container...
>     io.katacontainers.disk_share="{"src":"/dev/sdb","dest":"/dev/test"}"...
> )
> 
> ${docker} stop "$disk_container"
> ${docker} exec "$docker_id" mount /dev/test /tmp -->success!!
> 
> When the "disk_container" is started, a series of block devices are
> created. During the startup of "docker_id", /dev/test is created using
> mknod. After "disk_container" is stopped, the created sda/sdb/sdc disks
> are deleted, but mounting /dev/test still succeeds.
> 
> The reason is that runc calls unshare, which triggers clone_mnt(),
> increasing the "sb->s_active" reference count. As long as the "docker_id"
> does not exit, the superblock still has a reference count.
> 
> So when mounting, the old superblock is reused in sget_fc(), and the mount
> succeeds, even if the actual device no longer exists. The whole process can
> be simplified as follows:
> 
> mkfs.ext4 -F /dev/sdb
> mount /dev/sdb /mnt
> mknod /dev/test b 8 16    # [sdb 8:16]
> echo 1 > /sys/block/sdb/device/delete
> mount /dev/test /mnt1    # -> mount success
> 
> The overall change was introduced by: aca740cecbe5 ("fs: open block device
> after superblock creation"). Previously, we would open the block device
> once. Now, if the old superblock can be reused, the block device won't be
> opened again.
> 
> Would it be possible to additionally open the block device in read-only
> mode in super_s_dev_test() for verification? Or is there any better way to
> avoid this issue?

As long as you use the new mount api you should pass
FSCONFIG_CMD_CREATE_EXCL which will refuse to mount if a superblock for
the device already exists. IOW, it ensure that you cannot silently reuse
a superblock.

Other than that I think a blkdev_get_no_open(dev, false) after
lookup_bdev() should sort the issue out. Christoph?

