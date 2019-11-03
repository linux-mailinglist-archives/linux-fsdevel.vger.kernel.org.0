Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65281ED3E2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 17:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfKCQf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 11:35:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39232 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbfKCQf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 11:35:27 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRIqa-0000LY-4u; Sun, 03 Nov 2019 16:35:24 +0000
Date:   Sun, 3 Nov 2019 16:35:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, wugyuan@cn.ibm.com,
        jlayton@kernel.org, hsiangkao@aol.com, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC] lookup_one_len_unlocked() lousy calling conventions
Message-ID: <20191103163524.GO26530@ZenIV.linux.org.uk>
References: <20190927044243.18856-1-riteshh@linux.ibm.com>
 <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
 <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk>
 <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk>
 <20191102172229.GT20975@paulmck-ThinkPad-P72>
 <20191102180842.GN26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102180842.GN26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 02, 2019 at 06:08:42PM +0000, Al Viro wrote:

> It is converging to a reasonably small and understandable surface, actually,
> most of that being in core pathname resolution.  Two big piles of nightmares
> left to review - overlayfs and (somewhat surprisingly) setxattr call chains,
> the latter due to IMA/EVM/LSM insanity...

One thing found while digging through overlayfs (and responsible for several
remaining pieces from the assorted pile):

lookup_one_len_unlocked() calling conventions are wrong for its callers.
Namely, 11 out of 12 callers really want ERR_PTR(-ENOENT) on negatives.
Most of them take care to check, some rely upon that being impossible in
their case.  Interactions with dentry turning positive right after
lookup_one_len_unlocked() has returned it are of varying bugginess...

The only exception is ecryptfs, where we do lookup in the underlying fs
on ecryptfs_lookup() and want to retain a negative dentry if we get one.

Not sure what's the best way to handle that - it looks like we want
a primitive with different behaviour on negatives, so the most conservative
variant would be to add such, leaving lookup_one_len_unlocked() use
for ecryptfs (and dealing with barriers properly in there), with
everybody else switching to lookup_positive_unlocked(), or whatever
we call that new primitive.

Other variants:

1) add a primitve with existing lookup_one_len_unlocked() behaviour,
changing lookup_one_len_unlocked() itselt to new calling conventions.
Switch ecryptfs to that, drop now-useless checks from other callers.

2) get rid of pinning negative underlying dentries in ecryptfs.
The cost will be doing lookup in underlying layer twice on something
like mkdir(2), the second one quite likely served out of dcache.
That would make _all_ callers of lookup_one_len_unlocked() need
the same calling conventions.

Preferences?
