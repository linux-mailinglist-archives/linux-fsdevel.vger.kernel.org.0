Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6CA4F43B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 00:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiDEPC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 11:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392579AbiDENuK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:50:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F4285951
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Apr 2022 05:54:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 874A6210FD;
        Tue,  5 Apr 2022 12:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649163247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VGaenV6uYwFJEScE4s4S5pXIsyPfbWjTXH6GZD3zBYk=;
        b=MSKMEOyamoGJusJ5RhkJqbMVU24OZshv+UkidrQ23canr1vLEGJ0hGRhJTNlE+1b+OHD22
        sZEj2ErfV5rub0aacfaV+ZN5oc/+S8afj/PZBeQacQwmyRFsPPCxSc8BVIjWcoRgVaDHZl
        Zu42dI7rYN7HZD+V50iCP/N5vCHg8TU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649163247;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VGaenV6uYwFJEScE4s4S5pXIsyPfbWjTXH6GZD3zBYk=;
        b=vtemV07UgVXpiBglf8ZoTACeQZ9yTVv0rxW9trEE7XDKX45UrMueID93y6hqaD3PBs460L
        emze3pkicRAculCQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 73F83A3BA1;
        Tue,  5 Apr 2022 12:54:07 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 259C8A0615; Tue,  5 Apr 2022 14:54:07 +0200 (CEST)
Date:   Tue, 5 Apr 2022 14:54:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 04/16] fsnotify: remove unneeded refcounts of
 s_fsnotify_connectors
Message-ID: <20220405125407.qn6ac5e3bpr5is6h@quack3.lan>
References: <20220329074904.2980320-1-amir73il@gmail.com>
 <20220329074904.2980320-5-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329074904.2980320-5-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-03-22 10:48:52, Amir Goldstein wrote:
> s_fsnotify_connectors is elevated for every inode mark in addition to
> the refcount already taken by the inode connector.
> 
> This is a relic from s_fsnotify_inode_refs pre connector era.
> Remove those unneeded recounts.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I disagree it is a relict. fsnotify_sb_delete() relies on
s_fsnotify_connectors to wait for all connectors to be properly torn down
on unmount so that we don't get "Busy inodes after unmount" error messages
(and use-after-free issues). Am I missing something?

								Honza

> ---
>  fs/notify/mark.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index b1443e66ba26..698ed0a1a47e 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -169,21 +169,6 @@ static void fsnotify_connector_destroy_workfn(struct work_struct *work)
>  	}
>  }
>  
> -static void fsnotify_get_inode_ref(struct inode *inode)
> -{
> -	ihold(inode);
> -	atomic_long_inc(&inode->i_sb->s_fsnotify_connectors);
> -}
> -
> -static void fsnotify_put_inode_ref(struct inode *inode)
> -{
> -	struct super_block *sb = inode->i_sb;
> -
> -	iput(inode);
> -	if (atomic_long_dec_and_test(&sb->s_fsnotify_connectors))
> -		wake_up_var(&sb->s_fsnotify_connectors);
> -}
> -
>  static void fsnotify_get_sb_connectors(struct fsnotify_mark_connector *conn)
>  {
>  	struct super_block *sb = fsnotify_connector_sb(conn);
> @@ -245,7 +230,7 @@ static void fsnotify_drop_object(unsigned int type, void *objp)
>  	/* Currently only inode references are passed to be dropped */
>  	if (WARN_ON_ONCE(type != FSNOTIFY_OBJ_TYPE_INODE))
>  		return;
> -	fsnotify_put_inode_ref(objp);
> +	iput(objp);
>  }
>  
>  void fsnotify_put_mark(struct fsnotify_mark *mark)
> @@ -519,7 +504,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
>  	}
>  	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
>  		inode = fsnotify_conn_inode(conn);
> -		fsnotify_get_inode_ref(inode);
> +		ihold(inode);
>  	}
>  	fsnotify_get_sb_connectors(conn);
>  
> @@ -530,7 +515,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
>  	if (cmpxchg(connp, NULL, conn)) {
>  		/* Someone else created list structure for us */
>  		if (inode)
> -			fsnotify_put_inode_ref(inode);
> +			iput(inode);
>  		fsnotify_put_sb_connectors(conn);
>  		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
>  	}
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
