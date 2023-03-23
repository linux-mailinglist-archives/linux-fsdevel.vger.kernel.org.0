Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550676C65DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 11:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjCWK4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 06:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjCWK4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:56:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEF410A96;
        Thu, 23 Mar 2023 03:55:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8EA281FD91;
        Thu, 23 Mar 2023 10:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679568937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YwF6wTKRf8byZK5auIOmvz8r+sMLSBZV/2T+3zUIqww=;
        b=PBAY6JEFTGRFQJTGeTj1kB063NZfdx92B8IWGZ4bFf4q/nu0vAQl/tH8k2c8m9ntaS1wdO
        +y5PDue0qck38XhgzsEWzqFQ6Vtdup6eExo5lpdDCSIKFUc0ehtPxBUL00w3q1zclieMo7
        ojq/dJc7ZEW7H+Q5xmMp7Iw8QUReTjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679568937;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YwF6wTKRf8byZK5auIOmvz8r+sMLSBZV/2T+3zUIqww=;
        b=nJBg5WfzdIvgC1sZCld+XnBkvk8uMNqo+/NbL/LUUjXIhbjgptejUcrJu7OlGkU3fF+Ma1
        IT5Nibb0+iPcfhDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99BAB13596;
        Thu, 23 Mar 2023 10:55:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4iaBJSkwHGScegAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 23 Mar 2023 10:55:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0F78BA071C; Thu, 23 Mar 2023 11:55:37 +0100 (CET)
Date:   Thu, 23 Mar 2023 11:55:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 04/11] ext4: Convert mballoc cr (criteria) to enum
Message-ID: <20230323105537.rrecw5xqqzmw567d@quack3>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <9670431b31aa62e83509fa2802aad364910ee52e.1674822311.git.ojaswin@linux.ibm.com>
 <20230309121122.vzfswandgqqm4yk5@quack3>
 <ZBRAZsvbcSBNJ+Pl@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBRAZsvbcSBNJ+Pl@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 17-03-23 15:56:46, Ojaswin Mujoo wrote:
> On Thu, Mar 09, 2023 at 01:11:22PM +0100, Jan Kara wrote:
> > Also when going for symbolic allocator scan names maybe we could actually
> > make names sensible instead of CR[0-4]? Perhaps like CR_ORDER2_ALIGNED,
> > CR_BEST_LENGHT_FAST, CR_BEST_LENGTH_ALL, CR_ANY_FREE. And probably we could
> > deal with ordered comparisons like in:
> I like this idea, it should make the code a bit more easier to
> understand. However just wondering if I should do it as a part of this
> series or a separate patch since we'll be touching code all around and 
> I don't want to confuse people with the noise :) 

I guess a mechanical rename should not be really confusing. It just has to
be a separate patch.

> > 
> >                 if (cr < 2 &&
> >                     (!sbi->s_log_groups_per_flex ||
> >                      ((group & ((1 << sbi->s_log_groups_per_flex) - 1)) != 0)) &
> >                     !(ext4_has_group_desc_csum(sb) &&
> >                       (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))))
> >                         return 0;
> > 
> > to declare CR_FAST_SCAN = 2, or something like that. What do you think?
> About this, wont it be better to just use something like
> 
> cr < CR_BEST_LENGTH_ALL 
> 
> instead of defining a new CR_FAST_SCAN = 2.

Yeah, that works as well.

> The only concern is that if we add a new "fast" CR (say between
> CR_BEST_LENGTH_FAST and CR_BEST_LENGTH_ALL) then we'll need to make
> sure we also update CR_FAST_SCAN to 3 which is easy to miss.

Well, you have that problem with any naming scheme (and even with numbers).
So as long as names are all defined together, there's reasonable chance
you'll remember to verify the limits still hold :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
