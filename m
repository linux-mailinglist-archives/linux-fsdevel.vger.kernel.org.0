Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA23E8ED9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 12:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbhHKKlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 06:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:32790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236855AbhHKKk6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:40:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C33EB60560;
        Wed, 11 Aug 2021 10:40:32 +0000 (UTC)
Date:   Wed, 11 Aug 2021 12:40:30 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Questions re the new mount_setattr(2) manual page
Message-ID: <20210811104030.in6f25hw5h5cotti@wittgenstein>
References: <b58e2537-03f4-6f6c-4e1b-8ddd989624cc@gmail.com>
 <d5a8061a-3d8a-6353-5158-8feee0156c6b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5a8061a-3d8a-6353-5158-8feee0156c6b@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:47:14AM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Christian,
> 
> Some further questions...
> 
> In ERRORS there is:
> 
>        EINVAL The underlying filesystem is mounted in a user namespace.
> 
> I don't understand this. What does it mean?

The underlying filesystem has been mounted in a mount namespace that is
owned by a non-initial user namespace (Think of sysfs, overlayfs etc.).

> 
> Also, there is this:
> 
>        ENOMEM When  changing  mount  propagation to MS_SHARED, a new peer
>               group ID needs to be allocated for  all  mounts  without  a
>               peer  group  ID  set.  Allocation of this peer group ID has
>               failed.
> 
>        ENOSPC When changing mount propagation to MS_SHARED,  a  new  peer
>               group  ID  needs  to  be allocated for all mounts without a
>               peer group ID set.  Allocation of this peer  group  ID  can
>               fail.  Note that technically further error codes are possi‐
>               ble that are specific to the ID  allocation  implementation
>               used.
> 
> What is the difference between these two error cases? (That is, in what 
> circumstances will one get ENOMEM vs ENOSPC and vice versa?)

I did really wonder whether to even include those errors and I regret
having included them because they aren't worth a detailed discussion as
I'd consider them kernel internal relevant errors rather than userspace
relevant errors. In essence, peer group ids are allocated using the id
infrastructure of the kernel. It can fail for two main reasons:

1. ENOMEM there's not enough memory to allocate the relevant internal
   structures needed for the bitmap.
2. ENOSPC we ran out of ids, i.e. someone has somehow managed to
   allocate so many peer groups and managed to keep the kernel running
   (???) that the ida has ran out of ids.

Feel free to just drop those errors.

> 
> And then:
> 
>        EPERM  One  of  the mounts had at least one of MOUNT_ATTR_NOATIME,
>               MOUNT_ATTR_NODEV, MOUNT_ATTR_NODIRATIME, MOUNT_ATTR_NOEXEC,
>               MOUNT_ATTR_NOSUID, or MOUNT_ATTR_RDONLY set and the flag is
>               locked.  Mount attributes become locked on a mount if:
> 
>               •  A new mount or mount tree is created causing mount prop‐
>                  agation  across  user  namespaces.  The kernel will lock
> 
> Propagation is done across mont points, not user namespaces.
> should "across user namespaces" be "to a mount namespace owned 
> by a different user namespace"? Or something else?

That's really splitting hairs. Of course this means that we're
propagating into a mount namespace that is owned by a different user
namespace though "crossing user namespaces" might have been the better
choice.

> 
>                  the aforementioned  flags  to  protect  these  sensitive
>                  properties from being altered.
> 
>               •  A  new  mount  and user namespace pair is created.  This
>                  happens for  example  when  specifying  CLONE_NEWUSER  |
>                  CLONE_NEWNS  in unshare(2), clone(2), or clone3(2).  The
>                  aforementioned flags become locked to protect user name‐
>                  spaces from altering sensitive mount properties.
> 
> Again, this seems imprecise. Should it say something like:
> "... to prevent changes to sensitive mount properties in the new 
> mount namespace" ? Or perhaps you have a better wording.

That's not imprecise. What you want to protect against is altering
sensitive mount properties from within a user namespace irrespective of
whether or not the user namespace actually owns the mount namespace,
i.e. even if you own the mount namespace you shouldn't be able to alter
those properties. I concede though that "protect" should've been
"prevent".

You could probably say:

	A  new  mount  and user namespace pair is created.  This
	happens for  example  when  specifying  CLONE_NEWUSER  |
	CLONE_NEWNS  in unshare(2), clone(2), or clone3(2).
	The aforementioned flags become locked in the new mount
	namespace to prevent sensitive mount properties from being
	altered.
	Since the newly created mount namespace will be owned by the
	newly created user namespace a caller privileged in the newly
	created user namespace would be able to alter senstive
	mount properties. For example, without locking the read-only
	property for the mounts in the new mount namespace such a caller
	would be able to remount them read-write.

(Fwiw, in this scenario there's a bit of (moderately sane) strangeness.
 A CLONE_NEWUSER | CLONE_NEWMNT will cause even stronger protection to
 kick in. For all mounts not marked as expired MNT_LOCKED will be set
 which means that a umount() on any such mount copied from the previous
 mount namespace will yield EINVAL implying from userspace' perspective
 it's not mounted - granted EINVAL is the ioctl() of multiplexing errnos
 - whereas a remount to alter a locked flag will yield EPERM.)

Christian
