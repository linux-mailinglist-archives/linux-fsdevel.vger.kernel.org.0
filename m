Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC30B584470
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 18:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiG1Qxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 12:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiG1Qxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:53:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53E474374;
        Thu, 28 Jul 2022 09:53:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4B961344D0;
        Thu, 28 Jul 2022 16:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659027223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZDY3aqgFQ6Ip+bma3fiKPCAe3pQSvpckr0RLpuq5rQ=;
        b=SoLXiq3lWEMmBTps7RexCtGXjqeUZr/yrZVFGs0Mg3eT5hJaKXRQ0jGDFcIscKxnHpEZ9W
        A7bs7m3WefWD5rc/12o4WemFNTmTj4+dxMX5SixnT/jaSulukjhu0VI3ChXYcho275bLL4
        7f7/yKK7wKJm51dtLu8dzaHGGPyCb6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659027223;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZDY3aqgFQ6Ip+bma3fiKPCAe3pQSvpckr0RLpuq5rQ=;
        b=0wOZLqCQPf/3CZON6pWb++WpEaMbUZYBM4htqOVSdgi3M58cDP9C6b+J9hZxX9QtSq8la2
        vqZzS4k0Z4tQ2KAw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B99662C141;
        Thu, 28 Jul 2022 16:53:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3D845A0668; Thu, 28 Jul 2022 18:53:32 +0200 (CEST)
Date:   Thu, 28 Jul 2022 18:53:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, jlayton@kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <20220728165332.cu2kiduob2xyvoep@quack3>
References: <20220728133914.49890-1-lczerner@redhat.com>
 <20220728133914.49890-2-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728133914.49890-2-lczerner@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 28-07-22 15:39:14, Lukas Czerner wrote:
> Currently the I_DIRTY_TIME will never get set if the inode already has
> I_DIRTY_INODE with assumption that it supersedes I_DIRTY_TIME.  That's
> true, however ext4 will only update the on-disk inode in
> ->dirty_inode(), not on actual writeback. As a result if the inode
> already has I_DIRTY_INODE state by the time we get to
> __mark_inode_dirty() only with I_DIRTY_TIME, the time was already filled
> into on-disk inode and will not get updated until the next I_DIRTY_INODE
> update, which might never come if we crash or get a power failure.
> 
> The problem can be reproduced on ext4 by running xfstest generic/622
> with -o iversion mount option. Fix it by setting I_DIRTY_TIME even if
> the inode already has I_DIRTY_INODE.

As a datapoint I've checked and XFS has the very same problem as ext4.

> Also clear the I_DIRTY_TIME after ->dirty_inode() otherwise it may never
> get cleared.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  fs/fs-writeback.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 05221366a16d..174f01e6b912 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2383,6 +2383,11 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  
>  		/* I_DIRTY_INODE supersedes I_DIRTY_TIME. */
>  		flags &= ~I_DIRTY_TIME;
> +		if (inode->i_state & I_DIRTY_TIME) {
> +			spin_lock(&inode->i_lock);
> +			inode->i_state &= ~I_DIRTY_TIME;
> +			spin_unlock(&inode->i_lock);
> +		}

Hum, so this is a bit dangerous because inode->i_state may be inconsistent
with the writeback list inode is queued in (wb->b_dirty_time) and these two
are supposed to be in sync. So I rather think we need to make sure we go
through the full round of 'update flags and writeback list' below in case
we need to clear I_DIRTY_TIME from inode->i_state.

>  	} else {
>  		/*
>  		 * Else it's either I_DIRTY_PAGES, I_DIRTY_TIME, or nothing.
> @@ -2399,13 +2404,20 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  	 */
>  	smp_mb();
>  
> -	if (((inode->i_state & flags) == flags) ||
> -	    (dirtytime && (inode->i_state & I_DIRTY_INODE)))
> +	if ((inode->i_state & flags) == flags)
>  		return;
>  
>  	spin_lock(&inode->i_lock);
> -	if (dirtytime && (inode->i_state & I_DIRTY_INODE))
> +	if (dirtytime && (inode->i_state & I_DIRTY_INODE)) {
> +		/*
> +		 * We've got a new lazytime update. Make sure it's recorded in
> +		 * i_state, because the time might have already got updated in
> +		 * ->dirty_inode() and will not get updated until next
> +		 *  I_DIRTY_INODE update.
> +		 */
> +		inode->i_state |= I_DIRTY_TIME;
>  		goto out_unlock_inode;
> +	}

So I'm afraid this combination is not properly handled in
writeback_single_inode() where we have at the end:

        if (!(inode->i_state & I_DIRTY_ALL))
                inode_cgwb_move_to_attached(inode, wb);
        else if (!(inode->i_state & I_SYNC_QUEUED) &&
                 (inode->i_state & I_DIRTY))
                redirty_tail_locked(inode, wb);

So inode that had I_DIRTY_SYNC | I_DIRTY_TIME will not be properly refiled
to wb->b_dirty_time list after writeback was done and I_DIRTY_SYNC got
cleared.

So we need to refine it to something like:

	if (!(inode->i_state & I_DIRTY_ALL))
		inode_cgwb_move_to_attached(inode, wb);
	else if (!(inode->i_state & I_SYNC_QUEUED)) {
		if (inode->i_state & I_DIRTY) {
			redirty_tail_locked(inode, wb);
		} else if (inode->i_state & I_DIRTY_TIME) {
			inode->dirtied_when = jiffies;
			inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
		}
	}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
