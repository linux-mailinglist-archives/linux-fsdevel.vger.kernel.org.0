Return-Path: <linux-fsdevel+bounces-47548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BADABA9FD88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 01:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB50D171BEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 23:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7EA2135CE;
	Mon, 28 Apr 2025 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAo2m5kD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A51FDE33;
	Mon, 28 Apr 2025 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881734; cv=none; b=p0ujX1j8tEtMaLnh1HpiqE/OU4nBiMB+4B8sMexUDXHM/4o4VI39OVHb68MOdP/Nld/zdpMX4ROzzmjeDsv4/0vCD8iXcxM5S7hoQV61zVZz+Stxg8xq1DHFYl9KhI8DpVlz6BnQYvsEi2V7QLMZDAppL8Oq4Miced57aHrLbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881734; c=relaxed/simple;
	bh=vqxx5ITJdSbi8gq6eMAJPI6323cJXEPOZV0uX68kTH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMDvgKKDVLWdgod4YnuUx/8UoK54+Y/pJoFu+avEyvl8wvPROmFRSJ/lqJF2e8WAIyUIEcvMinmC874lyQWuN7gB+Ly9f02YZX1QLi8a3NnI4lS6cRNQUTRjQpAv+PmIXUfnvBHPe2UY0OzLwwLWEVPkw4mwkCMPJQLsiUepJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAo2m5kD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758BEC4CEEA;
	Mon, 28 Apr 2025 23:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745881734;
	bh=vqxx5ITJdSbi8gq6eMAJPI6323cJXEPOZV0uX68kTH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAo2m5kDb/pyyuC1rocXxoL0N1J5litPpu4IU4vvH9RlaSurRgMiRuC0StJYwJ6ZX
	 Q1I0GxiJP02d1MFtoUl9pIlXptXQyJ2X9XqF6jAH++8FsnuYu4V36TsMG3GG5HMK3k
	 n91FsddH55UK4FiM12V+6iRlQTSUXLjGuCw4MVwqScW6T0TSxTl1vsJ9MWlHNasAUJ
	 q/Jaw/mD4HJtSHOu5rpx/hNziVnnZCnj6+RcGXaNcueNqwzfTTCKL32m2Doe0t5fnV
	 AUhQ6ESgl/O4EI59CoEIXtx/PIZ7OnE590VpI1x6QJ1rLGuowPdRY28JebcVDePVNg
	 0xMYFw45xkBpw==
Date: Mon, 28 Apr 2025 16:08:52 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: dave@stgolabs.net, brauner@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <aBAKhPBAdGVrII2Y@bombadil.infradead.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
 <Z_6Gwl6nowYnsO3w@bombadil.infradead.org>
 <mxmnbr6gni2lupljf7pzkhs6f3hynr2lq2nshbgcmzg77jduwk@wn76alaoxjts>
 <Z__hthNd2nj9QjrM@bombadil.infradead.org>
 <jwciumjkfwwjeoklsi6ubcspcjswkz5s5gtttzpjqft6dtb7sp@c4ae6y5pix5w>
 <aAlN4-pMHoc-PZ1G@bombadil.infradead.org>
 <aAwSCSG1c-t8ATr3@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAwSCSG1c-t8ATr3@bombadil.infradead.org>

On Fri, Apr 25, 2025 at 03:51:55PM -0700, Luis Chamberlain wrote:
> On Wed, Apr 23, 2025 at 01:30:29PM -0700, Luis Chamberlain wrote:
> > On Wed, Apr 23, 2025 at 07:09:28PM +0200, Jan Kara wrote:
> > > On Wed 16-04-25 09:58:30, Luis Chamberlain wrote:
> > > > On Tue, Apr 15, 2025 at 06:28:55PM +0200, Jan Kara wrote:
> > > > > > So I tried:
> > > > > > 
> > > > > > root@e1-ext4-2k /var/lib/xfstests # fsck /dev/loop5 -y 2>&1 > log
> > > > > > e2fsck 1.47.2 (1-Jan-2025)
> > > > > > root@e1-ext4-2k /var/lib/xfstests # wc -l log
> > > > > > 16411 log
> > > > > 
> > > > > Can you share the log please?
> > > > 
> > > > Sure, here you go:
> > > > 
> > > > https://github.com/linux-kdevops/20250416-ext4-jbd2-bh-migrate-corruption
> > > > 
> > > > The last trace-0004.txt is a fresh one with Davidlohr's patches
> > > > applied. It has trace-0004-fsck.txt.
> > > 
> > > Thanks for the data! I was staring at them for some time and at this point
> > > I'm leaning towards a conclusion that this is actually not a case of
> > > metadata corruption but rather a bug in ext4 transaction credit computation
> > > that is completely independent of page migration.
> > > 
> > > Based on the e2fsck log you've provided the only damage in the filesystem
> > > is from the aborted transaction handle in the middle of extent tree growth.
> > > So nothing points to a lost metadata write or anything like that. And the
> > > credit reservation for page writeback is indeed somewhat racy - we reserve
> > > number of transaction credits based on current tree depth. However by the
> > > time we get to ext4_ext_map_blocks() another process could have modified
> > > the extent tree so we may need to modify more blocks than we originally
> > > expected and reserved credits for.
> > > 
> > > Can you give attached patch a try please?
> > > 
> > > 								Honza
> > > -- 
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
> > 
> > > From 4c53fb9f4b9b3eb4a579f69b7adcb6524d55629c Mon Sep 17 00:00:00 2001
> > > From: Jan Kara <jack@suse.cz>
> > > Date: Wed, 23 Apr 2025 18:10:54 +0200
> > > Subject: [PATCH] ext4: Fix calculation of credits for extent tree modification
> > > 
> > > Luis and David are reporting that after running generic/750 test for 90+
> > > hours on 2k ext4 filesystem, they are able to trigger a warning in
> > > jbd2_journal_dirty_metadata() complaining that there are not enough
> > > credits in the running transaction started in ext4_do_writepages().
> > > 
> > > Indeed the code in ext4_do_writepages() is racy and the extent tree can
> > > change between the time we compute credits necessary for extent tree
> > > computation and the time we actually modify the extent tree. Thus it may
> > > happen that the number of credits actually needed is higher. Modify
> > > ext4_ext_index_trans_blocks() to count with the worst case of maximum
> > > tree depth.
> > > 
> > > Link: https://lore.kernel.org/all/20250415013641.f2ppw6wov4kn4wq2@offworld
> > > Reported-by: Davidlohr Bueso <dave@stgolabs.net>
> > > Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > 
> > I kicked off tests! Let's see after ~ 90 hours!
> 
> Tested-by: kdevops@lists.linux.dev
> 
> I have run the test over 3 separate guests and each one has tested this
> over 48 hours each. There is no ext4 fs corruption reported, all is
> good, so I do believe thix fixes the issue. One of the guests was on
> Linus't tree which didn't yet have Davidlorh's fixes for folio migration.
> And so I believe this patch should have a stable tag fix so stable gets it.

Jan, my testing has passed 120 hours now on multiple guests. This is
certainly a fixed bug with your patch.

  Luis

