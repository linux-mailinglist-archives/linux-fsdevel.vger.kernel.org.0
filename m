Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09353724414
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 15:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbjFFNOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 09:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbjFFNOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:14:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFF210F1;
        Tue,  6 Jun 2023 06:13:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6904F219A4;
        Tue,  6 Jun 2023 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686057236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iPClwO9UuMLfIZheTczXeHjFZnehiQibnbUME4d+iNY=;
        b=gtYUHRuBTJAks2bN0OeBDMyKuI9Z2i3SHZ1rPHJbGfu4ShgmRuYtOXyHX6khAgF0HVa8IS
        bkoVIkWJzb0Ff4SbSTRPFLmZJqBCqHdJe2I/SzARhTA1wQ5KJUXFpZk098CoxpYf3r9m41
        XwIyki/4gwi5BcoZ15hrHBULsfBKG8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686057236;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iPClwO9UuMLfIZheTczXeHjFZnehiQibnbUME4d+iNY=;
        b=/Lp9rP9ALYOM5r7hlagk1K/8EiStVuqZoXMEkYDPBDtQscdTe1to0LAbfwdbLGkY6Ou4RW
        a68BrengZVYa04CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5939213776;
        Tue,  6 Jun 2023 13:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PwnCFRQxf2SIVAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 06 Jun 2023 13:13:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D96DFA0754; Tue,  6 Jun 2023 15:13:55 +0200 (CEST)
Date:   Tue, 6 Jun 2023 15:13:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 04/12] ext4: Convert mballoc cr (criteria) to enum
Message-ID: <20230606131355.5npiivxse3q5d3rq@quack3>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
 <5d82fd467bdf70ea45bdaef810af3b146013946c.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d82fd467bdf70ea45bdaef810af3b146013946c.1685449706.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 30-05-23 18:03:42, Ojaswin Mujoo wrote:
> Convert criteria to be an enum so it easier to maintain and
> update the tracefiles to use enum names. This change also makes
> it easier to insert new criterias in the future.
> 
> There is no functional change in this patch.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

...

> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index c075da665ec1..f9a4eaa10c6a 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -127,6 +127,23 @@ enum SHIFT_DIRECTION {
>  	SHIFT_RIGHT,
>  };
>  
> +/*
> + * Number of criterias defined. For each criteria, mballoc has slightly
> + * different way of finding the required blocks nad usually, higher the
> + * criteria the slower the allocation. We start at lower criterias and keep
> + * falling back to higher ones if we are not able to find any blocks.
> + */
> +#define EXT4_MB_NUM_CRS 4
> +/*
> + * All possible allocation criterias for mballoc
> + */
> +enum criteria {
> +	CR0,
> +	CR1,
> +	CR2,
> +	CR3,
> +};

Usually we define EXT4_MB_NUM_CRS like:

enum criteria {
	CR0,
	CR1,
	CR2,
	CR3,
	EXT4_MB_NUM_CRS
};

> @@ -2626,7 +2626,7 @@ static noinline_for_stack int
>  ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  {
>  	ext4_group_t prefetch_grp = 0, ngroups, group, i;
> -	int cr = -1, new_cr;
> +	enum criteria cr, new_cr;
>  	int err = 0, first_err = 0;
>  	unsigned int nr = 0, prefetch_ios = 0;
>  	struct ext4_sb_info *sbi;

This can cause uninitialized use of 'cr' variable in the 'out:' label.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
