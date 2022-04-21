Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1EF50A297
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 16:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389382AbiDUOh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 10:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389489AbiDUOh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:37:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802C92197
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 07:35:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3CA751F37B;
        Thu, 21 Apr 2022 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650551705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5I+5yB4Dy/kIK3h+N701Rbkyo8wcTU3IfxezymlMyw=;
        b=Rcq9RCWoH06cvSj2MiYENqrmIzHuT7ntGohNlmJJGUjxRy0bfAaixtPANsH8eyN+eoIM3X
        UU+fs2/F2rBLAXwL/+vLjnGIUrZVr5V6Nm6BcnDQ3x+oMeCxdhIhWETy7aqPwDBCCFeQM6
        VsgA9/wJ9pSUw+nG2Mkf2OdPxNaM7bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650551705;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5I+5yB4Dy/kIK3h+N701Rbkyo8wcTU3IfxezymlMyw=;
        b=SCGNqmCuwrPAa01OPrPEDjqQUR9tGhx2siWEnUqGxFFXYRfBd8rrR4zhvvNpx36AyO/weW
        ruQyuxdK1AX7ydCQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 26B1C2C146;
        Thu, 21 Apr 2022 14:35:05 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A15A2A0620; Thu, 21 Apr 2022 16:18:50 +0200 (CEST)
Date:   Thu, 21 Apr 2022 16:18:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 04/16] fsnotify: pass flags argument to
 fsnotify_add_mark() via mark
Message-ID: <20220421141850.e3cfr5sdiblhwvg7@quack3.lan>
References: <20220413090935.3127107-1-amir73il@gmail.com>
 <20220413090935.3127107-5-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413090935.3127107-5-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-04-22 12:09:23, Amir Goldstein wrote:
> Instead of passing the allow_dups argument to fsnotify_add_mark()
> as an argument, define the mark flag FSNOTIFY_MARK_FLAG_ALLOW_DUPS
> to express the old allow_dups meaning and pass this information on the
> mark itself.
> 
> We use mark->flags to pass inotify control flags and will pass more
> control flags in the future so let's make this the standard.
> 
> Although the FSNOTIFY_MARK_FLAG_ALLOW_DUPS flag is not used after the
> call to fsnotify_add_mark(), it does not hurt to leave this information
> on the mark for future use.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I wanted to comment on this already last time but forgot:
FSNOTIFY_MARK_FLAG_ALLOW_DUPS is IMO more a property of fsnotify_group
than a particular mark (or a particular call to fsnotify_add_mark()). As
such it would make more sense to me to have is as "feature" similarly to
fs-reclaim restrictions you introduce later in the series.

