Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB65916B729
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 02:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgBYBZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 20:25:00 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54390 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgBYBY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 20:24:59 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6Oy1-000c1D-U6; Tue, 25 Feb 2020 01:24:58 +0000
Date:   Tue, 25 Feb 2020 01:24:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v2)
Message-ID: <20200225012457.GA138294@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223011154.GY23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 23, 2020 at 01:12:21AM +0000, Al Viro wrote:
> 	This is a slightly extended repost of the patchset posted on
> Jan 19.  Current branch is in vfs.git#work.do_last, the main
> difference from the last time around being a bit of do_last()
> untangling added in the end of series.  #work.openat2 is already
> in mainline, which simplifies the series - now it's a straight
> branch with no merges.

Whee...  While trying to massage ".." handling towards the use of
regular mount crossing semantics, I've found something interesting.
Namely, if you start in a directory with overmounted parent,
LOOKUP_NO_XDEV resolution of ../something will bloody well cross
into the overmount.

Reason: follow_dotdot() (and its RCU counterpart) check for LOOKUP_NO_XDEV
when crossing into underlying fs, but not when crossing into overmount
of the parent.

Interpretation of .. is basically

loop:	if we are in root					// uncommon
		next = current position
	else if we are in root of a mounted filesystem		// more rare
		move to underlying mountpoint
		goto loop
	else
		next = parent directory of current position	// most common

	while next is overmounted				// _VERY_ uncommon
		next = whatever's mounted on next

	move to next

The second loop should've been sharing code with the normal mountpoint
crossing.  It doesn't, which has already lead to interesting inconsistencies
(e.g. autofs generally expects ->d_manage() to be called before crossing
into it; here it's not done).  LOOKUP_NO_XDEV has just added one more...

Incidentally, another inconsistency is LOOKUP_BENEATH treatment in case
when we have walked out of the subtree by way of e.g. procfs symlink and
then ran into .. in the absolute root (that's
                if (!follow_up(&nd->path))
                        break;
in follow_dotdot()).  Shouldn't that give the same reaction as ..
in root (EXDEV on LOOKUP_BENEATH, that is)?  It doesn't...

Another one is about LOOKUP_NO_XDEV again: suppose you have process'
root directly overmounted and cwd in the root of whatever's overmounting
it.  Resolution of .. will stay in cwd - we have no parent within the
chroot jail we are in, so we move to whatever's overmounting that root.
Which is the original location.  Should we fail on LOOKUP_NO_XDEV here?
Plain .. in the root of chroot jail (not overmounted by anything) does
*not*...
