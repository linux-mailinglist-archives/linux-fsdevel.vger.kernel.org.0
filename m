Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D717179815
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 19:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgCDSim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 13:38:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33000 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDSim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:38:42 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9Yub-005KCg-A2; Wed, 04 Mar 2020 18:38:30 +0000
Date:   Wed, 4 Mar 2020 18:38:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mattias Nissler <mnissler@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Raul Rangel <rrangel@google.com>,
        linux-fsdevel@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v6] Add a "nosymfollow" mount option.
Message-ID: <20200304183829.GR23230@ZenIV.linux.org.uk>
References: <20200304173446.122990-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304173446.122990-1-zwisler@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 10:34:46AM -0700, Ross Zwisler wrote:
> From: Mattias Nissler <mnissler@chromium.org>
> 
> For mounts that have the new "nosymfollow" option, don't follow symlinks
> when resolving paths. The new option is similar in spirit to the
> existing "nodev", "noexec", and "nosuid" options, as well as to the
> LOOKUP_NO_SYMLINKS resolve flag in the openat2(2) syscall. Various BSD
> variants have been supporting the "nosymfollow" mount option for a long
> time with equivalent implementations.
> 
> Note that symlinks may still be created on file systems mounted with
> the "nosymfollow" option present. readlink() remains functional, so
> user space code that is aware of symlinks can still choose to follow
> them explicitly.
> 
> Setting the "nosymfollow" mount option helps prevent privileged
> writers from modifying files unintentionally in case there is an
> unexpected link along the accessed path. The "nosymfollow" option is
> thus useful as a defensive measure for systems that need to deal with
> untrusted file systems in privileged contexts.
> 
> More information on the history and motivation for this patch can be
> found here:
> 
> https://sites.google.com/a/chromium.org/dev/chromium-os/chromiumos-design-docs/hardening-against-malicious-stateful-data#TOC-Restricting-symlink-traversal
> 
> Signed-off-by: Mattias Nissler <mnissler@chromium.org>
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
> Resending v6 which was previously posted here [0].
> 
> Aleksa, if I've addressed all of your feedback, would you mind adding
> your Reviewed-by?
> 
> Andrew, would you please consider merging this?

NAK.  It's not that I hated the patch, but I call hard moratorium on
fs/namei.c features this cycle.

Reason: very massive rewrite of the entire area about to hit -next.
Moreover, that rewrite is still in the "might be reordered/rebased/whatnot"
stage.  The patches had been posted on fsdevel, along with the warning
that it's going into -next shortly.

Folks, we are close enough to losing control of complexity in that
code.  It needs to be sanitized, or we'll get into a state where the
average amount of new bugs introduced by fixing an old one exceeds 1.

There had been several complexity injections into that thing over
years (r/o bind-mounts, original RCU pathwalk merge, atomic_open,
mount traps, openat2 to name some) and while some of that got eventually
cleaned up, there's a lot of subtle stuff accumulated in the area.
It can be sanitized and I am doing just that (62 commits in the local
branch at the moment).  If that gets in the way of someone's patches -
too fucking bad.  The stuff already in needs to be integrated properly;
that gets priority over additional security hardening any day, especially
since this cycle has already seen
	* user-triggerable oops in several years old hardening stuff
(use-after-free, unlikely to be escalatable beyond null pointer
dereference).  And I'm not blaming the patch authors - liveness analysis
in do_last() as it is in mainline is a nightmare.
	* my own brown paperbag braino in attempt to fix that.
Fortunately that one was easily caught by fuzzers and it was trivial to fix
once found.  Again, liveness analysis (and data invariants) from hell...
	* gaps in LOOKUP_NO_XDEV (openat2 series, just merged).  Missed
on review.  Reason: several places implementing mount crossing, with
varying amount of divergence between them.  One got missed...
	* rather interesting corner cases of aushit vs. open vs. NFS.
Fairly old ones, at that.  Still sorting that one out...

Anyway, the bottom line is: leave fs/namei.c (especially around the
pathwalk-related code) alone for now.  Or work on top of the posted
series, but expect it to change quite a bit under you.  Trying to
dump that fun job on akpm is unlikely to work.  And if all of that
comes as a surprise since you are not following fsdevel, consider
doing so in the future, please.

PS:
al@dizzy:~/linux/trees/vfs$ git diff --stat v5.6-rc1..HEAD fs/namei.c
 fs/namei.c | 1408 +++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------
 1 file changed, 597 insertions(+), 811 deletions(-)
al@dizzy:~/linux/trees/vfs$ wc -l fs/namei.c
4723 fs/namei.c

The affected area is almost exclusively in core pathname resolution
code.
