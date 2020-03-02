Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA64E175FB2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 17:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgCBQcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 11:32:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37384 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgCBQcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:32:02 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j8nz1-00070K-Mf; Mon, 02 Mar 2020 16:31:55 +0000
Date:   Mon, 2 Mar 2020 17:31:54 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200302163154.mpdf5oex3hxnrmvc@wittgenstein>
References: <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
 <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
 <20200302115239.pcxvej3szmricxzu@wittgenstein>
 <20200302120503.g5pt4ky3uvb2ly63@wittgenstein>
 <20200302151046.447zgo36dmfdr2ik@wittgenstein>
 <20200302153657.7k7qo4k5he2acxct@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200302153657.7k7qo4k5he2acxct@yavin>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 02:36:57AM +1100, Aleksa Sarai wrote:
> On 2020-03-02, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > On Mon, Mar 02, 2020 at 01:05:04PM +0100, Christian Brauner wrote:
> > > On Mon, Mar 02, 2020 at 12:52:39PM +0100, Christian Brauner wrote:
> > > > On Mon, Mar 02, 2020 at 12:30:47PM +0100, Florian Weimer wrote:
> > > > > * Christian Brauner:
> > > > > 
> > > > > > [Cc Florian since that ends up on libc's table sooner or later...]
> > > > > 
> > > > > I'm not sure what you are after here …
> > > > 
> > > > Exactly what you've commented below. Input on whether any of these
> > > > changes would be either problematic if you e.g. were to implement
> > > > openat() on top of openat2() in the future or if it would be problematic
> > > > if we e.g. were to really deprecate AT_* flags for new syscalls.
> > > > 
> > > > > 
> > > > > > On Fri, Feb 28, 2020 at 02:53:32PM +0000, David Howells wrote:
> > > > > >> 	
> > > > > >> I've been told that RESOLVE_* flags, which can be found in linux/openat2.h,
> > > > > >> should be used instead of the equivalent AT_* flags for new system calls.  Is
> > > > > >> this the case?
> > > > > >
> > > > > > Imho, it would make sense to use RESOLVE_* flags for new system calls
> > > > > > and afair this was the original intention.
> > > > > > The alternative is that RESOLVE_* flags are special to openat2(). But
> > > > > > that seems strange, imho. The semantics openat2() has might be very
> > > > > > useful for new system calls as well which might also want to support
> > > > > > parts of AT_* flags (see fsinfo()). So we either end up adding new AT_*
> > > > > > flags mirroring the new RESOLVE_* flags or we end up adding new
> > > > > > RESOLVE_* flags mirroring parts of AT_* flags. And if that's a
> > > > > > possibility I vote for RESOLVE_* flags going forward. The have better
> > > > > > naming too imho.
> > > > > >
> > > > > > An argument against this could be that we might end up causing more
> > > > > > confusion for userspace due to yet another set of flags. But maybe this
> > > > > > isn't an issue as long as we restrict RESOLVE_* flags to new syscalls.
> > > > > > When we introduce a new syscall userspace will have to add support for
> > > > > > it anyway.
> > > > > 
> > > > > I missed the start of the dicussion and what this is about, sorry.
> > > > > 
> > > > > Regarding open flags, I think the key point for future APIs is to avoid
> > > > > using the set of flags for both control of the operation itself
> > > > > (O_NOFOLLOW/AT_SYMLINK_NOFOLLOW, O_NOCTTY) and properaties of the
> > > > > resulting descriptor (O_RDWR, O_SYNC).  I expect that doing that would
> > > 
> > > Yeah, we have touched on that already and we have other APIs having
> > > related problems. A clean way to avoid this problem is to require new
> > > syscalls to either have two flag arguments, or - if appropriate -
> > > suggest they make use of struct open_how that was implemented for
> > > openat2().
> > 
> > By the way, if we really means business wrt to: separate resolution from
> > fd-property falgs then shouldn't we either require O_NOFOLLOW for
> > openat2() be specified in open_how->resolve or disallow O_NOFOLLOW for
> > openat2() and introduce a new RESOLVE_* variant?
> 
> I think we agreed a while ago we aren't touching O_ flags for openat2()
> because it would hamper adoption (this is the same reason we aren't
> fixing the whole O_ACCMODE mess, and O_LARGEFILE, and the arch-specific
> O_ flags, and O_TMPFILE, and __O_SYNC, and FASYNC/O_ASYNC, and
> __FMODE_EXEC and __FMODE_NONOTIFY, and ...).
> 
> To be fair, we did fix O_PATH|O_TMPFILE and invalid mode combinations
> but that's only because those were fairly broken.

Right, O_NOFOLLOW would've been kinda neat too because afaict it's the
only flag left that is specifically related to path resolution in there
that would fit nicely into open_how->resolve. :)

> 
> But as I mentioned in a sister mail, I do agree that allowing O_NOFOLLOW
> and RESOLVE_NO_TRAILING_SYMLINKS makes me feel a little uneasy. But

No version of this will be completey satisfying I fear.

Christian
