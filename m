Return-Path: <linux-fsdevel+bounces-14974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE26885A03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 14:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF0F1C2177F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 13:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C2384A51;
	Thu, 21 Mar 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVgs5M3U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D885810B;
	Thu, 21 Mar 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028120; cv=none; b=Uyd+ViSpA0pGy3RYw0QXRNlOdPK2KZ76xNdtrFq3vzg4SBxWyUbFRYRqy40Bdo+KXETdbO/gaZjBIq3hZNiJZZsu9xoMwiaBFpDr3FwgFfRTkb6SOLXgwzVJcheqwmA6TS3Zy1MLa1/6cXfH4/oUhuxP19HzuuINdjfDtobzuuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028120; c=relaxed/simple;
	bh=JpD2OHISkkjxiWqxZe4gvt3KE6laF2S8GHpaK5KN600=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXakTzL+FSVS6XWbULatdsdp/gyXf4CwgGRmcsiNlXmBzygFFX242d6bKZfVR4pvmYawY280udxfZIcNCgCkgRxh4aRjimE3v6u7Nny2s2cc/fYIDcITfobTkuZl4sPP6gdkQi0i61B2ewuyx+E0X2V0OLtjdkSB5Bkr2R6JPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVgs5M3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EEEC433C7;
	Thu, 21 Mar 2024 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711028120;
	bh=JpD2OHISkkjxiWqxZe4gvt3KE6laF2S8GHpaK5KN600=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVgs5M3U2fy7JgNBFDaw7i3SKbHIZjBHPK/mGVImZXYCb8UOcWIUGSzO5kc/EcFSG
	 sJU0W4H2QJVryB9kOxIZnXBzYFnvhe9wZkibLS0hw3/rlqjjLujFe39mcOdz/JKSKl
	 f1ii5dk+WTSs1i0vtseKFGoKEE1IAB3/+F/cGM8BY9//sxQ8R9I2PmTo1+6/hJSNtC
	 DDdNIJzwBVfTZgIS06Jv+nY0Ut8aO7ueCAxbBCj/0XR8MEKimKVJCaqRqmv1MBhHMA
	 wzJM8Bu+Q7iRh/5ox2JXBThuOPbqYFWlObC6QOZ030lgBTxtpuY8cFn7Y0jymZmbZv
	 cIyFGQef6vU1w==
Date: Thu, 21 Mar 2024 14:35:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, it+linux@molgen.mpg.de
Subject: Re: possible 6.6 regression: Deadlock involving super_lock()
Message-ID: <20240321-brecheisen-lasst-7ac15aff03b1@brauner>
References: <6e010dbb-f125-4f44-9b1a-9e6ac9bb66ff@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e010dbb-f125-4f44-9b1a-9e6ac9bb66ff@molgen.mpg.de>

> Also, one writeback thread was blocked. I mention that, because I
> don't get how these these two threads could depend on each other:

Writeback holds s_umount. So writeback seems to not make progress and
blocks the mount. So right now it seems unlikely that this is related.
Any chance you can try and reproduce this with v6.7 and newer?

> # # /proc/39359/task/39359: kworker/u268:5+flush-0:58 : 
> # cat /proc/39359/task/39359/stack
> 
> [<0>] folio_wait_bit_common+0x135/0x350
> [<0>] write_cache_pages+0x1a0/0x3a0
> [<0>] nfs_writepages+0x12a/0x1e0 [nfs]
> [<0>] do_writepages+0xcf/0x1e0
> [<0>] __writeback_single_inode+0x46/0x3a0
> [<0>] writeback_sb_inodes+0x1f5/0x4d0
> [<0>] __writeback_inodes_wb+0x4c/0xf0
> [<0>] wb_writeback+0x1f5/0x320
> [<0>] wb_workfn+0x350/0x4f0
> [<0>] process_one_work+0x142/0x300
> [<0>] worker_thread+0x2f5/0x410
> [<0>] kthread+0xe8/0x120
> [<0>] ret_from_fork+0x34/0x50
> [<0>] ret_from_fork_asm+0x1b/0x30

