Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8989D22C318
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 12:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgGXK2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 06:28:51 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:57836 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgGXK2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:28:51 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 34A2672CCDC;
        Fri, 24 Jul 2020 13:28:49 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 279C57CFF79; Fri, 24 Jul 2020 13:28:49 +0300 (MSK)
Date:   Fri, 24 Jul 2020 13:28:49 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        =?utf-8?B?w4Frb3M=?= Uzonyi <uzonyi.akos@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/nsfs.c: fix ioctl support of compat processes
Message-ID: <20200724102848.GA1654@altlinux.org>
References: <20200724001248.GC25522@altlinux.org>
 <CAK8P3a0JM8dytW6C8P9HoPcGksg0d5JCut1yT7JzBcUCAm-WcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a0JM8dytW6C8P9HoPcGksg0d5JCut1yT7JzBcUCAm-WcQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 11:20:26AM +0200, Arnd Bergmann wrote:
> On Fri, Jul 24, 2020 at 2:12 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> >
> > According to Documentation/driver-api/ioctl.rst, in order to support
> > 32-bit user space running on a 64-bit kernel, each subsystem or driver
> > that implements an ioctl callback handler must also implement the
> > corresponding compat_ioctl handler.  The compat_ptr_ioctl() helper can
> > be used in place of a custom compat_ioctl file operation for drivers
> > that only take arguments that are pointers to compatible data
> > structures.
> >
> > In case of NS_* ioctls only NS_GET_OWNER_UID accepts an argument, and
> > this argument is a pointer to uid_t type, which is universally defined
> > to __kernel_uid32_t.
> 
> This is potentially dangerous to rely on, as there are two parts that
> are mismatched:
> 
> - user space does not see the kernel's uid_t definition, but has its own,
>   which may be either the 16-bit or the 32-bit type. 32-bit uid_t was
>   introduced with linux-2.3.39 in back in 2000. glibc was already
>   using 32-bit uid_t at the time in user space, but uclibc only changed
>   in 2003, and others may have been even later.
> 
> - the ioctl command number is defined (incorrectly) as if there was no
>   argument, so if there is any user space that happens to be built with
>   a 16-bit uid_t, this does not get caught.

Note that NS_GET_OWNER_UID is provided on 32-bit architectures, too, so
this 16-bit vs 32-bit uid_t issue was exposed to userspace long time ago
when NS_GET_OWNER_UID was introduced, and making NS_GET_OWNER_UID
available for compat processes won't make any difference, as the mismatch
is not between native and compat types, but rather between 16-bit and
32-bit uid_t types.

I agree it would be correct to define NS_GET_OWNER_UID as
_IOR(NSIO, 0x4, uid_t) instead of _IO(NSIO, 0x4), but nobody Cc'ed me
on this topic when NS_GET_OWNER_UID was discussed, and that ship has long
sailed.

> > This change fixes compat strace --pidns-translation.
> > 
> > Note: when backporting this patch to stable kernels, commit
> > "compat_ioctl: add compat_ptr_ioctl()" is needed as well.
> > 
> > Reported-by: Ákos Uzonyi <uzonyi.akos@gmail.com>
> > Fixes: 6786741dbf99 ("nsfs: add ioctl to get an owning user namespace for ns file descriptor")
> > Cc: stable@vger.kernel.org # v4.9+
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >  fs/nsfs.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/nsfs.c b/fs/nsfs.c
> > index 800c1d0eb0d0..a00236bffa2c 100644
> > --- a/fs/nsfs.c
> > +++ b/fs/nsfs.c
> > @@ -21,6 +21,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
> >  static const struct file_operations ns_file_operations = {
> >         .llseek         = no_llseek,
> >         .unlocked_ioctl = ns_ioctl,
> > +       .compat_ioctl   = compat_ptr_ioctl,
> >  };
> >
> >  static char *ns_dname(struct dentry *dentry, char *buffer, int buflen)

-- 
ldv
