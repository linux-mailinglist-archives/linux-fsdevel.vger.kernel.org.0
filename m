Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D022A3D113C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 16:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbhGUNpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239327AbhGUNlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626877336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qxdAEr2YRqU2Aqy0XvfKttwJTSza/9Yda5xfUDXe0eg=;
        b=fFBZcncjK+39eEXGb2OLY+8arbmJzfUnBp7H1f6NDmxoLpEOYvl35UQWHd1gI1LGq/1guX
        rJaxFCTYr/7A5N3yia9HgbxfL//ryd0BU64afqzPN6MNbRe0SjiOpf9IAarVQPHe8aiII1
        b3NZ/nMcmWQqzhcoHjRdYjf7jeeMN1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-xax8cnLwMW-3dri9F1qkGw-1; Wed, 21 Jul 2021 10:22:13 -0400
X-MC-Unique: xax8cnLwMW-3dri9F1qkGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ACCE3E743;
        Wed, 21 Jul 2021 14:22:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-62.rdu2.redhat.com [10.10.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1F715D9DD;
        Wed, 21 Jul 2021 14:22:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tom Rix <trix@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "Alexey Dobriyan (SK hynix)" <adobriyan@gmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Miscellaneous fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <281334.1626877326.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 21 Jul 2021 15:22:06 +0100
Message-ID: <281335.1626877326@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Can you pull these miscellaneous fixes for afs please?

 (1) Fix a tracepoint that causes one of the tracing subsystem query files
     to crash if the module is loaded[1].

 (2) Fix afs_writepages() to take account of whether the storage rpc
     actually succeeded when updating the cyclic writeback counter[2].

 (3) Fix some error code propagation/handling[3].

 (4) Fix place where afs_writepages() was setting writeback_index to a fil=
e
     position rather than a page index[4].

Changes
=3D=3D=3D=3D=3D=3D=3D

ver #2:
   - Fix an additional case of afs_writepages() setting writeback_index on
     error[4].
   - Fix afs_writepages() setting writeback_index to a file pos[4].

Thanks,
David

Link: https://lore.kernel.org/r/162430903582.2896199.6098150063997983353.s=
tgit@warthog.procyon.org.uk/ [1]
Link: https://lore.kernel.org/r/20210430155031.3287870-1-trix@redhat.com [=
2]
Link: https://lore.kernel.org/r/1619691492-83866-1-git-send-email-jiapeng.=
chong@linux.alibaba.com [3]
Link: https://lore.kernel.org/r/CAB9dFdvHsLsw7CMnB+4cgciWDSqVjuij4mH3TaXnH=
QB8sz5rHw@mail.gmail.com/ [4]
Link: https://lore.kernel.org/r/162609463116.3133237.11899334298425929820.=
stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/162610726011.3408253.2771348573083023654.s=
tgit@warthog.procyon.org.uk/ # v2

---
The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d=
3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20210721

for you to fetch changes up to b428081282f85db8a0d4ae6206a8c39db9c8341b:

  afs: Remove redundant assignment to ret (2021-07-21 15:11:22 +0100)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (2):
      afs: Fix tracepoint string placement with built-in AFS
      afs: Fix setting of writeback_index

Jiapeng Chong (1):
      afs: Remove redundant assignment to ret

Tom Rix (1):
      afs: check function return

 fs/afs/cmservice.c         | 25 +++++------------
 fs/afs/dir.c               | 10 ++++---
 fs/afs/write.c             | 18 ++++++++-----
 include/trace/events/afs.h | 67 +++++++++++++++++++++++++++++++++++++++++=
+----
 4 files changed, 87 insertions(+), 33 deletions(-)

