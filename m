Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF0161F74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 15:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbfGHNSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 09:18:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56694 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfGHNSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:18:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkTXL-00068s-Pz; Mon, 08 Jul 2019 13:18:31 +0000
Date:   Mon, 8 Jul 2019 14:18:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts
 around
Message-ID: <20190708131831.GT17978@ZenIV.linux.org.uk>
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
 <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
 <c5b901ca-c243-bf80-91be-a794c4433415@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b901ca-c243-bf80-91be-a794c4433415@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 08, 2019 at 09:02:10PM +0900, Tetsuo Handa wrote:
> Hello, David Howells.
> 
> I realized via https://lwn.net/Articles/792622/ that a new set of
> system calls for filesystem mounting has been added to Linux 5.2. But
> I feel that LSM modules are not ready to support these system calls.
> 
> An example is move_mount() added by this patch. This patch added
> security_move_mount() LSM hook but none of in-tree LSM modules are
> providing "LSM_HOOK_INIT(move_mount, ...)" entry. Therefore, currently
> security_move_mount() is a no-op. At least for TOMOYO, I want to check
> mount manipulations caused by system calls because allowing mounts on
> arbitrary location is not acceptable for pathname based access control.
> What happened? I want TOMOYO to perform similar checks like mount() does.

That would be like tomoyo_check_mount_acl(), right?
        if (need_dev) {
                /* Get mount point or device file. */
                if (!dev_name || kern_path(dev_name, LOOKUP_FOLLOW, &path)) {
                        error = -ENOENT;
                        goto out;
                }
                obj.path1 = path;
                requested_dev_name = tomoyo_realpath_from_path(&path);
                if (!requested_dev_name) {
                        error = -ENOENT;
                        goto out;
                }
        } else {
is an obvious crap for *ALL* cases.  You are doing pathname resolution,
followed by normalization and checks.  Then the result of said pathname
resolution is thrown out and it's redone (usually by something in fs/super.c).
Results of _that_ get used.

Could you spell TOCTOU?  And yes, exploiting that takes a lot less than
being able to do mount(2) in the first place - just pass it
/proc/self/fd/69/<some acceptable path>/. with descriptor refering to
opened root directory.  With ~/<some acceptable path> being a symlink
to whatever you actually want to hit.  And descriptor 42 being your
opened homedir.  Now have that call of mount(2) overlap with dup2(42, 69)
from another thread sharing your descriptor table.  It doesn't take much
to get the timing right, especially if you can arrange for some other
activity frequently hitting namespace_sem at least shared (e.g. reading
/proc/mounts in a loop from another process); that's likely to stall
mount(2) at the point of lock_mount(), which comes *AFTER* the point
where LSM hook is stuck into.

Again, *ANY* checks on "dev_name" in ->sb_mount() instances are so much
snake oil.  Always had been.
