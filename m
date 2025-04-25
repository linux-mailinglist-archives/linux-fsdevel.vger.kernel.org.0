Return-Path: <linux-fsdevel+bounces-47421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34207A9D5ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 00:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8171BC67EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 22:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0A9296D0E;
	Fri, 25 Apr 2025 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEYaJyoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6160F224AE1;
	Fri, 25 Apr 2025 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745621516; cv=none; b=KIhlUd6uT3iqWuKmkp6QyJMOEq8PWoriHLb9u+cT/0gbUOMtEkWOWDD/usiif12wRx5k4PwC89e4vptC/Af/AWYssRrtZTXgMhsgb2hbsYxXq11/mgsYxpruk1SdnE2+tdirb+LEOAq1QjUqJQqC5GJopwHm5BFSx/RDykkWhgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745621516; c=relaxed/simple;
	bh=36lugvvl4zzEMISZR+vkYMgDKBdjxnRI+gAdGLkgpKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j30uz9StqEjcgSBbJmw1H3WsYLGvbjMgh/nheJ6HZIEiHNO87pLZtDMtk9B3gkycA6CPYJWGdlKXGdpZbQJWkZA9VRvIz4gJeuxnhM9SRi1Sr5/7pp+X+kyFQiytyttEffmadZGPZ8SeXFnX42tmoVH54y83dLuhMXaeNga0QIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEYaJyoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4297BC4CEE4;
	Fri, 25 Apr 2025 22:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745621515;
	bh=36lugvvl4zzEMISZR+vkYMgDKBdjxnRI+gAdGLkgpKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jEYaJyoCx0+Ng3BLeOf9fGGqg7JGn6rmbpV+T1iMGeX0fLpbiF7XjrJQAwrXj3ii9
	 s+zMTyN+46Sm8mnZMyUU6eHag5qE8moum14tNMMYgEdHWfYuQPXbdDu2pcGAkGZVBE
	 lE3W88Af9w/iqj311UZwlCXkxuXQ7FXSuV+H38e3pa3kVTjKmUW3rCS8A+OwTrxzm2
	 Oa155moLXl3x978WwIWVXGtNm7FFjb7EUAmIgVBb6YrVwaNicnEGLWnvXlMW22HmvY
	 KIyctV3KaeiT9pFpctTrsg8HTf1qRKyJPjgQeW2i3NZpnfyUZ2KNOjNzy7gmw4YPuL
	 ZANOj7MJpSh6g==
Date: Fri, 25 Apr 2025 15:51:53 -0700
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
Message-ID: <aAwSCSG1c-t8ATr3@bombadil.infradead.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
 <Z_6Gwl6nowYnsO3w@bombadil.infradead.org>
 <mxmnbr6gni2lupljf7pzkhs6f3hynr2lq2nshbgcmzg77jduwk@wn76alaoxjts>
 <Z__hthNd2nj9QjrM@bombadil.infradead.org>
 <jwciumjkfwwjeoklsi6ubcspcjswkz5s5gtttzpjqft6dtb7sp@c4ae6y5pix5w>
 <aAlN4-pMHoc-PZ1G@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAlN4-pMHoc-PZ1G@bombadil.infradead.org>

On Wed, Apr 23, 2025 at 01:30:29PM -0700, Luis Chamberlain wrote:
> On Wed, Apr 23, 2025 at 07:09:28PM +0200, Jan Kara wrote:
> > On Wed 16-04-25 09:58:30, Luis Chamberlain wrote:
> > > On Tue, Apr 15, 2025 at 06:28:55PM +0200, Jan Kara wrote:
> > > > > So I tried:
> > > > > 
> > > > > root@e1-ext4-2k /var/lib/xfstests # fsck /dev/loop5 -y 2>&1 > log
> > > > > e2fsck 1.47.2 (1-Jan-2025)
> > > > > root@e1-ext4-2k /var/lib/xfstests # wc -l log
> > > > > 16411 log
> > > > 
> > > > Can you share the log please?
> > > 
> > > Sure, here you go:
> > > 
> > > https://github.com/linux-kdevops/20250416-ext4-jbd2-bh-migrate-corruption
> > > 
> > > The last trace-0004.txt is a fresh one with Davidlohr's patches
> > > applied. It has trace-0004-fsck.txt.
> > 
> > Thanks for the data! I was staring at them for some time and at this point
> > I'm leaning towards a conclusion that this is actually not a case of
> > metadata corruption but rather a bug in ext4 transaction credit computation
> > that is completely independent of page migration.
> > 
> > Based on the e2fsck log you've provided the only damage in the filesystem
> > is from the aborted transaction handle in the middle of extent tree growth.
> > So nothing points to a lost metadata write or anything like that. And the
> > credit reservation for page writeback is indeed somewhat racy - we reserve
> > number of transaction credits based on current tree depth. However by the
> > time we get to ext4_ext_map_blocks() another process could have modified
> > the extent tree so we may need to modify more blocks than we originally
> > expected and reserved credits for.
> > 
> > Can you give attached patch a try please?
> > 
> > 								Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> 
> > From 4c53fb9f4b9b3eb4a579f69b7adcb6524d55629c Mon Sep 17 00:00:00 2001
> > From: Jan Kara <jack@suse.cz>
> > Date: Wed, 23 Apr 2025 18:10:54 +0200
> > Subject: [PATCH] ext4: Fix calculation of credits for extent tree modification
> > 
> > Luis and David are reporting that after running generic/750 test for 90+
> > hours on 2k ext4 filesystem, they are able to trigger a warning in
> > jbd2_journal_dirty_metadata() complaining that there are not enough
> > credits in the running transaction started in ext4_do_writepages().
> > 
> > Indeed the code in ext4_do_writepages() is racy and the extent tree can
> > change between the time we compute credits necessary for extent tree
> > computation and the time we actually modify the extent tree. Thus it may
> > happen that the number of credits actually needed is higher. Modify
> > ext4_ext_index_trans_blocks() to count with the worst case of maximum
> > tree depth.
> > 
> > Link: https://lore.kernel.org/all/20250415013641.f2ppw6wov4kn4wq2@offworld
> > Reported-by: Davidlohr Bueso <dave@stgolabs.net>
> > Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> I kicked off tests! Let's see after ~ 90 hours!

Tested-by: kdevops@lists.linux.dev

I have run the test over 3 separate guests and each one has tested this
over 48 hours each. There is no ext4 fs corruption reported, all is
good, so I do believe thix fixes the issue. One of the guests was on
Linus't tree which didn't yet have Davidlorh's fixes for folio migration.
And so I believe this patch should have a stable tag fix so stable gets it.

  Luis

