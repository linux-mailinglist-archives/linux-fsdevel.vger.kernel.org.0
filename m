Return-Path: <linux-fsdevel+bounces-47132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368EFA9997B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 22:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D892C3A96AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 20:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15C26E17A;
	Wed, 23 Apr 2025 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGUzH74f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C54686331;
	Wed, 23 Apr 2025 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745440230; cv=none; b=JQhMdnkTDNFFGwPdy2oAt96tQ8mWM8NNROKpulKfTbE+i7oQAvpwpPEiqQaXZLGvbC5ly1VbVyc+HCbRXNN5yseMIjh0Omrb+aEZnU2d+gesjwjNz8mcCjPKMbVmahuDgRQOixArHpCqe4+oeFezc6fYD36o+82Sd9m32zKEBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745440230; c=relaxed/simple;
	bh=zfnpkNpzO3aNFO+OP3lzklECKkdME0YLtwNkLDKthmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDzncxWFQOGzKuQjNJYn6yQVtIFWuvR4y890u3MMF7+fiVoKD3WyR6odx4QLbpZ0uMIlcw2Qn3SyZzgOtFazRvpBSpYrQe7o2PnS5nKrWMc1IvrKawEk0YDG184vtYIVT86zrxJdj9nuhxgyB+vdDBPendJEs3lxU4vgi6cKocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGUzH74f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D447C4CEE2;
	Wed, 23 Apr 2025 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745440229;
	bh=zfnpkNpzO3aNFO+OP3lzklECKkdME0YLtwNkLDKthmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGUzH74f/LbW6NCs62Zff+JfuLGq6keOuX4IvbzDuB7DNJNOg0P2wi/F/C8ehdk/k
	 ko8avwyRSiYSNEzgOsF4orsz8i9yDCmLrQxklSvOxJvkHTtlgat36TbLOwMPEdgKks
	 KqHhJjwCXz5fTZQzE9VhKvnXn4xGy5U/r+Dj3pIlWPS9FsefEAqf4rDvIG4/soxd3m
	 QrGvXKFNUMWec92qJbCiTboJ5duU4pSb/Wu0PuCu6Hh2mhTKjgtQG2gC3sbfUSoxRP
	 w2Ye2tW/1DgeFAXPwVlFyc7gyNmbc/Ij6EHFU/3HxoeSkLq0+6GWFKN4+/OrtRCoKf
	 y27BZigv4ldQA==
Date: Wed, 23 Apr 2025 13:30:27 -0700
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
Message-ID: <aAlN4-pMHoc-PZ1G@bombadil.infradead.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
 <Z_6Gwl6nowYnsO3w@bombadil.infradead.org>
 <mxmnbr6gni2lupljf7pzkhs6f3hynr2lq2nshbgcmzg77jduwk@wn76alaoxjts>
 <Z__hthNd2nj9QjrM@bombadil.infradead.org>
 <jwciumjkfwwjeoklsi6ubcspcjswkz5s5gtttzpjqft6dtb7sp@c4ae6y5pix5w>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jwciumjkfwwjeoklsi6ubcspcjswkz5s5gtttzpjqft6dtb7sp@c4ae6y5pix5w>

On Wed, Apr 23, 2025 at 07:09:28PM +0200, Jan Kara wrote:
> On Wed 16-04-25 09:58:30, Luis Chamberlain wrote:
> > On Tue, Apr 15, 2025 at 06:28:55PM +0200, Jan Kara wrote:
> > > > So I tried:
> > > > 
> > > > root@e1-ext4-2k /var/lib/xfstests # fsck /dev/loop5 -y 2>&1 > log
> > > > e2fsck 1.47.2 (1-Jan-2025)
> > > > root@e1-ext4-2k /var/lib/xfstests # wc -l log
> > > > 16411 log
> > > 
> > > Can you share the log please?
> > 
> > Sure, here you go:
> > 
> > https://github.com/linux-kdevops/20250416-ext4-jbd2-bh-migrate-corruption
> > 
> > The last trace-0004.txt is a fresh one with Davidlohr's patches
> > applied. It has trace-0004-fsck.txt.
> 
> Thanks for the data! I was staring at them for some time and at this point
> I'm leaning towards a conclusion that this is actually not a case of
> metadata corruption but rather a bug in ext4 transaction credit computation
> that is completely independent of page migration.
> 
> Based on the e2fsck log you've provided the only damage in the filesystem
> is from the aborted transaction handle in the middle of extent tree growth.
> So nothing points to a lost metadata write or anything like that. And the
> credit reservation for page writeback is indeed somewhat racy - we reserve
> number of transaction credits based on current tree depth. However by the
> time we get to ext4_ext_map_blocks() another process could have modified
> the extent tree so we may need to modify more blocks than we originally
> expected and reserved credits for.
> 
> Can you give attached patch a try please?
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

> From 4c53fb9f4b9b3eb4a579f69b7adcb6524d55629c Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Wed, 23 Apr 2025 18:10:54 +0200
> Subject: [PATCH] ext4: Fix calculation of credits for extent tree modification
> 
> Luis and David are reporting that after running generic/750 test for 90+
> hours on 2k ext4 filesystem, they are able to trigger a warning in
> jbd2_journal_dirty_metadata() complaining that there are not enough
> credits in the running transaction started in ext4_do_writepages().
> 
> Indeed the code in ext4_do_writepages() is racy and the extent tree can
> change between the time we compute credits necessary for extent tree
> computation and the time we actually modify the extent tree. Thus it may
> happen that the number of credits actually needed is higher. Modify
> ext4_ext_index_trans_blocks() to count with the worst case of maximum
> tree depth.
> 
> Link: https://lore.kernel.org/all/20250415013641.f2ppw6wov4kn4wq2@offworld
> Reported-by: Davidlohr Bueso <dave@stgolabs.net>
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>

I kicked off tests! Let's see after ~ 90 hours!

  Luis

