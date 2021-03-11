Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1585A337524
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 15:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhCKOKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 09:10:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233179AbhCKOKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615471822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8SAz47eHS2CgakOLUqpbe6DyZoVKv0WNeJAL94/owtQ=;
        b=bF/56KfLOLl4wxka0734CvKf7w5uzdR/+TMakDwLePjkYuCSyQSiazToFlag6Updjx/7VY
        4tg2RB5iY3MC7eU2iE029uVufGHh3/WGOX3mM/USlrG/MBGuEk78P+keK7Qj1V8y8nf2pP
        bJDtPU36ik9IB0mQmZ2FvbNyK0hA8Wc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-_GlUPJaANKSSX6U3yufcCg-1; Thu, 11 Mar 2021 09:10:19 -0500
X-MC-Unique: _GlUPJaANKSSX6U3yufcCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACBE6100C618;
        Thu, 11 Mar 2021 14:10:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 362CE196E3;
        Thu, 11 Mar 2021 14:10:16 +0000 (UTC)
Subject: [PATCH 0/2] AFS metadata xattr fixes
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        dhowells@redhat.com,
        Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Mar 2021 14:10:15 +0000
Message-ID: <161547181530.1868820.12933722592029066752.stgit@warthog.procyon.org.uk>
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

 (2) Hide ACL-related AFS xattrs[6].  This removes them from the list
     returned by listxattr(), but they're still available to get/set.

With further regard to the second patch, I tried just hiding the
appropriate ACL-related xattrs[5] first, but it didn't work well,
especially when a volume is replicated across servers of different types.

I wonder if it's better to just hide all the afs.* xattrs from listxattr().
It would probably be even better to not use xattrs for this, but I'm not
sure what I would use instead.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

David

Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003498.html [1]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003501.html [2]
Link: https://git.savannah.nongnu.org/cgit/attr.git/commit/?id=74da517cc655a82ded715dea7245ce88ebc91b98 [3]
Link: https://github.com/WayneD/rsync/issues/163 [4]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003516.html [5]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003524.html [6]
---
David Howells (2):
      afs: Fix accessing YFS xattrs on a non-YFS server
      afs: Fix afs_listxattr() to not list afs ACL special xattrs


 fs/afs/xattr.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)


