Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66246608D64
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Oct 2022 15:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJVNa7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Oct 2022 09:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJVNa5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Oct 2022 09:30:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F590FAE7C
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Oct 2022 06:30:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FA0FB8010F
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Oct 2022 13:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5537DC433D6;
        Sat, 22 Oct 2022 13:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666445453;
        bh=ZbGI1a3Y24Wh6UVuSR+QXxev/la1OEP5iR7aMh3W//0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AwhtCS8HOpriMHx1phym4w58oDANuUEZGZaO93qgv2Pgq4gadOaV8rkULOw00KuFB
         OTXfKU2aoDnxSmE3CRs2ruU/HyM4AZLAMmw1hBdtBMDmpnj/5NM8kgUDM4R1RlIp8L
         sTS8UvA5VADECz/EwO1SJ0GMM8QK+/oUnOxc6xFBiS/yP1vcC8ii7x2hpUxvk2tntU
         0c4TG6rEKgYHOKPrxJpfnL/px1z/R4fXJFz4VvSPLo29wtbulr7m86hBy8EVuZwn3f
         Y6XBBFctRpVIy8VnwAl/TRk5yNIN4UZyrzaHl9Go8vthjTgkEcnkVpHt7yWSWLX+KG
         SacEeCg0yOCew==
Date:   Sat, 22 Oct 2022 15:30:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        kernel-team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2] fuse: Rearrange fuse_allow_current_process checks
Message-ID: <20221022133043.acwmqowig2civ2mu@wittgenstein>
References: <20221020201409.1815316-1-davemarchevsky@fb.com>
 <20221021080902.cshha2dja73wuojr@wittgenstein>
 <CAEf4Bzbp6cMiSWBLxzXT5AT=X-cidnnx9GU6op_MnXvRH+7T3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbp6cMiSWBLxzXT5AT=X-cidnnx9GU6op_MnXvRH+7T3w@mail.gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 21, 2022 at 09:02:30AM -0700, Andrii Nakryiko wrote:
> On Fri, Oct 21, 2022 at 1:09 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Oct 20, 2022 at 01:14:09PM -0700, Dave Marchevsky wrote:
> > > This is a followup to a previous commit of mine [0], which added the
> > > allow_sys_admin_access && capable(CAP_SYS_ADMIN) check. This patch
> > > rearranges the order of checks in fuse_allow_current_process without
> > > changing functionality.
> > >
> > > [0] added allow_sys_admin_access && capable(CAP_SYS_ADMIN) check to the
> > > beginning of the function, with the reasoning that
> > > allow_sys_admin_access should be an 'escape hatch' for users with
> > > CAP_SYS_ADMIN, allowing them to skip any subsequent checks.
> > >
> > > However, placing this new check first results in many capable() calls when
> > > allow_sys_admin_access is set, where another check would've also
> > > returned 1. This can be problematic when a BPF program is tracing
> > > capable() calls.
> > >
> > > At Meta we ran into such a scenario recently. On a host where
> > > allow_sys_admin_access is set but most of the FUSE access is from
> > > processes which would pass other checks - i.e. they don't need
> > > CAP_SYS_ADMIN 'escape hatch' - this results in an unnecessary capable()
> > > call for each fs op. We also have a daemon tracing capable() with BPF and
> > > doing some data collection, so tracing these extraneous capable() calls
> > > has the potential to regress performance for an application doing many
> > > FUSE ops.
> > >
> > > So rearrange the order of these checks such that CAP_SYS_ADMIN 'escape
> > > hatch' is checked last. Previously, if allow_other is set on the
> > > fuse_conn, uid/gid checking doesn't happen as current_in_userns result
> > > is returned. It's necessary to add a 'goto' here to skip past uid/gid
> > > check to maintain those semantics here.
> > >
> > >   [0]: commit 9ccf47b26b73 ("fuse: Add module param for CAP_SYS_ADMIN access bypassing allow_other")
> > >
> > > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > ---
> >
> > The idea sounds good.
> >
> > > v1 -> v2: lore.kernel.org/linux-fsdevel/20221020183830.1077143-1-davemarchevsky@fb.com
> > >
> > >   * Add missing brackets to allow_other if statement (Andrii)
> > >
> > >  fs/fuse/dir.c | 14 +++++++++-----
> > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > > index 2c4b08a6ec81..2f14e90907a2 100644
> > > --- a/fs/fuse/dir.c
> > > +++ b/fs/fuse/dir.c
> > > @@ -1254,11 +1254,11 @@ int fuse_allow_current_process(struct fuse_conn *fc)
> > >  {
> > >       const struct cred *cred;
> > >
> > > -     if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
> > > -             return 1;
> > > -
> > > -     if (fc->allow_other)
> > > -             return current_in_userns(fc->user_ns);
> > > +     if (fc->allow_other) {
> > > +             if (current_in_userns(fc->user_ns))
> > > +                     return 1;
> > > +             goto skip_cred_check;
> >
> > I think this is misnamed especially because capabilities are creds as
> > well. Maybe we should not use a goto even if it makes the patch a bit
> > bigger (_completely untested_)?:
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index bb97a384dc5d..3d733e0865bf 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -1235,6 +1235,28 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
> >         return err;
> >  }
> >
> > +static inline bool fuse_permissible_uidgid(const struct fuse_conn *fc)
> > +{
> > +       cred = current_cred();
> > +       return (uid_eq(cred->euid, fc->user_id) &&
> > +               uid_eq(cred->suid, fc->user_id) &&
> > +               uid_eq(cred->uid,  fc->user_id) &&
> > +               gid_eq(cred->egid, fc->group_id) &&
> > +               gid_eq(cred->sgid, fc->group_id) &&
> > +               gid_eq(cred->gid,  fc->group_id))
> > +}
> > +
> > +static inline bool fuse_permissible_other(const struct fuse_conn *fc)
> > +{
> > +       if (current_in_userns(fc->user_ns))
> > +               return true;
> > +
> > +       if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
> > +               return true;
> 
> This needs to be checked regardless of fc->allow_other, so the change
> you are proposing is not equivalent to the original logic. It does

Thanks for spotting this. I missed that. I'm not opposed to gotos it
just seems a bit ugly in this case and I'd prefer sm like (again,
completely untested):

int fuse_allow_current_process(struct fuse_conn *fc)
{
	const struct cred *cred;
	int ret;

	if (fc->allow_other)
		ret = current_in_userns(fc->user_ns);
	else
		ret = fuse_permissible_uidgid(fc);
	if (!ret && allow_sys_admin_access && capable(CAP_SYS_ADMIN))
		ret = 1;

	return ret;
}

but I'm not fuzzed about it.
