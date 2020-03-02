Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 780351759C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 12:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgCBLwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 06:52:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54827 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgCBLwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:52:44 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j8jcm-0001Gr-Fk; Mon, 02 Mar 2020 11:52:40 +0000
Date:   Mon, 2 Mar 2020 12:52:39 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, cyphar@cyphar.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200302115239.pcxvej3szmricxzu@wittgenstein>
References: <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
 <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 02, 2020 at 12:30:47PM +0100, Florian Weimer wrote:
> * Christian Brauner:
> 
> > [Cc Florian since that ends up on libc's table sooner or later...]
> 
> I'm not sure what you are after here …

Exactly what you've commented below. Input on whether any of these
changes would be either problematic if you e.g. were to implement
openat() on top of openat2() in the future or if it would be problematic
if we e.g. were to really deprecate AT_* flags for new syscalls.

> 
> > On Fri, Feb 28, 2020 at 02:53:32PM +0000, David Howells wrote:
> >> 	
> >> I've been told that RESOLVE_* flags, which can be found in linux/openat2.h,
> >> should be used instead of the equivalent AT_* flags for new system calls.  Is
> >> this the case?
> >
> > Imho, it would make sense to use RESOLVE_* flags for new system calls
> > and afair this was the original intention.
> > The alternative is that RESOLVE_* flags are special to openat2(). But
> > that seems strange, imho. The semantics openat2() has might be very
> > useful for new system calls as well which might also want to support
> > parts of AT_* flags (see fsinfo()). So we either end up adding new AT_*
> > flags mirroring the new RESOLVE_* flags or we end up adding new
> > RESOLVE_* flags mirroring parts of AT_* flags. And if that's a
> > possibility I vote for RESOLVE_* flags going forward. The have better
> > naming too imho.
> >
> > An argument against this could be that we might end up causing more
> > confusion for userspace due to yet another set of flags. But maybe this
> > isn't an issue as long as we restrict RESOLVE_* flags to new syscalls.
> > When we introduce a new syscall userspace will have to add support for
> > it anyway.
> 
> I missed the start of the dicussion and what this is about, sorry.
> 
> Regarding open flags, I think the key point for future APIs is to avoid
> using the set of flags for both control of the operation itself
> (O_NOFOLLOW/AT_SYMLINK_NOFOLLOW, O_NOCTTY) and properaties of the
> resulting descriptor (O_RDWR, O_SYNC).  I expect that doing that would
> help code that has to re-create an equivalent descriptor.  The operation
> flags are largely irrelevant to that if you can get the descriptor by
> other means.
> 
> >>  (*) It has been suggested that AT_SYMLINK_NOFOLLOW should be the default, but
> >>      only RESOLVE_NO_SYMLINKS exists.
> >
> > I'd be very much in favor of not following symlinks being the default.
> > That's usually a source of a lot of security issues.
> 
> But that's inconsistent with the rest of the system.  And for example,
> if you make /etc/resolv.conf a symbolic link, a program which uses a new
> I/O library (with the new interfaces) will not be able to read it.

Fair, but I expect that e.g. a C library would simply implement openat()
on top of openat2() if the latter is available and thus could simply
pass RESOLVE_SYMLINKS so any new I/O library not making use of the
syscall directly would simply get the old behavior. For anyone using the
syscall directly they need to know about its exact semantics anyway. But
again, maybe just having it opt-in is fine.

> 
> AT_SYMLINK_NOFOLLOW only applies to the last pathname component anyway,
> so it's relatively little protection.

So this is partially why I think it's at least worth considerings: the
new RESOLVE_NO_SYMLINKS flag does block all symlink resolution, not just
for the last component in contrast to AT_SYMLINK_NOFOLLOW. This is
278121417a72d87fb29dd8c48801f80821e8f75a

Christian
