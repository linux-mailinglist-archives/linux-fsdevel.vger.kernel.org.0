Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E0F5481DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 10:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbiFMIYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 04:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239902AbiFMIYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:24:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D6F18B01
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 01:24:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fu3so9655403ejc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 01:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tvwt9+hyEDnP5LMzWBfWsanHUQ4kGvASG54JQJnoaek=;
        b=jaY9vfNnnjR194uwR/Cu24cmjqXLhxRzlm0+6q7J5foFfItrMS7QNWy96hTbi6CK4/
         D74zROX27WI0k3XWPS535rfdl/6ScdQQUPOjigqs5v5oHrKhedjx5WoInVyQN1iXlY7y
         ve0LJyaNXMmJAHjOY5wlihxhzgFqJ6s9ivlIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tvwt9+hyEDnP5LMzWBfWsanHUQ4kGvASG54JQJnoaek=;
        b=L22xVF9GE1cFLX/3s9XXq+SMbYv/ptPYp7+qjJ2Fl9V6cBXabKrCZ6bKHInHFmledH
         BSprrrN0s4JL88foTTN6yuSP2pIngZUOi/Fbvd1bJ0KOofHfqhitKbieuD6nT0DaxMVf
         wbAOEMfWZLRYtnRtIHSYm9ubvS+JdHVl7/vIR4RoOo3flG7YKWnTKLaJrxsU5cPmdZVk
         zeY26bboGEs0Cydd3scOLNtkY+IPvz+TYo7lr4DmK/j2ZkQ5kiGpkiQd9Xf42gCuO7LJ
         uvwUF9ENFSmYW86W12jpZHYVyDm7HuUYTZl1urtrpO3qTE7j4GHD+k/cEaHaipC8aAC9
         +4EA==
X-Gm-Message-State: AOAM530WEssoDBuB9GDe/TNq0lPemZemHEnYggHcmpAP3wmPtVpfW9uY
        NXnzeO/uNLsTzwCcsyjbJe1YEQcHanXYFtl+vkUY/g==
X-Google-Smtp-Source: ABdhPJxE9HrLL4zvOsYJm+D2HkTpV2KzfqwDoDBYYniYwTzojTDqBgMZK7Jexrlokva7+K9h1FKIFwEKCa+hci8rIxE=
X-Received: by 2002:a17:907:9715:b0:711:ca06:ca50 with SMTP id
 jg21-20020a170907971500b00711ca06ca50mr37043229ejc.192.1655108638621; Mon, 13
 Jun 2022 01:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220601184407.2086986-1-davemarchevsky@fb.com>
 <20220607084724.7gseviks4h2seeza@wittgenstein> <e933791c-21d1-18f9-de91-b194728432b8@fb.com>
In-Reply-To: <e933791c-21d1-18f9-de91-b194728432b8@fb.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 13 Jun 2022 10:23:47 +0200
Message-ID: <CAJfpegssrypgpDDheiYJS13=_p14sN4BK+bZShPG4VZu=WpSaA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Add module param for non-descendant userns
 access to allow_other
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-fsdevel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        kernel-team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Chris Mason <clm@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 10 Jun 2022 at 23:39, Andrii Nakryiko <andriin@fb.com> wrote:
>
>
>
> On 6/7/22 1:47 AM, Christian Brauner wrote:
> > On Wed, Jun 01, 2022 at 11:44:07AM -0700, Dave Marchevsky wrote:

[...]

> >> +static bool __read_mostly allow_other_parent_userns;
> >> +module_param(allow_other_parent_userns, bool, 0644);
> >> +MODULE_PARM_DESC(allow_other_parent_userns,
> >> + "Allow users not in mounting or descendant userns "
> >> + "to access FUSE with allow_other set");
> >
> > The name of the parameter also suggests that access is granted to parent
> > userns tasks whereas the change seems to me to allows every task access
> > to that fuse filesystem independent of what userns they are in.
> >
> > So even a task in a sibling userns could - probably with rather
> > elaborate mount propagation trickery - access that fuse filesystem.
> >
> > AFaict, either the module parameter is misnamed or the patch doesn't
> > implement the behavior expressed in the name.
> >
> > The original patch restricted access to a CAP_SYS_ADMIN capable task.
> > Did we agree that it was a good idea to weaken it to all tasks?
> > Shouldn't we still just restrict this to CAP_SYS_ADMIN capable tasks in
> > the initial userns?
>
> I think it's fine to allow for CAP_SYS_ADMIN only, but can we then
> ignore the allow_other mount option in such case? The idea is that
> CAP_SYS_ADMIN allows you to read FUSE-backed contents no matter what, so
> user not mounting with allow_other preventing root from reading contents
> defeats the purpose at least partially.

If we want to be compatible with "user_allow_other", then it should be
checking if the uid/gid of the current task is mapped in the
filesystems user_ns (fsuidgid_has_mapping()).  Right?

Thanks,
Miklos
