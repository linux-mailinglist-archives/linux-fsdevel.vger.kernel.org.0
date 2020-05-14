Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1221D33C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 16:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgENO5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 10:57:50 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59709 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726179AbgENO5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 10:57:50 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04EEvi0s008963
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 10:57:44 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 37502420304; Thu, 14 May 2020 10:57:44 -0400 (EDT)
Date:   Thu, 14 May 2020 10:57:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH 3/3] ext4: Avoid freeing inodes on dirty list
Message-ID: <20200514145744.GW1596452@mit.edu>
References: <20200421085445.5731-1-jack@suse.cz>
 <20200421085445.5731-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421085445.5731-4-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 10:54:45AM +0200, Jan Kara wrote:
> When we are evicting inode with journalled data, we may race with
> transaction commit in the following way:
> 
> CPU0					CPU1
> jbd2_journal_commit_transaction()	evict(inode)
> 					  inode_io_list_del()
> 					  inode_wait_for_writeback()
>   process BJ_Forget list
>     __jbd2_journal_insert_checkpoint()
>     __jbd2_journal_refile_buffer()
>       __jbd2_journal_unfile_buffer()
>         if (test_clear_buffer_jbddirty(bh))
>           mark_buffer_dirty(bh)
> 	    __mark_inode_dirty(inode)
> 					  ext4_evict_inode(inode)
> 					    frees the inode
> 
> This results in use-after-free issues in the writeback code (or
> the assertion added in the previous commit triggering).
> 
> Fix the problem by removing inode from writeback lists once all the page
> cache is evicted and so inode cannot be added to writeback lists again.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Applied, thanks.

						- Ted
