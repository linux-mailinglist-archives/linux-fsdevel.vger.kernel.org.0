Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D85617621E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 19:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCBSMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 13:12:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33202 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726451AbgCBSMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:12:52 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 022ICfZf008574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Mar 2020 13:12:42 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2999E42045B; Mon,  2 Mar 2020 13:12:41 -0500 (EST)
Date:   Mon, 2 Mar 2020 13:12:41 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        lampahome <pahome.chen@mirlab.org>, linux-fsdevel@vger.kernel.org
Subject: Re: why do we need utf8 normalization when compare name?
Message-ID: <20200302181241.GC6826@mit.edu>
References: <CAB3eZfv4VSj6_XBBdHK12iX_RakhvXnTCFAmQfwogR34uySo3Q@mail.gmail.com>
 <20200302125432.GP29971@bombadil.infradead.org>
 <20200302152818.GN23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302152818.GN23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 02, 2020 at 03:28:18PM +0000, Al Viro wrote:
> Why the hell do we need case-insensitive filesystems in the first place?
> I have only heard two explanations:
> 	1) because the layout (including name equivalences) is fixed by
> some OS that happens to be authoritative for that filesystem.  In that
> case we need to match the rules of that OS, whatever they are.  Unicode
> equivalence may be an interesting part of _their_ background reasons
> for setting those rules, but the only thing that really matters is what
> rules have they set.

It significantly helps porting applications that were originally
written for Windows and/or MacOS.  In particular, the work to add
Unicode comparison support to ext4 was funded to enable the ability to
run Windows gaming applications on Linux for Steam.


> 	2) early Android used to include a memory card with VFAT on
> it; the card is long gone, but crapplications came to rely upon having
> that shit.  And rather than giving them a file on the normal filesystem
> with VFAT image on it and /dev/loop set up and mounted, somebody wants
> to use parts of the normal (ext4) filesystem for it.  However, the
> same crapplications have come to rely upon the case-insensitive (sensu
> VFAT) behaviour there, so we must duplicate that vomit-inducing pile
> of hacks on ext4.  Ideally - with that vomit-induc{ing,ed} pile
> reclassified as a generic feature; those look more respectable.

There are a number of reasons why a loop device is not sufficient;
there is a requirement to have selective sharing of application data
between other applications, which is done using user/group ownership.

For Android, previously, this was done using sdcardfs which was based
off of wrapfs.  Wrapfs was the same base as unionfs, and as you may
recall, it had even more horrendous race issues, and more than once I
was asked to help to debug crashes when you fsstress was run on
different views of sdcardfs.  I've been strongly encouraging the push
to something more sane, but a requirement for this is case-folded
directory.

There is a third reason why case folding is necessary, which is for
file serving applications such as Samba which require case-folding,
and without file system level support, trying to simulate this in
userspace requires searching via readdir to do a case-insensitive
lookup (at least in some case).  So finding a more performant way to
support case-folding is a big help for applications like Samba.

Cheers,

						- Ted
