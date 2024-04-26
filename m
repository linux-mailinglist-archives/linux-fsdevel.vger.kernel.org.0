Return-Path: <linux-fsdevel+bounces-17846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD088B2E20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 02:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368741C21D0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 00:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B88EDC;
	Fri, 26 Apr 2024 00:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f0+vinsW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B8380;
	Fri, 26 Apr 2024 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714092453; cv=none; b=MRrdzrqBKu6AFDOgD8SIHwbx+TPy2RbqEZyz93X3niUsymj8/p12426vmwZ6zzojQ94i02Dud1OrEiQoIZbGO82oYi5xc2Yu8Phc2LC4Z+YHJ84u4GZRCToyhMmkJ9b28/XpkRx51SvjC1vaLv4D78ZWytDotEvGmJtjD8smkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714092453; c=relaxed/simple;
	bh=C5A9J+Gbrbj/i3IjchhAKHt0ZfALGWbdhp86L8wkEeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bylh/Z1HXsecrhNR1qVBabeg37u/d2nyDscAmtk7E8oXMdXS4wezRBNsay3sB3xirhz8GjIsMDZffgAwcBMi+fNQCUSHIzSX2PRycNh3hBxR7/cdi3yImyN8CT9/DE7DZd5wiPeQeCZ+kclrhscJ7KsVcLJIL0qqzz1s1ZT+i0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f0+vinsW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6jnE6LGAE0Ge7rAWbVl9vm4Cu+KrxLEesibskCl1htg=; b=f0+vinsWX0muKf6vaKgTKwJ3aM
	+DuqXXB3MLam69jGiOjU663h1e9sUMxRNxElfr+tDjGlokyrag0jL2mcN8ZbbcqjrwPxD1buayqVl
	UoYWexnagnozKyAzskjB+udRYZc3DZDJIiPRS0ntTrnlmyY/Z4RmmBme6dq2D5aL0NQ5GdaXg8YZw
	DjuORwkpqODS4GMKICRq7fXPJqps+xnze0ZE6HY8P+JzFOOXHwHxqiOFbC9xXpVisUc/zJqFnpqxE
	UCWk+aZXz+kfClceSFXdTtaQyKtUhgg5UGmZLP+vSa3L1Hxl+A5UO3r4j35dUrWjT/HxavIBNg0Ye
	tGVH1xCQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s09kN-0000000Ak4J-0KrB;
	Fri, 26 Apr 2024 00:47:28 +0000
Date: Thu, 25 Apr 2024 17:47:27 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, djwong@kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandan.babu@oracle.com,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 05/11] mm: do not split a folio if it has minimum
 folio order requirement
Message-ID: <Zir5n6JNiX14VoPm@bombadil.infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-6-kernel@pankajraghav.com>
 <Ziq4qAJ_p7P9Smpn@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ziq4qAJ_p7P9Smpn@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Apr 25, 2024 at 09:10:16PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 25, 2024 at 01:37:40PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > Splitting a larger folio with a base order is supported using
> > split_huge_page_to_list_to_order() API. However, using that API for LBS
> > is resulting in an NULL ptr dereference error in the writeback path [1].
> > 
> > Refuse to split a folio if it has minimum folio order requirement until
> > we can start using split_huge_page_to_list_to_order() API. Splitting the
> > folio can be added as a later optimization.
> > 
> > [1] https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df
> 
> Obviously this has to be tracked down and fixed before this patchset can
> be merged ... I think I have some ideas.  Let me look a bit.  How
> would I go about reproducing this?

Using kdevops this is easy:

make defconfig-lbs-xfs-small -j $(nproc)
make -j $(nproc)
make fstests
make linux
make fstests-baseline TESTS=generic/447 COUNT=10
tail -f

guestfs/*-xfs-reflink-16k-4ks/console.log
or
sudo virsh list
sudo virsh console ${foo}-xfs-reflink-16k-4ks

Where $foo is the value of CONFIG_KDEVOPS_HOSTS_PREFIX in .config for
your kdevops run.

Otherwise if you wanna run things manually the above uses an lbs branch
called large-block-minorder on kdevops [0] based on v6.9-rc5 with:

a) Fixes we know we need
b) this patch series minus this patch
c) A truncation enablement patch

Note that the above also uses an fstests git tree with the fstests
changes we also have posted as fixes and some new tests which have been
posted [1]. You will then want to run:

./check -s xfs_reflink_16k_4ks -I 10 generic/447

The configuration for xfs_reflink_16k_4ks follows:

cat /var/lib/xfstests/configs/min-xfs-reflink-16k-4ks.config

[default]
FSTYP=xfs
TEST_DIR=/media/test
SCRATCH_MNT=/media/scratch
RESULT_BASE=$PWD/results/$HOST/$(uname -r)
DUMP_CORRUPT_FS=1
CANON_DEVS=yes
RECREATE_TEST_DEV=true
SOAK_DURATION=9900

[xfs_reflink_16k_4ks]
TEST_DEV=/dev/loop16
SCRATCH_DEV_POOL="/dev/loop5 /dev/loop6 /dev/loop7 /dev/loop8 /dev/loop9 /dev/loop10 /dev/loop11 /dev/loop12"
MKFS_OPTIONS='-f -m reflink=1,rmapbt=1, -i sparse=1, -b size=16384, -s size=4k'
USE_EXTERNAL=no
LOGWRITES_DEV=/dev/loop15

I didn't have time to verify if the above commands for kdevops worked but... in
theory its possible it may, because you know, May is right around the
corner, and May... the force be with us.

[0] https://github.com/linux-kdevops/linux/tree/large-block-minorder
[1] https://github.com/linux-kdevops/fstests

  Luis

