Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85980396FF6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 11:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhFAJJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 05:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233360AbhFAJJw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:09:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69F73610C9;
        Tue,  1 Jun 2021 09:08:10 +0000 (UTC)
Date:   Tue, 1 Jun 2021 11:08:07 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Marko Rauhamaa <marko.rauhamaa@f-secure.com>
Subject: Re: fsnotify events for overlayfs real file
Message-ID: <20210601090807.cxcltwyjsmux3c7p@wittgenstein>
References: <CAOQ4uxguanxEis-82vLr7OKbxsLvk86M0Ehz2nN1dAq8brOxtw@mail.gmail.com>
 <CAJfpeguCwxXRM4XgQWHyPxUbbvUh-M6ei-tYa5Y0P56MJMW7OA@mail.gmail.com>
 <CAOQ4uxhsxmzWp+YMRBA3xFDzJ1ov--n=f+VAnBsJZ_4DyHoYXw@mail.gmail.com>
 <CAJfpegsqqwMgtDKESNVXvtYU=fsu2pZ_nE8UdXQSLudKqK8Xmw@mail.gmail.com>
 <CAOQ4uxiYZfQSZN4avfnNmQv1OxB5+Q=9wr-eSRXK+QkostC66w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiYZfQSZN4avfnNmQv1OxB5+Q=9wr-eSRXK+QkostC66w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 31, 2021 at 09:26:35PM +0300, Amir Goldstein wrote:
> On Mon, May 31, 2021 at 6:18 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Tue, 18 May 2021 at 19:56, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Tue, May 18, 2021 at 5:43 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > On Mon, 10 May 2021 at 18:32, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > > > My thinking was that we can change d_real() to provide the real path:
> > > > >
> > > > > static inline struct path d_real_path(struct path *path,
> > > > >                                     const struct inode *inode)
> > > > > {
> > > > >         struct realpath = {};
> > > > >         if (!unlikely(dentry->d_flags & DCACHE_OP_REAL))
> > > > >                return *path;
> > > > >         dentry->d_op->d_real(path->dentry, inode, &realpath);
> > > > >         return realpath;
> > > > > }
> >
> > Real paths are internal, we can't pass them (as fd in permission
> > events) to userspace.
> >
> > > > >
> > > > >
> > > > > Another option, instead of getting the realpath, just detect the
> > > > > mismatch of file_inode(file) != d_inode(path->dentry) in
> > > > > fanotify_file() and pass FSNOTIFY_EVENT_DENTRY data type
> > > > > with d_real() dentry to backend instead of FSNOTIFY_EVENT_PATH.
> > > > >
> > > > > For inotify it should be enough and for fanotify it is enough for
> > > > > FAN_REPORT_FID and legacy fanotify can report FAN_NOFD,
> > > > > so at least permission events listeners can identify the situation and
> > > > > be able to block access to unknown paths.
> >
> > That sounds like a good short term solution.
> >
> 
> It may be a fine academic solution, but I don't think it solves any real
> world problem.
> I am not aware of any security oriented solutions that use permission
> events on inode or directory (let alone sb).
> 
> The security oriented users of fanotify are anti-virus on-access
> protection engines and those are using mount marks anyway
> (dynamically adding them as far as I know).
> [cc Marko who may be able to shed some light]
> 
> For those products, creating a bind mount inside a new mount ns
> may actually escape the on-access policy or the new mount will
> also be marked I am not sure. I suppose cloning mount ns may be
> prohibited by another LSM or something(?).

Yes, this can be restricted in multiple ways. Three spring to mind right
away:
- procfs: write a really low number to /proc/sys/user/max_mnt_namespaces
- seccomp: prevent the clone3() syscall, prevent the legacy clone()
  syscall with CLONE_NEWNS, prevent unshare(CLONE_NEWNS)
- use LSM

> 
> >
> > >
> > > Is there a reason for the fake path besides the displayed path in
> > > /proc/self/maps?
> >
> > I'm not aware of any.
> >
> > >
> > > Does it make sense to keep one realfile with fake path for mmaped
> > > files along side a realfile with private/detached path used for all the
> > > other operations?
> >
> > This should work, but it would add more open files,
> 
> True, but only for the mmaped files.
> 
> > so needs some good justifications.
> >
> 
> I'm afraid I don't have one yet..
> Let's see what the AV vendors have to say.
> 
> Thanks,
> Amir.
