Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1C5557D68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 15:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiFWN73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 09:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiFWN72 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:59:28 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E05F3B031;
        Thu, 23 Jun 2022 06:59:27 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id b4so6436723vkh.6;
        Thu, 23 Jun 2022 06:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogy+YQkMGLcwRR8n0uq3dxwjYK412jStU07zA03fUns=;
        b=EHwxQxxYQhK+GktZNMWjAik3eMMRoQSxDsPdoGW5Wgp1YXaIFQaS3T4ZLtmBWiH/p0
         l736ctMtFCA4EegduXxEEaLLti0ZLXm0qDKXUWypSif191gj+937yr0XSEKzc+xFKPJJ
         nsk8ZU0IcgsMk3uvguOM4xdLhGyO+edFKjP0LzqIAzloRoVsMb8rSePbty8nIHbbt5Gb
         jZIpUYILD5FTH6g7VZrtEVOgmFdT3sg0KmilzwcGTQcvGKtRg0q2PokZNuHj9x3Uw7TL
         eey5RUpzjAFVaA71RgG4yUlEBw9ZFfshAPrnWl72L9DjUgiGRyEGEDPqLR/o6U0RBToe
         oedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogy+YQkMGLcwRR8n0uq3dxwjYK412jStU07zA03fUns=;
        b=HS+Hb0G55hjQjce2TN8aiMTHYEZ6mWiUqDNlJ0gNCIzp7o1EJE/TOtJ9Q8si0W/heQ
         xBIoC1X7Z7IGuMbGRbBzFxFlc2iaceoT1r4pjgjrNsIP1PmMRZx2bwwtkSXugOAVdmiK
         VPmZin2zhfP/Bzxwq56J+bBG6WE+33vGph6qSxj8tTMMY7EbW4HORd5sne3AuxMzS+Ae
         67VNHSIB4cHufZ/lFVf8odxxP18Js8GFEaeCW/phcgkDwKUigW3ZLQIxlLGN0y/QfUtL
         T00aCXgWGx9ekJaMHR1k4uDKBvAnVtdQSyH3DKw20Vi18mmUAz3v4x9x4krolsp9g8hl
         58pw==
X-Gm-Message-State: AJIora/g7496iAS3vIGUv9cKpseG5hrGsyk/ypExgfJvi6yjaeiPTPLj
        6PrgZ7FO1XIpR2czxDwlZpFgjZ1fuYjgWAqFJ+E=
X-Google-Smtp-Source: AGRyM1udSotwRsD/EPucHrlm8U0TSjNBHVJh/s9Eul5zKJxBv2IkjORtU1PkjdCqqFD0KTuDAguoD7QroVBQX2WAqwM=
X-Received: by 2002:a1f:c603:0:b0:36c:500c:d692 with SMTP id
 w3-20020a1fc603000000b0036c500cd692mr8908478vkf.11.1655992766470; Thu, 23 Jun
 2022 06:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220620134551.2066847-1-amir73il@gmail.com> <20220620134551.2066847-2-amir73il@gmail.com>
 <20220622160049.koda4uazle7i2735@quack3.lan> <CAOQ4uxg6-hzNTaXRdhC7RPZFfDJiNwbSEdj4yq40GZZQP7gC_A@mail.gmail.com>
 <20220623094943.tp3qtl6zgnjxup3z@quack3.lan>
In-Reply-To: <20220623094943.tp3qtl6zgnjxup3z@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 23 Jun 2022 16:59:15 +0300
Message-ID: <CAOQ4uxgVhF5DV+AC-nDwQhBS7rpHEF3+WQBHE1Fc07e77rhuvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fanotify: prepare for setting event flags in ignore mask
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 23, 2022 at 12:49 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 22-06-22 21:28:23, Amir Goldstein wrote:
> > On Wed, Jun 22, 2022 at 7:00 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 20-06-22 16:45:50, Amir Goldstein wrote:
> > > > Setting flags FAN_ONDIR FAN_EVENT_ON_CHILD in ignore mask has no effect.
> > > > The FAN_EVENT_ON_CHILD flag in mask implicitly applies to ignore mask and
> > > > ignore mask is always implicitly applied to events on directories.
> > > >
> > > > Define a mark flag that replaces this legacy behavior with logic of
> > > > applying the ignore mask according to event flags in ignore mask.
> > > >
> > > > Implement the new logic to prepare for supporting an ignore mask that
> > > > ignores events on children and ignore mask that does not ignore events
> > > > on directories.
> > > >
> > > > To emphasize the change in terminology, also rename ignored_mask mark
> > > > member to ignore_mask and use accessor to get only ignored events or
> > > > events and flags.
> > > >
> > > > This change in terminology finally aligns with the "ignore mask"
> > > > language in man pages and in most of the comments.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > ..
> > >
> > > > @@ -423,7 +425,8 @@ static bool fsnotify_iter_select_report_types(
> > > >                        * But is *this mark* watching children?
> > > >                        */
> > > >                       if (type == FSNOTIFY_ITER_TYPE_PARENT &&
> > > > -                         !(mark->mask & FS_EVENT_ON_CHILD))
> > > > +                         !(mark->mask & FS_EVENT_ON_CHILD) &&
> > > > +                         !(fsnotify_ignore_mask(mark) & FS_EVENT_ON_CHILD))
> > > >                               continue;
> > >
> > > So now we have in ->report_mask the FSNOTIFY_ITER_TYPE_PARENT if either
> > > ->mask or ->ignore_mask have FS_EVENT_ON_CHILD set. But I see nothing that
> > > would stop us from applying say ->mask to the set of events we are
> > > interested in if FS_EVENT_ON_CHILD is set only in ->ignore_mask? And
> >
> > I think I spent some time thinking about this and came to a conclusion that
> > 1. It is hard to get all the cases right
> > 2. It is a micro optimization
> >
> > The implication is that the user can set an ignore mask of an object, get no
> > events but still cause performance penalty. Right?
> > So just don't do that...
>
> So I was more afraid that this actually results in generating events we
> should not generate. For example consider dir 'd' with mask FS_OPEN and
> ignore_mask FS_MODIFY | FS_EVENT_ON_CHILD. Now open("d/file") happens so
> FS_OPEN is generated for d/file. We select FSNOTIFY_ITER_TYPE_PARENT in the
> ->report_mask because of the ignore_mask on 'd' and pass the iter to
> fanotify_handle_event(). There fanotify_group_event_mask() will include
> FS_OPEN to marks_mask and conclude event should be reported. But there's no
> mark that should result in reporting this...
>

I see... I think the FS_EVENT_ON_CHILD needs to be added to send_to_group()
just like it knows about FS_ISDIR. Will need to look into it and see which tests
we are missing.

> The problem is that with the introduction of FSNOTIFY_ITER_TYPE_PARENT we
> started to rely on that type being set only when the event on child should
> be reported to parent and now you break that AFAICT.
>

The idea behind FSNOTIFY_ITER_TYPE_PARENT is that the event handlers
have all the information to make the right decision based on mask/ignored_mask
and flags. I guess the implementation is incorrect though.

Well spotted!

Thanks,
Amir.
