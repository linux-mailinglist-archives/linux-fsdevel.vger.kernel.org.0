Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746F26C6618
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 12:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjCWLFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 07:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCWLFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:05:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3D3EF8F;
        Thu, 23 Mar 2023 04:05:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 160CA1FDB6;
        Thu, 23 Mar 2023 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679569535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C93TYWv0N9x7KQK/VtAr1G0i+9Az5/zlDZWXgCO5bMw=;
        b=bB86gTBGX+rMesvrIATLfIN80qbv79mSstN4ONhJR9kEN2muKtp/9vqs2oBQbCzghMiKuu
        6izWpFbUe4d4HDCL2HBYNY6ejDqvVWynQFZiw1O9TwrAhY2DOt0Aw+j3F2OA5WB2LQFWZT
        P0aM4TMGBOOairtK8+SuU6peCdjssRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679569535;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C93TYWv0N9x7KQK/VtAr1G0i+9Az5/zlDZWXgCO5bMw=;
        b=Ai7R7eylnWz27edA28WgT71dlQQ8XagQ+5F8I6b91Qw7B1jXPg74Bbny/+o8cU49bw4TuY
        x7PEr0ERYenpBCBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6BA413596;
        Thu, 23 Mar 2023 11:05:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uPBpNH4yHGTVAQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 23 Mar 2023 11:05:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9A1A7A071C; Thu, 23 Mar 2023 12:05:32 +0100 (CET)
Date:   Thu, 23 Mar 2023 12:05:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 11/11] ext4: Add allocation criteria 1.5 (CR1_5)
Message-ID: <20230323110532.n2pxx3ouoffhl2u6@quack3>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <08173ee255f70cdc8de9ac3aa2e851f9d74acb12.1674822312.git.ojaswin@linux.ibm.com>
 <20230309150649.5pnhqsf2khvffl6l@quack3>
 <ZBRQ8W/RL/Tjju68@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBRQ8W/RL/Tjju68@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 17-03-23 17:07:21, Ojaswin Mujoo wrote:
> On Thu, Mar 09, 2023 at 04:06:49PM +0100, Jan Kara wrote:
> > On Fri 27-01-23 18:07:38, Ojaswin Mujoo wrote:
> > > +/*
> > > + * We couldn't find a group in CR1 so try to find the highest free fragment
> > > + * order we have and proactively trim the goal request length to that order to
> > > + * find a suitable group faster.
> > > + *
> > > + * This optimizes allocation speed at the cost of slightly reduced
> > > + * preallocations. However, we make sure that we don't trim the request too
> > > + * much and fall to CR2 in that case.
> > > + */
> > > +static void ext4_mb_choose_next_group_cr1_5(struct ext4_allocation_context *ac,
> > > +		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> > > +{
> > > +	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> > > +	struct ext4_group_info *grp = NULL;
> > > +	int i, order, min_order;
> > > +
> > > +	if (unlikely(ac->ac_flags & EXT4_MB_CR1_5_OPTIMIZED)) {
> > > +		if (sbi->s_mb_stats)
> > > +			atomic_inc(&sbi->s_bal_cr1_5_bad_suggestions);
> > > +	}
> > > +
> > > +	/*
> > > +	 * mb_avg_fragment_size_order() returns order in a way that makes
> > > +	 * retrieving back the length using (1 << order) inaccurate. Hence, use
> > > +	 * fls() instead since we need to know the actual length while modifying
> > > +	 * goal length.
> > > +	 */
> > > +	order = fls(ac->ac_g_ex.fe_len);
> > > +	min_order = order - sbi->s_mb_cr1_5_max_trim_order;
> > 
> > Given we still require the allocation contains at least originally
> > requested blocks, is it ever the case that goal size would be 8 times
> > larger than original alloc size? Otherwise the
> > sbi->s_mb_cr1_5_max_trim_order logic seems a bit pointless...
> 
> Yes that is possible. In ext4_mb_normalize_request, for orignal request len <
> 8MB we actually determine the goal length based on the length of the
> file (i_size) rather than the length of the original request. For eg:
> 
> 	if (size <= 16 * 1024) {
> 		size = 16 * 1024;
> 	} else if (size <= 32 * 1024) {
> 		size = 32 * 1024;
> 	} else if (size <= 64 * 1024) {
> 		size = 64 * 1024;
> 
> and this goes all the way upto size = 8MB. So for a case where the file
> is >8MB, even if the original len is of 1 block(4KB), the goal len would
> be of 2048 blocks(8MB). That's why we decided to add a tunable depending
> on the user's preference.

Ah, I see. The problem with these tunables is that nobody knows to which
value tune them :). But yeah, the default value looks sane so I don't
object.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
