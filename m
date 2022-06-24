Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993975599B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 14:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiFXMfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 08:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiFXMfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:35:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360BC49B4B;
        Fri, 24 Jun 2022 05:35:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7C8A61F8BD;
        Fri, 24 Jun 2022 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656074148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z+Q4hBb11E5RBMLH4E3h0fC7zhRxF7uuEu3lS3dIsw4=;
        b=cKDzvbBD9+GZ9XdkquQNJx6VDx8pwzXuTYHZydudL9POgWW14aS5nTOkwIOA9UqkET/BKl
        f/hxhQQzO2Gj0OwhBZ8LL7FWSOCLO8AKEzoozYVDDDHyDz3NRccQ99wrunWWlg/DA6hmKw
        dNHMDqJQ+JKBOdyLfvCiFdZwEnKw5pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656074148;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z+Q4hBb11E5RBMLH4E3h0fC7zhRxF7uuEu3lS3dIsw4=;
        b=Crg4r9dcN/W2NAj6OZ/7ynfjIfnCwHvXOyfZN059bq8DJefl57KMmD+wdAI6mXlN6PLEt+
        PBgy586lDN6GS1Bg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 640582C220;
        Fri, 24 Jun 2022 12:35:48 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6A979A062D; Fri, 24 Jun 2022 14:35:47 +0200 (CEST)
Date:   Fri, 24 Jun 2022 14:35:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/2] fanotify: prepare for setting event flags in ignore
 mask
Message-ID: <20220624123547.nryytudtxmphjd5d@quack3.lan>
References: <20220620134551.2066847-1-amir73il@gmail.com>
 <20220620134551.2066847-2-amir73il@gmail.com>
 <20220622155248.d6oywn3rkurbijs6@quack3.lan>
 <CAOQ4uxitaemN+jfx+ZZ2jn4Z1a_bOj2k8mwOn60vnM-EWDw40g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxitaemN+jfx+ZZ2jn4Z1a_bOj2k8mwOn60vnM-EWDw40g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 24-06-22 14:32:24, Amir Goldstein wrote:
> On Wed, Jun 22, 2022 at 6:52 PM Jan Kara <jack@suse.cz> wrote:
> > > @@ -336,7 +341,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
> > >               *match_mask |= 1U << type;
> > >       }
> > >
> > > -     test_mask = event_mask & marks_mask & ~marks_ignored_mask;
> > > +     test_mask = event_mask & marks_mask & ~marks_ignore_mask;
> >
> > Especially because here if say FAN_EVENT_ON_CHILD becomes a part of
> > marks_ignore_mask it can result in clearing this flag in the returned
> > 'mask' which is likely not what we want if there are some events left
> > unignored in the 'mask'?
> 
> You are right.
> This can end up clearing FAN_ONDIR and then we won't report it.
> However, take a look at this:
> 
> commit 0badfa029e5fd6d5462adb767937319335637c83
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Thu Jul 16 11:42:09 2020 +0300
> 
>     fanotify: generalize the handling of extra event flags
> 
>     In fanotify_group_event_mask() there is logic in place to make sure we
>     are not going to handle an event with no type and just FAN_ONDIR flag.
>     Generalize this logic to any FANOTIFY_EVENT_FLAGS.
> 
>     There is only one more flag in this group at the moment -
>     FAN_EVENT_ON_CHILD. We never report it to user, but we do pass it in to
>     fanotify_alloc_event() when group is reporting fid as indication that
>     event happened on child. We will have use for this indication later on.
> 
> What the hell did I mean by "We will have use for this indication later on"?

Heh, I was wondering about exactly that sentence when I was writing my
review comments and looking where the code came from :). I didn't find a
good explanation...

> fanotify_alloc_event() does not look at the FAN_EVENT_ON_CHILD flag.
> I think I had the idea that events reported in a group with FAN_REPORT_NAME
> on an inode mark should not report its parent fid+name to be compatible with
> inotify behavior and I think you shot this idea down, but it is only a guess.

Yeah, maybe.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
