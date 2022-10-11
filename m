Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B4C5FB3B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 15:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiJKNsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 09:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJKNsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:48:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BDE9FD7;
        Tue, 11 Oct 2022 06:48:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03F9960CD4;
        Tue, 11 Oct 2022 13:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCB5C433D6;
        Tue, 11 Oct 2022 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665496129;
        bh=Y7w3/2h6RT8lZoM3bDrj/fs1hB6BhjEkjz5UMvLvsPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y04tTnkXB3chW9h1tMhZWOwzDgVoDkSRlCBZATta5Z7evh8ZpVDXc0xjTqSnmljCg
         MH+H1JjSkOUSCctPE9OFz1+EfOqwjIG76x9Xi2eRkMPlr3eObsbH2S6gdAN/sD/xOe
         EXejXG7aOlLy7MTUxnRTtnx177NtonVcT6QsQ18m31wFb6fRAITlSK2TYebY5AhP2T
         LfFQSMCKYNsMBGHwLz9dBF1s5fUI3W+y/Be3tm8xSRTsP//I0WCLwDeDWB6Zr8bhfu
         kAaB6LqaS5EDWu9aagk7KrxglNRtespCOhsCHTnZUkZX6vr6NTBqDOLv/v0eybp4gA
         kPEv6EiuFzkkA==
Date:   Tue, 11 Oct 2022 15:48:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] attr: use consistent sgid stripping checks
Message-ID: <20221011134838.3tkh3xroqnnkeydo@wittgenstein>
References: <20221007140543.1039983-1-brauner@kernel.org>
 <20221007140543.1039983-4-brauner@kernel.org>
 <CAOQ4uxggKnsyi2DvVOCUQQ8hEZJjioing_H-M4y_Hq-wvRk0nA@mail.gmail.com>
 <20221011085634.2qp2ragzcdzub6oq@wittgenstein>
 <CAOQ4uxhGqCkzsugEd_TZ+s3FEKiAxQtBy1rm3KP4KS=hzTsf4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhGqCkzsugEd_TZ+s3FEKiAxQtBy1rm3KP4KS=hzTsf4w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 11, 2022 at 02:07:10PM +0300, Amir Goldstein wrote:
> > > > @@ -721,10 +721,10 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
> > > >                 return -EINVAL;
> > > >         if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
> > > >                 return -EINVAL;
> > > > -       if (!S_ISDIR(inode->i_mode))
> > > > -               newattrs.ia_valid |=
> > > > -                       ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_KILL_PRIV;
> > > >         inode_lock(inode);
> > > > +       if (!S_ISDIR(inode->i_mode))
> > > > +               newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
> > > > +                                    should_remove_sgid(mnt_userns, inode);
> > >
> > > This is making me stop and wonder:
> > > 1. This has !S_ISDIR, should_remove_suid() has S_ISREG and
> > >     setattr_drop_sgid() has neither - is this consistent?
> >
> > I thought about that. It'very likely redundant since we deal with that
> > in other parts but I need to verify all callers before we can remove
> > that.
> >
> > > 2. SUID and PRIV are removed unconditionally and SGID is
> > >     removed conditionally - this is not a change of behavior
> > >     (at least for non-overlayfs), but is it desired???
> >
> > It looks that way but it isn't. The setgid bit was only killed
> > unconditionally for S_IXGRP. We continue to do that. But it was always
> > removed conditionally for ~S_IXGRP. The difference between this patchset
> > and earlier is that it was done in settattr_prepare() or setattr_copy()
> > before this change.
> >
> > IOW, we raised ATTR_KILL_SGID unconditionally but then only
> > conditionally obeyed it in setattr_{prepare,copy}() whereas now we
> > conditionally raise ATTR_KILL_SGID. That's surely a slight change but it
> > just means that we don't cause bugs for filesystems that roll their own
> > prepare or copy helpers and is just nicer overall.
> >
> 
> Yes, that sounds right.
> 
> The point that I was trying to make and failed to articulate myself was
> that chown_common() raises ATTR_KILL_SUID unconditionally,
> while should_remove_suid() raises ATTR_KILL_SUID conditional
> to !capable(CAP_FSETID).
> 
> Is this inconsistency in stripping SUID desired?

I looked at this before and it likely isn't intentional. But I need to
do pre-git archeology to determine that after I'm back from PTO. It
likely is something we can tackle.

> 
> According to man page (I think that) it is:
> 
> "When the owner or group of an executable file is changed by an
>  unprivileged user, the S_ISUID and S_ISGID mode bits are cleared.
>  POSIX does not specify whether this also  should  happen  when  root
>  does the chown(); the Linux behavior depends on the kernel version,
>  and since Linux 2.2.13, root is treated like other users..."
> 
> So special casing SUID stripping in chown() looks intentional,
> but maybe it is worth a comment.

It definitely is worth a comment but I think instead we should in the
future risk changing this for the write path as well. Because right now
losing the S_ISGID bit during chown() for regular files unconditionally
is important to not accidently have root create a situation where they
open a way for an unprivileged user to escalate privileges when chowning
a non-root owned setuid binary to a root-owned setuid binary:

touch aaa
chown 1000:1000
chmod u+s aaa
sudo chown aaa

and if the setuid bit would be retained then an unpriv user can now
abuse the setuid binary - if they can execute ofc. So that's why it's
dropped unconditionally. However, if that is a valid attack scenario
then a write should also drop setuid unconditionally since a non-harmful
setuid binary could be changed to a harmful one.

> 
> The paragraph above *may* be interpreted that chown() should strip
> S_SGID|S_IXGRP regardless of CAP_FSETID, which, as you say,
> has not been the case for a while.

Yeah, for the setgid bit we've been dropping it implicitly currently.

Thanks!
Christian
