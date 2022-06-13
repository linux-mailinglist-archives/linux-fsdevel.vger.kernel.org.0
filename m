Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED4C54838E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 11:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240874AbiFMJh6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 05:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbiFMJh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:37:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD2B1275F
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 02:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8EFDB80E46
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 09:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1769DC34114;
        Mon, 13 Jun 2022 09:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655113073;
        bh=z42egx6NdYRUFiWyjQhIsH/qM+Aqi25H2YZvte4HHPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PC/apWkmoAM5pyhodcYqj2ojvuOjWWb7une9fVNwepuaYa3ja+iIVnHb7WHjD39aw
         k0npt/ptLWa+21Tx2qZMlEkf+SOPPO2b3nmmyfKwEJdf0rSBc3WME2GM7LEMX0woLz
         f0EgCaWj2WzHTwJn3jnWbsBIKs+42VgVfVeJO5EwF9wv37dldEUcMHIxX8hZX+szHC
         RdppPFRSIFBIy6Vi4pWmiik9+aMwQrhfoDslAj+3WlGY+YOAozKD39nITJJr7BZ0Iz
         eHI9uBxRsOuCSMkKHMKjSpDleMtke60mmyQdv459S+xF+QMyCtcHJhmIjiA+jbKoBu
         xq6jzK17eSK0A==
Date:   Mon, 13 Jun 2022 11:37:45 +0200
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
Message-ID: <20220613093745.4szlhoutyqpizyys@wittgenstein>
References: <20220601184407.2086986-1-davemarchevsky@fb.com>
 <20220607084724.7gseviks4h2seeza@wittgenstein>
 <e933791c-21d1-18f9-de91-b194728432b8@fb.com>
 <CAJfpegssrypgpDDheiYJS13=_p14sN4BK+bZShPG4VZu=WpSaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegssrypgpDDheiYJS13=_p14sN4BK+bZShPG4VZu=WpSaA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:23:47AM +0200, Miklos Szeredi wrote:
> On Fri, 10 Jun 2022 at 23:39, Andrii Nakryiko <andriin@fb.com> wrote:
> >
> >
> >
> > On 6/7/22 1:47 AM, Christian Brauner wrote:
> > > On Wed, Jun 01, 2022 at 11:44:07AM -0700, Dave Marchevsky wrote:
> 
> [...]
> 
> > >> +static bool __read_mostly allow_other_parent_userns;
> > >> +module_param(allow_other_parent_userns, bool, 0644);
> > >> +MODULE_PARM_DESC(allow_other_parent_userns,
> > >> + "Allow users not in mounting or descendant userns "
> > >> + "to access FUSE with allow_other set");
> > >
> > > The name of the parameter also suggests that access is granted to parent
> > > userns tasks whereas the change seems to me to allows every task access
> > > to that fuse filesystem independent of what userns they are in.
> > >
> > > So even a task in a sibling userns could - probably with rather
> > > elaborate mount propagation trickery - access that fuse filesystem.
> > >
> > > AFaict, either the module parameter is misnamed or the patch doesn't
> > > implement the behavior expressed in the name.
> > >
> > > The original patch restricted access to a CAP_SYS_ADMIN capable task.
> > > Did we agree that it was a good idea to weaken it to all tasks?
> > > Shouldn't we still just restrict this to CAP_SYS_ADMIN capable tasks in
> > > the initial userns?
> >
> > I think it's fine to allow for CAP_SYS_ADMIN only, but can we then
> > ignore the allow_other mount option in such case? The idea is that
> > CAP_SYS_ADMIN allows you to read FUSE-backed contents no matter what, so
> > user not mounting with allow_other preventing root from reading contents
> > defeats the purpose at least partially.
> 
> If we want to be compatible with "user_allow_other", then it should be
> checking if the uid/gid of the current task is mapped in the
> filesystems user_ns (fsuidgid_has_mapping()).  Right?

I think that's doable. So assuming we're still talking about requiring
cap_sys_admin then we'd roughly have sm like:

	if (fc->allow_other)
		return current_in_userns(fc->user_ns) ||
			(capable(CAP_SYS_ADMIN) &&
			fsuidgid_has_mapping(..., &init_user_ns));

so say a fuse filesystem is mounted in a userns with a mapping of
0:10000:100. Assume root in init_user_ns is trying to access that fuse
filesystem:

fuse_sb->s_user_ns = 0:10000:100
current_fsuid() = 0
current_fsgid() = 0
capable(CAP_SYS_ADMIN)

that would fail as

fsuidgid_has_mapping() {
	kuid_has_mapping(0:10000:1000, 0) -> INVALID_UID
	kgid_has_mapping(0:10000:1000, 0) -> INVALID_GID
}

so root would have to do:

setfsuid(100000)
setfsgid(100000)

// This transition will cost you at least
// CAP_CHOWN
// CAP_MKNOD
// CAP_DAC_OVERRIDE
// CAP_DAC_READ_SEARCH
// CAP_FOWNER
// CAP_FSETID
// but those are regained when transitioning back to fsuid/fsgid 0.

fuse_sb->s_user_ns = 0:10000:100
current_fsuid() = 100000
current_fsgid() = 100000
capable(CAP_SYS_ADMIN)

that would succeed as

fsuidgid_has_mapping() {
	kuid_has_mapping(0:10000:1000, 0) -> 0
	kgid_has_mapping(0:10000:1000, 0) -> 0
}
