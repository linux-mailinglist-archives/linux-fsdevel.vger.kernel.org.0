Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AD01A89C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 20:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504097AbgDNShb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 14:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504089AbgDNSh0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:37:26 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7462A20575;
        Tue, 14 Apr 2020 18:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586889443;
        bh=cauObjlwmdet1Zv/2eis89Ja/RROM0qVoqgZxwHGT4c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=O4oqV/J8mhsohmjix0IJ3G4Nf8nDbP/6rgLNvf/g7y6h/afbTKqHHSyK+mhkLjKBF
         U307yR6DZF9A+YPIFGg8WJXb7YSCOVxhu+jk8KoNoTuqJAKDI+dIByT1Nk4JV1JDJ8
         uC2DDespudGu5inDlgL/BR5a+7MMToq3bsV5TG40=
Message-ID: <19cac5afa0496e049535f5129804b687cdf64dbb.camel@kernel.org>
Subject: Re: [PATCH v4 RESEND 2/2] buffer: record blockdev write errors in
 super_block that it backs
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        andres@anarazel.de, willy@infradead.org, dhowells@redhat.com,
        hch@infradead.org, akpm@linux-foundation.org, david@fromorbit.com
Date:   Tue, 14 Apr 2020 14:37:21 -0400
In-Reply-To: <20200414162639.GK28226@quack2.suse.cz>
References: <20200414120409.293749-1-jlayton@kernel.org>
         <20200414120409.293749-3-jlayton@kernel.org>
         <20200414162639.GK28226@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-04-14 at 18:26 +0200, Jan Kara wrote:
> On Tue 14-04-20 08:04:09, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> > 
> > When syncing out a block device (a'la __sync_blockdev), any error
> > encountered will only be recorded in the bd_inode's mapping. When the
> > blockdev contains a filesystem however, we'd like to also record the
> > error in the super_block that's stored there.
> > 
> > Make mark_buffer_write_io_error also record the error in the
> > corresponding super_block when a writeback error occurs and the block
> > device contains a mounted superblock.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> 
> The patch looks good to me. I'd just note that bh->b_bdev->bd_super
> dereference is safe only because we will flush all dirty data when
> unmounting a filesystem which is somewhat tricky. Maybe that warrants a
> comment? Otherwise feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Oh, hmm...now that I look again, I'm not sure this is actually safe.

bh->b_bdev gets cleared out as we discard the buffer, so I don't think
that could end up getting zeroed while we're still using it.

The bd_super pointer gets zeroed out in kill_block_super, and after that
point it calls sync_blockdev(). Could writeback error processing race
with kill_block_super such that bd_inode gets set to NULL after we test
it but before we dereference it?

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

