Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5FC5487D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 17:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353531AbiFMLbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 07:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354991AbiFMLaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:30:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A5240A0F
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 03:46:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CC45B80D3F
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 10:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B647C3411E;
        Mon, 13 Jun 2022 10:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655117170;
        bh=fGjo/48T3OcMOAZLDGkLu/dlITR6JxffM0YBmKa6tiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBrxYaaJPQnf/kAmcTsGbBGlh2J0Zw1IrvSHwNoxfwUWWsBl0T4Ad0FFUA+F1i6VU
         g/llStBuA0kqVvTMqhrFs9STWec+J8jKLhPfreQIGbxf+IMuiRpve4AjT0TIOosL5P
         0Zq3MuZB0ha5kblXtZoukpU0TL24E79243kAlWekysxUsAxWcDVz+OdUiY8VxxuiQ+
         R9As56wdTx+FCuuqqRJfH1pdkWbrFSVYiiITvUcIxOFa7S8DzPCfHKk3M3HOMIyovC
         3QHL9VGzEFLLVQ1S3rwMP1KJyuaNpb8UZt4KeLJIfF12jaze7Zl01hIeMMuLmMp8Y3
         Il92O6AnE6Dcw==
Date:   Mon, 13 Jun 2022 12:46:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-fsdevel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        kernel-team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Chris Mason <clm@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2] fuse: Add module param for non-descendant userns
 access to allow_other
Message-ID: <20220613104604.t5ptuhrl2d4l7kbl@wittgenstein>
References: <20220601184407.2086986-1-davemarchevsky@fb.com>
 <20220607084724.7gseviks4h2seeza@wittgenstein>
 <e933791c-21d1-18f9-de91-b194728432b8@fb.com>
 <CAJfpegssrypgpDDheiYJS13=_p14sN4BK+bZShPG4VZu=WpSaA@mail.gmail.com>
 <20220613093745.4szlhoutyqpizyys@wittgenstein>
 <CAJfpegu0Aj65rrPN_TtN8ugQNCP2d2LEB47zSDLy7H6aqd-HuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegu0Aj65rrPN_TtN8ugQNCP2d2LEB47zSDLy7H6aqd-HuA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 13, 2022 at 12:34:05PM +0200, Miklos Szeredi wrote:
> On Mon, 13 Jun 2022 at 11:37, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, Jun 13, 2022 at 10:23:47AM +0200, Miklos Szeredi wrote:
> > > On Fri, 10 Jun 2022 at 23:39, Andrii Nakryiko <andriin@fb.com> wrote:
> > > >
> > > >
> > > >
> > > > On 6/7/22 1:47 AM, Christian Brauner wrote:
> > > > > On Wed, Jun 01, 2022 at 11:44:07AM -0700, Dave Marchevsky wrote:
> > >
> > > [...]
> > >
> > > > >> +static bool __read_mostly allow_other_parent_userns;
> > > > >> +module_param(allow_other_parent_userns, bool, 0644);
> > > > >> +MODULE_PARM_DESC(allow_other_parent_userns,
> > > > >> + "Allow users not in mounting or descendant userns "
> > > > >> + "to access FUSE with allow_other set");
> > > > >
> > > > > The name of the parameter also suggests that access is granted to parent
> > > > > userns tasks whereas the change seems to me to allows every task access
> > > > > to that fuse filesystem independent of what userns they are in.
> > > > >
> > > > > So even a task in a sibling userns could - probably with rather
> > > > > elaborate mount propagation trickery - access that fuse filesystem.
> > > > >
> > > > > AFaict, either the module parameter is misnamed or the patch doesn't
> > > > > implement the behavior expressed in the name.
> > > > >
> > > > > The original patch restricted access to a CAP_SYS_ADMIN capable task.
> > > > > Did we agree that it was a good idea to weaken it to all tasks?
> > > > > Shouldn't we still just restrict this to CAP_SYS_ADMIN capable tasks in
> > > > > the initial userns?
> > > >
> > > > I think it's fine to allow for CAP_SYS_ADMIN only, but can we then
> > > > ignore the allow_other mount option in such case? The idea is that
> > > > CAP_SYS_ADMIN allows you to read FUSE-backed contents no matter what, so
> > > > user not mounting with allow_other preventing root from reading contents
> > > > defeats the purpose at least partially.
> > >
> > > If we want to be compatible with "user_allow_other", then it should be
> > > checking if the uid/gid of the current task is mapped in the
> > > filesystems user_ns (fsuidgid_has_mapping()).  Right?
> >
> > I think that's doable. So assuming we're still talking about requiring
> > cap_sys_admin then we'd roughly have sm like:
> >
> >         if (fc->allow_other)
> >                 return current_in_userns(fc->user_ns) ||
> >                         (capable(CAP_SYS_ADMIN) &&
> >                         fsuidgid_has_mapping(..., &init_user_ns));
> 
> No, I meant this:
> 
>         if (fc->allow_other)
>                 return current_in_userns(fc->user_ns) ||
>                         (userns_allow_other &&
>                         fsuidgid_has_mapping(..., &init_user_ns));
> 
> But I think the OP wanted to allow real root to access the fs, which
> this doesn't allow (since 0 will have no mapping in the user ns), so
> I'm not sure what's the right solution...

I aimed to show that. You can setfs*id() and retain capabilities and
still access the filesystem.

> 
> Maybe the original patch is fine: this check isn't meant to protect
> the filesystem from access, it's meant to protect the accessor.

I don't have specific worries here. I'm just a bit hesitant to just let
anyone access the fs. But if we go for allow other semantics then that's
probably fine. Though I wonder why then we don't just do:

if (fc->allow_other)
        return current_in_userns(fc->user_ns) ||
                (userns_allow_other &&
                ns_capable(fc->user_ns, CAP_SYS_ADMIN));

? That'll let any ancestor userns access the fs not just descendants of
fc->user_ns.
