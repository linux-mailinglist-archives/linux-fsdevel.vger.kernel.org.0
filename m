Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39234BD4EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 06:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiBUFEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 00:04:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiBUFEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:04:47 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246632A720
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Feb 2022 21:04:23 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nM0s1-003V5c-Rm; Mon, 21 Feb 2022 05:04:21 +0000
Date:   Mon, 21 Feb 2022 05:04:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] umount/__detach_mounts() race
Message-ID: <YhMdVcrtXGLTrbWR@zeniv-ca.linux.org.uk>
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

	BTW, while looking through the vicinity - I think this 
        if (!check_mnt(old) && old_path->dentry->d_op != &ns_dentry_operations)
			return mnt;
in __do_loopback() is too permissive.  I'd prefer to replace it with
        if (!check_mnt(old)) {
		// allow binding objects from internal instance of nsfs
		if (old->mnt_ns != MNT_NS_INTERAL ||
		    old_path->dentry->d_op != &ns_dentry_operations)
			return mnt;
	}

Suppose we'd bound an nsfs object e.g. on /tmp/foo.  Consider a race
between mount --bind /tmp/foo /tmp/bar and umount -l /tmp/foo.

do_loopback() resolves /tmp/foo.  We have dentry from nsfs and mount
that sits on /tmp/foo.  We'd resolved /tmp/bar.

In the meanwhile, umount has resolved /tmp/foo and unmounted it.
struct mount is still alive due to the reference held by do_loopback().

do_loopback() finally grabs namespace_sem.  It verifies that mountpoint
to be (/tmp/bar) is still OK (it is) and calls __do_loopback().  The
check in __do_loopback() passes - old is unmounted, but dentry is
nsfs one, so we proceed to clone old.

And that's where the things go wrong - we copy the flags, including
MNT_UMOUNT, to the new instance.  And proceed to attach it on /tmp/bar.

It's really not a good thing.  E.g. __detach_mnt() will assume that
reference to the parent mount of /tmp/bar is *not* held.  As the
matter of fact, it is, so we'll get a leak if the mountpoint (/tmp/bar,
that is) gets unlinked in another namespace.  That's not the only way
to get trouble - we are really not supposed to have MNT_UMOUNT mounts
attached to !MNT_UMOUNT ones.

Eric, do you see any problems with the change above?
