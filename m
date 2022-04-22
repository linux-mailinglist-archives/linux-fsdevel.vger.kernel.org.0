Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A204350B49F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 12:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446400AbiDVKFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 06:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380220AbiDVKFs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:05:48 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F590541B2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 03:02:56 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b68so5453431qkc.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 03:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHxhyoiEiwcl5ZOWAvFuDSmZTnm7e0HeAJewfy7dRpo=;
        b=H4JBl3tKAKNC55G853HLJZr2iFBtWw/YzhY60bgwTVzpEFaQNDbUozii5vHBpJjq34
         ZWjlmA/2PPkA85vzht6vlgLmGqcynKvalY4f6OfkbAd4Wu9mUDYi9qXFmqjb8YiJNQrJ
         Pzo7ZopJRD14P6NMrIpz09PYwtrIVlZRQe8MNc2f5n7A+kitjyjnvwWq1ljoJGZRbKlj
         AfX2yrISkHjETEaCNtAxY7Dp0anQlv7XIzGAR+dlRUwMGdOPfOikpNt86MumDgeJqUkI
         oRllDG34F5JEYg2tAJVt8eJTWA50Uh5mTGAWhYEI9lA3tHbkwGQ8mi5zWeq4ME0Gurbc
         AxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHxhyoiEiwcl5ZOWAvFuDSmZTnm7e0HeAJewfy7dRpo=;
        b=J9aCLJSuINfNvSJvWgrbEUVevLK6zP00eY8V5UxEIIhGiE42thygB3WqeqrfCZaPAe
         jR65D1nSR0nOBv+2EGeJ2cFNFYk82RVeihAXRtuzmB/6/aJ1aSpzoPnmOGsbxGvY1vJx
         MCATjAmWeIm/np6KTpXuFD1OkrATKYOFro6szWEBftfqvWu7a2hCE8X0aA7uwGsHVTNK
         F40kwWbUg1tfUts07GISDKi16ycr0TAbSN+u+m1G9FOjcVbShG/HCFkPPOTM2CGSRQeM
         yAuS72TgmQFd8AOTyrKZAl6OpuWpQashVWXNLYmMfhttI0yJ8zuMD5OapEjztWnUb0TK
         87Pw==
X-Gm-Message-State: AOAM533LzJWZau6DfUyY5Vm2weUg0NkYrVhuaYt86Z1HSQYE2DCHzjKA
        qIQGZPVSa6xIr+MDxilgv27uFsiTQHI6XpVXuqGFWaBVVcg=
X-Google-Smtp-Source: ABdhPJyRYdHOc7Ap9QBSASd0U5IVbqDVsCCF9FBAejlYNPO7q5WmM7PwHNKrRr9gLzx8HlS4haPHTPX2Z30hgzJ3lHk=
X-Received: by 2002:a05:620a:461f:b0:69f:9b9:6c8f with SMTP id
 br31-20020a05620a461f00b0069f09b96c8fmr2071822qkb.258.1650621775456; Fri, 22
 Apr 2022 03:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220413090935.3127107-1-amir73il@gmail.com> <20220413090935.3127107-5-amir73il@gmail.com>
 <20220421141850.e3cfr5sdiblhwvg7@quack3.lan>
In-Reply-To: <20220421141850.e3cfr5sdiblhwvg7@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 22 Apr 2022 13:02:44 +0300
Message-ID: <CAOQ4uxgU2uq6KG8afGcyRDG5-U6kk2LeYOyAJOekt-JCj_vMpQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] fsnotify: pass flags argument to
 fsnotify_add_mark() via mark
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 21, 2022 at 5:35 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 13-04-22 12:09:23, Amir Goldstein wrote:
> > Instead of passing the allow_dups argument to fsnotify_add_mark()
> > as an argument, define the mark flag FSNOTIFY_MARK_FLAG_ALLOW_DUPS
> > to express the old allow_dups meaning and pass this information on the
> > mark itself.
> >
> > We use mark->flags to pass inotify control flags and will pass more
> > control flags in the future so let's make this the standard.
> >
> > Although the FSNOTIFY_MARK_FLAG_ALLOW_DUPS flag is not used after the
> > call to fsnotify_add_mark(), it does not hurt to leave this information
> > on the mark for future use.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> I wanted to comment on this already last time but forgot:
> FSNOTIFY_MARK_FLAG_ALLOW_DUPS is IMO more a property of fsnotify_group
> than a particular mark (or a particular call to fsnotify_add_mark()). As
> such it would make more sense to me to have is as "feature" similarly to
> fs-reclaim restrictions you introduce later in the series.

That's a good idea. I'll do that.

>
> As a bonus, no need for 'flags' argument to
> fsnotify_add_inode_mark_locked() or fsnotify_add_inode_mark().

I prefer to avoid collecting this bonus and leave a flags argument
for future use.

The reason is that I intend to try and convince you to take the patch
for FSNOTIFY_ADD_MARK_UPDATE_MASKS in a future patch set,
so for the chance that I am able to convince you, let's avoid the churn
for now. We can always cleanup the unneeded flags argument later.

Thanks,
Amir.
