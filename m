Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41E94DC9F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 16:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbiCQP3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 11:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbiCQP3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:29:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095D3207A03
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 08:27:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9DB8F1F37F;
        Thu, 17 Mar 2022 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647530864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ba37Sn5Isnfr1xb5UZN0sl6DsctIfjmQRjzTGypIhb8=;
        b=RgcFzjkOVkmBmwimRDiFOteMbwBl1uRmghnHZlHmwTXfzN/Qda69B4LvQtk41KXsH15lyt
        XNNljeieFgpJrLU4jdJuGUM6MC8wYDxunxlryFGx7wk9Cl7WjF6ncR+5bByV6Y3TxR4xJL
        NIRSnwA96eL2M7kvbGzyH7rmk507yqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647530864;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ba37Sn5Isnfr1xb5UZN0sl6DsctIfjmQRjzTGypIhb8=;
        b=RNZn8LyvL92aHgBWugvf08+AJYA8CqV0MFXnVzo6o09to9g49Sl+ej73TmGyFcnfZTNi30
        318hSKtxRXNn++CQ==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6C2F3A3B83;
        Thu, 17 Mar 2022 15:27:44 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1FA2CA0615; Thu, 17 Mar 2022 16:27:41 +0100 (CET)
Date:   Thu, 17 Mar 2022 16:27:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] fsnotify: allow adding an inode mark without pinning
 inode
Message-ID: <20220317152741.mzd5u2larfhrs2cg@quack3.lan>
References: <20220307155741.1352405-1-amir73il@gmail.com>
 <20220307155741.1352405-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307155741.1352405-4-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 07-03-22 17:57:39, Amir Goldstein wrote:
> fsnotify_add_mark() and variants implicitly take a reference on inode
> when attaching a mark to an inode.
> 
> Make that behavior opt-out with the flag FSNOTIFY_ADD_MARK_NO_IREF.
> 
> Instead of taking the inode reference when attaching connector to inode
> and dropping the inode reference when detaching connector from inode,
> take the inode reference on attach of the first mark that wants to hold
> an inode reference and drop the inode reference on detach of the last
> mark that wants to hold an inode reference.
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

Couple of notes below.

> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 190df435919f..f71b6814bfa7 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -213,6 +213,17 @@ static void *fsnotify_detach_connector_from_object(
>  	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
>  		inode = fsnotify_conn_inode(conn);
>  		inode->i_fsnotify_mask = 0;
> +
> +		pr_debug("%s: inode=%p iref=%u sb_connectors=%lu icount=%u\n",
> +			 __func__, inode, atomic_read(&conn->proxy_iref),
> +			 atomic_long_read(&inode->i_sb->s_fsnotify_connectors),
> +			 atomic_read(&inode->i_count));

Are these pr_debug() prints that useful? My experience is they get rarely used
after the code is debugged... If you think some places are useful longer
term, tracepoints are probably easier to use these days?

> +
> +		/* Unpin inode when detaching from connector */
> +		if (atomic_read(&conn->proxy_iref))
> +			atomic_set(&conn->proxy_iref, 0);
> +		else
> +			inode = NULL;

proxy_iref is always manipulated under conn->lock so there's no need for
atomic operations here.

>  	} else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
>  		fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
>  	} else if (conn->type == FSNOTIFY_OBJ_TYPE_SB) {
> @@ -240,12 +251,43 @@ static void fsnotify_final_mark_destroy(struct fsnotify_mark *mark)
>  /* Drop object reference originally held by a connector */
>  static void fsnotify_drop_object(unsigned int type, void *objp)
>  {
> +	struct inode *inode = objp;
> +
>  	if (!objp)
>  		return;
>  	/* Currently only inode references are passed to be dropped */
>  	if (WARN_ON_ONCE(type != FSNOTIFY_OBJ_TYPE_INODE))
>  		return;
> -	fsnotify_put_inode_ref(objp);
> +
> +	pr_debug("%s: inode=%p sb_connectors=%lu, icount=%u\n", __func__,
> +		 inode, atomic_long_read(&inode->i_sb->s_fsnotify_connectors),
> +		 atomic_read(&inode->i_count));
> +
> +	fsnotify_put_inode_ref(inode);
> +}
> +
> +/* Drop the proxy refcount on inode maintainted by connector */
> +static struct inode *fsnotify_drop_iref(struct fsnotify_mark_connector *conn,
> +					unsigned int *type)
> +{
> +	struct inode *inode = fsnotify_conn_inode(conn);
> +
> +	if (WARN_ON_ONCE(!inode || conn->type != FSNOTIFY_OBJ_TYPE_INODE))
> +		return NULL;
> +
> +	pr_debug("%s: inode=%p iref=%u sb_connectors=%lu icount=%u\n",
> +		 __func__, inode, atomic_read(&conn->proxy_iref),
> +		 atomic_long_read(&inode->i_sb->s_fsnotify_connectors),
> +		 atomic_read(&inode->i_count));
> +
> +	if (WARN_ON_ONCE(!atomic_read(&conn->proxy_iref)) ||
> +	    !atomic_dec_and_test(&conn->proxy_iref))
> +		return NULL;
> +
> +	fsnotify_put_inode_ref(inode);

You cannot call fsnotify_put_inode_ref() here because the function is
called under conn->lock and iput() can sleep... You need to play similar
game with passing inode pointer like
fsnotify_detach_connector_from_object() does.

> +	*type = FSNOTIFY_OBJ_TYPE_INODE;
> +
> +	return inode;
>  }
>  
>  void fsnotify_put_mark(struct fsnotify_mark *mark)
> @@ -275,6 +317,9 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
>  		free_conn = true;
>  	} else {
>  		__fsnotify_recalc_mask(conn);
> +		/* Unpin inode on last mark that wants inode refcount held */
> +		if (mark->flags & FSNOTIFY_MARK_FLAG_HAS_IREF)
> +			objp = fsnotify_drop_iref(conn, &type);
>  	}

This is going to be interesting. What if the connector got detached from
the inode before fsnotify_put_mark() was called? Then iref_proxy would be
already 0 and we would barf? I think
fsnotify_detach_connector_from_object() needs to drop inode reference but
leave iref_proxy alone for this to work. fsnotify_drop_iref() would then
drop inode reference only if iref_proxy reaches 0 and conn->objp != NULL...


>  	WRITE_ONCE(mark->connector, NULL);
>  	spin_unlock(&conn->lock);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
