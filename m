Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181ACBC8A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 15:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441057AbfIXNNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 09:13:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:46978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440971AbfIXNNa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 09:13:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7591AE5C;
        Tue, 24 Sep 2019 13:13:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D51991E4427; Tue, 24 Sep 2019 15:13:43 +0200 (CEST)
Date:   Tue, 24 Sep 2019 15:13:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v3 2/6] ext4: move inode extension/truncate code out from
 ext4_iomap_end()
Message-ID: <20190924131343.GB11819@quack2.suse.cz>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <784214745d589dd2bdcde2d69a69e837e6980592.1568282664.git.mbobrowski@mbobrowski.org>
 <20190923162115.GG20367@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923162115.GG20367@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 23-09-19 18:21:15, Jan Kara wrote:
> On Thu 12-09-19 21:04:00, Matthew Bobrowski wrote:
> So I'd just call ext4_handle_inode_extension() unconditionally like:
> 
> 	error = ext4_handle_inode_extension(inode, offset, ret, len);
> 
> and have a quick check at the beginning of that function to avoid starting
> transaction when there isn't anything to do. Something like:
> 
> 	/*
> 	 * DIO and DAX writes get exclusion from truncate (i_rwsem) and
> 	 * page writeback (i_rwsem and flushing all dirty pages).
> 	 */
> 	WARN_ON_ONCE(i_size_read(inode) != EXT4_I(inode)->i_disksize);
> 	if (offset + count <= i_size_read(inode))
> 		return 0;

One correction here. With commit 45d8ec4d9fd54 in mind this should be:

 	/*
 	 * DIO and DAX writes get exclusion from truncate (i_rwsem). There
 	 * can be pending delalloc writeback beyond the range written by
 	 * DIO though.
 	 */
 	WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
 	if (offset + count <= EXT4_I(inode)->i_disksize)
 		return 0;

								Honza

> 	if (len < 0)
> 		goto truncate;
> 
> 	... do the heavylifting with transaction start, inode size update,
> 	and orphan handling...
> 
> 	if (truncate) {
> truncate:
> 		ext4_truncate_failed_write(inode);
> orphan_del:
> 		/*
> 		 * If the truncate operation failed early the inode
> 		 * may still be on the orphan list. In that case, we
> 		 * need try remove the inode from the linked list in
> 		 * memory.
> 		 */
> 		if (inode->i_nlink)
> 			ext4_orphan_del(NULL, inode);
> 	}
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
