Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822F0679BB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjAXO0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjAXO0A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:26:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C22748601
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:25:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D022261299
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 14:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185C6C433D2;
        Tue, 24 Jan 2023 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674570340;
        bh=fdXxH6MB+iSs16cgCEgq5lSOiFvTvOJ3zpEWw/AGu68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmlyJYyJXNfLvq/fhT74vGvcYmafmlSTvG/rr4HNp6PsT7jhNpRG4WV3jmM2/4V0g
         W4KcIGj0icndf3fGusnD/qfAfwly6zHTj5J8se9iUq2oOe6xnr4RGRkOyCUs9BiBOK
         l3kq4VvmII8+4pbyflxBqJHZ5cxYzq9HN/eSbtqCahID7t0+aYwCDCZDKX8tox16nt
         JaDaeXMSvJPaatGsI5E4sDV1AYe/ByKFIFiMIMtW1PtqLPcKJAsjcOx/8xZsxJJlVS
         aPj4MGjhWklJGHdddoVfaa4Hr6JnTsaoaoe4u4lE8Hki2m3dI7S4CwN9y1RQc/LFR4
         fLXtkq4+B1DAQ==
Date:   Tue, 24 Jan 2023 15:25:35 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] fuse: fixes after adapting to new posix acl api
Message-ID: <20230124142535.dmc2k2mrqcvj66k5@wittgenstein>
References: <20230118-fs-fuse-acl-v1-1-a628a9bb55ef@kernel.org>
 <CAJfpegsNZ1F1hhEaBH2Lw20CsqYm-nEFEUAH0k46_ua=5Gp2zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsNZ1F1hhEaBH2Lw20CsqYm-nEFEUAH0k46_ua=5Gp2zw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 03:07:18PM +0100, Miklos Szeredi wrote:
> On Fri, 20 Jan 2023 at 12:55, Christian Brauner <brauner@kernel.org> wrote:
> >
> > This cycle we ported all filesystems to the new posix acl api. While
> > looking at further simplifications in this area to remove the last
> > remnants of the generic dummy posix acl handlers we realized that we
> > regressed fuse daemons that don't set FUSE_POSIX_ACL but still make use
> > of posix acls.
> >
> > With the change to a dedicated posix acl api interacting with posix acls
> > doesn't go through the old xattr codepaths anymore and instead only
> > relies the get acl and set acl inode operations.
> >
> > Before this change fuse daemons that don't set FUSE_POSIX_ACL were able
> > to get and set posix acl albeit with two caveats. First, that posix acls
> > aren't cached. And second, that they aren't used for permission checking
> > in the vfs.
> >
> > We regressed that use-case as we currently refuse to retrieve any posix
> > acls if they aren't enabled via FUSE_POSIX_ACL. So older fuse daemons
> > would see a change in behavior.
> 
> This originates commit e45b2546e23c ("fuse: Ensure posix acls are
> translated outside of init_user_ns") which, disables set/get acl in
> the problematic case instead of translating them.
> 
> Not sure if there's a real use case or it's completely theoretical.
> Does anyone know?

After 4+ years without anyone screaming for non-FUSE_POSIX_ACL daemons
to be able set/get posix acls without permission checking in the vfs
inside a userns we can continue not enabling this. Even if we now
actually can.

> 
> >
> > We can restore the old behavior in multiple ways. We could change the
> > new posix acl api and look for a dedicated xattr handler and if we find
> > one prefer that over the dedicated posix acl api. That would break the
> > consistency of the new posix acl api so we would very much prefer not to
> > do that.
> >
> > We could introduce a new ACL_*_CACHE sentinel that would instruct the
> > vfs permission checking codepath to not call into the filesystem and
> > ignore acls.
> >
> > But a more straightforward fix for v6.2 is to do the same thing that
> > Overlayfs does and give fuse a separate get acl method for permission
> > checking. Overlayfs uses this to express different needs for vfs
> > permission lookup and acl based retrieval via the regular system call
> > path as well. Let fuse do the same for now. This way fuse can continue
> > to refuse to retrieve posix acls for daemons that don't set
> > FUSE_POSXI_ACL for permission checking while allowing a fuse server to
> > retrieve it via the usual system calls.
> >
> > In the future, we could extend the get acl inode operation to not just
> > pass a simple boolean to indicate rcu lookup but instead make it a flag
> > argument. Then in addition to passing the information that this is an
> > rcu lookup to the filesystem we could also introduce a flag that tells
> > the filesystem that this is a request from the vfs to use these acls for
> > permission checking. Then fuse could refuse the get acl request for
> > permission checking when the daemon doesn't have FUSE_POSIX_ACL set in
> > the same get acl method. This would also help Overlayfs and allow us to
> > remove the second method for it as well.
> >
> > But since that change is more invasive as we need to update the get acl
> > inode operation for multiple filesystems we should not do this as a fix
> > for v6.2. Instead we will do this for the v6.3 merge window.
> >
> > Fwiw, since posix acls are now always correctly translated in the new
> > posix acl api we could also allow them to be used for daemons without
> > FUSE_POSIX_ACL that are not mounted on the host. But this is behavioral
> > change and again if dones should be done for v6.3. For now, let's just
> > restore the original behavior.
> 
> Agreed.
> 
> >
> > A nice side-effect of this change is that for fuse daemons with and
> > without FUSE_POSIX_ACL the same code is used for posix acls in a
> > backwards compatible way. This also means we can remove the legacy xattr
> > handlers completely. We've also added comments to explain the expected
> > behavior for daemons without FUSE_POSIX_ACL into the code.
> >
> > Fixes: 318e66856dde ("xattr: use posix acl api")
> > Signed-off-by: Seth Forshee (Digital Ocean) <sforshee@kernel.org>
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> 
> Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
> 
> 
> > If you're fine with this approach then could you please route this to
> > Linus during v6.2 still? If you prefer I do it I'm happy to as well.
> 
> I don't think I have anything pending for v6.2 in fuse, but if you
> don't either I can handle the routing.

I don't but if you'd be fine with me taking it it would make my life
easier for another series.

Thanks!
Christian
