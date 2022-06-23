Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E80557A23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiFWMRS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 08:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiFWMRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:17:16 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F3534B9D;
        Thu, 23 Jun 2022 05:17:15 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id j1so10339229vsj.12;
        Thu, 23 Jun 2022 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sb/jwSe5HoSp8kH02mtcD5nKWDYLNYBGBBdjWlW/hgg=;
        b=ZlmQm6ttq+q+bJ+WYsd41EU3h2wV5pgrNq2/DrRfhd/JyS57UFJ+5TfMWbF3Ym1MUS
         H/WLtqVAE41Cjs1vtaK7sLiCJH31l5AU6g00Jf88bro/8h3LsSILn9M4iwXOmWqrYuvc
         7oAbC8TXl2IMsPHAthS/rI8C1kMXHyWgGp1fDKk2f69FxO7y44cQRcu/tXScxKjbXC2V
         rMbq8amryhi3I+0gkIOzVF20lxZ1CFEQGaIDzWpdy8xIEqgwirTxKkIj5xDAIovkjjpf
         o0YWSOZdwZs+SifuWYCznBAUKdFdfzIEkqMTwKOjxSYNksaNE7a69+TGZ/aIIC1W8ew7
         ZNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sb/jwSe5HoSp8kH02mtcD5nKWDYLNYBGBBdjWlW/hgg=;
        b=zFHw3/GZvr5wNPabEF7QGtT3DJBbaF3FF7SWHC8mlj4bRH9BKVFA0bByTqmRyM70I+
         KMkXW5+ySkcJ3zJ/YImTfcADkGXDlalgtYkrJ/fNKlY4BKFBg8P9z2KK7so5oSgBng3s
         cO8/GNqv+wsojuvoZVZe8zdTp0BsJ+vPm88D6fmSawZ4Vixv4oRpZMsTwm2VNjXHSsye
         YBQs6R/39n/MuyHuHSmK9shPQOTqIaVQmfVyS9GDvO8wBVREqp8VbGghQhrvhQqE2WpX
         3XZ6PpxDRJMuINrGgQfqJVpkaXH9Ys5Pb1rv/gWWBDcyQyH1uKGH/A5t7QDGPn4AHlh+
         iIvQ==
X-Gm-Message-State: AJIora9VfK/NH6TXczLJ3Whdp/wx74c9zpJtgt0vSvTPbw8Xfo4VuoKQ
        eovd2UkiylyKx20w7fYRFh5Eutda2Xf1DsF1uVY=
X-Google-Smtp-Source: AGRyM1uWKMbJWyZkYE4XFBOdesa+iiLiSyyUdSsPZESGKXZ3H6l+T6qAr07jRPujOEDinYnjWJAmWHYMKWi9MyF7IvU=
X-Received: by 2002:a67:fa01:0:b0:354:3136:c62e with SMTP id
 i1-20020a67fa01000000b003543136c62emr10134728vsq.2.1655986631710; Thu, 23 Jun
 2022 05:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220620134551.2066847-1-amir73il@gmail.com> <20220620134551.2066847-3-amir73il@gmail.com>
 <20220623101408.ejmqpp7xw6f67me7@quack3.lan>
In-Reply-To: <20220623101408.ejmqpp7xw6f67me7@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 23 Jun 2022 15:17:00 +0300
Message-ID: <CAOQ4uxiy7WkzhUO6o4ZgpNH2rrca5iXwTFujw=rJNWosVaK8zA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: introduce FAN_MARK_IGNORE
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

On Thu, Jun 23, 2022 at 1:14 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 20-06-22 16:45:51, Amir Goldstein wrote:
> > This flag is a new way to configure ignore mask which allows adding and
> > removing the event flags FAN_ONDIR and FAN_EVENT_ON_CHILD in ignore mask.
> >
> > The legacy FAN_MARK_IGNORED_MASK flag would always ignore events on
> > directories and would ignore events on children depending on whether
> > the FAN_EVENT_ON_CHILD flag was set in the (non ignored) mask.
> >
> > FAN_MARK_IGNORE can be used to ignore events on children without setting
> > FAN_EVENT_ON_CHILD in the mark's mask and will not ignore events on
> > directories unconditionally, only when FAN_ONDIR is set in ignore mask.
> >
> > The new behavior is sticky.  After calling fanotify_mark() with
> > FAN_MARK_IGNORE once, calling fanotify_mark() with FAN_MARK_IGNORED_MASK
> > will update the ignore mask, but will not change the event flags in
> > ignore mask nor how these flags are treated.
>
> IMHO this stickyness is not very obvious. Wouldn't it be less error-prone
> for users to say that once FAN_MARK_IGNORE is used for a mark, all
> subsequent modifications of ignore mask have to use FAN_MARK_IGNORE? I mean
> if some program bothers with FAN_MARK_IGNORE, I'd expect it to use it for
> all its calls as otherwise the mixup is kind of difficult to reason
> about...

I like that.

>
> Also it follows the behavior we have picked for FAN_MARK_EVICTABLE AFAIR
> but that's not really important to me.

It's kind of the opposite in the case of FAN_MARK_EVICTABLE.
FAN_MARK_EVICTABLE can be "upgraded" no non-evictable
but not the other way around.
And also with FAN_MARK_EVICTABLE we do not deprecate the
old API...

See man page draft:
https://github.com/amir73il/man-pages/commit/58851140bbc08b9ab9c7edd8830f37cf883d8d2a#diff-7a4387558a34e18ed6fb13d31933b2e4506496f8b3dd55df700f62b258e6f004R165

>
> > @@ -1591,10 +1601,20 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
> >
> >       /*
> >        * Event flags (FAN_ONDIR, FAN_EVENT_ON_CHILD) have no effect with
> > -      * FAN_MARK_IGNORED_MASK.
> > +      * FAN_MARK_IGNORED_MASK.  They can be updated in ignore mask with
> > +      * FAN_MARK_IGNORE and then they do take effect.
> >        */
> > -     if (ignore)
> > +     switch (ignore) {
> > +     case 0:
> > +     case FAN_MARK_IGNORE:
> > +             break;
> > +     case FAN_MARK_IGNORED_MASK:
> >               mask &= ~FANOTIFY_EVENT_FLAGS;
> > +             umask = FANOTIFY_EVENT_FLAGS;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
>
> I think this would be easier to follow as two ifs:
>
>         /* We don't allow FAN_MARK_IGNORE & FAN_MARK_IGNORED_MASK together */
>         if (ignore == FAN_MARK_IGNORE | FAN_MARK_IGNORED_MASK)
>                 return -EINVAL;
>         /*
>          * Event flags (FAN_ONDIR, FAN_EVENT_ON_CHILD) have no effect with
>          * FAN_MARK_IGNORED_MASK.
>          */
>         if (ignore == FAN_MARK_IGNORED_MASK) {
>                 mask &= ~FANOTIFY_EVENT_FLAGS;
>                 umask = FANOTIFY_EVENT_FLAGS;
>         }
>

Yeh that looks better.

Thanks,
Amir.
