Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A664C525372
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 19:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356898AbiELRVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 13:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356965AbiELRVB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 13:21:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640137027
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 10:21:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 352891F8EF;
        Thu, 12 May 2022 17:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652376059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfJIKCz2LbREfbnq4CvcWdm6ei+WHliyWcq6pCEH2XQ=;
        b=sgXMsi17sxRC62zm/E74FOD6zu3RaBHyX+oimq+B1G8pR7H1er/EyjQNowsw9TnS+If+jt
        5l5lNPPmKA+Y1z/e9i6HkwZmAjDUOqYCJOTLCCdOLtRU6w2luHR3KW/zEtfqmQHyhWSTof
        bdbImJXLCQNZKUkorkX9Beg98Y1+rvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652376059;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfJIKCz2LbREfbnq4CvcWdm6ei+WHliyWcq6pCEH2XQ=;
        b=4kNL0YaxhPaf/Wu0ciR8ABroP2mzV8bOVECiCHMP2ldestu7dCyQtu0Nbc06C0y+JDeYPS
        xz1mjQUFq0VWdhDQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 160DF2C141;
        Thu, 12 May 2022 17:20:59 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A8183A062A; Thu, 12 May 2022 19:20:58 +0200 (CEST)
Date:   Thu, 12 May 2022 19:20:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fsnotify: introduce mark type iterator
Message-ID: <20220512172058.j2zyhpmyt4trlwvf@quack3.lan>
References: <20220511092914.731897-1-amir73il@gmail.com>
 <20220511092914.731897-2-amir73il@gmail.com>
 <20220511125440.5zsuzn7eemdvfksi@quack3.lan>
 <CAOQ4uxjjfaU4xefu1-qK5MzGq+m0EChB9mK6TZo1Lp6bmBviUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjjfaU4xefu1-qK5MzGq+m0EChB9mK6TZo1Lp6bmBviUQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 11-05-22 21:26:16, Amir Goldstein wrote:
> On Wed, May 11, 2022 at 3:54 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 11-05-22 12:29:13, Amir Goldstein wrote:
> > > fsnotify_foreach_iter_mark_type() is used to reduce boilerplate code
> > > of iteratating all marks of a specific group interested in an event
> > > by consulting the iterator report_mask.
> > >
> > > Use an open coded version of that iterator in fsnotify_iter_next()
> > > that collects all marks of the current iteration group without
> > > consulting the iterator report_mask.
> > >
> > > At the moment, the two iterator variants are the same, but this
> > > decoupling will allow us to exclude some of the group's marks from
> > > reporting the event, for example for event on child and inode marks
> > > on parent did not request to watch events on children.
> > >
> > > Fixes: 2f02fd3fa13e ("fanotify: fix ignore mask logic for events on child and on dir")
> > > Reported-by: Jan Kara <jack@suse.com>
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Mostly looks good. Two nits below.
> >
> > >  /*
> > > - * Pop from iter_info multi head queue, the marks that were iterated in the
> > > + * Pop from iter_info multi head queue, the marks that belong to the group of
> > >   * current iteration step.
> > >   */
> > >  static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
> > >  {
> > > +     struct fsnotify_mark *mark;
> > >       int type;
> > >
> > >       fsnotify_foreach_iter_type(type) {
> > > -             if (fsnotify_iter_should_report_type(iter_info, type))
> > > +             mark = iter_info->marks[type];
> > > +             if (mark && mark->group == iter_info->current_group)
> > >                       iter_info->marks[type] =
> > >                               fsnotify_next_mark(iter_info->marks[type]);
> >
> > Wouldn't it be more natural here to use the new helper
> > fsnotify_foreach_iter_mark_type()? In principle we want to advance mark
> > types which were already reported...
> 
> Took me an embarrassing amount of time to figure out why this would be wrong
> and I must have known this a few weeks ago when I wrote the patch, so
> a comment is in order:
> 
>         /*
>          * We cannot use fsnotify_foreach_iter_mark_type() here because we
>          * may need to check if next group has a mark of type X even if current
>          * group did not have a mark of type X.
>          */

Well, but this function is just advancing the lists for marks we have
already processed. And processed marks are exactly those set in report_mask.
So your code should be equivalent to the old one but using
fsnotify_foreach_iter_mark_type() should work as well AFAICT.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
