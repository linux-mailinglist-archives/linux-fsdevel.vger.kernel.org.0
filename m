Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D92617B9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jul 2019 23:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfGGVkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jul 2019 17:40:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46244 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbfGGVkp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jul 2019 17:40:45 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkEtm-0003su-Qy; Sun, 07 Jul 2019 21:40:42 +0000
Date:   Sun, 7 Jul 2019 22:40:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] make struct mountpoint bear the dentry reference to
 mountpoint, not struct mount
Message-ID: <20190707214042.GS17978@ZenIV.linux.org.uk>
References: <20190706001612.GM17978@ZenIV.linux.org.uk>
 <20190706002236.26113-1-viro@ZenIV.linux.org.uk>
 <20190706002236.26113-4-viro@ZenIV.linux.org.uk>
 <CAHk-=wgB5NN=N9Z4Y26CTSr1EchMfXbuFvVU4rcKaNca9qVkiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgB5NN=N9Z4Y26CTSr1EchMfXbuFvVU4rcKaNca9qVkiA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 07, 2019 at 02:17:38PM -0700, Linus Torvalds wrote:
> On Fri, Jul 5, 2019 at 5:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > +static HLIST_HEAD(unmounted);  /* protected by namespace_sem */
> > +static LIST_HEAD(ex_mountpoints);
> 
> What protects the ex_mountpoints list?
> 
> It looks like it's the mount_lock, but why isn't that documented?
> 
> It sure isn't namespace_sem from the comment above.

It is namespace_sem.  Of all put_mountpoint() callers only the one
from mntput_no_expire() (disposing of stuck MNT_LOCKed children)
is not under namespace_sem; all such are told to use ex_mountpoints
for disposal.  See
+               if (!list)
+                       list = &ex_mountpoints;
+               dput_to_list(dentry, list);
in there.  Only one call site gets non-default disposal list -
                list_for_each_entry_safe(p, tmp, &mnt->mnt_mounts,  mnt_child) {
-                       umount_mnt(p);
+                       umount_mnt(p, &list);
                }
in mntput_no_expire() passes a local list to umount_mnt() (which passes it
to put_mountpoint()).

And namespace_unlock() empties ex_mountpoints before dropping namespace_sem -
the contents gets moved to a local list, which is fed to shrink_dentry_list()
as soon as we drop namespace_sem.

Protection of the disposal list is up to the callers of put_mountpoint();
for ex_mountpoints it's namespace_sem, for the one in mntput_no_expire()
we don't need any exclusion whatsoever - no other thread can access it.

IOW, the comment re namespace_sem applies to ex_mountpoints as well.
