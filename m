Return-Path: <linux-fsdevel+bounces-2799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15B07EA1CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 18:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D9B8B20A31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 17:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB6224D9;
	Mon, 13 Nov 2023 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEE2/t5y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1407224CE;
	Mon, 13 Nov 2023 17:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6600C433C7;
	Mon, 13 Nov 2023 17:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699896055;
	bh=xAPJraPLQAkSEMrXbNNi6jnVOIDBHLRqKC+IUziKfv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEE2/t5yeQlHrX4qRNp8a2xVGp/zSrsUOLZtJjfwyLlI4zC1VrUhYtZQjrOxjSHul
	 8nJlAJEh4Prmu8Rr3qjB3/SCk9lhLw+mNpceoAxGHdE0Y1JT0JJUkEChj2P9djSJWx
	 fUG8TtajhlmY4lSoj8Ry4QfRHkTwB8DdYp/lghse/8BRVvK720VCM9uzQQ0jmJqY16
	 fW4r53/T0pkOSV0Kv+hhHT2sx9GsKmZh/1eu/vsVfvuj7xkjUVoKpFQ8hh51TJp0JR
	 xO2/jgnklHdisx8V+WoHOequXkLyLQatexoWCTIcFVEx3wQi1pAGJk4SDSny/Ieg2k
	 +LNa9i0iS8RRA==
Date: Mon, 13 Nov 2023 10:20:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] buffer: Fix grow_buffers() for block size >
 PAGE_SIZE
Message-ID: <20231113172052.GA3733520@dev-arch.thelio-3990X>
References: <20231109210608.2252323-4-willy@infradead.org>
 <202311121240.AN8GbAbe-lkp@intel.com>
 <20231113091006.f9d4de1aaf7ed2f8beef07fb@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113091006.f9d4de1aaf7ed2f8beef07fb@linux-foundation.org>

On Mon, Nov 13, 2023 at 09:10:06AM -0800, Andrew Morton wrote:
> On Sun, 12 Nov 2023 12:52:00 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Matthew,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on akpm-mm/mm-everything]
> > [also build test ERROR on linus/master next-20231110]
> > [cannot apply to v6.6]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/buffer-Return-bool-from-grow_dev_folio/20231110-051651
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > patch link:    https://lore.kernel.org/r/20231109210608.2252323-4-willy%40infradead.org
> > patch subject: [PATCH v2 3/7] buffer: Fix grow_buffers() for block size > PAGE_SIZE
> > config: hexagon-comet_defconfig (https://download.01.org/0day-ci/archive/20231112/202311121240.AN8GbAbe-lkp@intel.com/config)
> > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311121240.AN8GbAbe-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202311121240.AN8GbAbe-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> ld.lld: error: undefined symbol: __muloti4
> >    >>> referenced by buffer.c
> >    >>>               fs/buffer.o:(bdev_getblk) in archive vmlinux.a
> >    >>> referenced by buffer.c
> >    >>>               fs/buffer.o:(bdev_getblk) in archive vmlinux.a
> > 
> 
> What a peculiar compiler.
> 
> I assume this fixes?
> 
> --- a/fs/buffer.c~buffer-fix-grow_buffers-for-block-size-page_size-fix
> +++ a/fs/buffer.c
> @@ -1099,7 +1099,7 @@ static bool grow_buffers(struct block_de
>  	}
>  
>  	/* Create a folio with the proper size buffers */
> -	return grow_dev_folio(bdev, block, pos / PAGE_SIZE, size, gfp);
> +	return grow_dev_folio(bdev, block, pos >> PAGE_SHIFT, size, gfp);
>  }
>  
>  static struct buffer_head *
> _
> 
> 

No, this is not a division libcall. This seems to be related to the
types of the variables used in __builtin_mul_overflow() :/ for some odd
reason, clang generates a libcall when passing in an 'unsigned long
long' and 'unsigned int', which apparently has not been done before in
the kernel?

https://github.com/ClangBuiltLinux/linux/issues/1958
https://godbolt.org/z/csfGc6z6c

A cast would work around this but that could have other implications I
am not aware of (I've done little further investigation due to LPC):

diff --git a/fs/buffer.c b/fs/buffer.c
index 4eb44ccdc6be..d39934783743 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1091,7 +1091,7 @@ static bool grow_buffers(struct block_device *bdev, sector_t block,
 	 * Check for a block which lies outside our maximum possible
 	 * pagecache index.
 	 */
-	if (check_mul_overflow(block, size, &pos) || pos > MAX_LFS_FILESIZE) {
+	if (check_mul_overflow(block, (u64)size, &pos) || pos > MAX_LFS_FILESIZE) {
 		printk(KERN_ERR "%s: requested out-of-range block %llu for device %pg\n",
 			__func__, (unsigned long long)block,
 			bdev);

Cheers,
Nathan

