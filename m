Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187CA3E3E87
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 05:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhHID6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 23:58:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56414 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbhHID6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 23:58:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 353DF21E55;
        Mon,  9 Aug 2021 03:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628481497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sb1QA97NgQTxNE9aFEJpXFBCpCFiUGgr0naZO+lLRCk=;
        b=KzG4GFORXeMkvnlSFrT1yn+WfPYF3LvxsokNV1wFl106F18UNkhAxdKOAXpF5A9A36RHm9
        ibzdubEpKPP8VEm/Lf0QyjkMMrJj7HRDCDnba3KcfN1dSlpwS+/l5ODYr1RYtnzyF6J13Z
        MRs056zY/oXOSUs8+cybs9NiXGkxv5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628481497;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sb1QA97NgQTxNE9aFEJpXFBCpCFiUGgr0naZO+lLRCk=;
        b=W+yBQz1VKF0Yrm8tgHBsuIYABA07f5kSfl4AG8iPDxD6IzMSTKixf5LPvKzAHF8n5gEODc
        S7C/+a6enIEvPfBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45AB613A9F;
        Mon,  9 Aug 2021 03:58:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1hoKAdenEGG7BgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 09 Aug 2021 03:58:15 +0000
Subject: [PATCH/RFC 0/4] Attempt to make progress with btrfs dev number
  strangeness.
From:   NeilBrown <neilb@suse.de>
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Mon, 09 Aug 2021 13:55:27 +1000
Message-ID: <162848123483.25823.15844774651164477866.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I continue to search for a way forward for btrfs so that its behaviour
with respect to device numbers and subvols is somewhat coherent.

This series implements some of the ideas in my "A Third perspective"[1],
though with changes is various details.

I introduce two new mount options, which default to
no-change-in-behaviour.

 -o inumbits=  causes inode numbers to be more unique across a whole btrfs
               filesystem, and is many cases completely unique.  Mounting
               with "-i inumbits=56" will resolve the NFS issues that
               started me tilting at this particular windmill.

 -o numdevs=  can reduce the number of distinct devices reported by
              stat(), either to 2 or to 1.
              Both ease problems for sites that exhaust their supply of
              device numbers.
              '2' allows "du -x" to continue to work, but is otherwise
              rather strange.
              '1' breaks the use of "du -x" and similar to examine a
              single subvol which might have subvol descendants, but
              provides generally sane behaviour
              "-o numdevs=1" also forces inumbits to have a useful value.

I introduce a "tree id" which can be discovered using statx().  Two
files with the same dev and ino might still be different if the tree-ids
are different.  Connected files with the same tree-id may be usefully
considered to be related.

I also change various /proc files (only when numdevs=1 is used) to
provide extra information so they are useful with btrfs despite subvols.
/proc/maps /proc/smaps /proc/locks /proc/X/fdinfo/Y are affected.
The inode number becomes "XX:YY" where XX is the subvol number (tree id)
and YY is the inode number.

An alternate might be to report a number which might use up to 128 bits.
Which is less likely to seriously break code?

Note that code which ignores badly formatted lines is safe, because it
will never currently find a match for a btrfs file in these files
anyway.  The device number they report is never returned in st_dev for
stat() on any file.

The audit subsystem and one or two other places report dev/ino and so
need enhanced, but I haven't tried to address those.

Various trace points also report dev/ino.  I haven't tried thinking
about those either.

Thanks for your upcoming replies!

NeilBrown

---

NeilBrown (4):
      btrfs: include subvol identifier in inode number if -o inumbits=...
      btrfs: add numdevs= mount option.
      VFS/btrfs: add STATX_TREE_ID
      Add "tree" number to "inode" number in various /proc files.


 fs/btrfs/ctree.h          | 17 +++++++++++++++--
 fs/btrfs/disk-io.c        | 24 +++++++++++++++++++++---
 fs/btrfs/inode.c          | 39 ++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/ioctl.c          |  6 ++++--
 fs/btrfs/super.c          | 31 +++++++++++++++++++++++++++++++
 fs/inode.c                |  1 +
 fs/locks.c                | 12 +++++++++---
 fs/notify/fdinfo.c        | 19 ++++++++++++++-----
 fs/proc/nommu.c           | 11 ++++++++---
 fs/proc/task_mmu.c        | 17 ++++++++++++-----
 fs/proc/task_nommu.c      | 11 ++++++++---
 fs/stat.c                 |  2 ++
 include/linux/fs.h        |  3 ++-
 include/linux/stat.h      | 13 +++++++++++++
 include/uapi/linux/stat.h |  3 ++-
 samples/vfs/test-statx.c  |  4 +++-
 16 files changed, 183 insertions(+), 30 deletions(-)

--
Signature

