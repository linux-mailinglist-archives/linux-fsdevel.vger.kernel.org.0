Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42605430B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 14:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbiFHMsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 08:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239514AbiFHMsT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:48:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB2692D0C;
        Wed,  8 Jun 2022 05:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF7B4B8276C;
        Wed,  8 Jun 2022 12:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D66FC34116;
        Wed,  8 Jun 2022 12:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654692494;
        bh=kL7aqTzSrEHcf3xZnL9DdRnwdBZsFUKtW/2ujP1VUbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+UPSSFw+vgYMzwwfmzMdDix74pc+PpAiHwFtFPbm0Rmj5nt+c93ofl1Absuy8yre
         2rVzdZOxFIttdCCnGT4hEBVVtOVHP281fHSOQCtzoiy2GxMTKLGW9dqw9eUJ8DRfoI
         59Xc/ltMZWoqXp5QV75udZRKq1gDkWO7ore0oaD9pXJ9cLK2oG4OzhE2jP4/CTyf1J
         BPJtzBgsFnYlWlZoKRPO3ZXpHq3PJ/Wn1kqdoqFnzSiQ/x0naJwOERiFExY+Eo/Hsb
         0Z7orm0A5tvTn2jhiZUJusrIEYY21CSypQxJxVEtR60fAyBy4zofy73/IwZczAMKPK
         Tan82+dxllvFw==
Date:   Wed, 8 Jun 2022 14:48:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
Message-ID: <20220608124808.uylo5lntzfgxxmns@wittgenstein>
References: <20220607153139.35588-1-cgzones@googlemail.com>
 <20220608112728.b4xrdppxqmyqmtwf@wittgenstein>
 <CAOQ4uxipD6khNUYuZT80WUa0KOMdyyP0ia55uhmeRCLj4NBicg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxipD6khNUYuZT80WUa0KOMdyyP0ia55uhmeRCLj4NBicg@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 08, 2022 at 03:28:52PM +0300, Amir Goldstein wrote:
> On Wed, Jun 8, 2022 at 2:57 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Jun 07, 2022 at 05:31:39PM +0200, Christian Göttsche wrote:
> > > From: Miklos Szeredi <mszeredi@redhat.com>
> > >
> > > Support file descriptors obtained via O_PATH for extended attribute
> > > operations.
> > >
> > > Extended attributes are for example used by SELinux for the security
> > > context of file objects. To avoid time-of-check-time-of-use issues while
> > > setting those contexts it is advisable to pin the file in question and
> > > operate on a file descriptor instead of the path name. This can be
> > > emulated in userspace via /proc/self/fd/NN [1] but requires a procfs,
> > > which might not be mounted e.g. inside of chroots, see[2].
> > >
> > > [1]: https://github.com/SELinuxProject/selinux/commit/7e979b56fd2cee28f647376a7233d2ac2d12ca50
> > > [2]: https://github.com/SELinuxProject/selinux/commit/de285252a1801397306032e070793889c9466845
> > >
> > > Original patch by Miklos Szeredi <mszeredi@redhat.com>
> > > https://patchwork.kernel.org/project/linux-fsdevel/patch/20200505095915.11275-6-mszeredi@redhat.com/
> > >
> > > > While this carries a minute risk of someone relying on the property of
> > > > xattr syscalls rejecting O_PATH descriptors, it saves the trouble of
> > > > introducing another set of syscalls.
> > > >
> > > > Only file->f_path and file->f_inode are accessed in these functions.
> > > >
> > > > Current versions return EBADF, hence easy to detect the presense of
> > > > this feature and fall back in case it's missing.
> > >
> > > CC: linux-api@vger.kernel.org
> > > CC: linux-man@vger.kernel.org
> > > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> > > ---
> >
> > I'd be somewhat fine with getxattr and listxattr but I'm worried that
> > setxattr/removexattr waters down O_PATH semantics even more. I don't
> > want O_PATH fds to be useable for operations which are semantically
> > equivalent to a write.
> 
> It is not really semantically equivalent to a write if it works on a
> O_RDONLY fd already.

The fact that it works on a O_RDONLY fd has always been weird. And is
probably a bug. If you look at xattr_permission() you can see that it
checks for MAY_WRITE for set operations... setxattr() writes to disk for
real filesystems. I don't know how much closer to a write this can get.

In general, one semantic aberration doesn't justify piling another one
on top.

(And one thing that speaks for O_RDONLY is at least that it actually
opens the file wheres O_PATH doesn't.)

> 
> >
> > In sensitive environments such as service management/container runtimes
> > we often send O_PATH fds around precisely because it is restricted what
> > they can be used for. I'd prefer to not to plug at this string.
> 
> But unless I am mistaken, path_setxattr() and syscall_fsetxattr()
> are almost identical w.r.t permission checks and everything else.
> 
> So this change introduces nothing new that a user in said environment
> cannot already accomplish with setxattr().
> 
> Besides, as the commit message said, doing setxattr() on an O_PATH
> fd is already possible with setxattr("/proc/self/$fd"), so whatever security
> hole you are trying to prevent is already wide open.

That is very much a something that we're trying to restrict for this
exact reason and is one of the main motivator for upgrade mask in
openat2(). If I want to send a O_PATH around I want it to not be
upgradable. Aleksa is working on upgrade masks with openat2() (see [1]
and part of the original patchset in [2]. O_PATH semantics don't need to
become weird.

[1]: https://lore.kernel.org/all/20220526130355.fo6gzbst455fxywy@senku
[2]: https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20190728010207.9781-8-cyphar@cyphar.com
