Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59092520337
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 19:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbiEIRJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 13:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbiEIRJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 13:09:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB91E32;
        Mon,  9 May 2022 10:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58596B81810;
        Mon,  9 May 2022 17:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE54C385AC;
        Mon,  9 May 2022 17:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652115936;
        bh=xo+qSn55GKDWgqWrux6+qYgOx0w1nXrx/9yk3yKMA6U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y/oBEcY5ZRBCCs6MdtdQ69R57cP/ZZBMntr5Ktx4rYRRLq99iX7mTEHSe91uNGnOu
         SbyCiRg9wqESPmfV35B/ODUr1/og8AA6P0f7OD+GbdeYjZLPKUn0wXAou1y7oEU0+g
         wCq+FDOOr/k5B0KLjgeHGau7+5yGxlffM1xtPhnNTrpFmiznsPixnkAEAXA5rUE8GS
         IfG3+sMD7BmKV3KkycKItll6+Fwurk25lpfM9Wa78nPDu7yWVHvXyu2kJKBHfhBoVU
         s4K9HjVSxap2REEzzFIfotbmvWlwv1iQdTIAhU7Tm1P9oWmDlniV8bJRFcRKIMuNIS
         7+IRgfvxWhLBQ==
Message-ID: <938d9a9c8490085a01c2c22068e3e56f737baea4.camel@kernel.org>
Subject: Re: [PATCH RFC v25 4/7] fs/lock: add helper
 locks_owner_has_blockers to check for blockers
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        bfields@fieldses.org
Cc:     viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 09 May 2022 13:05:34 -0400
In-Reply-To: <1651526367-1522-5-git-send-email-dai.ngo@oracle.com>
References: <1651526367-1522-1-git-send-email-dai.ngo@oracle.com>
         <1651526367-1522-5-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-05-02 at 14:19 -0700, Dai Ngo wrote:
> Add helper locks_owner_has_blockers to check if there is any blockers
> for a given lockowner.
> 
> Reviewed-by: J. Bruce Fields <bfields@fieldses.org>
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
