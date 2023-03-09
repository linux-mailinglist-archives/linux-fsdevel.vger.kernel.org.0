Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862556B23BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 13:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjCIML1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 07:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCIMLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:11:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A5CE8ABB;
        Thu,  9 Mar 2023 04:11:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D7B0D2007B;
        Thu,  9 Mar 2023 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678363882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=06HODakZlwz/k2YThwRN3Zc6vrX2aFdxNnGOiwjUJRE=;
        b=QQtA5MgLeHwNGm99vPRu+4EOM56fCNCmL9eF3JMk3Yh8tUSpRcLaRHBYIVVZidWODr8ejP
        hoDNp8jjSh7YmFS55txMt9Zi/4CQ7abn0pNlwFznkTN/KZMsV55a8loD/IGm4AxGohDn0I
        s77XA+16FjIZzO9D6vWNt/uBJh7UWpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678363882;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=06HODakZlwz/k2YThwRN3Zc6vrX2aFdxNnGOiwjUJRE=;
        b=mwwaEI5jbt/hevrojcq/rfw8EcfjduFGDK7FH22yUyjrlnMb/qxMqNNaTUGREc88ma+2li
        jEYI9TgT54+EtaCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C61F113A10;
        Thu,  9 Mar 2023 12:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id InlSMOrMCWSOaAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Mar 2023 12:11:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4F886A06FF; Thu,  9 Mar 2023 13:11:22 +0100 (CET)
Date:   Thu, 9 Mar 2023 13:11:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 04/11] ext4: Convert mballoc cr (criteria) to enum
Message-ID: <20230309121122.vzfswandgqqm4yk5@quack3>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <9670431b31aa62e83509fa2802aad364910ee52e.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9670431b31aa62e83509fa2802aad364910ee52e.1674822311.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-01-23 18:07:31, Ojaswin Mujoo wrote:
> Convert criteria to be an enum so it easier to maintain. This change
> also makes it easier to insert new criterias in the future.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Just two small comments below:

> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index b8b00457da8d..6037b8e0af86 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -126,6 +126,14 @@ enum SHIFT_DIRECTION {
>  	SHIFT_RIGHT,
>  };
>  
> +/*
> + * Number of criterias defined. For each criteria, mballoc has slightly
> + * different way of finding the required blocks nad usually, higher the
						   ^^^ and

> + * criteria the slower the allocation. We start at lower criterias and keep
> + * falling back to higher ones if we are not able to find any blocks.
> + */
> +#define EXT4_MB_NUM_CRS 4
> +

So defining this in a different header than the enum itself is fragile. I
understand you need it in ext4_sb_info declaration so probably I'd move the
enum declaration to ext4.h. Alternatively I suppose we could move a lot of
mballoc stuff out of ext4_sb_info into a separate struct because there's a
lot of it. But that would be much larger undertaking.

Also when going for symbolic allocator scan names maybe we could actually
make names sensible instead of CR[0-4]? Perhaps like CR_ORDER2_ALIGNED,
CR_BEST_LENGHT_FAST, CR_BEST_LENGTH_ALL, CR_ANY_FREE. And probably we could
deal with ordered comparisons like in:

                if (cr < 2 &&
                    (!sbi->s_log_groups_per_flex ||
                     ((group & ((1 << sbi->s_log_groups_per_flex) - 1)) != 0)) &
                    !(ext4_has_group_desc_csum(sb) &&
                      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))))
                        return 0;

to declare CR_FAST_SCAN = 2, or something like that. What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
