Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFF2557717
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 11:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiFWJtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 05:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiFWJtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:49:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E66BEB;
        Thu, 23 Jun 2022 02:49:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7412921D23;
        Thu, 23 Jun 2022 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655977784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+CLl76jCtc8JF3MOH1U5ZFbevKkgfgdE07Jn+f0mNCI=;
        b=fBTd+tR4X2qkk37Pn+hlm0r9bZLPgH6EvaSpqYhwDnZ4hytW6sSzacCvMImZW30w2CeqbN
        aUOh+rouH878Bw5fX/Krpi+RyQQmCFrY6mniJzICicOJeN4F5g70zwvGaibj0K2jCnLrtk
        EkOluqiKnbrHm40cC1FRqRHkNMwkc+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655977784;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+CLl76jCtc8JF3MOH1U5ZFbevKkgfgdE07Jn+f0mNCI=;
        b=2pS36cRb+Iu7+M3vn/Be7YOzAx3YYw4MZ34FGOnlRkKW07tlWgWWHCsjOlb7DlJhpnkMmG
        YcYoqWFAQwOumqBw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A7C4E2C142;
        Thu, 23 Jun 2022 09:49:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 03515A062B; Thu, 23 Jun 2022 11:49:43 +0200 (CEST)
Date:   Thu, 23 Jun 2022 11:49:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/2] fanotify: prepare for setting event flags in ignore
 mask
Message-ID: <20220623094943.tp3qtl6zgnjxup3z@quack3.lan>
References: <20220620134551.2066847-1-amir73il@gmail.com>
 <20220620134551.2066847-2-amir73il@gmail.com>
 <20220622160049.koda4uazle7i2735@quack3.lan>
 <CAOQ4uxg6-hzNTaXRdhC7RPZFfDJiNwbSEdj4yq40GZZQP7gC_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg6-hzNTaXRdhC7RPZFfDJiNwbSEdj4yq40GZZQP7gC_A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-06-22 21:28:23, Amir Goldstein wrote:
> On Wed, Jun 22, 2022 at 7:00 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 20-06-22 16:45:50, Amir Goldstein wrote:
> > > Setting flags FAN_ONDIR FAN_EVENT_ON_CHILD in ignore mask has no effect.
> > > The FAN_EVENT_ON_CHILD flag in mask implicitly applies to ignore mask and
> > > ignore mask is always implicitly applied to events on directories.
> > >
> > > Define a mark flag that replaces this legacy behavior with logic of
> > > applying the ignore mask according to event flags in ignore mask.
> > >
> > > Implement the new logic to prepare for supporting an ignore mask that
> > > ignores events on children and ignore mask that does not ignore events
> > > on directories.
> > >
> > > To emphasize the change in terminology, also rename ignored_mask mark
> > > member to ignore_mask and use accessor to get only ignored events or
> > > events and flags.
> > >
> > > This change in terminology finally aligns with the "ignore mask"
> > > language in man pages and in most of the comments.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > ..
> >
> > > @@ -423,7 +425,8 @@ static bool fsnotify_iter_select_report_types(
> > >                        * But is *this mark* watching children?
> > >                        */
> > >                       if (type == FSNOTIFY_ITER_TYPE_PARENT &&
> > > -                         !(mark->mask & FS_EVENT_ON_CHILD))
> > > +                         !(mark->mask & FS_EVENT_ON_CHILD) &&
> > > +                         !(fsnotify_ignore_mask(mark) & FS_EVENT_ON_CHILD))
> > >                               continue;
> >
> > So now we have in ->report_mask the FSNOTIFY_ITER_TYPE_PARENT if either
> > ->mask or ->ignore_mask have FS_EVENT_ON_CHILD set. But I see nothing that
> > would stop us from applying say ->mask to the set of events we are
> > interested in if FS_EVENT_ON_CHILD is set only in ->ignore_mask? And
> 
> I think I spent some time thinking about this and came to a conclusion that
> 1. It is hard to get all the cases right
> 2. It is a micro optimization
> 
> The implication is that the user can set an ignore mask of an object, get no
> events but still cause performance penalty. Right?
> So just don't do that...

So I was more afraid that this actually results in generating events we
should not generate. For example consider dir 'd' with mask FS_OPEN and
ignore_mask FS_MODIFY | FS_EVENT_ON_CHILD. Now open("d/file") happens so
FS_OPEN is generated for d/file. We select FSNOTIFY_ITER_TYPE_PARENT in the
->report_mask because of the ignore_mask on 'd' and pass the iter to
fanotify_handle_event(). There fanotify_group_event_mask() will include
FS_OPEN to marks_mask and conclude event should be reported. But there's no
mark that should result in reporting this...

The problem is that with the introduction of FSNOTIFY_ITER_TYPE_PARENT we
started to rely on that type being set only when the event on child should
be reported to parent and now you break that AFAICT.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
