Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5FE3B3180
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 16:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhFXOiq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 10:38:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53484 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230170AbhFXOim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:38:42 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15OEZOhp006025
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 10:35:25 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D389415C3CD7; Thu, 24 Jun 2021 10:35:24 -0400 (EDT)
Date:   Thu, 24 Jun 2021 10:35:24 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, adilger.kernel@dilger.ca, david@fromorbit.com,
        hch@infradead.org
Subject: Re: [RFC PATCH v4 2/8] jbd2: ensure abort the journal if detect IO
 error when writing original buffer back
Message-ID: <YNSYLBPMzhKK9ov+@mit.edu>
References: <20210610112440.3438139-1-yi.zhang@huawei.com>
 <20210610112440.3438139-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610112440.3438139-3-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 07:24:34PM +0800, Zhang Yi wrote:
> Although we merged c044f3d8360 ("jbd2: abort journal if free a async
> write error metadata buffer"), there is a race between
> jbd2_journal_try_to_free_buffers() and jbd2_journal_destroy(), so the
> jbd2_log_do_checkpoint() may still fail to detect the buffer write
> io error flag which may lead to filesystem inconsistency.
> 
> jbd2_journal_try_to_free_buffers()     ext4_put_super()
>                                         jbd2_journal_destroy()
>   __jbd2_journal_remove_checkpoint()
>   detect buffer write error              jbd2_log_do_checkpoint()
>                                          jbd2_cleanup_journal_tail()
>                                            <--- lead to inconsistency
>   jbd2_journal_abort()
> 
> Fix this issue by introducing a new atomic flag which only have one
> JBD2_CHECKPOINT_IO_ERROR bit now, and set it in
> __jbd2_journal_remove_checkpoint() when freeing a checkpoint buffer
> which has write_io_error flag. Then jbd2_journal_destroy() will detect
> this mark and abort the journal to prevent updating log tail.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
