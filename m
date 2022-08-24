Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354765A006D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 19:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbiHXRcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 13:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbiHXRcG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:32:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99BA7E309;
        Wed, 24 Aug 2022 10:32:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 18EB6346EE;
        Wed, 24 Aug 2022 17:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661362323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZhpnH9UkJ7Vb+Ss6HU7G5rPt6ff/Whuzp6/WdawmjKU=;
        b=ukG5miMRu0grAi2XW4Fs5XLCHlafehvSEx+xYFbJQXF0Vhw8zjJ765TxH93hJoIc92+LFi
        1EV2t6koW154qu2eeaOsgWUrFtJr//0bP56xnDmTBnIeGyOqvCjgXsh/ta88CJm+PalA+Y
        nXQYZ/cPIRtYUZqYVEQEe3znYcygr50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661362323;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZhpnH9UkJ7Vb+Ss6HU7G5rPt6ff/Whuzp6/WdawmjKU=;
        b=qBazGQuuQstl/06tpGDchjVx7egmzmcYiYNE0lOnMaV9swxKVEfEfSlpfOryo12K3G2PYj
        dOyBivHa0u91jTAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3890D13AC0;
        Wed, 24 Aug 2022 17:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 54rADZJgBmMRTQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 24 Aug 2022 17:32:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0B463A0679; Wed, 24 Aug 2022 19:31:46 +0200 (CEST)
Date:   Wed, 24 Aug 2022 19:31:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jlayton@kernel.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org,
        david@fromorbit.com, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 2/3] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <20220824173146.rza57sg5fuf2fc6b@quack3>
References: <20220824160349.39664-1-lczerner@redhat.com>
 <20220824160349.39664-2-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824160349.39664-2-lczerner@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 24-08-22 18:03:48, Lukas Czerner wrote:
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
> with -o iversion mount option.
> 
> Fix it by allowing I_DIRTY_TIME to be set even if the inode already has
> I_DIRTY_INODE. Also make sure that the case is properly handled in
> writeback_single_inode() as well. Additionally changes in
> xfs_fs_dirty_inode() was made to accommodate for I_DIRTY_TIME in flag.
> 
> Thanks Jan Kara for suggestions on how to make this work properly.
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just two nits below:

> @@ -2369,6 +2374,17 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  	trace_writeback_mark_inode_dirty(inode, flags);
>  
>  	if (flags & I_DIRTY_INODE) {
> +

Pointless empty line here.

> +		/* Inode timestamp update will piggback on this dirtying */

Maybe expand this comment to:

		/*
		 * Inode timestamp update will piggback on this dirtying.
		 * We tell ->dirty_inode callback that timestamps need to
		 * be updated by setting I_DIRTY_TIME in flags.
		 */
> +		if (inode->i_state & I_DIRTY_TIME) {
> +			spin_lock(&inode->i_lock);
> +			if (inode->i_state & I_DIRTY_TIME) {
> +				inode->i_state &= ~I_DIRTY_TIME;
> +				flags |= I_DIRTY_TIME;
> +			}
> +			spin_unlock(&inode->i_lock);
> +		}
> +

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
