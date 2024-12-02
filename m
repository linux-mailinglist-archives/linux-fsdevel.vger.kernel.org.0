Return-Path: <linux-fsdevel+bounces-36234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F639E0289
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 13:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66962B271A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 11:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161D41FE45D;
	Mon,  2 Dec 2024 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcX3Bo4z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FCE17E
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140517; cv=none; b=M/6n5RT1yKQA3QZsJbC+Pdcl49TyPQvsrlw0UAA+kfR1N1UHxKEekiYyDN+e0rSHO246+MxcjwGAODAd/X4KpHqfUj7DA58UcN+hhU3xFyFm7QoNnaQW1f1CW95pqy5ZSbaXlhzt0IIaWEChylEQQ6oI6jKY8efoQEUpnnn1Mfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140517; c=relaxed/simple;
	bh=6ZTzSd3598K7bk8uKPBxkkO6GPTLYYedOpYNaudS/Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYCVPYXX6ARVAPFzSQ59NOCCaTEPG7mzDWpOsalrn8pYdrCRNxbkFJ5RhZ8PdvlGdt5T+Kwac2rHySTHXwlzJCkYTL8YtvB2IJjoBNQNtJYv2334bKcufAJpdm0cef3xPg2vCnBjst8w1CUhjHUptPsD5pogYdKs6fiQdaWMRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcX3Bo4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396F0C4CED1;
	Mon,  2 Dec 2024 11:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733140517;
	bh=6ZTzSd3598K7bk8uKPBxkkO6GPTLYYedOpYNaudS/Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mcX3Bo4zkrARWxJk5el7UyMfuS47LwKleagPcfgk094917iimKCoYRxQR+NBrJrbg
	 fnblbeKvkOMGdEK6neNd9Mrd1c0EjB98OddUUJrJKchxcH4l7EIVVsbdiVoDLvxTu0
	 u1XUMGglu0CXh6d1mX84AQjGuxN4MqCOFU1oiPZx32A2ePuQyxZ1y0dH7HExH4GsX3
	 klkUFmW4zOs836pDETDkgPbuyMGV6ve2Dg4GFdzXlaDgobV08Kz32kABc/SbC7/2Wh
	 uZev7LFUxjLcqi3+1gbqC5m92AB5BMw6bMkxPuf1SDkawEyRspk7kaTXYKuenaSQ3b
	 snDTiKc1+vGsA==
Date: Mon, 2 Dec 2024 12:55:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jon DeVree <nuxi@vault24.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] 2038 warning is not printed with new mount API
Message-ID: <20241202-natur-davor-864eb423be9c@brauner>
References: <Z00wR_eFKZvxFJFW@feynman.vault24.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z00wR_eFKZvxFJFW@feynman.vault24.org>

On Sun, Dec 01, 2024 at 10:57:59PM -0500, Jon DeVree wrote:
> When using the old mount API, the linux kernel displays a warning for
> filesystems that lack support for timestamps after 2038. This same
> warning does not display when using the new mount API
> (fsopen/fsconfig/fsmount)
> 
> util-linux 2.39 and higher use the new mount API when available which
> means the warning is effectively invisible for distributions with the
> newer util-linux.
> 
> I noticed this after upgrading a box from Debian Bookworm to Trixie, but
> its also reproducible with stock upstream kernels.
> 
> From a box running a vanilla 6.1 kernel:
> 
> With util-linux 2.38.1 (old mount API)
> [11526.615241] loop0: detected capacity change from 0 to 6291456
> [11526.618049] XFS (loop0): Mounting V5 Filesystem
> [11526.621376] XFS (loop0): Ending clean mount
> [11526.621600] xfs filesystem being mounted at /mnt supports timestamps until 2038 (0x7fffffff)
> [11530.275460] XFS (loop0): Unmounting Filesystem
> 
> With util-linux 2.39.4 (new mount API)
> [11544.063381] loop0: detected capacity change from 0 to 6291456
> [11544.066295] XFS (loop0): Mounting V5 Filesystem
> [11544.069596] XFS (loop0): Ending clean mount
> [11545.527687] XFS (loop0): Unmounting Filesystem
> 
> With util-linux 2.40.2 (new mount API)
> [11550.718647] loop0: detected capacity change from 0 to 6291456
> [11550.722105] XFS (loop0): Mounting V5 Filesystem
> [11550.725297] XFS (loop0): Ending clean mount
> [11552.009042] XFS (loop0): Unmounting Filesystem
> 
> All of them were mounting the same filesystem image that was created
> with: mkfs.xfs -m bigtime=0

With the new mount api the placement of the warning isn't clear:

- If we warn at superblock creation time aka
  fsconfig(FSCONFIG_CMD_CREATE) time but it's misleading because neither
  a mount nor a mountpoint do exist. Hence, the format of the warning
  has to be different.

- If we warn at fsmount() time a mount exists but the
  mountpoint isn't known yet as the mount is detached. This again means
  the format of the warning has to be different.

- If we warn at move_mount() we know the mount and the mountpoint. So
  the format of the warning could be kept.

  But there are considerable downsides:

  * The fs_context isn't available to move_mount()
    which means we cannot log this into the fscontext as well as into
    dmesg which is annoying because it's likely that userspace wants to
    see that message in the fscontext log as well.

  * Once fsmount() has been called it is possible for
    userspace to interact with the filesystem (open and create
    files etc.).

    If userspace holds on to to the detached mount, i.e., never calls
    move_mount(), the warning would never be seen.

  * We'd have to differentiate between adding the first mount for a
    given filesystems and bind-mounts.

IMHO, the best place to log a warning is either at fsmount() time or at
superblock creation time but then the format of the warning will have to
be slightly, changed. We could change it to:

[11526.621600] xfs filesystem supports timestamps until 2038 (0x7ffffff

libmount will log additional information about the mount to figure out
what filesystem caused this warning to be logged.

Would that work for you?

