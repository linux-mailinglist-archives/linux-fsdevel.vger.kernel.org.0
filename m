Return-Path: <linux-fsdevel+bounces-46492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EB1A8A3EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE44117E7F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5D2210F49;
	Tue, 15 Apr 2025 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLZ6pla5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2AC2F2;
	Tue, 15 Apr 2025 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733893; cv=none; b=nsZMWVGMpHVjCqrcJjwrVuRhy8EZGObJJ9DmxKY8awbC7h9wEU3SfxHRwjiMvoXPPKe/GJq6N/aXpIPGVrwwvZAmMtD+PjquOy+gQVzfSoiM+002C2Bj7Vvgp4P/NBsUw+fQHlSAZjz/H1Zs8lCzx0v+dauNjqzZD3yXSNgChMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733893; c=relaxed/simple;
	bh=TTzt00DG4m8YTP79xAQ6Vc0Czj8pe4Ekm0GuBijqACM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq70mP6v+ui05FgGEM65ZeNdzA2/N8Zp8tWBpcDgHUCF46ROjPvOOcC5NIXykJXTrTxcmNieZ9EgnBpsElx8BLTu7enQSHT0Ub6zY+XluN70DS1BwcDueRXrtGlCbS2AEb5dzonooHZydnDYAemjKcUDlK3pRa+scz89KBoalJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLZ6pla5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279FAC4CEEB;
	Tue, 15 Apr 2025 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744733892;
	bh=TTzt00DG4m8YTP79xAQ6Vc0Czj8pe4Ekm0GuBijqACM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLZ6pla5ACcnqulLMEDJOTd+4m63v1IVlXP4x6W6/Du6+HgglgLZiCuu+l9IVB45n
	 n0+A4YSLy+MiLY4FfYjs4K5TT/CfXl1GzdOyxFWRjoYScuXo3MS0BqD/nCeudDVLlf
	 lmfdFLOM2M2sBQu8EOFLStlwmt6eQbENfKRb2Q/YP64GOdwfChLhHFhDbtkvOwdzhP
	 Hs9rEyYKXwOZhSs6qXnPJ36TiWBBTGoSaAiIEJd9a9LfXgp1oLssjRTL2BHPnzupMP
	 p/rS+6A54oUZyEzs2rdrm0/9mYGDI1rWuqXztTs9qIvtb6yJm6TfuNw0t36NBuTIKf
	 hEBy1DNx3NQEQ==
Date: Tue, 15 Apr 2025 09:18:10 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, riel@surriel.com, dave@stgolabs.net,
	willy@infradead.org, hannes@cmpxchg.org, oliver.sang@intel.com,
	david@redhat.com, axboe@kernel.dk, hare@suse.de,
	david@fromorbit.com, djwong@kernel.org, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <Z_6Gwl6nowYnsO3w@bombadil.infradead.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>

On Thu, Apr 10, 2025 at 02:05:38PM +0200, Jan Kara wrote:
> On Wed 09-04-25 18:49:38, Luis Chamberlain wrote:
> > ** Reproduced on vanilla Linux with udelay(2000) **
> > 
> > Call trace (ENOSPC journal failure):
> >   do_writepages()
> >     → ext4_do_writepages()
> >       → ext4_map_blocks()
> >         → ext4_ext_map_blocks()
> >           → ext4_ext_insert_extent()
> >             → __ext4_handle_dirty_metadata()
> >               → jbd2_journal_dirty_metadata() → ERROR -28 (ENOSPC)
> 
> Curious. Did you try running e2fsck after the filesystem complained like
> this? This complains about journal handle not having enough credits for
> needed metadata update. Either we've lost some update to the journal_head
> structure (b_modified got accidentally cleared) or some update to extent
> tree.

Just tried it after pkill fsstress and stopping the test:

root@e1-ext4-2k /var/lib/xfstests # umount /dev/loop5
root@e1-ext4-2k /var/lib/xfstests # fsck /dev/loop5
fsck from util-linux 2.41
e2fsck 1.47.2 (1-Jan-2025)
/dev/loop5 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Inode 26 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 129 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 592 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 1095 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 1416 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 1653 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 1929 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 1965 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 2538 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 2765 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 2831 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 2838 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 3595 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 4659 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 5268 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 6400 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 6830 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 8490 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 8555 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 8658 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 8754 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 8996 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 9168 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 9430 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 9468 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 9543 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 9632 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 9746 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 10043 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 10280 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 10623 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 10651 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 10691 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 10708 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 11389 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 11564 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 11578 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 11842 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 11900 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yInode 12721 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 12831 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yInode 13531 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yyyyInode 16580 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 16740 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yInode 17123 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yInode 17192 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 17412 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 17519 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yyInode 18730 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 18974 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 19118 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yyInode 19806 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 19942 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 20303 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 20323 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 21047 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 21919 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 22180 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 22856 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 23462 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 23587 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 23775 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 23916 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 24046 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 24161 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yInode 25576 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 25666 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 25992 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 26404 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 26795 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 26862 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 26868 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yInode 27627 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 27959 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 28014 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yInode 29120 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 29308 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yyyyInode 30673 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yInode 31127 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 31332 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 31547 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yyInode 32727 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 32888 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 33062 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yyyInode 34421 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 34508 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yyyyInode 35996 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 36258 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yyInode 36867 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 37166 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 37171 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 37548 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 37732 extent tree (at level 1) could be shorter.  Optimize<y>? yes
yInode 38028 extent tree (at level 1) could be shorter.  Optimize<y>? yes
Inode 38099 extent tree (at level 1) could be shorter.  Optimize<y>? yes
....

So I tried:

root@e1-ext4-2k /var/lib/xfstests # fsck /dev/loop5 -y 2>&1 > log
e2fsck 1.47.2 (1-Jan-2025)
root@e1-ext4-2k /var/lib/xfstests # wc -l log
16411 log

root@e1-ext4-2k /var/lib/xfstests # tail log

Free blocks count wrong for group #609 (62, counted=63).
Fix? yes

Free blocks count wrong (12289, counted=12293).
Fix? yes


/dev/loop5: ***** FILE SYSTEM WAS MODIFIED *****
/dev/loop5: 1310719/1310720 files (10.7% non-contiguous),
10473467/10485760 blocks

  Luis

