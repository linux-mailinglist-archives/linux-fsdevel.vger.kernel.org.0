Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846E98E7BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 11:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfHOJGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 05:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730212AbfHOJGG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:06:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEF3A218A6;
        Thu, 15 Aug 2019 09:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565859965;
        bh=Mc3YrEyyDx8AvnWtpvQCsXoWv0AaiAhsDt9By4lPmxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3L5k2vJ2kFpsG2wfCLVkOngcZzZqI9yll1frug6xM0uM7bdwF/+iA26VOaSAndDN
         v6ed2vDKBv2obKuG2LL7maD7MOtU/i9uIyZSa3nZVUd+iYA5s3wlBu9pi47qQOVRbO
         /OliDX5MrGyc2/QiINacfpFQxVdBu/vbpytThbqc=
Date:   Thu, 15 Aug 2019 11:06:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Pavel Machek <pavel@denx.de>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Li Guifu <bluce.liguifu@huawei.com>,
        David Sterba <dsterba@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v8 00/24] erofs: promote erofs from staging v8
Message-ID: <20190815090603.GD4938@kroah.com>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815044155.88483-1-gaoxiang25@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 12:41:31PM +0800, Gao Xiang wrote:
> [I strip the previous cover letter, the old one can be found in v6:
>  https://lore.kernel.org/r/20190802125347.166018-1-gaoxiang25@huawei.com/]
> 
> We'd like to submit a formal moving patch applied to staging tree
> for 5.4, before that we'd like to hear if there are some ACKs,
> suggestions or NAKs, objections of EROFS. Therefore, we can improve
> it in this round or rethink about the whole thing.
> 
> As related materials mentioned [1] [2], the goal of EROFS is to
> save extra storage space with guaranteed end-to-end performance
> for read-only files, which has better performance over exist Linux
> compression filesystems based on fixed-sized output compression
> and inplace decompression. It even has better performance in
> a large compression ratio range compared with generic uncompressed
> filesystems with proper CPU-storage combinations. And we think this
> direction is correct and a dedicated kernel team is continuously /
> actively working on improving it, enough testers and beta / end
> users using it.
> 
> EROFS has been applied to almost all in-service HUAWEI smartphones
> (Yes, the number is still increasing by time) and it seems like
> a success. It can be used in more wider scenarios. We think it's
> useful for Linux / Android OS community and it's the time moving
> out of staging.
> 
> In order to get started, latest stable mkfs.erofs is available at
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b dev
> 
> with README in the repository.
> 
> We are still tuning sequential read performance for ultra-fast
> speed NVME SSDs like Samsung 970PRO, but at least now you can
> try on your PC with some data with proper compression ratio,
> the latest Linux kernel, USB stick for convenience sake and
> a not very old-fashioned CPU. There are also benchmarks available
> in the above materials mentioned.
> 
> EROFS is a self-contained filesystem driver. Although there are
> still some TODOs to be more generic, we will actively keep on
> developping / tuning EROFS with the evolution of Linux kernel
> as the other in-kernel filesystems.
> 
> As I mentioned before in LSF/MM 2019, in the future, we'd like
> to generalize the decompression engine into a library for other
> fses to use after the whole system is mature like fscrypt.
> However, such metadata should be designed respectively for
> each fs, and synchronous metadata read cost will be larger
> than EROFS because of those ondisk limitation. Therefore EROFS
> is still a better choice for read-only scenarios.
> 
> EROFS is now ready for reviewing and moving, and the code is
> already cleaned up as shiny floors... Please kindly take some
> precious time, share your comments about EROFS and let us know
> your opinion about this. It's really important for us since
> generally speaking, we like to use Linux _in-tree_ stuffs rather
> than lack of supported out-of-tree / orphan stuffs as well.

I know everyone is busy, but given the length this has been in staging,
and the constant good progress toward cleaning it all up that has been
happening, I want to get this moved out of staging soon.

So, unless there are any objections, I'll take this patchset in a week
into my staging tree to move the filesystem into the "real" part of the
kernel.

thanks,

greg k-h
