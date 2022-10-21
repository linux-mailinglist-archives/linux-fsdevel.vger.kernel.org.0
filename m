Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659776073CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 11:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiJUJSQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 05:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiJUJSO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:18:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C232565C1;
        Fri, 21 Oct 2022 02:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16690B82A2D;
        Fri, 21 Oct 2022 09:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC3BC433D6;
        Fri, 21 Oct 2022 09:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666343835;
        bh=nJQIG7eMdgvCQHUqn+x+OTgBKkxaBGtjNSHBvblPK6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M8KAatuffLbqLPdmCbdRAEoQmAM4Xwt6l+h9GAluMntgCXEbJz30bl78WqyPI/tZ4
         Vl7+tUJ3On77kf2t9u4H20KKjJv6fJA0J84qXikAJIhTOzUWaJOTISk9p+zJUXT3kV
         CqwWY9B7CPYAUwyXh08tyuq1yEXj1pTgZNvcwL5g/4atWXet5g039IX6nEKnh/Ag2K
         NPQzYn9oI43FRzXuTbvQvzG4MdlsgAp1frF0Ir1zBwcCDWuOoqX+++WmNV2hryN1bO
         SOJ1gFaRzZOwy3yVwfTG3u8Ffufs60Us98ZwKjqdOcdI0X850NntPkAgZwcUn+YNIP
         m0T2PhtSEeiWg==
Date:   Fri, 21 Oct 2022 11:17:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] fsnotify: Protect i_fsnotify_mask and child flags
 with inode rwsem
Message-ID: <20221021091710.jxv6zi3nfkmqdmqy@wittgenstein>
References: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
 <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221021010310.29521-3-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021010310.29521-3-stephen.s.brennan@oracle.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 20, 2022 at 06:03:09PM -0700, Stephen Brennan wrote:
> When an inode is interested in events on its children, it must set
> DCACHE_FSNOTIFY_PARENT_WATCHED flag on all its children. Currently, when
> the fsnotify connector is removed and i_fsnotify_mask becomes zero, we
> lazily allow __fsnotify_parent() to do this the next time we see an
> event on a child.
> 
> However, if the list of children is very long (e.g., in the millions),
> and lots of activity is occurring on the directory, then it's possible
> for many CPUs to end up blocked on the inode spinlock in
> __fsnotify_update_child_flags(). Each CPU will then redundantly iterate
> over the very long list of children. This situation can cause soft
> lockups.
> 
> To avoid this, stop lazily updating child flags in __fsnotify_parent().
> Instead, update flags when we disconnect a mark connector. Remember the
> state of the children flags in the fsnotify_mark_connector flags.
> Provide mutual exclusion by holding i_rwsem exclusive while we update
> children, and use the cached state to avoid updating flags
> unnecessarily.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
> 
>  fs/notify/fsnotify.c             |  22 ++++++-
>  fs/notify/fsnotify.h             |  31 ++++++++-
>  fs/notify/mark.c                 | 106 ++++++++++++++++++++-----------
>  include/linux/fsnotify_backend.h |   8 +++
>  4 files changed, 127 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 6c338322f0c3..f83eca4fb841 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -103,13 +103,15 @@ void fsnotify_sb_delete(struct super_block *sb)
>   * parent cares.  Thus when an event happens on a child it can quickly tell
>   * if there is a need to find a parent and send the event to the parent.
>   */
> -void __fsnotify_update_child_dentry_flags(struct inode *inode)
> +bool __fsnotify_update_children_dentry_flags(struct inode *inode)
>  {
>  	struct dentry *alias, *child;
>  	int watched;
>  
>  	if (!S_ISDIR(inode->i_mode))
> -		return;
> +		return false;
> +
> +	lockdep_assert_held_write(&inode->i_rwsem);
>  
>  	/* determine if the children should tell inode about their events */
>  	watched = fsnotify_inode_watches_children(inode);
> @@ -133,6 +135,20 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
>  		spin_unlock(&child->d_lock);
>  	}
>  	spin_unlock(&alias->d_lock);
> +	return watched;
> +}
> +
> +void __fsnotify_update_child_dentry_flags(struct inode *inode, struct dentry *dentry)
> +{
> +	/*
> +	 * Flag would be cleared soon by
> +	 * __fsnotify_update_child_dentry_flags(), but as an
> +	 * optimization, clear it now.
> +	 */
> +	spin_lock(&dentry->d_lock);
> +	if (!fsnotify_inode_watches_children(inode))
> +		dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
> +	spin_unlock(&dentry->d_lock);
>  }
>  
>  /* Are inode/sb/mount interested in parent and name info with this event? */
> @@ -203,7 +219,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  	p_inode = parent->d_inode;
>  	p_mask = fsnotify_inode_watches_children(p_inode);
>  	if (unlikely(parent_watched && !p_mask))
> -		__fsnotify_update_child_dentry_flags(p_inode);
> +		__fsnotify_update_child_dentry_flags(p_inode, dentry);
>  
>  	/*
>  	 * Include parent/name in notification either if some notification
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index fde74eb333cc..182d93014c6b 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -70,11 +70,40 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
>  	fsnotify_destroy_marks(&sb->s_fsnotify_marks);
>  }
>  
> +static inline bool fsnotify_children_need_update(struct fsnotify_mark_connector *conn,
> +                                                 struct inode *inode)
> +{
> +	bool watched, flags_set;
> +	watched = fsnotify_inode_watches_children(inode);

nit: I'd leave a blank line after the variable declarations. Same for
fsnotify_update_children_dentry_flags() below.

> +	flags_set = conn->flags & FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
> +	return (watched && !flags_set) || (!watched && flags_set);
> +}
> +
>  /*
>   * update the dentry->d_flags of all of inode's children to indicate if inode cares
>   * about events that happen to its children.
>   */
> -extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
> +extern bool __fsnotify_update_children_dentry_flags(struct inode *inode);
> +
> +static inline void fsnotify_update_children_dentry_flags(struct fsnotify_mark_connector *conn,
> +                                                         struct inode *inode)

Should that be a static inline function in a header seems a bit big. :)
