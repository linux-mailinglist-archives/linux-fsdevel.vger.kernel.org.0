Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6892175E2A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 16:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgCBP2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 10:28:22 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53754 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgCBP2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:28:22 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8mzS-0043bp-Qb; Mon, 02 Mar 2020 15:28:18 +0000
Date:   Mon, 2 Mar 2020 15:28:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lampahome <pahome.chen@mirlab.org>, linux-fsdevel@vger.kernel.org
Subject: Re: why do we need utf8 normalization when compare name?
Message-ID: <20200302152818.GN23230@ZenIV.linux.org.uk>
References: <CAB3eZfv4VSj6_XBBdHK12iX_RakhvXnTCFAmQfwogR34uySo3Q@mail.gmail.com>
 <20200302125432.GP29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302125432.GP29971@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 02, 2020 at 04:54:32AM -0800, Matthew Wilcox wrote:
> On Mon, Mar 02, 2020 at 05:00:24PM +0800, lampahome wrote:
> > According to case insensitive since kernel 5.2, d_compare will
> > transform string into normalized form and then compare.
> > 
> > But why do we need this normalization function? Could we just compare
> > by utf8 string?
> 
> Have you read https://en.wikipedia.org/wiki/Unicode_equivalence ?
> 
> We need to decide whether a user with a case-insensitive filesystem
> who looks up a file with the name U+00E5 (lower case "a" with ring)
> should find a file which is named U+00C5 (upper case "A" with ring)
> or U+212B (Angstrom sign).
> 
> Then there's the question of whether e-acute is stored as U+00E9
> or U+0065 followed by U+0301, and both of those will need to be found
> by a user search for U+00C9 or a user searching for U+0045 U+0301.
> 
> So yes, normalisation needs to be done.

Why the hell do we need case-insensitive filesystems in the first place?
I have only heard two explanations:
	1) because the layout (including name equivalences) is fixed by
some OS that happens to be authoritative for that filesystem.  In that
case we need to match the rules of that OS, whatever they are.  Unicode
equivalence may be an interesting part of _their_ background reasons
for setting those rules, but the only thing that really matters is what
rules have they set.
	2) early Android used to include a memory card with VFAT on
it; the card is long gone, but crapplications came to rely upon having
that shit.  And rather than giving them a file on the normal filesystem
with VFAT image on it and /dev/loop set up and mounted, somebody wants
to use parts of the normal (ext4) filesystem for it.  However, the
same crapplications have come to rely upon the case-insensitive (sensu
VFAT) behaviour there, so we must duplicate that vomit-inducing pile
of hacks on ext4.  Ideally - with that vomit-induc{ing,ed} pile
reclassified as a generic feature; those look more respectable.

(1) is reasonable enough, but belongs in specific weird filesystems.
(2) is, IMO, a bad joke.

Does anybody know of any other reasons?
