Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD654BEB5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 20:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiBUTxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 14:53:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiBUTxa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:53:30 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875E922524
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 11:53:06 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMEk5-003jIM-0B; Mon, 21 Feb 2022 19:53:05 +0000
Date:   Mon, 21 Feb 2022 19:53:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] umount/__detach_mounts() race
Message-ID: <YhPtoCCjMCPDBzaz@zeniv-ca.linux.org.uk>
References: <YhMAy1WseafC+uIv@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhMAy1WseafC+uIv@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	BTW, for the folks not familiar with the area -
refcounting rules for mounts are

	(1) being a child of some mount contributes 1.  That
applies to all mounts.
	(2) being a part of a tree of some namespace contributes
number of children; ditto for a tree that had never been in any
namespace.
	(3) being a part of decaying fragment (something detached
by umount_tree()) does not contribute anything.  (1) still applies,
but (2) does not.
	(4) being a root of some namespace contributes 1.
	(5) being a part of a list passing through ->mnt_umount
contributes 1.

Everything else is due to explicit references stored in some objects
other than mnt_namespace and mount instances, including local variables,
etc.

Decaying fragments are distinguishable by having MNT_UMOUNT on all
mounts in them (namespace_lock() stabilizes that, just as it does to
everything else tree-related).  There should never be a mix of
MNT_UMOUNT and non-MNT_UMOUNT mounts in any tree.

Everything in decaying fragment also has
	NULL ->mnt_ns
	empty ->mnt_list
	NULL ->mnt_master
	empty ->mnt_shared/->mnt_slave/->mnt_slave_list
	empty ->mnt_expire

Decaying fragments can fall apart into smaller subtrees.
If nothing else, that happens when there's no more external
references to the root of fragment - its children are torn away,
moved into a list that passes through their ->mnt_umount
(see mntput_no_expire(), circa line 1210) and later dropped
(cleanup_mnt(), circa line 1138).  It also happens when
mountpoint of something in a fragment gets invalidated
(see __detach_mounts(), MNT_UMOUNT case).

However, that's the only thing that can happen to those fragments -
they can't get anything mounted/unmounted/moved.  Stepping on
something like NFS referral point fails, instead of automounting
anything, etc.

	umount_tree() should never be called on those - it's about
tearing some part of live trees (whether they are in a namespace
or not) into decaying fragments and collecting the roots of those
fragments into a list ('unmounted', passing through ->mnt_umount)
for the subsequent namespace_unlock() to drop.

Another thing: namespace root may go into decaying fragment (which can
happen only if it's explicitly passed as argument to umount_tree())
only when the namespace is about to be freed.  I think we should be
OK there, but I'm not happy with the proof - it's too convoluted and
smells like it might be brittle.  Might be worth making that more
straightforward...

Another fun area is handling of internal mounts (which is what got
me started on that round of code review).  Both in terms of
RCU delays between ->mnt_ns going NULL and in terms of sync
behaviour needed in final mntput() for those.  Final mntput()
also involves rather delicate interactions with legitimizing
references acquired in RCU mode - that's what __legitimize_mnt()
and MNT_DOOMED is about and documentation is... lacking, to
put it mildly.  It's scattered over a bunch of commit messages,
and incomplete even there.

I'll post when I get the documentation of that stuff into more or
less usable shape.  IMO it should go into Documentation/filesystems/*,
but it'll obviously need a review first...
