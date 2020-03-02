Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA6DB175A53
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 13:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgCBMUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 07:20:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55580 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgCBMUE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:20:04 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j8k3E-00033u-Gx; Mon, 02 Mar 2020 12:20:00 +0000
Date:   Mon, 2 Mar 2020 13:19:59 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, cyphar@cyphar.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200302121959.it3iophjavbhtoyp@wittgenstein>
References: <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
 <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
 <20200302115239.pcxvej3szmricxzu@wittgenstein>
 <8736arnel9.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8736arnel9.fsf@oldenburg2.str.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 02, 2020 at 01:09:06PM +0100, Florian Weimer wrote:
> * Christian Brauner:
> 
> >> But that's inconsistent with the rest of the system.  And for example,
> >> if you make /etc/resolv.conf a symbolic link, a program which uses a new
> >> I/O library (with the new interfaces) will not be able to read it.
> >
> > Fair, but I expect that e.g. a C library would simply implement openat()
> > on top of openat2() if the latter is available and thus could simply
> > pass RESOLVE_SYMLINKS so any new I/O library not making use of the
> > syscall directly would simply get the old behavior. For anyone using the
> > syscall directly they need to know about its exact semantics anyway. But
> > again, maybe just having it opt-in is fine.
> 
> I'm more worried about fancy new libraries which go directly to the new
> system calls, but set the wrong defaults for a general-purpose open
> operation.
> 
> Can we pass RESOLVE_SYMLINKS with O_NOFLLOW, so that we can easily
> implement open/openat for architectures that provide only the openat2
> system call?

You can currently do RESOLVE_NO_SYMLINKS | O_NOFOLLOW. So I'd expect
RESOLVE_SYMLINKS | O_NOFOLLOW would work as well. But from what it looks
like having no symlink resolution be opt-in seems more likely.

> 
> >> AT_SYMLINK_NOFOLLOW only applies to the last pathname component anyway,
> >> so it's relatively little protection.
> >
> > So this is partially why I think it's at least worth considerings: the
> > new RESOLVE_NO_SYMLINKS flag does block all symlink resolution, not just
> > for the last component in contrast to AT_SYMLINK_NOFOLLOW. This is
> > 278121417a72d87fb29dd8c48801f80821e8f75a
> 
> RESOLVE_NO_SYMLINKS shouldn't be the default, though (whoever is
> responsible for applying that default).  Otherwise system administrators
> can no longer move around data between different file systems and set
> symbolic links accordingly.

Ok, maybe then we'll just leave RESOLVE_NO_SYMLINKS as opt-in.
