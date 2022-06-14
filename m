Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ED154B34E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 16:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiFNOfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 10:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347316AbiFNOeC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:34:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FAB3703A
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 07:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 307B2B818E3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 14:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22942C3411B;
        Tue, 14 Jun 2022 14:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655217235;
        bh=+h5Gkxi6P4QAdEYIx3YgbpjuNNXHxiiQXJ9zzw6ICfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOTe8X51CwYH7PrvJ8p4T5HW2OfCCCL5yHotMdp43XQCd6gVYV8b/p7+Ns6plfFtC
         fjgVQCZaa7Mwqr/H3+ORwonqOeGSABztQ2i8W/olh+B3Kx5pl38BFE0+PMKoPkxphl
         k/lF4jiZagZKAYhM7im5ZMkRb57ZV6bLWSJmzH8K9JgjmJut9m662aCrgHLeAsjhnP
         WHtggj60AnEXhWCrjN3jHj28T4yX01ueSL2VtRhhNj9RIIoX3R5rxNE7EohqUBnvLF
         1K8OOdQAgdBmrHTiCZWlpoMosJx8niXsGZNkkh3lz5D2eLNzKHSyqYlg+0L5+ipXHx
         HHeV6IG1S5cEA==
Date:   Tue, 14 Jun 2022 16:33:44 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Andrii Nakryiko <andriin@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-fsdevel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        kernel-team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Chris Mason <clm@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2] fuse: Add module param for non-descendant userns
 access to allow_other
Message-ID: <20220614143344.wxh2rmwz3gikhzga@wittgenstein>
References: <20220601184407.2086986-1-davemarchevsky@fb.com>
 <20220607084724.7gseviks4h2seeza@wittgenstein>
 <e933791c-21d1-18f9-de91-b194728432b8@fb.com>
 <CAJfpegssrypgpDDheiYJS13=_p14sN4BK+bZShPG4VZu=WpSaA@mail.gmail.com>
 <20220613093745.4szlhoutyqpizyys@wittgenstein>
 <CAJfpegu0Aj65rrPN_TtN8ugQNCP2d2LEB47zSDLy7H6aqd-HuA@mail.gmail.com>
 <CAEf4BzaqfkfTgjbE2bEzELsTRpofv1Bstz2cPL8bGKS7jXvYTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzaqfkfTgjbE2bEzELsTRpofv1Bstz2cPL8bGKS7jXvYTg@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 13, 2022 at 11:21:24AM -0700, Andrii Nakryiko wrote:
> On Mon, Jun 13, 2022 at 3:34 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, 13 Jun 2022 at 11:37, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Mon, Jun 13, 2022 at 10:23:47AM +0200, Miklos Szeredi wrote:
> > > > On Fri, 10 Jun 2022 at 23:39, Andrii Nakryiko <andriin@fb.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 6/7/22 1:47 AM, Christian Brauner wrote:
> > > > > > On Wed, Jun 01, 2022 at 11:44:07AM -0700, Dave Marchevsky wrote:
> > > >
> > > > [...]
> > > >
> > > > > >> +static bool __read_mostly allow_other_parent_userns;
> > > > > >> +module_param(allow_other_parent_userns, bool, 0644);
> > > > > >> +MODULE_PARM_DESC(allow_other_parent_userns,
> > > > > >> + "Allow users not in mounting or descendant userns "
> > > > > >> + "to access FUSE with allow_other set");
> > > > > >
> > > > > > The name of the parameter also suggests that access is granted to parent
> > > > > > userns tasks whereas the change seems to me to allows every task access
> > > > > > to that fuse filesystem independent of what userns they are in.
> > > > > >
> > > > > > So even a task in a sibling userns could - probably with rather
> > > > > > elaborate mount propagation trickery - access that fuse filesystem.
> > > > > >
> > > > > > AFaict, either the module parameter is misnamed or the patch doesn't
> > > > > > implement the behavior expressed in the name.
> > > > > >
> > > > > > The original patch restricted access to a CAP_SYS_ADMIN capable task.
> > > > > > Did we agree that it was a good idea to weaken it to all tasks?
> > > > > > Shouldn't we still just restrict this to CAP_SYS_ADMIN capable tasks in
> > > > > > the initial userns?
> > > > >
> > > > > I think it's fine to allow for CAP_SYS_ADMIN only, but can we then
> > > > > ignore the allow_other mount option in such case? The idea is that
> > > > > CAP_SYS_ADMIN allows you to read FUSE-backed contents no matter what, so
> > > > > user not mounting with allow_other preventing root from reading contents
> > > > > defeats the purpose at least partially.
> > > >
> > > > If we want to be compatible with "user_allow_other", then it should be
> > > > checking if the uid/gid of the current task is mapped in the
> > > > filesystems user_ns (fsuidgid_has_mapping()).  Right?
> > >
> > > I think that's doable. So assuming we're still talking about requiring
> > > cap_sys_admin then we'd roughly have sm like:
> > >
> > >         if (fc->allow_other)
> > >                 return current_in_userns(fc->user_ns) ||
> > >                         (capable(CAP_SYS_ADMIN) &&
> > >                         fsuidgid_has_mapping(..., &init_user_ns));
> >
> > No, I meant this:
> >
> >         if (fc->allow_other)
> >                 return current_in_userns(fc->user_ns) ||
> >                         (userns_allow_other &&
> >                         fsuidgid_has_mapping(..., &init_user_ns));
> >
> > But I think the OP wanted to allow real root to access the fs, which
> > this doesn't allow (since 0 will have no mapping in the user ns), so
> > I'm not sure what's the right solution...
> 
> Right, so I was basically asking why not do something like this:
> 
> $ git diff
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 74303d6e987b..8c04955eb26e 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1224,6 +1224,9 @@ int fuse_allow_current_process(struct fuse_conn *fc)
>  {
>         const struct cred *cred;
> 
> +       if (fuse_allow_sys_admin_access && capable(CAP_SYS_ADMIN))
> +               return 1;
> +
>         if (fc->allow_other)
>                 return current_in_userns(fc->user_ns);
> 
> 
> where fuse_allow_sys_admin_access is module param which has to be
> opted into through sysfs?

You can either do this or do what I suggested in:
https://lore.kernel.org/linux-fsdevel/20220613104604.t5ptuhrl2d4l7kbl@wittgenstein
which is a bit more lax.

If you make it module load parameter only it has the advantage that it
can't be changed after fuse has been loaded which in this case might be
an advantage. It's likely that users might not be too happy if module
semantics can be changed that drastically at runtime. But I have no
strong opinions here.

Christian
