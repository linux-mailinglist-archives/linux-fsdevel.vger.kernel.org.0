Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0613C633EB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 15:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiKVOUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 09:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiKVOUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:20:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9556C67F67;
        Tue, 22 Nov 2022 06:20:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2669961728;
        Tue, 22 Nov 2022 14:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C8DC433D6;
        Tue, 22 Nov 2022 14:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669126815;
        bh=3b4JAkbPbOHvStFDBMyZzjgbzZs+yLv59iyVIqZjO+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIBUOLbdZoaT7XQq7YVPp/D8shsDqMnW3Oe+0+4NFXgIqN1pYimrfFbbmZ8rSi7PV
         kaPR0pWoscmWAUusOQAEkHJACQHT2vvUEiN1FNm3a5IEJnU1AT7CWUmQs+/EZ/y0O1
         zsM/0UnVw7bNVjY8Rh5xb3xVG3f6fMiwlBKZdbRdSV1NFK58DzUHtXRm6s8NLlYGGz
         sVDKqBHVnCfsYE3luVuoK2pxv3ABRpy8BbCx2Pa5l0q4SBukL6/IVHqvGz3zjIoKx9
         m0wd7ERHl2bYVOfEA/wIoWR7IwjdQrRPlxqIVdYgiFF1UqS66ciKnAVqa83DZd8sc8
         ME1Hm8OuYIETQ==
Date:   Tue, 22 Nov 2022 15:20:10 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, fstests <fstests@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Subject: Re: sgid clearing rules?
Message-ID: <20221122142010.zchf2jz2oymx55qi@wittgenstein>
References: <CAJfpegsVAUUg5p6DbL1nA_oRF4Bui+saqbFjjYn=VYtd-N2Xew@mail.gmail.com>
 <20221122105731.parciulns5mg4jwr@wittgenstein>
 <CAJfpegvtgFBesiuGO93HRidWw22gQgi8VN8xNGqK86qEm3sfng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegvtgFBesiuGO93HRidWw22gQgi8VN8xNGqK86qEm3sfng@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:21:59PM +0100, Miklos Szeredi wrote:
> On Tue, 22 Nov 2022 at 11:57, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, Nov 21, 2022 at 02:14:13PM +0100, Miklos Szeredi wrote:
> > > I'm looking at sgid clearing in case of file modification.  Seems like
> > > the intent was:
> > >
> > >  - if not a regular file, then don't clear
> > >  - else if task has CAP_FSETID in init_user_ns, then don't clear
> >
> > This one is a remnant of the past. The code was simply not updated to
> > reflect the new penultimate rule you mention below. This is fixed in
> > -next based on the VFS work we did (It also includes Amirs patches we
> > reviewed a few weeks ago for file_remove_privs() in ovl.).
> >
> > >  - else if group exec is set, then clear
> > >  - else if gid is in task's group list, then don't clear
> > >  - else if gid and uid are mapped in current namespace and task has
> > > CAP_FSETID in current namespace, then don't clear
> > >  - else clear
> > >
> >
> > The setgid stripping series in -next implements these rules.
> >
> > > However behavior seems to deviate from that if group exec is clear and
> > > *suid* bit is not set.  The reason is that inode_has_no_xattr() will
> > > set S_NOSEC and __file_remove_privs() will bail out before even
> > > starting to interpret the rules.
> >
> > Great observation. The dentry_needs_remove_privs() now calls the new
> > setattr_should_drop_sgid() helper which drops the setgid bit according
> > to the rules above. And yes, we should drop the S_IXGRP check from
> > is_sxid() for consistency.
> > The scenario where things get wonky with the S_IXGRP check present must
> > be when setattr_should_drop_sgid() retains the setgid bit.
> 
> Which is exactly what seems to happen in Test 9 and Test 11 in the
> generic/68[3-7].
> 
> > In that case
> > is_sxid() will mark the inode as not being security relevant even though
> > the setgid bit is still set on it. This dates back to mandatory locking
> > when the setgid bit was used for that. But mandatory locks are out of
> > the door for a while now and this is no longer true and also wasn't
> > enforced consistently for countless years even when they were still
> > there. So we should make this helper consistent with the rest.
> >
> > I will run the patch below through xfstests with
> >
> > -g acl,attr,cap,idmapped,io_uring,perms,unlink
> >
> > which should cover all setgid tests (We've added plenty of new tests to
> > the "perms" group.). Could you please review whether this make sense to you?
> >
> > From cbe6cec88c6cfc66e0fb61f602bb2810c3c48578 Mon Sep 17 00:00:00 2001
> > From: Christian Brauner <brauner@kernel.org>
> > Date: Tue, 22 Nov 2022 11:40:32 +0100
> > Subject: [PATCH] fs: use consistent setgid checks in is_sxid()
> >
> > Now that we made the VFS setgid checking consistent an inode can't be
> > marked security irrelevant even if the setgid bit is still set. Make
> > this function consistent with the other helpers.
> >
> > Reported-by: Miklos Szeredi <miklos@szeredi.hu>
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> >  include/linux/fs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index b39c5efca180..d07cadac547e 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3527,7 +3527,7 @@ int __init list_bdev_fs_names(char *buf, size_t size);
> >
> >  static inline bool is_sxid(umode_t mode)
> >  {
> > -       return (mode & S_ISUID) || ((mode & S_ISGID) && (mode & S_IXGRP));
> > +       return (mode & S_ISUID) || ((mode & S_ISGID));
> 
> Yes, this is what I meant.  This can be simplified to:
> 
>        return mode & (S_ISUID | S_ISGID);

Thanks, will update accordingly.

Fwiw, enforcing the rules consistently across write operations and
chmod/chown will lead to losing the setgid bit in cases were it might've
been retained before.

I've mentioned this a few times but it's worth repeating. For the sake
of maintainability, consistency, and security this is a risk worth
taking. I've mentioned this already in the last pull request that fixed
issues in this area so Linus is aware that this is a user visible
change we're risking on purpose. I'll mention this again in detail this
time as well.

If this leads to regressions the fix is easy and we simply need to have
special setgid handling in the write path again with different semantics
from chmod/chown. We'll see. I'll update the tests if this second setgid
cleanup gets merged. Before that just be aware that there might be
failures for tests where unprivileged users modify a setgid file.

Thanks!
Christian
