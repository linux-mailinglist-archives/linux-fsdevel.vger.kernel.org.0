Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550346E97C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 16:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjDTO62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 10:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjDTO60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:58:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0344C18;
        Thu, 20 Apr 2023 07:58:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 18CD5218E3;
        Thu, 20 Apr 2023 14:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682002696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gDf4XujYppNB9yfIolnvmPiQWugPbK/UQC0PFMlPEMo=;
        b=P7nvd52LsUKd9ZcwsE9cJ+xvHQ4YwoVQUa81fNln5PZLn/nky/9AyvmKo3lexVYilgS1TR
        IfjDL1lo+lrSiB1pFH/VCVmgRB0+0BYlGYsbFI0JyO3X6dIn0mSKydcfHo6oyxoYkn6s2S
        xsmWIrKHAW6ivloDcV8s20nZvvSKIoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682002696;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gDf4XujYppNB9yfIolnvmPiQWugPbK/UQC0PFMlPEMo=;
        b=/1w8GnyqqkATDhJDhJbLByPmULVmEotyijJ7ZUysGIHOIxs8vvh0JIjMW8AIrdykLdJt09
        ns8QoKkQMzO35BDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09D4D1333C;
        Thu, 20 Apr 2023 14:58:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bxVaAghTQWTlSwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 20 Apr 2023 14:58:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9220EA0729; Thu, 20 Apr 2023 16:58:15 +0200 (CEST)
Date:   Thu, 20 Apr 2023 16:58:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 04/11] ext4: Convert mballoc cr (criteria) to enum
Message-ID: <20230420145815.rs4amtveq4v3qz6p@quack3>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <9670431b31aa62e83509fa2802aad364910ee52e.1674822311.git.ojaswin@linux.ibm.com>
 <20230309121122.vzfswandgqqm4yk5@quack3>
 <ZBRAZsvbcSBNJ+Pl@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230323105537.rrecw5xqqzmw567d@quack3>
 <ZB8IB14yLaoY4+19@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <ZEDcjKUG3OjK9hg9@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEDcjKUG3OjK9hg9@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-04-23 12:02:44, Ojaswin Mujoo wrote:
> On Sat, Mar 25, 2023 at 08:12:36PM +0530, Ojaswin Mujoo wrote:
> > On Thu, Mar 23, 2023 at 11:55:37AM +0100, Jan Kara wrote:
> > > On Fri 17-03-23 15:56:46, Ojaswin Mujoo wrote:
> > > > On Thu, Mar 09, 2023 at 01:11:22PM +0100, Jan Kara wrote:
> > > > > Also when going for symbolic allocator scan names maybe we could actually
> > > > > make names sensible instead of CR[0-4]? Perhaps like CR_ORDER2_ALIGNED,
> > > > > CR_BEST_LENGHT_FAST, CR_BEST_LENGTH_ALL, CR_ANY_FREE. And probably we could
> > > > > deal with ordered comparisons like in:
> > > > I like this idea, it should make the code a bit more easier to
> > > > understand. However just wondering if I should do it as a part of this
> > > > series or a separate patch since we'll be touching code all around and 
> > > > I don't want to confuse people with the noise :) 
> > > 
> > > I guess a mechanical rename should not be really confusing. It just has to
> > > be a separate patch.
> > Alright, got it.
> > > 
> > > > > 
> > > > >                 if (cr < 2 &&
> > > > >                     (!sbi->s_log_groups_per_flex ||
> > > > >                      ((group & ((1 << sbi->s_log_groups_per_flex) - 1)) != 0)) &
> > > > >                     !(ext4_has_group_desc_csum(sb) &&
> > > > >                       (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))))
> > > > >                         return 0;
> > > > > 
> > > > > to declare CR_FAST_SCAN = 2, or something like that. What do you think?
> > > > About this, wont it be better to just use something like
> > > > 
> > > > cr < CR_BEST_LENGTH_ALL 
> > > > 
> > > > instead of defining a new CR_FAST_SCAN = 2.
> > > 
> > > Yeah, that works as well.
> > > 
> > > > The only concern is that if we add a new "fast" CR (say between
> > > > CR_BEST_LENGTH_FAST and CR_BEST_LENGTH_ALL) then we'll need to make
> > > > sure we also update CR_FAST_SCAN to 3 which is easy to miss.
> > > 
> > > Well, you have that problem with any naming scheme (and even with numbers).
> > > So as long as names are all defined together, there's reasonable chance
> > > you'll remember to verify the limits still hold :)
> > haha that's true. Anyways, I'll try a few things and see what looks
> > good. Thanks for the suggestions.
> Hey Jan,
> 
> So I was playing around with this and I prepare a patch to convert CR
> numbers to symbolic names and it looks good as far as things like these
> are concerned:
> 
>   if (cr < CR_POWER2_ALIGNED)
> 		...
> 
> However there's one problem that this numeric naming scheme is used in
> several places like struct member names, function names, traces and
> comments. The issue is that replacing it everywhere is making some of
> the names very long for example:
> 
> 	atomic_read(&sbi->s_bal_cr0_bad_suggestions));
> 
> becomes:
> 
> 	atomic_read(&sbi->s_bal_cr_power2_aligned_bad_suggestions));
> 
> And this is kind of making the code look messy at a lot of places. So
> right now there are a few options we can consider:
> 
> 1. Use symbolic names everywhere at the cost of readability

Can we maybe go with 1b) being: Use symbolic names in variables / members /
...  but shortened? Like s_bal_p2aligned_bad_suggestions? Not sure how many
things are like this but from a quick looks it seems we need to come up
with a sensible shortcut only for cr0 and cr1?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
