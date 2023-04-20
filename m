Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261626E975A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 16:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjDTOj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjDTOj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:39:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3F610F2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 07:39:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EEE8F1FDB3;
        Thu, 20 Apr 2023 14:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682001594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qHAAL2DzpsQCozNz8x3S9EtbHdkbdVoss/RQUW176WA=;
        b=Id22B1U228MFmO4fzCWEF1cYa2Bv0JHQnIe3QA1Q47191EwoV9iLrLfqo7B8ImCDp4IPKt
        x100xL1A9bVNzJwiGCTEG+bY7MLaNnXwaZpMmGD3baVeNswqKWXfXeMKqzCtY7xT60CbsA
        j1jrrLhqtPRYddeHTYvI5Q/c+1a/lzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682001594;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qHAAL2DzpsQCozNz8x3S9EtbHdkbdVoss/RQUW176WA=;
        b=Ik7WFZbbaJ3mOyfrxuRcyg7kfw5zuOyOqGA22weyslekHhihz+XfG7/mfey9AbSS80g2OL
        btXTL2Yeq0wwxfDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E07101333C;
        Thu, 20 Apr 2023 14:39:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jgLANrpOQWRMQgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 20 Apr 2023 14:39:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 743DCA0729; Thu, 20 Apr 2023 16:39:54 +0200 (CEST)
Date:   Thu, 20 Apr 2023 16:39:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     cem@kernel.org
Cc:     hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 6/6] Add default quota limit mount options
Message-ID: <20230420143954.asmpkta4tknyzcda@quack3>
References: <20230420080359.2551150-1-cem@kernel.org>
 <20230420080359.2551150-7-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420080359.2551150-7-cem@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-04-23 10:03:59, cem@kernel.org wrote:
> From: Lukas Czerner <lczerner@redhat.com>
> 
> Allow system administrator to set default global quota limits at tmpfs
> mount time.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  Documentation/filesystems/tmpfs.rst | 34 ++++++++++----
>  include/linux/shmem_fs.h            |  8 ++++
>  mm/shmem.c                          | 69 +++++++++++++++++++++++++++++
>  mm/shmem_quota.c                    |  9 ++++
>  4 files changed, 111 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> index 1d4ef4f7cca7e..241c11f86cd73 100644
> --- a/Documentation/filesystems/tmpfs.rst
> +++ b/Documentation/filesystems/tmpfs.rst
> @@ -88,15 +88,31 @@ that instance in a system with many CPUs making intensive use of it.
>  
>  tmpfs also supports quota with the following mount options
>  
> -========  =============================================================
> -quota     User and group quota accounting and enforcement is enabled on
> -          the mount. Tmpfs is using hidden system quota files that are
> -          initialized on mount.
> -usrquota  User quota accounting and enforcement is enabled on the
> -          mount.
> -grpquota  Group quota accounting and enforcement is enabled on the
> -          mount.
> -========  =============================================================
> +======================== =================================================
> +quota                    User and group quota accounting and enforcement
> +                         is enabled on the mount. Tmpfs is using hidden
> +                         system quota files that are initialized on mount.
> +usrquota                 User quota accounting and enforcement is enabled
> +                         on the mount.
> +grpquota                 Group quota accounting and enforcement is enabled
> +                         on the mount.
> +usrquota_block_hardlimit Set global user quota block hard limit.
> +usrquota_inode_hardlimit Set global user quota inode hard limit.
> +grpquota_block_hardlimit Set global group quota block hard limit.
> +grpquota_inode_hardlimit Set global group quota inode hard limit.
> +======================== =================================================
> +
> +None of the quota related mount options can be set or changed on remount.
> +
> +Quota limit parameters accept a suffix k, m or g for kilo, mega and giga
> +and can't be changed on remount. Default global quota limits are taking
> +effect for any and all user/group/project except root the first time the
> +quota entry for user/group/project id is being accessed - typically the
> +first time an inode with a particular id ownership is being created after
> +the mount. In other words, instead of the limits being initialized to zero,
> +they are initialized with the particular value provided with these mount
> +options. The limits can be changed for any user/group id at any time as it
									   ^^ they
> +normally can.
	    ^^^ can be
           
> @@ -3714,6 +3723,50 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>  		ctx->seen |= SHMEM_SEEN_QUOTA;
>  		ctx->quota_types |= QTYPE_MASK_GRP;
>  		break;
> +	case Opt_usrquota_block_hardlimit:
> +		size = memparse(param->string, &rest);
> +		if (*rest || !size)
> +			goto bad_value;
> +		if (size > SHMEM_QUOTA_MAX_SPC_LIMIT)
> +			return invalfc(fc,
> +				       "User quota block hardlimit too large.");
> +		ctx->qlimits.usrquota_bhardlimit = size;
> +		ctx->seen |= SHMEM_SEEN_QUOTA;
> +		ctx->quota_types |= QTYPE_MASK_USR;

So if I get it right, the intention here is that if
usrquota_block_hardlimit=value option is used, it automatically enables
user quota accounting and enforcement. I guess it is logical but it is not
documented and I'd prefer to require explicit usrquota mount option to
enable accounting & enforcement - it is then e.g. easier to parse mount
options (in userspace) for finding out whether enforcement is enabled or
not. Also I can imagine we would allow changing the default limits on
remount but it isn't easy to enable quota accounting on remount etc.

> diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
> index c0b531e2ef688..3cc53f2c35e2c 100644
> --- a/mm/shmem_quota.c
> +++ b/mm/shmem_quota.c
> @@ -166,6 +166,7 @@ static int shmem_acquire_dquot(struct dquot *dquot)
>  {
>  	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
>  	struct rb_node **n = &((struct rb_root *)info->dqi_priv)->rb_node;
> +	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
>  	struct rb_node *parent = NULL, *new_node = NULL;
>  	struct quota_id *new_entry, *entry;
>  	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
> @@ -195,6 +196,14 @@ static int shmem_acquire_dquot(struct dquot *dquot)
>  	}
>  
>  	new_entry->id = id;
> +	if (dquot->dq_id.type == USRQUOTA) {
> +		new_entry->bhardlimit = sbinfo->qlimits.usrquota_bhardlimit;
> +		new_entry->ihardlimit = sbinfo->qlimits.usrquota_ihardlimit;
> +	} else if (dquot->dq_id.type == GRPQUOTA) {
> +		new_entry->bhardlimit = sbinfo->qlimits.grpquota_bhardlimit;
> +		new_entry->ihardlimit = sbinfo->qlimits.grpquota_ihardlimit;
> +	}
> +
>  	new_node = &new_entry->node;
>  	rb_link_node(new_node, parent, n);
>  	rb_insert_color(new_node, (struct rb_root *)info->dqi_priv);

Maybe in shmem_dquot_release() when usage is 0 and limits are at default
limits, we can free the structure?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