As a bonus, no need for 'flags' argument to
fsnotify_add_inode_mark_locked() or fsnotify_add_inode_mark().

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c |  2 +-
>  fs/notify/inotify/inotify_user.c   |  4 ++--
>  fs/notify/mark.c                   | 13 ++++++-------
>  include/linux/fsnotify_backend.h   | 19 ++++++++++---------
>  kernel/audit_fsnotify.c            |  3 ++-
>  5 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 9b32b76a9c30..0f0db1efa379 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1144,7 +1144,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>  	}
>  
>  	fsnotify_init_mark(mark, group);
> -	ret = fsnotify_add_mark_locked(mark, connp, obj_type, 0, fsid);
> +	ret = fsnotify_add_mark_locked(mark, connp, obj_type, fsid);
>  	if (ret) {
>  		fsnotify_put_mark(mark);
>  		goto out_dec_ucounts;
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index d8907d32a05b..6fc0f598a7aa 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -603,7 +603,6 @@ static int inotify_new_watch(struct fsnotify_group *group,
>  
>  	fsnotify_init_mark(&tmp_i_mark->fsn_mark, group);
>  	tmp_i_mark->fsn_mark.mask = inotify_arg_to_mask(inode, arg);
> -	tmp_i_mark->fsn_mark.flags = inotify_arg_to_flags(arg);
>  	tmp_i_mark->wd = -1;
>  
>  	ret = inotify_add_to_idr(idr, idr_lock, tmp_i_mark);
> @@ -618,7 +617,8 @@ static int inotify_new_watch(struct fsnotify_group *group,
>  	}
>  
>  	/* we are on the idr, now get on the inode */
> -	ret = fsnotify_add_inode_mark_locked(&tmp_i_mark->fsn_mark, inode, 0);
> +	ret = fsnotify_add_inode_mark_locked(&tmp_i_mark->fsn_mark, inode,
> +					     inotify_arg_to_flags(arg));
>  	if (ret) {
>  		/* we failed to get on the inode, get off the idr */
>  		inotify_remove_from_idr(group, tmp_i_mark);
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index c86982be2d50..ea8f557881b1 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -574,7 +574,7 @@ static struct fsnotify_mark_connector *fsnotify_grab_connector(
>  static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
>  				  fsnotify_connp_t *connp,
>  				  unsigned int obj_type,
> -				  int allow_dups, __kernel_fsid_t *fsid)
> +				  __kernel_fsid_t *fsid)
>  {
>  	struct fsnotify_mark *lmark, *last = NULL;
>  	struct fsnotify_mark_connector *conn;
> @@ -633,7 +633,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
>  
>  		if ((lmark->group == mark->group) &&
>  		    (lmark->flags & FSNOTIFY_MARK_FLAG_ATTACHED) &&
> -		    !allow_dups) {
> +		    !(mark->flags & FSNOTIFY_MARK_FLAG_ALLOW_DUPS)) {
>  			err = -EEXIST;
>  			goto out_err;
>  		}
> @@ -668,7 +668,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
>   */
>  int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
>  			     fsnotify_connp_t *connp, unsigned int obj_type,
> -			     int allow_dups, __kernel_fsid_t *fsid)
> +			     __kernel_fsid_t *fsid)
>  {
>  	struct fsnotify_group *group = mark->group;
>  	int ret = 0;
> @@ -688,7 +688,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
>  	fsnotify_get_mark(mark); /* for g_list */
>  	spin_unlock(&mark->lock);
>  
> -	ret = fsnotify_add_mark_list(mark, connp, obj_type, allow_dups, fsid);
> +	ret = fsnotify_add_mark_list(mark, connp, obj_type, fsid);
>  	if (ret)
>  		goto err;
>  
> @@ -708,14 +708,13 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
>  }
>  
>  int fsnotify_add_mark(struct fsnotify_mark *mark, fsnotify_connp_t *connp,
> -		      unsigned int obj_type, int allow_dups,
> -		      __kernel_fsid_t *fsid)
> +		      unsigned int obj_type, __kernel_fsid_t *fsid)
>  {
>  	int ret;
>  	struct fsnotify_group *group = mark->group;
>  
>  	mutex_lock(&group->mark_mutex);
> -	ret = fsnotify_add_mark_locked(mark, connp, obj_type, allow_dups, fsid);
> +	ret = fsnotify_add_mark_locked(mark, connp, obj_type, fsid);
>  	mutex_unlock(&group->mark_mutex);
>  	return ret;
>  }
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index b1c72edd9784..2ff686882303 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -473,6 +473,7 @@ struct fsnotify_mark {
>  	/* General fsnotify mark flags */
>  #define FSNOTIFY_MARK_FLAG_ALIVE		0x0001
>  #define FSNOTIFY_MARK_FLAG_ATTACHED		0x0002
> +#define FSNOTIFY_MARK_FLAG_ALLOW_DUPS		0x0004
>  	/* inotify mark flags */
>  #define FSNOTIFY_MARK_FLAG_EXCL_UNLINK		0x0010
>  #define FSNOTIFY_MARK_FLAG_IN_ONESHOT		0x0020
> @@ -634,30 +635,30 @@ extern struct fsnotify_mark *fsnotify_find_mark(fsnotify_connp_t *connp,
>  /* Get cached fsid of filesystem containing object */
>  extern int fsnotify_get_conn_fsid(const struct fsnotify_mark_connector *conn,
>  				  __kernel_fsid_t *fsid);
> +
>  /* attach the mark to the object */
>  extern int fsnotify_add_mark(struct fsnotify_mark *mark,
>  			     fsnotify_connp_t *connp, unsigned int obj_type,
> -			     int allow_dups, __kernel_fsid_t *fsid);
> +			     __kernel_fsid_t *fsid);
>  extern int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
>  				    fsnotify_connp_t *connp,
> -				    unsigned int obj_type, int allow_dups,
> +				    unsigned int obj_type,
>  				    __kernel_fsid_t *fsid);
>  
>  /* attach the mark to the inode */
>  static inline int fsnotify_add_inode_mark(struct fsnotify_mark *mark,
> -					  struct inode *inode,
> -					  int allow_dups)
> +					  struct inode *inode, int flags)
>  {
> +	mark->flags = flags;
>  	return fsnotify_add_mark(mark, &inode->i_fsnotify_marks,
> -				 FSNOTIFY_OBJ_TYPE_INODE, allow_dups, NULL);
> +				 FSNOTIFY_OBJ_TYPE_INODE, NULL);
>  }
>  static inline int fsnotify_add_inode_mark_locked(struct fsnotify_mark *mark,
> -						 struct inode *inode,
> -						 int allow_dups)
> +						 struct inode *inode, int flags)
>  {
> +	mark->flags = flags;
>  	return fsnotify_add_mark_locked(mark, &inode->i_fsnotify_marks,
> -					FSNOTIFY_OBJ_TYPE_INODE, allow_dups,
> -					NULL);
> +					FSNOTIFY_OBJ_TYPE_INODE, NULL);
>  }
>  
>  /* given a group and a mark, flag mark to be freed when all references are dropped */
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index 02348b48447c..3c35649bc7f5 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -100,7 +100,8 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
>  	audit_update_mark(audit_mark, dentry->d_inode);
>  	audit_mark->rule = krule;
>  
> -	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, true);
> +	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode,
> +				      FSNOTIFY_MARK_FLAG_ALLOW_DUPS);
>  	if (ret < 0) {
>  		fsnotify_put_mark(&audit_mark->mark);
>  		audit_mark = ERR_PTR(ret);
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
