Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE1FF173B52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 16:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgB1PYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 10:24:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52761 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgB1PYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:24:30 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j7hV6-0004yt-9A; Fri, 28 Feb 2020 15:24:28 +0000
Date:   Fri, 28 Feb 2020 16:24:27 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-api@vger.kernel.org, viro@zeniv.linux.org.uk,
        metze@samba.org, torvalds@linux-foundation.org, cyphar@cyphar.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fweimer@redhat.com
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200228152427.rv3crd7akwdhta2r@wittgenstein>
References: <96563.1582901612@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96563.1582901612@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc Florian since that ends up on libc's table sooner or later...]

On Fri, Feb 28, 2020 at 02:53:32PM +0000, David Howells wrote:
> 	
> I've been told that RESOLVE_* flags, which can be found in linux/openat2.h,
> should be used instead of the equivalent AT_* flags for new system calls.  Is
> this the case?

Imho, it would make sense to use RESOLVE_* flags for new system calls
and afair this was the original intention.
The alternative is that RESOLVE_* flags are special to openat2(). But
that seems strange, imho. The semantics openat2() has might be very
useful for new system calls as well which might also want to support
parts of AT_* flags (see fsinfo()). So we either end up adding new AT_*
flags mirroring the new RESOLVE_* flags or we end up adding new
RESOLVE_* flags mirroring parts of AT_* flags. And if that's a
possibility I vote for RESOLVE_* flags going forward. The have better
naming too imho.

An argument against this could be that we might end up causing more
confusion for userspace due to yet another set of flags. But maybe this
isn't an issue as long as we restrict RESOLVE_* flags to new syscalls.
When we introduce a new syscall userspace will have to add support for
it anyway.

> 
> If so, should we comment them as being deprecated in the header file?  And
> should they be in linux/fcntl.h rather than linux/openat2.h?
> 
> Also:
> 
>  (*) It should be noted that the RESOLVE_* flags are not a superset of the
>      AT_* flags (there's no equivalent of AT_NO_AUTOMOUNT for example).

That's true but it seems we could just add e.g. RESOLVE_NO_AUTOMOUNT as
soon as we have a new syscall showing up that needs it or we have an
existing syscall (e.g. openat2()) that already uses RESOLVE_* flags and
needs it?

> 
>  (*) It has been suggested that AT_SYMLINK_NOFOLLOW should be the default, but
>      only RESOLVE_NO_SYMLINKS exists.

I'd be very much in favor of not following symlinks being the default.
That's usually a source of a lot of security issues.
And since no kernel with openat2() has been released there's still time
to switch it and with openat2() being a new syscall it won't hurt if it
has new semantics; I mean it deviates from openat() - intentionally -
already.

Christian
