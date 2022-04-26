Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5F8510105
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 16:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349472AbiDZO5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 10:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351773AbiDZO5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:57:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743C464720;
        Tue, 26 Apr 2022 07:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BF99DCE1EA1;
        Tue, 26 Apr 2022 14:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14B5C385A0;
        Tue, 26 Apr 2022 14:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650984835;
        bh=KmqW8cpwOQam+syOSz/PwH5wv80htuNPJ/Ou7/xXDEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2srGQ+T1sP/B2eF62Rj7QyAqD9SyHeEqMupxx1poA9agdV22DqGIa31vNO32Zvci
         1EEj2MChuyXH62pivEKg1SjVuwUM2+vVC0HjjyEplrwPXM8LSj1k9XYjzPwZ4JiOvd
         IOZBxwHPT+ia3K51+pNyXd9m++kx0HQmdWxNXjVrGXTAVYsTjNPKa0izrvarEiFTpF
         GhcBv9+rrdy908DvXpUuMY7Ey5Ttjsc5+49gZyVilvOPaL6gR4wXXdAx9d+yGht+td
         5TP/y7q2qXYIRcKvdRrEcuEWT0Kj1KlsuzdgLwwFaE+a2wH9vyhEQ8iDsJ8TmRPbkT
         IawVZz96GvUBQ==
Date:   Tue, 26 Apr 2022 16:53:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v8 3/4] fs: move S_ISGID stripping into the vfs
Message-ID: <20220426145349.zxmahoq2app2lhip@wittgenstein>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650971490-4532-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220426103846.tzz66f2qxcxykws3@wittgenstein>
 <CAOQ4uxhRMp4tM9nP+0yPHJyzPs6B2vtX6z51tBHWxE6V+UZREw@mail.gmail.com>
 <CAJfpegu5uJiHgHmLcuSJ6+cQfOPB2aOBovHr4W5j_LU+reJsCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegu5uJiHgHmLcuSJ6+cQfOPB2aOBovHr4W5j_LU+reJsCw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 01:52:11PM +0200, Miklos Szeredi wrote:
> On Tue, 26 Apr 2022 at 13:21, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Apr 26, 2022 at 1:38 PM Christian Brauner <brauner@kernel.org> wrote:
> 
> > > One thing that I just remembered and which I think I haven't mentioned
> > > so far is that moving S_ISGID stripping from filesystem callpaths into
> > > the vfs callpaths means that we're hoisting this logic out of vfs_*()
> > > helpers implicitly.
> > >
> > > So filesystems that call vfs_*() helpers directly can't rely on S_ISGID
> > > stripping being done in vfs_*() helpers anymore unless they pass the
> > > mode on from a prior run through the vfs.
> > >
> > > This mostly affects overlayfs which calls vfs_*() functions directly. So
> > > a typical overlayfs callstack would be (roughly - I'm omw to lunch):
> > >
> > > sys_mknod()
> > > -> do_mknodat(mode) // calls vfs_prepare_mode()
> > >    -> .mknod = ovl_mknod(mode)
> > >       -> ovl_create(mode)
> > >          -> vfs_mknod(mode)
> > >
> > > I think we are safe as overlayfs passes on the mode on from its own run
> > > through the vfs and then via vfs_*() to the underlying filesystem but it
> > > is worth point that out.
> > >
> > > Ccing Amir just for confirmation.
> >
> > Looks fine to me, but CC Miklos ...
> 
> Looks fine to me as well.  Overlayfs should share the mode (including
> the suid and sgid bits), owner, group and ACL's with the underlying
> filesystem, so clearing sgid based on overlay parent directory should
> result in the same mode as if it was done based on the parent
> directory on the underlying layer.

Ah yes, good point.

> 
> AFAIU this logic is not affected by userns or mnt_userns, but
> Christian would be best to confirm that.

It does depend on it as S_ISGID stripping requires knowledge about
whether the caller has CAP_FSETID and is capable over the parent
directory or if they are in the group the file is owned by.

I think ultimately it might just come down to moving vfs_prepare_mode()
into vfs_*() helpers and not into the do_*at() helpers.

That would be cleaner anyway as right now we have this weird disconnect
between vfs_tmpfile() and vfs_{create,mknod,mkdir}(). IOW, vfs_tmpfile()
doesn't even have an associated do_*() wrapper where we could call
vfs_prepare_mode() from.

So ultimately it might be nicer if we do it in vfs_*() helpers anyway.

The less pretty thing about it will be that the security_path_*() hooks
also want a mode.

Right now these hooks receive the mode as it's passed in from userspace
minus umask but before S_ISGID stripping happens.

Whereas I think they should really see what the filesystem sees and
currently it's a bug that they see something else.

I need to think about this a bit.
