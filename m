Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF22257E4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 18:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgHaQLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 12:11:34 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:35021 "EHLO
        lizzy.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHaQLd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=okecird89HXny2cKbrtEOlP3jUlkIOz5LXFE8koWQJM=; b=TOE3zOcmnrsXp+97kJgNpOxVHE
        VoJ9M1NApQvMVg++DeYkqEU6nMIgnlJvzdkXGwOoUJkHGfRyrq72xZVnjQVcaUcH3CwZzoMhCBSuE
        5N/wV0MtVyuV+awH28jOzBrLiCMvrntP73Nn4J6DV0Al+TEEU3PdG095JlE7lmXpO09EGAf8phdZs
        W9qOs76F+8wqQuRBAiubFm8pTN526wf7Z5qdqt2TunStBof32wYFhnzWwo/GWD0BNt5Qx/SjWiaJl
        +jX4A0UylBD/tUwvyegadRAdpWi0VFn/47m8hkq2Q20PQuGLS9xk/F6EY++gDe+23XQdFflrQOV1l
        dqNuExmQ==;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Date:   Mon, 31 Aug 2020 18:11:17 +0200
Message-ID: <3192737.RVN0C98cj1@silver>
In-Reply-To: <20200831142312.GB4267@mit.edu>
References: <20200816225620.GA28218@dread.disaster.area> <20200829201245.GU14765@casper.infradead.org> <20200831142312.GB4267@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sonntag, 30. August 2020 21:05:40 CEST Miklos Szeredi wrote:
> On Sat, Aug 29, 2020 at 9:25 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Sat, Aug 29, 2020 at 09:13:24PM +0200, Miklos Szeredi wrote:
> > > > d_path() is the least of the problems, actually.  Directory tree
> > > > structure on those, OTOH, is a serious problem.  If you want to have
> > > > getdents(2) on that shite, you want an opened descriptor that looks
> > > > like a directory.  And _that_ opens a large can of worms.  Because
> > > > now you have fchdir(2) to cope with, lookups going through
> > > > /proc/self/fd/<n>/..., etc., etc.
> > > 
> > > Seriously, nobody wants fchdir().  And getdents() does not imply
> > > fchdir().
> > 
> > Yes, it does.  If it's a directory, fchdir(2) gets to deal with it.
> > If it's not, no getdents(2).  Unless you special-case the damn thing in
> > said fchdir(2).
> 
> Huh?  f_op->iterate() needed for getdents(2) and i_op->lookup() needed
> for fchdir(2).
> 
> Yes, open(..., O_ALT) would be special.  Let's call it open_alt(2) to
> avoid confusion with normal open on a normal filesystem.   No special
> casing anywhere at all.   It's a completely new interface that returns
> a file which either has ->read/write() or ->iterate() and which points
> to an inode with empty i_ops.

Wouldn't that be overkill to introduce a new syscall just for that?
My {disclaimer: quick & naive} approach would be sticking a new flag 
S_ALT_WHATEVER onto i_flags maybe? And hard code denial in 
inode_permission(MAY_EXEC) if that S_ALT_WHATEVER flag is present? Then you 
can getdents() but not fchdir() into it, if I am not missing something.

On Montag, 31. August 2020 09:34:20 CEST Miklos Szeredi wrote:
> On Sun, Aug 30, 2020 at 9:10 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Sun, Aug 30, 2020 at 09:05:40PM +0200, Miklos Szeredi wrote:
> > > Yes, open(..., O_ALT) would be special.  Let's call it open_alt(2) to
> > > avoid confusion with normal open on a normal filesystem.   No special
> > > casing anywhere at all.   It's a completely new interface that returns
> > > a file which either has ->read/write() or ->iterate() and which points
> > > to an inode with empty i_ops.
> > 
> > I think fiemap() should be allowed on a stream.  After all, these extents
> > do exist.  But I'm opposed to allowing getdents(); it'll only encourage
> > people to think they can have non-files as streams.
> 
> Call it whatever you want.  I think getdents (without lseek!!!)  is a
> fine interface for enumeration.
> 
> Also let me stress again, that this ALT thing is not just about
> streams, but a generic interface for getting OOB/meta/whatever data
> for a given inode/path.  Hence it must have a depth of at least 2, but
> limiting it to 2 would again be shortsighted.

Al, feeling about these two issues?

On Montag, 31. August 2020 16:23:12 CEST Theodore Y. Ts'o wrote:
> On Sat, Aug 29, 2020 at 09:12:45PM +0100, Matthew Wilcox wrote:
> > > 	3) what happens to it if that underlying file is unlinked?
> > 
> > Unlinking a file necessarily unlinks all the streams.  So the file
> > remains in existance until all fds on it are closed, including all
> > the streams.
> 
> That's a bad idea, because if the fds are closed silently, then they
> can be reused; and then if the userspace library tries to write to
> what it *thinks* is an ADS file, not knowing that the application has
> unlinked and closed the ADS file, user file data would be lost.

Why would that be bad with ADS while it is Ok with regular files right now?

Best regards,
Christian Schoenebeck


