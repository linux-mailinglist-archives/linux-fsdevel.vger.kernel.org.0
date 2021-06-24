Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9AE3B31D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 16:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhFXO6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 10:58:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57075 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231250AbhFXO6w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:58:52 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15OEuFGA016041
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 10:56:15 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3818D15C3CD7; Thu, 24 Jun 2021 10:56:15 -0400 (EDT)
Date:   Thu, 24 Jun 2021 10:56:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, adilger.kernel@dilger.ca, david@fromorbit.com,
        hch@infradead.org
Subject: Re: [RFC PATCH v4 5/8] jbd2,ext4: add a shrinker to release
 checkpointed buffers
Message-ID: <YNSdD4sW5ajlk/Cv@mit.edu>
References: <20210610112440.3438139-1-yi.zhang@huawei.com>
 <20210610112440.3438139-6-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610112440.3438139-6-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 07:24:37PM +0800, Zhang Yi wrote:
> Current metadata buffer release logic in bdev_try_to_free_page() have
> a lot of use-after-free issues when umount filesystem concurrently, and
> it is difficult to fix directly because ext4 is the only user of
> s_op->bdev_try_to_free_page callback and we may have to add more special
> refcount or lock that is only used by ext4 into the common vfs layer,
> which is unacceptable.
> 
> One better solution is remove the bdev_try_to_free_page callback, but
> the real problem is we cannot easily release journal_head on the
> checkpointed buffer, so try_to_free_buffers() cannot release buffers and
> page under memory pressure, which is more likely to trigger
> out-of-memory. So we cannot remove the callback directly before we find
> another way to release journal_head.
> 
> This patch introduce a shrinker to free journal_head on the checkpointed
> transaction. After the journal_head got freed, try_to_free_buffers()
> could free buffer properly.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
