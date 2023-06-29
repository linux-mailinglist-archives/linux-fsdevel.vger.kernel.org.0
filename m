Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8697424C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 13:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjF2LJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 07:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjF2LJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:09:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6989D4230;
        Thu, 29 Jun 2023 04:08:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 08CC71F8D6;
        Thu, 29 Jun 2023 11:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688036894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1qHtLjDFCTPjeJw9isUtkpCV8ZlDmCULwOsl6gfQ958=;
        b=U2SbulpZkKl6trrVBa2y2QEJpr4kFWv1STBLkj4vu7DNCq9ty1vtnMmhp1ilaBd3Am6+ea
        rzmrgVC93jBkzuThBvJa3ZvRYHilmlVkK3Ytmd8s2g1j2lrRCjw2g/VG+OVYGNfBJ39/i6
        2xb6+qmCP+QMCE/xLSL8ScM8J3jmLvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688036894;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1qHtLjDFCTPjeJw9isUtkpCV8ZlDmCULwOsl6gfQ958=;
        b=zbQ//WpR6lkTV/vyXbtFK0V12dKh4iZDowmuikTWDRQ/7mjGiQO0VIORRY3MHqJ8r3WPha
        NJD1XIb/7AyV4LDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDAA1139FF;
        Thu, 29 Jun 2023 11:08:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bcICOh1mnWTHMAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Jun 2023 11:08:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7A435A0722; Thu, 29 Jun 2023 13:08:13 +0200 (CEST)
Date:   Thu, 29 Jun 2023 13:08:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 6/7] quota: simplify drop_dquot_ref()
Message-ID: <20230629110813.kfaja4bdomilmns6@quack3>
References: <20230628132155.1560425-1-libaokun1@huawei.com>
 <20230628132155.1560425-7-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628132155.1560425-7-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 28-06-23 21:21:54, Baokun Li wrote:
> Now when dqput() drops the last reference count, it will call
> synchronize_srcu(&dquot_srcu) in quota_release_workfn() to ensure that
> no other user will use the dquot after the last reference count is dropped,
> so we don't need to call synchronize_srcu(&dquot_srcu) in drop_dquot_ref()
> and remove the corresponding logic directly to simplify the code.

Nice simplification!  It is also important that dqput() now cannot sleep
which was another reason for the logic with tofree_head in
remove_inode_dquot_ref(). Probably this is good to mention in the
changelog.

> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/quota/dquot.c | 33 ++++++---------------------------
>  1 file changed, 6 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index e8e702ac64e5..df028fb2ce72 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -1090,8 +1090,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
>   * Remove references to dquots from inode and add dquot to list for freeing
>   * if we have the last reference to dquot
>   */
> -static void remove_inode_dquot_ref(struct inode *inode, int type,
> -				   struct list_head *tofree_head)
> +static void remove_inode_dquot_ref(struct inode *inode, int type)
>  {
>  	struct dquot **dquots = i_dquot(inode);
>  	struct dquot *dquot = dquots[type];
> @@ -1100,21 +1099,7 @@ static void remove_inode_dquot_ref(struct inode *inode, int type,
>  		return;
>  
>  	dquots[type] = NULL;
> -	if (list_empty(&dquot->dq_free)) {
> -		/*
> -		 * The inode still has reference to dquot so it can't be in the
> -		 * free list
> -		 */
> -		spin_lock(&dq_list_lock);
> -		list_add(&dquot->dq_free, tofree_head);
> -		spin_unlock(&dq_list_lock);
> -	} else {
> -		/*
> -		 * Dquot is already in a list to put so we won't drop the last
> -		 * reference here.
> -		 */
> -		dqput(dquot);
> -	}
> +	dqput(dquot);
>  }

I think you can also just drop remove_inode_dquot_ref() as it is trivial
now and inline it at its only callsite...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
