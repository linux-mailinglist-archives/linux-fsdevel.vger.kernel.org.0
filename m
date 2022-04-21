Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D5650A36C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 16:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244846AbiDUO6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 10:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389713AbiDUO5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:57:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B0143AE1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 07:54:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EEAC8210EB;
        Thu, 21 Apr 2022 14:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650552872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8rfifwXGvc9hKlSwl2Kl78XhnggQ01oFP3IUMA0xE0=;
        b=YKrYMFxmoads5dGPotB/GL0CebVJj3ZaOvF0JICcDS0dYCcCIqP9Xh8CvBae3alM9C2NTt
        bsDG1yvi9Xa+HERg396J8LYwbyt/436u4NRrwA2noc1J4V9sZ12pn4YzdhBwQV6SCt8np+
        NIqqtkPwq/vs54H7NQfAnkFKoxJ/F+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650552872;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8rfifwXGvc9hKlSwl2Kl78XhnggQ01oFP3IUMA0xE0=;
        b=o2JAs6d+aA4Ic8M5y85RN+m2GqZYqV8x/jUXFyL07HQiQaE/Fiw2gZcTF2d2sBEh1pZV8W
        dnDQbdKU7r7wgRBg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D527B2C141;
        Thu, 21 Apr 2022 14:54:32 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 41B3FA0620; Thu, 21 Apr 2022 16:54:32 +0200 (CEST)
Date:   Thu, 21 Apr 2022 16:54:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 11/16] fsnotify: allow adding an inode mark without
 pinning inode
Message-ID: <20220421145432.7egh77pypqbii74o@quack3.lan>
References: <20220413090935.3127107-1-amir73il@gmail.com>
 <20220413090935.3127107-12-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413090935.3127107-12-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-04-22 12:09:30, Amir Goldstein wrote:
> fsnotify_add_mark() and variants implicitly take a reference on inode
> when attaching a mark to an inode.
> 
> Make that behavior opt-out with the mark flag FSNOTIFY_MARK_FLAG_NO_IREF.
> 
> Instead of taking the inode reference when attaching connector to inode
> and dropping the inode reference when detaching connector from inode,
> take the inode reference on attach of the first mark that wants to hold
> an inode reference and drop the inode reference on detach of the last
> mark that wants to hold an inode reference.
> 
> Backends can "upgrade" an existing mark to take an inode reference, but
> cannot "downgrade" a mark with inode reference to release the refernce.
> 
> This leaves the choice to the backend whether or not to pin the inode
> when adding an inode mark.
> 
> This is intended to be used when adding a mark with ignored mask that is
> used for optimization in cases where group can afford getting unneeded
> events and reinstate the mark with ignored mask when inode is accessed
> again after being evicted.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Just two nits below.

> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 7120918d8251..e38cb241536f 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -116,20 +116,67 @@ __u32 fsnotify_conn_mask(struct fsnotify_mark_connector *conn)
>  	return *fsnotify_conn_mask_p(conn);
>  }
>  
> -static void __fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
> +/*
> + * Update the proxy refcount on inode maintainted by connector.
> + *
> + * When it's time to drop the proxy refcount, clear the HAS_IREF flag
> + * and return the inode object.  fsnotify_drop_object() will be resonsible
> + * for doing iput() outside of spinlocks when last mark that wanted iref
> + * is detached.
> + *
> + * Note that the proxy refcount is NOT dropped if backend only sets the
> + * NO_IREF mark flag and does detach the mark!
> + */

This comment seems outdated - still speaking about proxy refcount which
does not exist anymore...

> +static void fsnotify_get_inode_ref(struct inode *inode)
> +{
> +	ihold(inode);
> +	atomic_long_inc(&inode->i_sb->s_fsnotify_connectors);
> +}
> +
> @@ -505,6 +551,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
>  		return -ENOMEM;
>  	spin_lock_init(&conn->lock);
>  	INIT_HLIST_HEAD(&conn->list);
> +	conn->flags = 0;

Why this? We init conn->flags just a bit later...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
