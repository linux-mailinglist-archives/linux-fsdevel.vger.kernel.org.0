Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24C7548DA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 18:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350824AbiFMLFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 07:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351842AbiFMLFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:05:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF561FA6D
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 03:34:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gl15so10312722ejb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 03:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Us1zc6m+ozV1ZtHxfelnSiC+YK2LK1NOUXmmJ9vZF8=;
        b=KkJ3vLTEbmtDLoY/yjzGlpStmsdRtNpstwN3pDAJIa10JoCWXVLs0d4RSWybiWXV26
         wQqQrQ2cv0mO5MwoKz9GjVie/qEcJXUFhKpYZa37ObJ6FiV+Y+kFwcgrhUziaK/ZsB5u
         On9doKI+5ZoCk6be+tQObMLuaWNfZUfYNnz9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Us1zc6m+ozV1ZtHxfelnSiC+YK2LK1NOUXmmJ9vZF8=;
        b=L2L29fu2cp8dcE4l9UlGcs6hhX+S9o6djldLE/aOj0+AvihbPDO89+BPAu720ihGsS
         7v+w3CrLs1urO5N2znZL4zYhLS4xJfIHWxzSqstC5xGJRscVpu1ysbI/eQ6azTK4vDwi
         +5NNMl4FQU1ZaNPBVADFsqMWZJyWxIAp5hJR8eR/klsYgbePwVrrEoKLT6bMxEik0lUd
         /EvZSoa4Sl7OUoMVYKIsM3oNyNu5PNZPCca/urqKBZ7eNmmpC0l53NxVs1yH6z0lfWAz
         LhuLvL5wsBXt/2sMHn179bA1p9PG69w0j+yGNKcOl+qqu23S2K0UwA7e+cGOl2KAaB6o
         q7bA==
X-Gm-Message-State: AOAM531a5N22cm3k7GWvwZztbi2bNSQvsZObuPZi4Q9uPEKiM8jZ3vjD
        oGqDdR3E/Ea0m94drkaa86NLHKkpHyuDDfDp2JoJfw==
X-Google-Smtp-Source: ABdhPJy9lYLV0YNU7k01NIn/Mv1xvVEU2HVq61DwjPsZxSq4zrZAHZza4EOJ8FvR2QMOpcQovbrEX6icxsZVXjYKPuI=
X-Received: by 2002:a17:906:7308:b0:710:dad0:f56d with SMTP id
 di8-20020a170906730800b00710dad0f56dmr40493203ejc.691.1655116456756; Mon, 13
 Jun 2022 03:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220601184407.2086986-1-davemarchevsky@fb.com>
 <20220607084724.7gseviks4h2seeza@wittgenstein> <e933791c-21d1-18f9-de91-b194728432b8@fb.com>
 <CAJfpegssrypgpDDheiYJS13=_p14sN4BK+bZShPG4VZu=WpSaA@mail.gmail.com> <20220613093745.4szlhoutyqpizyys@wittgenstein>
In-Reply-To: <20220613093745.4szlhoutyqpizyys@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 13 Jun 2022 12:34:05 +0200
Message-ID: <CAJfpegu0Aj65rrPN_TtN8ugQNCP2d2LEB47zSDLy7H6aqd-HuA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Add module param for non-descendant userns
 access to allow_other
To:     Christian Brauner <brauner@kernel.org>
Cc:     Andrii Nakryiko <andriin@fb.com>,
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

On Mon, 13 Jun 2022 at 11:37, Christian Brauner <brauner@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 10:23:47AM +0200, Miklos Szeredi wrote:
> > On Fri, 10 Jun 2022 at 23:39, Andrii Nakryiko <andriin@fb.com> wrote:
> > >
> > >
> > >
> > > On 6/7/22 1:47 AM, Christian Brauner wrote:
> > > > On Wed, Jun 01, 2022 at 11:44:07AM -0700, Dave Marchevsky wrote:
> >
> > [...]
> >
> > > >> +static bool __read_mostly allow_other_parent_userns;
> > > >> +module_param(allow_other_parent_userns, bool, 0644);
> > > >> +MODULE_PARM_DESC(allow_other_parent_userns,
> > > >> + "Allow users not in mounting or descendant userns "
> > > >> + "to access FUSE with allow_other set");
> > > >
> > > > The name of the parameter also suggests that access is granted to parent
> > > > userns tasks whereas the change seems to me to allows every task access
> > > > to that fuse filesystem independent of what userns they are in.
> > > >
> > > > So even a task in a sibling userns could - probably with rather
> > > > elaborate mount propagation trickery - access that fuse filesystem.
> > > >
> > > > AFaict, either the module parameter is misnamed or the patch doesn't
> > > > implement the behavior expressed in the name.
> > > >
> > > > The original patch restricted access to a CAP_SYS_ADMIN capable task.
> > > > Did we agree that it was a good idea to weaken it to all tasks?
> > > > Shouldn't we still just restrict this to CAP_SYS_ADMIN capable tasks in
> > > > the initial userns?
> > >
> > > I think it's fine to allow for CAP_SYS_ADMIN only, but can we then
> > > ignore the allow_other mount option in such case? The idea is that
> > > CAP_SYS_ADMIN allows you to read FUSE-backed contents no matter what, so
> > > user not mounting with allow_other preventing root from reading contents
> > > defeats the purpose at least partially.
> >
> > If we want to be compatible with "user_allow_other", then it should be
> > checking if the uid/gid of the current task is mapped in the
> > filesystems user_ns (fsuidgid_has_mapping()).  Right?
>
> I think that's doable. So assuming we're still talking about requiring
> cap_sys_admin then we'd roughly have sm like:
>
>         if (fc->allow_other)
>                 return current_in_userns(fc->user_ns) ||
>                         (capable(CAP_SYS_ADMIN) &&
>                         fsuidgid_has_mapping(..., &init_user_ns));

No, I meant this:

        if (fc->allow_other)
                return current_in_userns(fc->user_ns) ||
                        (userns_allow_other &&
                        fsuidgid_has_mapping(..., &init_user_ns));

But I think the OP wanted to allow real root to access the fs, which
this doesn't allow (since 0 will have no mapping in the user ns), so
I'm not sure what's the right solution...

Maybe the original patch is fine: this check isn't meant to protect
the filesystem from access, it's meant to protect the accessor.

Thanks,
Miklos
