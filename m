Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA711759F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 13:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgCBMFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 07:05:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55059 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgCBMFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:05:07 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j8jol-0001z4-W6; Mon, 02 Mar 2020 12:05:04 +0000
Date:   Mon, 2 Mar 2020 13:05:03 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, cyphar@cyphar.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200302120503.g5pt4ky3uvb2ly63@wittgenstein>
References: <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
 <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
 <20200302115239.pcxvej3szmricxzu@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200302115239.pcxvej3szmricxzu@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 02, 2020 at 12:52:39PM +0100, Christian Brauner wrote:
> On Mon, Mar 02, 2020 at 12:30:47PM +0100, Florian Weimer wrote:
> > * Christian Brauner:
> > 
> > > [Cc Florian since that ends up on libc's table sooner or later...]
> > 
> > I'm not sure what you are after here …
> 
> Exactly what you've commented below. Input on whether any of these
> changes would be either problematic if you e.g. were to implement
> openat() on top of openat2() in the future or if it would be problematic
> if we e.g. were to really deprecate AT_* flags for new syscalls.
> 
> > 
> > > On Fri, Feb 28, 2020 at 02:53:32PM +0000, David Howells wrote:
> > >> 	
> > >> I've been told that RESOLVE_* flags, which can be found in linux/openat2.h,
> > >> should be used instead of the equivalent AT_* flags for new system calls.  Is
> > >> this the case?
> > >
> > > Imho, it would make sense to use RESOLVE_* flags for new system calls
> > > and afair this was the original intention.
> > > The alternative is that RESOLVE_* flags are special to openat2(). But
> > > that seems strange, imho. The semantics openat2() has might be very
> > > useful for new system calls as well which might also want to support
> > > parts of AT_* flags (see fsinfo()). So we either end up adding new AT_*
> > > flags mirroring the new RESOLVE_* flags or we end up adding new
> > > RESOLVE_* flags mirroring parts of AT_* flags. And if that's a
> > > possibility I vote for RESOLVE_* flags going forward. The have better
> > > naming too imho.
> > >
> > > An argument against this could be that we might end up causing more
> > > confusion for userspace due to yet another set of flags. But maybe this
> > > isn't an issue as long as we restrict RESOLVE_* flags to new syscalls.
> > > When we introduce a new syscall userspace will have to add support for
> > > it anyway.
> > 
> > I missed the start of the dicussion and what this is about, sorry.
> > 
> > Regarding open flags, I think the key point for future APIs is to avoid
> > using the set of flags for both control of the operation itself
> > (O_NOFOLLOW/AT_SYMLINK_NOFOLLOW, O_NOCTTY) and properaties of the
> > resulting descriptor (O_RDWR, O_SYNC).  I expect that doing that would

Yeah, we have touched on that already and we have other APIs having
related problems. A clean way to avoid this problem is to require new
syscalls to either have two flag arguments, or - if appropriate -
suggest they make use of struct open_how that was implemented for
openat2().

 * @flags: O_* flags.
 * @mode: O_CREAT/O_TMPFILE file mode.
 * @resolve: RESOLVE_* flags.
 */
struct open_how {
	__u64 flags;
	__u64 mode;
	__u64 resolve;
};
