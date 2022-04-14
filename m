Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B86C500719
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 09:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbiDNHkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 03:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiDNHkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:40:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4373256415;
        Thu, 14 Apr 2022 00:38:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E274F1F747;
        Thu, 14 Apr 2022 07:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649921894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hT+knE9TV0fknXqaP/vEB7WYsrSBA5fzZ7sExOr3dw=;
        b=aohmTLrbVTD86oE7+SsZqDVi2lqtz1j7ogs4Cs0VA3kWhVeXC1v1VT/uihTvjq239SPx83
        UQFu1pdc5HHKqIhkl2s1/RpLAlwtCDRaRj2lagdytLLT2nC/8KMqnpffEztqYD+FQF+iQk
        xjdHGfYCmtyJt5ocwvGDVDJdvPoHCwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649921894;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hT+knE9TV0fknXqaP/vEB7WYsrSBA5fzZ7sExOr3dw=;
        b=PUHpjk/daB3UV+CFagYStPsjIvjETQj66VwLW4WGwDDASth3HlZMI/i4ifeguZtftsatNH
        +S5L0JtebkKn8jBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C48E113A86;
        Thu, 14 Apr 2022 07:38:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N+JQL2bPV2LNNQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Apr 2022 07:38:14 +0000
Message-ID: <83f49beb-52f7-15f6-3b53-97cac0030ca4@suse.cz>
Date:   Thu, 14 Apr 2022 09:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm/smaps_rollup: return empty file for kthreads instead
 of ESRCH
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Daniel Colascione <dancol@google.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220413211357.26938-1-alex_y_xu.ref@yahoo.ca>
 <20220413211357.26938-1-alex_y_xu@yahoo.ca>
 <20220413142748.a5796e31e567a6205c850ae7@linux-foundation.org>
 <1649886492.rqei1nn3vm.none@localhost>
 <20220413160613.385269bf45a9ebb2f7223ca8@linux-foundation.org>
 <YleToQbgeRalHTwO@casper.infradead.org>
 <YlfFaPhNFWNP+1Z7@localhost.localdomain>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YlfFaPhNFWNP+1Z7@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/14/22 08:55, Alexey Dobriyan wrote:
> On Thu, Apr 14, 2022 at 04:23:13AM +0100, Matthew Wilcox wrote:
>> On Wed, Apr 13, 2022 at 04:06:13PM -0700, Andrew Morton wrote:
>> > On Wed, 13 Apr 2022 18:25:53 -0400 "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca> wrote:
>> > > > 258f669e7e88 was 4 years ago, so I guess a -stable backport isn't
>> > > > really needed.
>> > > 
>> > > Current behavior (4.19+):
>> [...]
>> > > Pre-4.19 and post-patch behavior:
>> > 
>> > I don't think this will work very well.  smaps_rollup is the sort of
>> > system tuning thing for which organizations will develop in-house
>> > tooling which never get relesaed externally.
>> > 
>> > > 3. As mentioned previously, this was already the behavior between 4.14 
>> > >    and 4.18 (inclusive).
>> > > 
>> > 
>> > Yup.  Hm, tricky.  I'd prefer to leave it alone if possible.  How
>> > serious a problem is this, really?  
>> 
>> I don't think "It's been like this for four years" is as solid an argument
>> as you might like.  Certain distributions (of the coloured millinery
>> variety, for example) haven't updated their kernel since then and so
>> there may well be many organisations who have not been exposed to the
>> current behaviour.  Even my employers distribution, while it offers a
>> 5.4 based kernel, still has many customers who have not moved from the
>> 4.14 kernel.  Inertia is a real thing, and restoring this older behaviour
>> might well be an improvement.
> 
> Returning ESRCH is better so that programs don't waste time reading and
> closing empty files and instantiating useless inodes.

Hm, unfortunately I don't remember why I put return -ESRCH for this case in
addition to get_proc_task() failing. I doubt it was a conscious decision to
treat kthreads differently - I think I would have preferred consistency with
maps/smaps.

Can the awk use case be fixed with some flag to make it ignore the errors?

> Of course it is different if this patch was sent as response to a regression.

