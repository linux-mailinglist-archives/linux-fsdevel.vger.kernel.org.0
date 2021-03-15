Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DB333C391
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 18:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhCORJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 13:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230502AbhCORJA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:09:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 377F364E28;
        Mon, 15 Mar 2021 17:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615828140;
        bh=C3y1gWu0mj6sHOu2wbzix1MXb4Khnol0O9jGWjGXdoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfx8V+L248Sb0cOFIO9OpRQywUxlaYpHKq6/0+3HAz9iKhs5e3QFbf/TFMvLK+7eu
         zNAp73hif8Tx8HWFpGlWuBpSVd9wtOmspfcHyL9+/9fi9EvDzTx64ZQyfB1mz91rmf
         aDT3ENxqR65rFM023ecmh/PApDBHxGwi/jEXhzGjJv5VdoxGxtTD7wWnZ9wFPPf7Ke
         OlZ4TRO80L6r9lH8JWS8COBFqd4C3j+XTOoRRbtTLB7hpECJQEYwlKQxuCVEaLoxza
         +daAU5OflkO9OwY2pN9WaNLEMCOzzpp4iGS9kkm2a+axB+sS3rogNDPk8Kt5PNicqj
         87/fsXfqb11Ug==
Date:   Mon, 15 Mar 2021 10:08:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        kernel test robot <lkp@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 2/2] zonefs: Fix O_APPEND async write handling
Message-ID: <20210315170855.tguqrsl7wsbjojib@archlinux-ax161>
References: <20210315034919.87980-3-damien.lemoal@wdc.com>
 <202103151548.W9MG3wiF-lkp@intel.com>
 <PH0PR04MB741614B0DED04C088E0B075E9B6C9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <BL0PR04MB6514205221C23615549ED67DE76C9@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR04MB6514205221C23615549ED67DE76C9@BL0PR04MB6514.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 07:22:56AM +0000, Damien Le Moal wrote:
> On 2021/03/15 16:21, Johannes Thumshirn wrote:
> > On 15/03/2021 08:16, kernel test robot wrote:
> >> 818	static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
> >>    819	{
> >>    820		struct inode *inode = file_inode(iocb->ki_filp);
> >>    821		struct zonefs_inode_info *zi = ZONEFS_I(inode);
> >>    822		struct super_block *sb = inode->i_sb;
> >>    823		bool sync = is_sync_kiocb(iocb);
> >>    824		bool append = false;
> >>    825		ssize_t ret, count;
> > 
> >>    843		count = zonefs_write_checks(iocb, from);
> >>  > 844		if (count <= 0)
> >>    845			goto inode_unlock;
> > 
> > Args that needs to be:
> > 			if (count <= 0) {
> > 				ret = count;
> > 				goto inode_unlock;
> > 			}
> > 
> > Sorry for not spotting it.
> 
> Yep. Sending v2. Weird that gcc does not complain on my local compile...

Unfortunately, GCC's version of this warning was disabled for default
compiles by Linus in commit 78a5255ffb6a ("Stop the ad-hoc games with
-Wno-maybe-initialized"). W=2 is required, which can be quite noisy from
my understanding. KCFLAGS=-Wmaybe-uninitialized is a good option.

Cheers,
Nathan

> > 
> >>    878	inode_unlock:
> >>    879		inode_unlock(inode);
> >>    880	
> >>    881		return ret;
> >>    882	}
> >>    883	
> > 
> 
> -- 
> Damien Le Moal
> Western Digital Research
