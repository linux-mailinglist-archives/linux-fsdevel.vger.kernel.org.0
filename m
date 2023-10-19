Return-Path: <linux-fsdevel+bounces-724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A3B7CF2A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 10:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0BEB21213
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B6815AD2;
	Thu, 19 Oct 2023 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP+sVk6V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC864156E3
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 08:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F385C433C7;
	Thu, 19 Oct 2023 08:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697704421;
	bh=iEXdTTzK+elcZBRtjaa/vcBtb7MjPeQVufHauy94o9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LP+sVk6VvEzWz9ydQcKYtTR8LiVzxk651fnxYyKKR9Ivi/tjF9PMtO9YhVpTxXZsV
	 gC+JcUxEecAyWWC9g4mu8j86V1CWpwGdP+u7zFs9fbwZN46GY6X3gMGxjWFdV9NzcL
	 CiIhRL1Pw+4ubSEnqyuLbhvEYb2RZkTs3NVw8Q8bVkN5VVZ6wdaPP6Tj8CTd6BO2Wb
	 DKaaV4tnB+t3kkKWEetWKwVkwqEdSKK79tjVLk+UtyYiuGQkVpaMl+pKHCVpsO2cfc
	 33H4qQagoWHG//xZPyOBt1/HWE1kLzP2BcffuhkAf7/m2EAJwuVbst/bgUpHUvZa30
	 zBMAGgAUwhSzA==
Date: Thu, 19 Oct 2023 10:33:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Avoid grabbing sb->s_umount under
 bdev->bd_holder_lock
Message-ID: <20231019-galopp-zeltdach-b14b7727f269@brauner>
References: <20231018152924.3858-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018152924.3858-1-jack@suse.cz>

On Wed, Oct 18, 2023 at 05:29:24PM +0200, Jan Kara wrote:
> The implementation of bdev holder operations such as fs_bdev_mark_dead()
> and fs_bdev_sync() grab sb->s_umount semaphore under
> bdev->bd_holder_lock. This is problematic because it leads to
> disk->open_mutex -> sb->s_umount lock ordering which is counterintuitive
> (usually we grab higher level (e.g. filesystem) locks first and lower
> level (e.g. block layer) locks later) and indeed makes lockdep complain
> about possible locking cycles whenever we open a block device while
> holding sb->s_umount semaphore. Implement a function

This patches together with my series that Christoph sent out for me
Link: https://lore.kernel.org/r/20231017184823.1383356-1-hch@lst.de
two days ago (tyvm!) the lockdep false positives are all gone and we
also eliminated the counterintuitive ordering requirement that forces us
to give up s_umount before opening block devices.

I've verified that yesterday and did a bunch of testing via sudden
device removal.

Christoph had thankfully added generic/730 and generic/731 to emulate
some device removal. I also messed around with the loop code and
specifically used LOOP_CHANGE_FD to force a disk_force_media_change() on
a filesystem.

