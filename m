Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924C4338110
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 00:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhCKXGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 18:06:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39499 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbhCKXGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 18:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615503990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HtAWYSLLqT0QGTRR/NdQtQI9u91J7Jlm7FNQuSRjgM8=;
        b=bf5oZlfzEMAtK/McZKf/j5yiIytWvRSF4IGDkaSHVwnMiQLeQQE0l17xmuDJ9pjpcltcZ4
        Jgicis8vewUpGEPwhY+wXGWaOtfKBEy24Ku3jDH4x4W4475BdHHL+Eee+1AOhbpCPnvvOq
        3PE9/YYPrhGSSJdzZF4uEYTuHhax2bE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-lKX6lvm1Oky9mK8Dr6mfJQ-1; Thu, 11 Mar 2021 18:06:27 -0500
X-MC-Unique: lKX6lvm1Oky9mK8Dr6mfJQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E4EF1966322;
        Thu, 11 Mar 2021 23:06:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D0C819C47;
        Thu, 11 Mar 2021 23:06:24 +0000 (UTC)
Subject: [PATCH v2 0/2] AFS metadata xattr fixes
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        dhowells@redhat.com,
        Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Mar 2021 23:06:24 +0000
Message-ID: <161550398415.1983424.4857046033308089813.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a pair of fixes for AFS.

 (1) Fix an oops in AFS that can be triggered by accessing one of the
     afs.yfs.* xattrs against a yfs server[1][2] - for instance by "cp -a"
     or "rsync -X".  These try and copy all of the xattrs.

     They should pay attention to the list in /etc/xattr.conf, but cp
     doesn't on Ubuntu and rsync doesn't seem to on Ubuntu or Fedora.
     xattr.conf has been modified upstream[3], but a new version hasn't
     been cut yet.  I've logged a bug against rsync for the problem
     there[4].

 (2) Stop listing "afs.*" xattrs[6], particularly ACL ones[8].  This
     removes them from the list returned by listxattr(), but they're still
     available to get/set.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Changes:
ver #2:
 - Hide all of the afs.* xattrs, not just the ACL ones[7].

David

Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003498.html [1]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003501.html [2]
Link: https://git.savannah.nongnu.org/cgit/attr.git/commit/?id=74da517cc655a82ded715dea7245ce88ebc91b98 [3]
Link: https://github.com/WayneD/rsync/issues/163 [4]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003516.html [5]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003524.html [6]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003565.html # v1
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003568.html [7]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003570.html [8]

---
David Howells (2):
      afs: Fix accessing YFS xattrs on a non-YFS server
      afs: Stop listxattr() from listing "afs.*" attributes


 fs/afs/dir.c      |  1 -
 fs/afs/file.c     |  1 -
 fs/afs/inode.c    |  1 -
 fs/afs/internal.h |  1 -
 fs/afs/mntpt.c    |  1 -
 fs/afs/xattr.c    | 23 -----------------------
 6 files changed, 28 deletions(-)


