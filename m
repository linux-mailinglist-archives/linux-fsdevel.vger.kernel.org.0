Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8F54E22F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 10:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345678AbiCUJKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 05:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345623AbiCUJKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:10:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC963DF7C
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 02:09:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6612F1F37F;
        Mon, 21 Mar 2022 09:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647853762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iea9zm5Pabi5b4nJXG6eNco1lLeH+gXs+NfqLPdQL2M=;
        b=zxu25ytxR0mv0n7lwUHnegTDWE7+BRyLhFpGe+G2NF8xpVsNT7+axx90V6UcDJErZ2CRtV
        uu04OXlFN8ZkMnHVlQTCPmq3qvLz1ExeALlC39bLVNWK2uXA8dWX3zT32cT1PL9gCT1F9/
        ofGGGHNofaZoCMPdS2HXMX3J4H+g8xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647853762;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iea9zm5Pabi5b4nJXG6eNco1lLeH+gXs+NfqLPdQL2M=;
        b=ko89DgXKVxeKuyeMIOMnpNmqNMeYtASuZ3PcJrJXczkbybl03+C1p8N5MfPp1+RyzWMrke
        CILYnHo64f+O1ZBg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4D624A3B81;
        Mon, 21 Mar 2022 09:09:22 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 043BBA0610; Mon, 21 Mar 2022 10:09:18 +0100 (CET)
Date:   Mon, 21 Mar 2022 10:09:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/5] fanotify: add support for exclusive create of mark
Message-ID: <20220321090918.tpthlbjd6ffavdte@quack3.lan>
References: <20220307155741.1352405-1-amir73il@gmail.com>
 <20220307155741.1352405-5-amir73il@gmail.com>
 <20220317153443.iy5rvns5nwxlxx43@quack3.lan>
 <20220317154550.y3rvxmmfcaf5n5st@quack3.lan>
 <CAOQ4uxi85LV7upQuBUjL==aaWoY8WGMG4DRQToj6Y-JCn-Ex=g@mail.gmail.com>
 <20220318103219.j744o5g5bmsneihz@quack3.lan>
 <CAOQ4uxj_-pYg4g6V8OrF8rD-8R+Mn1tMsPBq52WnfkvjZWYVrw@mail.gmail.com>
 <20220318140951.oly4ummcuu2snat5@quack3.lan>
 <CAOQ4uxisrc_u761uv9_EwgiENz4J6SNk=hPxpr7Nn=vC1S2gLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxisrc_u761uv9_EwgiENz4J6SNk=hPxpr7Nn=vC1S2gLg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 18-03-22 18:06:40, Amir Goldstein wrote:
> > > > So far my thinking is that we either follow the path of possibly generating
> > > > more events than necessary (i.e., any merge of two masks that do not both
> > > > have FAN_MARK_VOLATILE set will clear FAN_MARK_VOLATILE)
> 
> I agree that would provide predictable behavior which is also similar to
> that of _SURV_MODIFY.
> But IMO, this is very weird to explain/document in the wider sense.
> However, if we only document that
> "FAN_MARK_VOLATILE cannot be set on an existing mark and any update
>  of the mask without FAN_MARK_VOLATILE clears that flag"
> (i.e. we make _VOLATILE imply the _CREATE behavior)
> then the merge logic is the same as you suggested, but easier to explain.

Yes, makes sense.

> > > > or we rework the
> > > > whole mark API (and implementation!) to completely avoid these strange
> > > > effects of flag merging. I don't like FAN_MARK_CREATE much because IMO it
> > > > solves only half of the problem - when new mark with a flag wants to merge
> > > > with an existing mark, but does not solve the other half when some other
> > > > mark wants to merge to a mark with a flag. Thoughts?
> > > >
> > >
> > > Yes. Just one thought.
> > > My applications never needed to change the mark mask after it was
> > > set and I don't really see a huge use case for changing the mask
> > > once it was set (besides removing the entire mark).
> > >
> > > So instead of FAN_MARK_CREATE, we may try to see if FAN_MARK_CONST
> > > results in something that is useful and not too complicated to implement
> > > and document.
> > >
> > > IMO using a "const" initialization for the "volatile" mark is not such a big
> > > limitation and should not cripple the feature.
> >
> > OK, so basically if there's mark already placed at the inode and we try to
> > add FAN_MARK_CONST, the addition would fail, and similarly if we later tried
> > to add further mark to the inode with FAN_MARK_CONST mark, it would fail?
> >
> > Thinking out loud: What does FAN_MARK_CONST bring compared to the
> > suggestion to go via the path of possibly generating more events by
> > clearing FAN_MARK_VOLATILE? I guess some additional safety if you would add
> > another mark to the same inode by an accident. Because if you never update
> > marks, there's no problem with additional mark flags.
> > Is the new flag worth it? Not sure...  :)
> 
> I rather not add new flags if we can do without them.
> 
> To summarize my last proposal:
> 
> 1. On fanotify_mark() with FAN_MARK_VOLATILE
> 1.a. If the mark is new, the HAS_IREF flag is not set and no ihold()
> 1.b. If mark already exists without HAS_IREF flag, mask is updated
> 1.c. If mark already exists with HAS_IREF flag, mark add fails with EEXISTS
> 
> 2. On fanotify_mark() without FAN_MARK_VOLATILE
> 2.a. If the mark is new or exists without HAS_IREF, the HAS_IREF flag
> is set and ihold()
> 2.b. If mark already exists with HAS_IREF flag, mask is updated
> 
> Do we have a winner?

Sounds good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
