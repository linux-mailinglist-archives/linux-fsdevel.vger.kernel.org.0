Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDB91145A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfLERSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:18:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:53228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729931AbfLERSX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:18:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6FF2B234;
        Thu,  5 Dec 2019 17:18:21 +0000 (UTC)
Date:   Thu, 5 Dec 2019 18:18:15 +0100
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org,
        nborisov@suse.com, dsterba@suse.cz,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/8] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20191205171815.GA19670@Johanness-MacBook-Pro.local>
References: <20191205155630.28817-1-rgoldwyn@suse.de>
 <20191205155630.28817-5-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205155630.28817-5-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 09:56:26AM -0600, Goldwyn Rodrigues wrote:
[...]
> +static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	ssize_t ret = 0;
> +
> +	if (iocb->ki_flags & IOCB_DIRECT) {
> +		struct inode *inode = file_inode(iocb->ki_filp);
> +
> +		inode_lock_shared(inode);
> +		ret = btrfs_direct_IO(iocb, to);
> +		inode_unlock_shared(inode);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return generic_file_buffered_read(iocb, to, ret);

This could as well call generic_file_read_iter() and would thus make patch 1
of this series obsolete. I think this is cleaner.

Thanks,
	Johannes
