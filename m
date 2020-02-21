Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1E4167E2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 14:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBUNOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 08:14:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:48580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbgBUNOt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:14:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E4372AF4D;
        Fri, 21 Feb 2020 13:14:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46E03DA70E; Fri, 21 Feb 2020 14:14:30 +0100 (CET)
Date:   Fri, 21 Feb 2020 14:14:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
Message-ID: <20200221131429.GF2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20200220152355.5ticlkptc7kwrifz@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220152355.5ticlkptc7kwrifz@fiona>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 09:23:55AM -0600, Goldwyn Rodrigues wrote:
> In case of a block device error, written parameter in iomap_end()
> is zero as opposed to the amount of submitted I/O.
> Filesystems such as btrfs need to account for the I/O in ordered
> extents, even if it resulted in an error. Having (incomplete)
> submitted bytes in written gives the filesystem the amount of data
> which has been submitted before the error occurred, and the
> filesystem code can choose how to use it.
> 
> The final returned error for iomap_dio_rw() is set by
> iomap_dio_complete().
> 
> Partial writes in direct I/O are considered an error. So,
> ->iomap_end() using written == 0 as error must be changed
> to written < length. In this case, ext4 is the only user.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 41c1e7c20a1f..01865db1bd09 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -264,7 +264,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		size_t n;
>  		if (dio->error) {
>  			iov_iter_revert(dio->submit.iter, copied);
> -			copied = ret = 0;
> +			ret = 0;
>  			goto out;
>  		}

This part fixes problems I saw with the dio-iomap btrfs conversion
patchset, thanks.
