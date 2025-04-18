Return-Path: <linux-fsdevel+bounces-46675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 629A0A939A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 17:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4871A7A7436
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 15:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072C5211710;
	Fri, 18 Apr 2025 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMUdGKTK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDDE211285;
	Fri, 18 Apr 2025 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990142; cv=none; b=pwXv6VZW4jp0dkaa6f+uTXk81LwvA6bRFZMFnzuJgg+cunFmqsVAmQ+fPzgw9XGNAHUHJN73q/Qa5PzcoYLX+rddUoSi0lqDaERTUqG0oCGY2kYu+n3oBOBDHs0oVfEe8gBcW9Xrvpi6/kGMoDJ334zfdUGmT5qUK9OcnZdu8Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990142; c=relaxed/simple;
	bh=t3sZeskjpo2ArADGfTulRLq8dgnCboNGoKaTb3UPjmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aChn8L0mLzhR3C5atJ4WxbyW+LtvYJ1SrOdYqZZrMhDnyrN343nTiilSBvZo2hnrbX55qTKm0zrAddYpP72LxoDJVZr3M7ugj2zsLsXssbF3PfNdc5m8f38bC1ZWEGghgHmaEMwDKAb2dtJmbcv2l1AdI4Txpm4YYsDBX/HgvRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMUdGKTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C43C4CEE2;
	Fri, 18 Apr 2025 15:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990141;
	bh=t3sZeskjpo2ArADGfTulRLq8dgnCboNGoKaTb3UPjmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMUdGKTKUZ782mwJ50bnIbokfjc9u+g90NuxFPcceugcW3LgMtypY0fhCkxtMk5hR
	 mDgUO+zVIGCTIb5AP+VyBcKDnKV4//dBgEB1UNQMZ7QTtHZnmuk41h42rNmJ57mlfD
	 1KFvX2Z4WWwjfKWERrfO4VF2Qx9/OCgZkDcRzTHtyN0cFuYdwwoUPSFy1UFfaM2ixZ
	 sZd0G/40WK6HUx80b4TMf68agQYoU9CMNGo93sd4i9EQgFqJaPzrbKup7XApG0+vu4
	 5KyqCZtrA3m40xfP6aJoTEXHHrQYXrmbQDVVej7JxGx0P9XtapbCZPXUH+g8m4jexM
	 3tSzxmgtoKONw==
Date: Fri, 18 Apr 2025 08:29:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>, Jack Vogel <jack.vogel@oracle.com>
Subject: Re: [RFC[RAP] 1/2] block: fix race between set_blocksize and read
 paths
Message-ID: <20250418152901.GI25659@frogsfrogsfrogs>
References: <20250415001405.GA25659@frogsfrogsfrogs>
 <Z_80_EXzPUiAow2I@infradead.org>
 <20250416050144.GZ25675@frogsfrogsfrogs>
 <Z_88swOZp_SlQYgC@infradead.org>
 <xaqx4eiipvlytkx2vxxf3a25zxvn2vcj7kepcsjd34x6p3iy6w@fbvjbphgekb4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xaqx4eiipvlytkx2vxxf3a25zxvn2vcj7kepcsjd34x6p3iy6w@fbvjbphgekb4>

On Fri, Apr 18, 2025 at 07:51:58AM +0000, Shinichiro Kawasaki wrote:
> On Apr 15, 2025 / 22:14, Christoph Hellwig wrote:
> > On Tue, Apr 15, 2025 at 10:01:44PM -0700, Darrick J. Wong wrote:
> > > It's the same patch as:
> > > https://lore.kernel.org/linux-fsdevel/20250408175125.GL6266@frogsfrogsfrogs/
> > > 
> > > which is to say, xfs/032 with while true; do blkid; done running in the
> > > background to increase the chances of a collision.
> > 
> > I think the xfs-zoned CI actually hit this with 032 without any extra
> > action the.
> 
> I observed xfs/032 hanged using the kernel on linux-xfs/for-next branch with git
> hash 71700ac47ad8. Before the hang, kernel reported the messages below:
> 
>   Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>   CPU: 21 UID: 0 PID: 3187783 Comm: (udev-worker) Not tainted 6.15.0-rc1-kts-xfs-g71700ac47ad+ #1 PREEMPT(lazy)
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
>   RIP: 0010:guard_bio_eod+0x52/0x5b0
> 
> The failure was recreated in stable manner. I applied this patch series, and
> confirmed the failure disappears. Good. (I needed to resolve conflicts, though)
> 
> This patch fixes block layer. So, IMO, it's the better to have a test case in
> blktests to confirm the fix. I created a blktests test case which recreates the
> failure using blockdev and fio commands. Will post it soon.

Ok.  I'll post a non-rfcrap version of the series shortly.  Thank you
for writing a regression test! :)

--D

