Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DAC4DCCA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 18:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiCQRkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 13:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiCQRku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:40:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BE51544A8;
        Thu, 17 Mar 2022 10:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43F9D61588;
        Thu, 17 Mar 2022 17:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019BEC340E9;
        Thu, 17 Mar 2022 17:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647538772;
        bh=VtW13YgT4q4uwX/cPEscTDVU54ZSezg/kx/kVBiZW64=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ruJS653mMh70w5ZoYM/awpHlxld386cvmBnhDGoAZmwX1lZTH+VqRATaL4AhihvUT
         XY1TzcvW333X7qDsiYXZNqux45g0aYUM/xIvJx8gylsmC4AJFY5bPHuYGcycuZbejh
         lAo8UpR9YUUkpEvNlQByvMNJ3Gs7LZ0NY+lV7nrJXlZ/Gf5iW0TKpXr0ZOv5hjuw+/
         ABI7hKqMn/c536VOBCNzzAVPbY9sKp/jkgW7epuosm4do00D/Q6k35iIGTc3/wieyj
         45zBYANZWvJ01NgCs3te9fVAawCs8i2MGWbqVqVYl4a0wJifCLWey9VOGenkYBYdPK
         lzdEYUb756jag==
Message-ID: <bf53431f2a6a1f50d4f21f67722a207f582ecf29.camel@kernel.org>
Subject: Re: [PATCH RFC v17 01/11] fs/lock: add helper
 locks_owner_has_blockers to check for blockers
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        bfields@fieldses.org
Cc:     viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 17 Mar 2022 13:39:30 -0400
In-Reply-To: <1647503028-11966-2-git-send-email-dai.ngo@oracle.com>
References: <1647503028-11966-1-git-send-email-dai.ngo@oracle.com>
         <1647503028-11966-2-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-03-17 at 00:43 -0700, Dai Ngo wrote:
> Add helper locks_owner_has_blockers to check if there is any blockers
> for a given lockowner.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/locks.c         | 28 ++++++++++++++++++++++++++++
>  include/linux/fs.h |  7 +++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 050acf8b5110..53864eb99dc5 100644
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
> index 831b20430d6e..2057a9df790f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1200,6 +1200,8 @@ extern void lease_unregister_notifier(struct notifier_block *);
>  struct files_struct;
>  extern void show_fd_locks(struct seq_file *f,
>  			 struct file *filp, struct files_struct *files);
> +extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
> +			fl_owner_t owner);
>  #else /* !CONFIG_FILE_LOCKING */
>  static inline int fcntl_getlk(struct file *file, unsigned int cmd,
>  			      struct flock __user *user)
> @@ -1335,6 +1337,11 @@ static inline int lease_modify(struct file_lock *fl, int arg,
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
