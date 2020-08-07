Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8024823F22E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 19:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgHGRt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 13:49:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37728 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726038AbgHGRt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:49:56 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 077HnP53001823
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Aug 2020 13:49:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2D34B420263; Fri,  7 Aug 2020 13:49:25 -0400 (EDT)
Date:   Fri, 7 Aug 2020 13:49:25 -0400
From:   tytso@mit.edu
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     <linux-ext4@vger.kernel.org>, <jack@suse.cz>,
        <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] ext4: abort the filesystem if failed to async
 write metadata buffer
Message-ID: <20200807174925.GV7657@mit.edu>
References: <20200620025427.1756360-1-yi.zhang@huawei.com>
 <20200620025427.1756360-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620025427.1756360-2-yi.zhang@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 10:54:23AM +0800, zhangyi (F) wrote:
> There is a risk of filesystem inconsistency if we failed to async write
> back metadata buffer in the background. Because of current buffer's end
> io procedure is handled by end_buffer_async_write() in the block layer,
> and it only clear the buffer's uptodate flag and mark the write_io_error
> flag, so ext4 cannot detect such failure immediately. In most cases of
> getting metadata buffer (e.g. ext4_read_inode_bitmap()), although the
> buffer's data is actually uptodate, it may still read data from disk
> because the buffer's uptodate flag has been cleared. Finally, it may
> lead to on-disk filesystem inconsistency if reading old data from the
> disk successfully and write them out again.
> 
> This patch detect bdev mapping->wb_err when getting journal's write
> access and mark the filesystem error if bdev's mapping->wb_err was
> increased, this could prevent further writing and potential
> inconsistency.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Thanks, applied.

							- Ted
