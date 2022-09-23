Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035B45E79F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 13:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiIWLso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 07:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiIWLsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:48:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED5613504C;
        Fri, 23 Sep 2022 04:48:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7882B219AB;
        Fri, 23 Sep 2022 11:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663933721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZPjyD0/xt3seSELxX6T0Z8850lxbllz/WwfFXpyRRVE=;
        b=3WQsmWHWi98kHArxLDSeXFRquDbDCvwvEXdL6ZY6FGzw01ouFy+Q2ndzX0IeULWfM3ofUs
        2FGllDhMidI9bcQsNiIx6tA/U4mx3ErUxaSsGhOas05LpogzWPXjQ1QZo8wBiysiviCq5W
        agahA403zfat5cYoVeB1AskuVYgJoGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663933721;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZPjyD0/xt3seSELxX6T0Z8850lxbllz/WwfFXpyRRVE=;
        b=Frwjz0PdM5zF+2ALhLDkWv3CN3NnGMsB4WcYTRwVo0ujr3IMYYqElkjXQoJsWfbZO7uyOh
        ty5L7ukhHEoMS1Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69F7013A00;
        Fri, 23 Sep 2022 11:48:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zYPUGRmdLWMxYgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 23 Sep 2022 11:48:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F1472A0685; Fri, 23 Sep 2022 13:48:40 +0200 (CEST)
Date:   Fri, 23 Sep 2022 13:48:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     jack@suse.com, tytso@mit.edu, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH v2 2/3] quota: Replace all block number checking with
 helper function
Message-ID: <20220923114840.npx52cadeofesp5i@quack3>
References: <20220922130401.1792256-1-chengzhihao1@huawei.com>
 <20220922130401.1792256-3-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922130401.1792256-3-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 22-09-22 21:04:00, Zhihao Cheng wrote:
> Cleanup all block checking places, replace them with helper function
> do_check_range().
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  fs/quota/quota_tree.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)

Thanks for the fix! One comment below:

> diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
> index f89186b6db1d..47711e739ddb 100644
> --- a/fs/quota/quota_tree.c
> +++ b/fs/quota/quota_tree.c
> @@ -71,11 +71,12 @@ static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
>  	return ret;
>  }
>  
> -static inline int do_check_range(struct super_block *sb, uint val, uint max_val)
> +static inline int do_check_range(struct super_block *sb, uint val,
> +				 uint min_val, uint max_val)
>  {
> -	if (val >= max_val) {
> -		quota_error(sb, "Getting block too big (%u >= %u)",
> -			    val, max_val);
> +	if (val < min_val || val >= max_val) {
> +		quota_error(sb, "Getting block %u out of range %u-%u",
> +			    val, min_val, max_val);
>  		return -EUCLEAN;
>  	}

It is strange that do_check_range() checks min_val() with strict inequality
and max_val with non-strict one. That's off-by-one problem waiting to
happen when we forget about this detail. Probably make max_val
non-inclusive as well (the parameter max_val suggests the passed value is
the biggest valid one anyway).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
