Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBC84DDB4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 15:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiCROLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 10:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbiCROLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:11:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B7D1EA5F5
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 07:09:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E2C301F37F;
        Fri, 18 Mar 2022 14:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647612592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wssZDuetQ6c1JayzpT2JjIL3BIrieVTqq3387hoXdrw=;
        b=NH3kZKP7GWjaCZ4ss5eo8CZ+jXZWsoyuDNNLRShflqaMhJvAsQI2n6xwl96Y+ugL3lNzyj
        MMYwZn0XLQ8X4ugxcoxF3AWf28v//Qzw5z8dRQWlgKgF8ztegK9B4MgfKbhPUEBswOwd2j
        QJ8Z6a3Ymxv1KSEnAUjcjcBkkGtPybY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647612592;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wssZDuetQ6c1JayzpT2JjIL3BIrieVTqq3387hoXdrw=;
        b=Tv07QEkuwvLvN0xK8FHEvhKXqg4LM1HfYefFPKGpJ7EC4ONTOCSa7PXEG+XAJ4buVrNS/E
        pVRp44pHa+1tsECA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C4AD2A3B8A;
        Fri, 18 Mar 2022 14:09:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EAFD8A0608; Fri, 18 Mar 2022 15:09:51 +0100 (CET)
Date:   Fri, 18 Mar 2022 15:09:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/5] fanotify: add support for exclusive create of mark
Message-ID: <20220318140951.oly4ummcuu2snat5@quack3.lan>
References: <20220307155741.1352405-1-amir73il@gmail.com>
 <20220307155741.1352405-5-amir73il@gmail.com>
 <20220317153443.iy5rvns5nwxlxx43@quack3.lan>
 <20220317154550.y3rvxmmfcaf5n5st@quack3.lan>
 <CAOQ4uxi85LV7upQuBUjL==aaWoY8WGMG4DRQToj6Y-JCn-Ex=g@mail.gmail.com>
 <20220318103219.j744o5g5bmsneihz@quack3.lan>
 <CAOQ4uxj_-pYg4g6V8OrF8rD-8R+Mn1tMsPBq52WnfkvjZWYVrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj_-pYg4g6V8OrF8rD-8R+Mn1tMsPBq52WnfkvjZWYVrw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 18-03-22 13:04:51, Amir Goldstein wrote:
> > > The problem that I was trying to avoid with FAN_MARK_VOLATILE is similar
> > > to an existing UAPI problem with FAN_MARK_IGNORED_SURV_MODIFY -
> > > This flag can only be set and not cleared and when set it affects all the events
> > > set in the mask prior to that time, leading to unpredictable results.
> > >
> > > Let's say a user sets FAN_CLOSE in ignored mask without _SURV_MODIFY
> > > and later sets FAN_OPEN  in ignored mask with _SURV_MODIFY.
> > > Does the ignored mask now include FAN_CLOSE? That depends
> > > whether or not FAN_MODIFY event took place between the two calls.
> >
> > Yeah, but with FAN_MARK_VOLATILE the problem also goes the other way
> > around. If I set FAN_MARK_VOLATILE on some inode and later add something to
> > a normal mask, I might be rightfully surprised when the mark gets evicted
> > and thus I will not get events I'm expecting. Granted the application would
> > be stepping on its own toes because marks are "merged" only for the same
> > notification group but still it could be surprising and avoiding such
> > mishaps would probably involve extra tracking on the application side.
> >
> > The problem essentially lies in mixing mark "flags" (ONDIR, ON_CHILD,
> > VOLATILE, SURV_MODIFY) with mark mask. Mark operations with identical set
> > of flags can be merged without troubles but once flags are different
> > results of the merge are always "interesting". So far the consequences were
> > mostly benign (getting more events than the application may have expected)
> > but with FAN_MARK_VOLATILE we can also start loosing events and that is
> > more serious.
> >
> > So far my thinking is that we either follow the path of possibly generating
> > more events than necessary (i.e., any merge of two masks that do not both
> > have FAN_MARK_VOLATILE set will clear FAN_MARK_VOLATILE) or we rework the
> > whole mark API (and implementation!) to completely avoid these strange
> > effects of flag merging. I don't like FAN_MARK_CREATE much because IMO it
> > solves only half of the problem - when new mark with a flag wants to merge
> > with an existing mark, but does not solve the other half when some other
> > mark wants to merge to a mark with a flag. Thoughts?
> >
> 
> Yes. Just one thought.
> My applications never needed to change the mark mask after it was
> set and I don't really see a huge use case for changing the mask
> once it was set (besides removing the entire mark).
> 
> So instead of FAN_MARK_CREATE, we may try to see if FAN_MARK_CONST
> results in something that is useful and not too complicated to implement
> and document.
> 
> IMO using a "const" initialization for the "volatile" mark is not such a big
> limitation and should not cripple the feature.

OK, so basically if there's mark already placed at the inode and we try to
add FAN_MARK_CONST, the addition would fail, and similarly if we later tried
to add further mark to the inode with FAN_MARK_CONST mark, it would fail?

Thinking out loud: What does FAN_MARK_CONST bring compared to the
suggestion to go via the path of possibly generating more events by
clearing FAN_MARK_VOLATILE? I guess some additional safety if you would add
another mark to the same inode by an accident. Because if you never update
marks, there's no problem with additional mark flags. Is the new flag worth
it? Not sure...  :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
