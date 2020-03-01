Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B432174E87
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 17:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCAQia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 11:38:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55780 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgCAQi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 11:38:29 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j8Rbl-0000yU-V7; Sun, 01 Mar 2020 16:38:26 +0000
Date:   Sun, 1 Mar 2020 17:38:25 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, fweimer@redhat.com
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200301163825.ov42k4pvtbxlmg4s@wittgenstein>
References: <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
 <20200229152656.gwu7wbqd32liwjye@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200229152656.gwu7wbqd32liwjye@yavin>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 01, 2020 at 02:26:56AM +1100, Aleksa Sarai wrote:
> On 2020-02-28, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > [Cc Florian since that ends up on libc's table sooner or later...]
> > 
> > On Fri, Feb 28, 2020 at 02:53:32PM +0000, David Howells wrote:
> > > 	
> > > I've been told that RESOLVE_* flags, which can be found in linux/openat2.h,
> > > should be used instead of the equivalent AT_* flags for new system calls.  Is
> > > this the case?
> > 
> > Imho, it would make sense to use RESOLVE_* flags for new system calls
> > and afair this was the original intention.
> 
> Yes, RESOLVE_ flags would ideally be usable with all new system calls
> (though only where it makes sense, obviously). This would make it much
> easier for userspace to safely resolve paths without having to go
> through several levels of O_PATH fuckery.
> 
> The "openat2.h" name was honestly a completely arbitrary decision.
> 
> > So we either end up adding new AT_* flags mirroring the new RESOLVE_*
> > flags or we end up adding new RESOLVE_* flags mirroring parts of AT_*
> > flags. And if that's a possibility I vote for RESOLVE_* flags going
> > forward. The have better naming too imho.
> 
> I can see the argument for merging AT_ flags into RESOLVE_ flags (fewer
> flag arguments for syscalls is usually a good thing) ... but I don't
> really like it. There are a couple of problems right off the bat:

Sorry, I didn't want to suggest that we simply merge them or make one a
superset of the other (Though I think that's what David first had in
mind.). I rather meant it like: If we need a flag in the RESOLVE_*
namespace that already corresponds to a flag present in the AT_*
namespace we should not use the AT_* flag but rather introduce a new
RESOLVE_* flag. This way we don't end up mixing AT_* and RESOLVE_*
flags. That obviously is optimistic about not ending up with a scenario
where an old syscall suddenly wants a RESOLVE_* flag. That still seems
better than a new syscall wanting RESOLVE_* and AT_*. But maybe I'm
overthinking this.

I think you did a good job by keeping the values apart for now for
RESOLVE_* and AT_*, right? Mixing them would thus be kinda ok but still
feels very messy.

> 
>  * The prefix RESOLVE_ implies that the flag is specifically about path
>    resolution. While you could argue that AT_EMPTY_PATH is at least
>    *related* to path resolution, flags like AT_REMOVEDIR and
>    AT_RECURSIVE aren't.
> 
>  * That point touches on something I see as a more fundamental problem
>    in the AT_ flags -- they were intended to be generic flags for all of
>    the ...at(2) syscalls. But then AT_ grew things like AT_STATX_ and
>    AT_REMOVEDIR (both of which are necessary features to have for their
>    respective syscalls, but now those flag bits are dead for other
>    syscalls -- not to mention the whole AT_SYMLINK_{NO,}FOLLOW thing).

Right, basically why we ended up with RESOLVE_*.

> 
>  * While the above might be seen as minor quibbles, the really big
>    issue is that even the flags which are "similar" (AT_SYMLINK_NOFOLLOW
>    and RESOLVE_NO_SYMLINKS) have different semantics (by design -- in my
>    view, AT_SYMLINK_{NO,}FOLLOW / O_NOFOLLOW / lstat(2) has always had
>    the wrong semantics if the intention was to be a way to safely avoid
>    resolving symlinks).
> 
> But maybe I'm just overthinking what a merge of AT_ and RESOLVE_ would
> look like -- would it on.
> 
> > An argument against this could be that we might end up causing more
> > confusion for userspace due to yet another set of flags. But maybe this
> > isn't an issue as long as we restrict RESOLVE_* flags to new syscalls.
> > When we introduce a new syscall userspace will have to add support for
> > it anyway.
> > 
> > > 
> > > If so, should we comment them as being deprecated in the header file?  And
> > > should they be in linux/fcntl.h rather than linux/openat2.h?
> > > 
> > > Also:
> > > 
> > >  (*) It should be noted that the RESOLVE_* flags are not a superset of the
> > >      AT_* flags (there's no equivalent of AT_NO_AUTOMOUNT for example).
> > 
> > That's true but it seems we could just add e.g. RESOLVE_NO_AUTOMOUNT as
> > soon as we have a new syscall showing up that needs it or we have an
> > existing syscall (e.g. openat2()) that already uses RESOLVE_* flags and
> > needs it?
> 
> RESOLVE_NO_AUTOMOUNT is on the roadmap for openat2() -- I mentioned it
> as future work in the cover letter. :P
> 
> But see my above concerns about merging AT_ and RESOLVE_ flags. The
> semantic disconnect between AT_ and RESOLVE_ (which is most obvious with
> AT_SYMLINK_NOFOLLOW) also exists for AT_NO_AUTOMOUNT.
> 
> > >  (*) It has been suggested that AT_SYMLINK_NOFOLLOW should be the default, but
> > >      only RESOLVE_NO_SYMLINKS exists.
> > 
> > I'd be very much in favor of not following symlinks being the default.
> > That's usually a source of a lot of security issues.
> > And since no kernel with openat2() has been released there's still time
> > to switch it and with openat2() being a new syscall it won't hurt if it
> > has new semantics; I mean it deviates from openat() - intentionally -
> > already.
> 
> I agree in principle, but the problem is that if we want to add new
> RESOLVE_ flags you end up with half (or fewer) of the flags being opt-in
> with the rest necessarily being opt-out (since the flag not being set
> needs to be the old behaviour).

(This also reminds me of the discussion we had with new fd types
being cloexec by default going forward or not. :))
Fair, but that's true for any new flag argument that introduces a
hardening relevant feature that wasn't blocked by default for any
syscall (looking at you mmap(MAP_FIXED/MAP_FIXED_NOREPLACE) :).) I'd
also point out that with symlink resolution we've over time kinda
figured out that it should probably be opt-in rather than opt-out. I
feel that's not necessarily true for something like xdev.

> 
> There's also a slight ugliness with RESOLVE_SYMLINKS|RESOLVE_MAGICLINKS
> -- should you have to specify both or should RESOLVE_MAGICLINKS imply
> RESOLVE_SYMLINKS but only for magic-links. (Is allowing magic-links but
> not symlinks even a sane thing to do?)

Tricky but you have the inverse problem right now, no? Meaning, what
happens if you specify RESOLVE_NO_SYMLINKS but don't specify
RESOLVE_MAGICLINKS? Seems like you'd end up allowing magic links but no
symlinks, no?

> 
> Also I have a very strong feeling people won't like RESOLVE_XDEV nor
> RESOLVE_SYMLINKS being opt-in -- lots of systems use bind-mounts and
> symlinks in system paths and developers might not be aware of this.

I don't see that as a problem because openat2() is a new syscall anyway.
So any application that wants to make use of it needs to get used to
new semantics already. It's not that we're switching an old syscall to
new behavior.

Christian
