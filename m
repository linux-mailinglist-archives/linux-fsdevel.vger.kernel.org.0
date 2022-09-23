Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9585E79DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 13:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiIWLoZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 07:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiIWLoX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:44:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF14E9500;
        Fri, 23 Sep 2022 04:44:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7AC8A21982;
        Fri, 23 Sep 2022 11:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663933461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nCuSLtvESoPhmOq7Knt6Vlnqo6bc39YbBo1w/321TOI=;
        b=vwhFH6UR8SEb7BjkDsn71ntwpehuoT3/ra3bcUiO+LL8efDItpBPcktuVLYLelW9pf+ab1
        5YT8H8MOHdPv9PkDKKwkWVoXKMcnw4TzDylVIZrAW6NbGmjRggM6oqdXCFlg1qGJvs3vMA
        D+v61u8F5ocQ6fD+h3V4+3RI8eUU92Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663933461;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nCuSLtvESoPhmOq7Knt6Vlnqo6bc39YbBo1w/321TOI=;
        b=CV8EA9mavukHh8A+k0/HmgHwwT8ENzxq8TvTpgVHnUmrg7wEcfyO+B6CeJU115B2Tf69yK
        g7JQmQesc3pKDwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 662F813A00;
        Fri, 23 Sep 2022 11:44:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id da7wGBWcLWNUYAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 23 Sep 2022 11:44:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F0281A0685; Fri, 23 Sep 2022 13:44:20 +0200 (CEST)
Date:   Fri, 23 Sep 2022 13:44:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     jack@suse.com, tytso@mit.edu, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH v2 3/3] quota: Add more checking after reading from quota
 file
Message-ID: <20220923114420.43dasp3uw76yugac@quack3>
References: <20220922130401.1792256-1-chengzhihao1@huawei.com>
 <20220922130401.1792256-4-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922130401.1792256-4-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 22-09-22 21:04:01, Zhihao Cheng wrote:
> It would be better to do more sanity checking (eg. dqdh_entries,
> block no.) for the content read from quota file, which can prevent
> corrupting the quota file.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  fs/quota/quota_tree.c | 43 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
> index 47711e739ddb..54fe4ad71de5 100644
> --- a/fs/quota/quota_tree.c
> +++ b/fs/quota/quota_tree.c
> @@ -71,12 +71,12 @@ static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
>  	return ret;
>  }
>  
> -static inline int do_check_range(struct super_block *sb, uint val,
> -				 uint min_val, uint max_val)
> +static inline int do_check_range(struct super_block *sb, const char *val_name,
> +				 uint val, uint min_val, uint max_val)
>  {
>  	if (val < min_val || val >= max_val) {
> -		quota_error(sb, "Getting block %u out of range %u-%u",
> -			    val, min_val, max_val);
> +		quota_error(sb, "Getting %s %u out of range %u-%u",
> +			    val_name, val, min_val, max_val);
>  		return -EUCLEAN;
>  	}

As I already wrote in my comments to v1, please create do_check_range()
already with this prototype in patch 1 so that you don't have to update it
(and all the call sites) in each of the patches. It makes review simpler.

> @@ -268,6 +270,11 @@ static uint find_free_dqentry(struct qtree_mem_dqinfo *info,
>  		*err = check_dquot_block_header(info, dh);
>  		if (*err)
>  			goto out_buf;
> +		*err = do_check_range(info->dqi_sb, "dqdh_entries",
> +				      le16_to_cpu(dh->dqdh_entries), 0,
> +				      qtree_dqstr_in_blk(info));
> +		if (*err)
> +			goto out_buf;

The checking of dqdh_entries belongs into check_dquot_block_header(). That
was the reason why it was created. So that all the checks are together in
one function...

>  	} else {
>  		blk = get_free_dqblk(info);
>  		if ((int)blk < 0) {
> @@ -349,6 +356,10 @@ static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
>  	}
>  	ref = (__le32 *)buf;
>  	newblk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
> +	ret = do_check_range(dquot->dq_sb, "block", newblk, 0,
> +			     info->dqi_blocks);
> +	if (ret)
> +		goto out_buf;
>  	if (!newblk)
>  		newson = 1;
>  	if (depth == info->dqi_qtree_depth - 1) {
> @@ -461,6 +472,11 @@ static int free_dqentry(struct qtree_mem_dqinfo *info, struct dquot *dquot,
>  	}
>  	dh = (struct qt_disk_dqdbheader *)buf;
>  	ret = check_dquot_block_header(info, dh);
> +	if (ret)
> +		goto out_buf;
> +	ret = do_check_range(info->dqi_sb, "dqdh_entries",
> +			     le16_to_cpu(dh->dqdh_entries), 1,
> +			     qtree_dqstr_in_blk(info) + 1);

Again, the check of dqdh_entries should be in check_dquot_block_header().

> @@ -739,7 +756,13 @@ static int find_next_id(struct qtree_mem_dqinfo *info, qid_t *id,
>  		goto out_buf;
>  	}
>  	for (i = __get_index(info, *id, depth); i < epb; i++) {
> -		if (ref[i] == cpu_to_le32(0)) {
> +		uint blk_no = le32_to_cpu(ref[i]);
> +
> +		ret = do_check_range(info->dqi_sb, "block", blk_no, 0,
> +				     info->dqi_blocks);
> +		if (ret)
> +			goto out_buf;
> +		if (blk_no == 0) {
>  			*id += level_inc;
>  			continue;
>  		}

I'd leave checking for 0 first here - i.e.:
		if (ref[i] == cpu_to_le32(0)) {
  			*id += level_inc;
  			continue;
  		}

and only then do:
		blk_no = le32_to_cpu(ref[i]);
		ret = do_check_range(...);

There's no point in checking known-good value.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
