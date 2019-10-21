Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC519DEE6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 15:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfJUNxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 09:53:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:34878 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727152AbfJUNxk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:53:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 772EEB9B8;
        Mon, 21 Oct 2019 13:53:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CF5211E4AA2; Mon, 21 Oct 2019 15:53:37 +0200 (CEST)
Date:   Mon, 21 Oct 2019 15:53:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 09/12] ext4: move inode extension/truncate code out
 from ->iomap_end() callback
Message-ID: <20191021135337.GH25184@quack2.suse.cz>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <629e86cf14761cdb716bce57feec9997abdd6ff6.1571647179.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629e86cf14761cdb716bce57feec9997abdd6ff6.1571647179.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-10-19 20:18:56, Matthew Bobrowski wrote:
> In preparation for implementing the iomap direct I/O modifications,
> the inode extension/truncate code needs to be moved out from the
> ext4_iomap_end() callback. For direct I/O, if the current code
> remained, it would behave incorrrectly. Updating the inode size prior
> to converting unwritten extents would potentially allow a racing
> direct I/O read to find unwritten extents before being converted
> correctly.
> 
> The inode extension/truncate code now resides within a new helper
> ext4_handle_inode_extension(). This function has been designed so that
> it can accommodate for both DAX and direct I/O extension/truncate
> operations.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> ---
>  fs/ext4/file.c  | 71 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  fs/ext4/inode.c | 48 +--------------------------------
>  2 files changed, 71 insertions(+), 48 deletions(-)
> 

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

One nit below:

> +static ssize_t ext4_handle_inode_extension(struct inode *inode, ssize_t written,
> +					   loff_t offset, size_t count)

IMHO a bit more logical ordering of arguments would be 'inode, offset,
written, count'...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
