Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62ED555343
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 20:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357635AbiFVS2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 14:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356636AbiFVS2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:28:36 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E493E30576;
        Wed, 22 Jun 2022 11:28:35 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id 184so2842824vsz.2;
        Wed, 22 Jun 2022 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dI7/D7f9EgO7+izfcBoxTP/wyucrZR4DpWnBmVtnhZw=;
        b=RaeSkMNFIDlGtxga6Y1yft0yXVRJMaWv3hzGqSkpVi6z9+7Zbu3TCSjhW6T2Xj9Ffi
         2+uaFdvUwuNoCKk32HxET2JKkoxde/yBEJX4d+3ULB3qMejfHImD2534RqHdBG1Xxm1S
         Jp72Mf8/3A13mfvhi2O1T/Xc8CVtRerZrCU7bdB3prNaL6+bg37t+s2TfYAVTQcctfEh
         tdVFnWJjlhCzOPXLx8C5BB5M+ck9sZ42czw4vXzKAOJzAQWDGBO0frae+lSy4px60svI
         nBUa8hgxmRWM+MypfAFc4qz8bUGZyP5FjzO6aDvFE0RrGE947+yO6+kZlNVaaeG8r0a9
         pLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dI7/D7f9EgO7+izfcBoxTP/wyucrZR4DpWnBmVtnhZw=;
        b=2AZhgfCblIOU/2l10NJSf9hgq8NXy8wFGxsGUy+0hBHO0RonzfVTZOtU6/WLzvVJh8
         5W6cI+uIcWvnR4FUToHKz8+K3H5l+85R4kywNCwHGPWbtDfdvEUqYBQ3KnRYzhavcQE6
         fiBUZu19QDtwdy3LbF5ODPMOd5OMqg4Nk21iF07KtpGj9Jmekb/hd4BaCJa9CH85H8xC
         bLvkPLw2SKPt7eGm75Mb3FtV3F3v9J1BO79Hmh1AZ62XdKheFQxywcdmE3X7E/4TPnXk
         cqdq+jil8LIuC30e7M5sM3eVn0zAr1oVNR2oz3IlWRGmj0cFb6y6odoE70c/y6kCGbWk
         7QLw==
X-Gm-Message-State: AJIora/jyyp0v2NhfaW864ZXXmgPX9/g893y35ZklQfBfD9Y/Aroq3Ly
        wqbqOjNzXCI7vFqqpeQf1IlKfhx5QeVc+RkGUllKXRSaOcSKkg==
X-Google-Smtp-Source: AGRyM1u+ppgcSZAFILUKJ0UqfJNw76+eMuJ/aPugbMMFRbSFjD+EtMovHRGY8NnP4SA66xWhkv17DARCRXI+dwKPlBQ=
X-Received: by 2002:a05:6102:5dc:b0:354:63f1:df8d with SMTP id
 v28-20020a05610205dc00b0035463f1df8dmr2054898vsf.72.1655922514823; Wed, 22
 Jun 2022 11:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220620134551.2066847-1-amir73il@gmail.com> <20220620134551.2066847-2-amir73il@gmail.com>
 <20220622160049.koda4uazle7i2735@quack3.lan>
In-Reply-To: <20220622160049.koda4uazle7i2735@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 22 Jun 2022 21:28:23 +0300
Message-ID: <CAOQ4uxg6-hzNTaXRdhC7RPZFfDJiNwbSEdj4yq40GZZQP7gC_A@mail.gmail.com>
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

On Wed, Jun 22, 2022 at 7:00 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 20-06-22 16:45:50, Amir Goldstein wrote:
> > Setting flags FAN_ONDIR FAN_EVENT_ON_CHILD in ignore mask has no effect.
> > The FAN_EVENT_ON_CHILD flag in mask implicitly applies to ignore mask and
> > ignore mask is always implicitly applied to events on directories.
> >
> > Define a mark flag that replaces this legacy behavior with logic of
> > applying the ignore mask according to event flags in ignore mask.
> >
> > Implement the new logic to prepare for supporting an ignore mask that
> > ignores events on children and ignore mask that does not ignore events
> > on directories.
> >
> > To emphasize the change in terminology, also rename ignored_mask mark
> > member to ignore_mask and use accessor to get only ignored events or
> > events and flags.
> >
> > This change in terminology finally aligns with the "ignore mask"
> > language in man pages and in most of the comments.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> ..
>
> > @@ -423,7 +425,8 @@ static bool fsnotify_iter_select_report_types(
> >                        * But is *this mark* watching children?
> >                        */
> >                       if (type == FSNOTIFY_ITER_TYPE_PARENT &&
> > -                         !(mark->mask & FS_EVENT_ON_CHILD))
> > +                         !(mark->mask & FS_EVENT_ON_CHILD) &&
> > +                         !(fsnotify_ignore_mask(mark) & FS_EVENT_ON_CHILD))
> >                               continue;
>
> So now we have in ->report_mask the FSNOTIFY_ITER_TYPE_PARENT if either
> ->mask or ->ignore_mask have FS_EVENT_ON_CHILD set. But I see nothing that
> would stop us from applying say ->mask to the set of events we are
> interested in if FS_EVENT_ON_CHILD is set only in ->ignore_mask? And

I think I spent some time thinking about this and came to a conclusion that
1. It is hard to get all the cases right
2. It is a micro optimization

The implication is that the user can set an ignore mask of an object, get no
events but still cause performance penalty. Right?
So just don't do that...

It is easier to maintain the code with the rule that an "interest" in the object
is either positive (I want this event) or negative (I don't want this event).
If the user has no interest, the user should set nothing in the mark.

Do you agree with me that the added complexity would not be worth it?

> there's the same problem in the other direction as well. Am I missing

Other direction?

Thanks,
Amir.
