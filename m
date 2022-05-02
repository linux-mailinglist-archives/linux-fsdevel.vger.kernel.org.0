Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469C951731C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385965AbiEBPr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 11:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385918AbiEBPrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 11:47:24 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024D5E28;
        Mon,  2 May 2022 08:43:55 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8560A6CCD; Mon,  2 May 2022 11:43:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8560A6CCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651506235;
        bh=TbaPUFb11LFf/EvEElbW4m/ZrC8JpPAfxnh2akq4yEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRH1bekpRFfO23MNUE8tRvWOGn/OlFqeDoW5glgTugUfl3kcT8RGggAkyLQhD5c97
         sKEekbeSi53FHJJBy0nW6mWFWGi4yXW4haSYu9Ogm2ecnz8lfP5MhnbmfaE1FuEZcY
         qT5wrrBbE3/QKlcTsyl2AaP0MwYEY2N7gCpJUPGc=
Date:   Mon, 2 May 2022 11:43:55 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v24 4/7] fs/lock: add helper locks_owner_has_blockers
 to check for blockers
Message-ID: <20220502154355.GD30550@fieldses.org>
References: <1651426696-15509-1-git-send-email-dai.ngo@oracle.com>
 <1651426696-15509-5-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651426696-15509-5-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 01, 2022 at 10:38:13AM -0700, Dai Ngo wrote:
> Add helper locks_owner_has_blockers to check if there is any blockers
> for a given lockowner.

Reviewed-by: J. Bruce Fields <bfields@fieldses.org>

> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/locks.c         | 28 ++++++++++++++++++++++++++++
>  include/linux/fs.h |  7 +++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 8c6df10cd9ed..c369841ef7d1 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -300,6 +300,34 @@ void locks_release_private(struct file_lock *fl)
>  }
>  EXPORT_SYMBOL_GPL(locks_release_private);
>  
> +/**
> + * locks_owner_has_blockers - Check for blocking lock requests
> + * @flctx: file lock context
> + * @owner: lock owner
> + *
> + * Return values:
> + *   %true: @owner has at least one blocker
> + *   %false: @owner has no blockers
> + */
> +bool locks_owner_has_blockers(struct file_lock_context *flctx,
> +		fl_owner_t owner)
> +{
> +	struct file_lock *fl;
> +
> +	spin_lock(&flctx->flc_lock);
> +	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
> +		if (fl->fl_owner != owner)
> +			continue;
> +		if (!list_empty(&fl->fl_blocked_requests)) {
> +			spin_unlock(&flctx->flc_lock);
> +			return true;
> +		}
> +	}
> +	spin_unlock(&flctx->flc_lock);
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(locks_owner_has_blockers);
> +
>  /* Free a lock which is not in use. */
>  void locks_free_lock(struct file_lock *fl)
>  {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index bbde95387a23..b8ed7f974fb4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1174,6 +1174,8 @@ extern void lease_unregister_notifier(struct notifier_block *);
>  struct files_struct;
>  extern void show_fd_locks(struct seq_file *f,
>  			 struct file *filp, struct files_struct *files);
> +extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
> +			fl_owner_t owner);
>  #else /* !CONFIG_FILE_LOCKING */
>  static inline int fcntl_getlk(struct file *file, unsigned int cmd,
>  			      struct flock __user *user)
> @@ -1309,6 +1311,11 @@ static inline int lease_modify(struct file_lock *fl, int arg,
>  struct files_struct;
>  static inline void show_fd_locks(struct seq_file *f,
>  			struct file *filp, struct files_struct *files) {}
> +static inline bool locks_owner_has_blockers(struct file_lock_context *flctx,
> +			fl_owner_t owner)
> +{
> +	return false;
> +}
>  #endif /* !CONFIG_FILE_LOCKING */
>  
>  static inline struct inode *file_inode(const struct file *f)
> -- 
> 2.9.5
