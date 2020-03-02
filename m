Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8134A175A9E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 13:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgCBMfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 07:35:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55830 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgCBMfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:35:13 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j8kHv-0003wC-Bf; Mon, 02 Mar 2020 12:35:11 +0000
Date:   Mon, 2 Mar 2020 13:35:10 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, cyphar@cyphar.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200302123510.bm3a2zssohwvkaa4@wittgenstein>
References: <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
 <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
 <20200302115239.pcxvej3szmricxzu@wittgenstein>
 <8736arnel9.fsf@oldenburg2.str.redhat.com>
 <20200302121959.it3iophjavbhtoyp@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200302121959.it3iophjavbhtoyp@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 02, 2020 at 01:20:00PM +0100, Christian Brauner wrote:
> On Mon, Mar 02, 2020 at 01:09:06PM +0100, Florian Weimer wrote:
> > * Christian Brauner:
> > 
> > >> But that's inconsistent with the rest of the system.  And for example,
> > >> if you make /etc/resolv.conf a symbolic link, a program which uses a new
> > >> I/O library (with the new interfaces) will not be able to read it.
> > >
> > > Fair, but I expect that e.g. a C library would simply implement openat()
> > > on top of openat2() if the latter is available and thus could simply
> > > pass RESOLVE_SYMLINKS so any new I/O library not making use of the
> > > syscall directly would simply get the old behavior. For anyone using the
> > > syscall directly they need to know about its exact semantics anyway. But
> > > again, maybe just having it opt-in is fine.
> > 
> > I'm more worried about fancy new libraries which go directly to the new
> > system calls, but set the wrong defaults for a general-purpose open
> > operation.
> > 
> > Can we pass RESOLVE_SYMLINKS with O_NOFLLOW, so that we can easily
> > implement open/openat for architectures that provide only the openat2
> > system call?
> 
> You can currently do RESOLVE_NO_SYMLINKS | O_NOFOLLOW. So I'd expect
> RESOLVE_SYMLINKS | O_NOFOLLOW would work as well. But from what it looks
> like having no symlink resolution be opt-in seems more likely.

One difference to openat() is that openat2() doesn't silently ignore
unknown flags. But I'm not sure that would matter for iplementing
openat() via openat2() since there are no flags that openat() knows about
that openat2() doesn't know about afaict. So the only risks would be
programs that accidently have a bit set that isn't used yet. But that
seems unlikely. And I'm not aware of any flag that was deprecated that
some programs could still pass (a problem we had with CLONE_DETACHED for
example).
