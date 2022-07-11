Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9507F56D360
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 05:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiGKDhn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jul 2022 23:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKDhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:37:42 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A0062D3;
        Sun, 10 Jul 2022 20:37:40 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 80B7C100515;
        Mon, 11 Jul 2022 13:37:37 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6lxQUv2q0AWL; Mon, 11 Jul 2022 13:37:37 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 6D6EF10051D; Mon, 11 Jul 2022 13:37:37 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 48A32100507;
        Mon, 11 Jul 2022 13:37:35 +1000 (AEST)
Subject: [PATCH 0/3] autofs: fix may_umount_tree()
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 11 Jul 2022 11:37:35 +0800
Message-ID: <165751053430.210556.5634228273667507299.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function used by autofs to check if a tree of mounts may be umounted
doesn't work with mount namespaces.

Some time ago an attempt to fix it, appart from the implementation being
wrong, failed to take advantage of cases that allowed the check to
terminate early and so was too inefficient to be considered for merge.

This series utilizes cases for which the check can be terminated early
as best it can.

The patches in this series are prefixed with vfs becuase they are
changes to the VFS code but the only caller of the may_umount_tree()
function is the autofs file system.

For the interested here is a procedure that can be used to reproduce
the problem on a current kernel:

- Add this line to /etc/auto.master:
/- /etc/auto.test -t 5

- create the map /etc/auto.test as:
/test -fstype=tmpfs :tmpfs

- Enable debug logging in automount:

sed -i '/^#logging =/c logging = debug' /etc/autofs.conf
systemctl restart autofs.service

The autofs debug logging output can be observed in another terminal
using "journalctl -f".

Use the following script to run the two tests below.

$ cat /usr/local/bin/test.sh
#!/bin/sh
set -e
exec > >(logger --id=$$) 2>&1
echo Starting test
# Change to the /test directory to keep the mount active
cd /test
grep /test /proc/self/mountinfo
sleep 10
echo Ending test

1. Run the test script as root from the root mount namespace.
- observe that automount reports "expire_proc_direct: 1 remaining in /-"
  until after the script exits.
- correct behaviour.

2. Run the test script as root from a new mount namespace by using:

# unshare -m --propagation unchanged test.sh

- Observe that automount reports "expiring path /test" before the
  script has exited and tries to unmount /test.
  This fails with ">> umount: /test: target is busy." until the script
  exits.
- incorrect behaviour.

Signed-off-by: Ian Kent <raven@themaw.net>
---

Ian Kent (3):
      vfs: track count of child mounts
      vfs: add propagate_mount_tree_busy() helper
      vfs: make may_umount_tree() mount namespace aware


 fs/autofs/expire.c    | 14 ++++++++--
 fs/mount.h            |  1 +
 fs/namespace.c        | 40 +++++++++++++++++++---------
 fs/pnode.c            | 61 +++++++++++++++++++++++++++++++++++++++++++
 fs/pnode.h            |  1 +
 include/linux/mount.h |  5 +++-
 6 files changed, 107 insertions(+), 15 deletions(-)

--
Ian

