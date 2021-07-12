Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E83C6087
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 18:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhGLQaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 12:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234284AbhGLQah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626107268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y7Db03HN3MeqSERix8FpAWv0C58s26YC1WHrC0xCtdw=;
        b=cqf+OPVXzHSZselPoGc/39Yh7FORkLI38dzJVVKWL6rhtiO6c8aKeXpKk4YkkzRODT1e2O
        W7ZeSiZ0elTwZCjV5qtoG+pn92jTIEZUNkFGs5z798gv0yfOM0nkA8LemgwrEWT46OWrCj
        f5LFqzpBhwSo7bIbRS1WCa8HvW+7Du8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-Kb_glMI-NayIU06b3rxf2w-1; Mon, 12 Jul 2021 12:27:45 -0400
X-MC-Unique: Kb_glMI-NayIU06b3rxf2w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D5BD801107;
        Mon, 12 Jul 2021 16:27:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-19.rdu2.redhat.com [10.10.118.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AA241970E;
        Mon, 12 Jul 2021 16:27:40 +0000 (UTC)
Subject: [PATCH v2 0/4] afs: Miscellaneous fixes
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tom Rix <trix@redhat.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        "Alexey Dobriyan (SK hynix)" <adobriyan@gmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Jul 2021 17:27:40 +0100
Message-ID: <162610726011.3408253.2771348573083023654.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here are some fixes for AFS:

 (1) Fix a tracepoint that causes one of the tracing subsystem query files
     to crash if the module is loaded[1].

 (2) Fix afs_writepages() to take account of whether the storage rpc
     actually succeeded when updating the cyclic writeback counter[2].

 (3) Fix some error code propagation/handling[3].

 (4) Fix place where afs_writepages() was setting writeback_index to a file
     position rather than a page index[4].

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Changes
=======

ver #2:
   - Fix an additional case of afs_writepages() setting writeback_index on
     error[4].
   - Fix afs_writepages() setting writeback_index to a file pos[4].

David

Link: https://lore.kernel.org/r/162430903582.2896199.6098150063997983353.stgit@warthog.procyon.org.uk/ [1]
Link: https://lore.kernel.org/r/20210430155031.3287870-1-trix@redhat.com [2]
Link: https://lore.kernel.org/r/1619691492-83866-1-git-send-email-jiapeng.chong@linux.alibaba.com [3]
Link: https://lore.kernel.org/r/CAB9dFdvHsLsw7CMnB+4cgciWDSqVjuij4mH3TaXnHQB8sz5rHw@mail.gmail.com/ [4]

---
David Howells (2):
      afs: Fix tracepoint string placement with built-in AFS
      afs: Fix setting of writeback_index

Jiapeng Chong (1):
      afs: Remove redundant assignment to ret

Tom Rix (1):
      afs: check function return


 fs/afs/dir.c   | 10 ++++++----
 fs/afs/write.c | 18 ++++++++++++------
 2 files changed, 18 insertions(+), 10 deletions(-)


