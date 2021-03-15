Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AC633C410
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 18:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhCORZX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 13:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234618AbhCORZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615829102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/iLlVeV0kBl0vCchkuA6jyppxX0wnv4Ah3e5Q6JSthQ=;
        b=YVZHrWpjQdzYLNPxIHO6Rc8P71/sJEQK+JSD4kHoUgzoqFJhbZiVfukLoeUQZZ+9uB6Llh
        bk+T3Thw2f2N9KQ0Tz4y1fxKbIIYZzZCEqSBt/4TzRvFrmmUIM9Q7FGztklCueAbLAsArR
        4DWFx3CNkejhQiyx8wwgCp0MOCEygpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-bPTQR2kBPDWNgv07i7fCnA-1; Mon, 15 Mar 2021 13:24:58 -0400
X-MC-Unique: bPTQR2kBPDWNgv07i7fCnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EB59363A1;
        Mon, 15 Mar 2021 17:24:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EC031037E81;
        Mon, 15 Mar 2021 17:24:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com,
        Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        Jeffrey Altman <jaltman@auristor.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Fix oops and confusion from metadata xattrs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2932436.1615829093.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 15 Mar 2021 17:24:53 +0000
Message-ID: <2932437.1615829093@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Can you pull these two fixes to the afs filesystem please?

 (1) Fix an oops in AFS that can be triggered by accessing one of the
     afs.yfs.* xattrs against an OpenAFS server - for instance by "cp
     -a"[1], "rsync -X" or getfattr[2].  These try and copy all of the
     xattrs.

     cp and rsync should pay attention to the list in /etc/xattr.conf, but
     cp doesn't on Ubuntu and rsync doesn't seem to on Ubuntu or Fedora.
     xattr.conf has been modified upstream[3], and a new version has just
     been cut that includes it.  I've logged a bug against rsync for the
     problem there[4].

 (2) Stop listing "afs.*" xattrs[6], particularly ACL ones[8] so that they
     don't confuse cp and rsync.  This removes them from the list returned
     by listxattr(), but they're still available to get/set.

Changes:
ver #2:
 - Hide all of the afs.* xattrs, not just the ACL ones[7].

David

Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003498.htm=
l [1]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003501.htm=
l [2]
Link: https://git.savannah.nongnu.org/cgit/attr.git/commit/?id=3D74da517cc=
655a82ded715dea7245ce88ebc91b98 [3]
Link: https://github.com/WayneD/rsync/issues/163 [4]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003516.htm=
l [5]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003524.htm=
l [6]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003565.htm=
l # v1
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003568.htm=
l [7]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003570.htm=
l [8]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003571.htm=
l # v2
---
The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab1=
5:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20210315

for you to fetch changes up to a7889c6320b9200e3fe415238f546db677310fa9:

  afs: Stop listxattr() from listing "afs.*" attributes (2021-03-15 17:09:=
54 +0000)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (2):
      afs: Fix accessing YFS xattrs on a non-YFS server
      afs: Stop listxattr() from listing "afs.*" attributes

 fs/afs/dir.c          |  1 -
 fs/afs/file.c         |  1 -
 fs/afs/fs_operation.c |  7 +++++--
 fs/afs/inode.c        |  1 -
 fs/afs/internal.h     |  1 -
 fs/afs/mntpt.c        |  1 -
 fs/afs/xattr.c        | 31 +++++++------------------------
 7 files changed, 12 insertions(+), 31 deletions(-)

