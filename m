Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8798D5B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 16:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfHNOPN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 10:15:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfHNOPM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:15:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29FE33001468;
        Wed, 14 Aug 2019 14:15:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9530460D26;
        Wed, 14 Aug 2019 14:15:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.com
cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        baijiaju1990@gmail.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13352.1565792109.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 14 Aug 2019 15:15:09 +0100
Message-ID: <13353.1565792109@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 14 Aug 2019 14:15:12 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Can you pull these afs fixes please?

 (1) Fix the CB.ProbeUuid handler to generate its reply correctly.

 (2) Fix a mix up in indices when parsing a Volume Location entry record.

 (3) Fix a potential NULL-pointer deref when cleaning up a read request.

 (4) Fix the expected data version of the destination directory in
     afs_rename().

 (5) Fix afs_d_revalidate() to only update d_fsdata if it's not the same as
     the directory data version to reduce the likelihood of overwriting the
     result of a competing operation.  (d_fsdata carries the directory DV
     or the least-significant word thereof).

 (6) Fix the tracking of the data-version on a directory and make sure that
     dentry objects get properly initialised, updated and revalidated.

     Also fix rename to update d_fsdata to match the new directory's DV if
     the dentry gets moved over and unhash the dentry to stop
     afs_d_revalidate() from interfering.

David
---
The following changes since commit 2a11c76e5301dddefcb618dac04f74e6314df6bc:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost (2019-07-29 11:34:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20190814

for you to fetch changes up to 9dd0b82ef530cdfe805c9f7079c99e104be59a14:

  afs: Fix missing dentry data version updating (2019-07-30 14:38:52 +0100)

----------------------------------------------------------------
AFS Fixes

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

----------------------------------------------------------------
David Howells (4):
      afs: Fix the CB.ProbeUuid service handler to reply correctly
      afs: Fix off-by-one in afs_rename() expected data version calculation
      afs: Only update d_fsdata if different in afs_d_revalidate()
      afs: Fix missing dentry data version updating

Jia-Ju Bai (1):
      fs: afs: Fix a possible null-pointer dereference in afs_put_read()

Marc Dionne (1):
      afs: Fix loop index mixup in afs_deliver_vl_get_entry_by_name_u()

 fs/afs/cmservice.c | 10 ++----
 fs/afs/dir.c       | 89 ++++++++++++++++++++++++++++++++++++++++++++----------
 fs/afs/file.c      | 12 +++++---
 fs/afs/vlclient.c  | 11 ++++---
 4 files changed, 89 insertions(+), 33 deletions(-)
