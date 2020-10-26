Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B5E299049
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782287AbgJZO5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:57:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:51512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1782238AbgJZO5M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:57:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1249DABE3;
        Mon, 26 Oct 2020 14:57:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D4AEF1E10F5; Mon, 26 Oct 2020 15:57:10 +0100 (CET)
Date:   Mon, 26 Oct 2020 15:57:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Strange SEEK_HOLE / SEEK_DATA behavior
Message-ID: <20201026145710.GF28769@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

When reviewing Matthew's THP patches I've noticed one odd behavior which
got copied from current iomap seek hole/data helpers. Currently we have:

# fallocate -l 4096 testfile
# xfs_io -x -c "seek -h 0" testfile
Whence	Result
HOLE	0
# dd if=testfile bs=4096 count=1 of=/dev/null
# xfs_io -x -c "seek -h 0" testfile
Whence	Result
HOLE	4096

So once we read from an unwritten extent, the areas with cached pages
suddently become treated as data. Later when pages get evicted, they become
treated as holes again. Strictly speaking I wouldn't say this is a bug
since nobody promises we won't treat holes as data but it looks weird.
Shouldn't we treat clean pages over unwritten extents still as holes and
only once the page becomes dirty treat is as data? What do other people
think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
