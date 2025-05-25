Return-Path: <linux-fsdevel+bounces-49822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083DCAC3625
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 20:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790631893244
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 18:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4747D1F4177;
	Sun, 25 May 2025 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wfeo8Mq3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0836C3FE7
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748196178; cv=none; b=UdNGV859X9/77Waqxk4Un3jqGKYdHbNB4Jp43FWj/ktBEkSrJfsmBYVs4jTooTWoAZJXsqeTAl2H3sEgyu1rF7b9RAbaykUj06CTfhf4Rgafm6/pkZ/ZuB2HCOx2mjxi8MtcFePqVcgM4tKagH9j2nD2IZFrh7Jeku+zb5awnh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748196178; c=relaxed/simple;
	bh=t+OLoZVeodcH8b2fuYVebUwSNodXBZ3JaVjbWdGZBhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzAemVukuwuWeFsngX3Ir1UVcva4/qTewptvGiL/LEq0N0L7TmAZ6vF6pabU06oXJJg1kNckmi3dBlnuiJbE8kgmQSOZZshzRcQPak8JzUwClt/9XGR53amBK52ua1SGFzGieqpLc5ukaaDvJ+PBxTu9qSvvDyeNvDK5ZrCEQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wfeo8Mq3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lJMTbEKUo1hXNgRfKiYXNPDlQhTz75f+eJkMkyQncm0=; b=wfeo8Mq3kngGOXwreQmkuDkuwL
	3+rP5U+bIeP8AtRNcLB0BROiLwJFTkXMmkDGMfH7EFMOdhKCgBgVxFtJ5S8geq7ByDxlZ279LgQXB
	ajcugVeUO3SPkwLQrH1xWVYCNJ10Jc85hweEtlxT8c6xnxBcaa55UtjRU304zh/ukp23oxj9DXGkk
	GKmo6RoUxwjjpHCHLpKRHXpGynjtOQx0FJ53f9tLyFiM9K73ycpSEVYC+/F8xop9kS8JvLsW1d4FW
	fetqQsBSj1nQQfeA8QKpYjGcmP+RYycBJ9zBFle5Qh3nCfqhThZ5mTlOp5hzFNlGzv7iw6TwPJgM4
	QsR08uNg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJFgT-0000000GQYG-2h5f;
	Sun, 25 May 2025 18:02:53 +0000
Date: Sun, 25 May 2025 19:02:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
Message-ID: <20250525180253.GT2023217@ZenIV>
References: <20250525083209.GS2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525083209.GS2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, May 25, 2025 at 09:32:09AM +0100, Al Viro wrote:
> generic/127 with xfstests built on debian-testing (trixie) ends up with
> assorted memory corruption; trace below is with CONFIG_DEBUG_PAGEALLOC and
> CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT and it looks like a double free
> somewhere in iomap.  Unfortunately, commit in question is just making
> xfs use the infrastructure built in earlier series - not that useful
> for isolating the breakage.

FWIW, the same breakage is reproduced within a couple of iterations of
./check generic/127 on debian-testing image with xfstests built fresh from
git and debian linux-image-6.15-rc7-amd64-unsigned_6.15~rc7-1~exp1_amd64.deb

IOW, it's not something exotic in .config here.  KVM setup is also not
unusual -

kvm \
	-boot order=c \
	-m 16384 \
	-netdev "tap,id=nic0,ifname=tap4,script=no,downscript=no" \
	-device "e1000,netdev=nic0" \
	-nographic \
	-smp 4 \
	-hdb /home/al/emu/ssd/image \
	trixie.img

with image partitioned into two 6G xfs filesystems, with

export TEST_DEV=/dev/sdb1
export TEST_DIR=/home/test
export SCRATCH_DEV=/dev/sdb2
export SCRATCH_MNT=/home/scratch

for local.config.  Bog-standard install, ext4 for everything on sda,
nothing fancy for storage setup - qemu defaults all way through.

