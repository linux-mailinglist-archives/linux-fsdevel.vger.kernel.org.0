Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F7B3AF6E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 22:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFUUne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 16:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230447AbhFUUnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 16:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624308076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KYy9riG6O7TpoXICXGlQRZsJx+uJQz3RP31zFvC9R5Y=;
        b=bx66Pb6Y/VdDs4QT+6Pb9ajk6Wilz0wtTSIYLvPJhHjC0FcSBs3yXZQGYnglG6REazzSIt
        OnMII9AOl1h//tF0gnz3gbMGP5CwG8WukXtNQeMpZRTgpdkblUWGYrRInh8g4xiuET+twU
        HbRR6iJkKabBNpaIgMDhjOKLW4turpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-CT7d7j36NwqHef497rDiqw-1; Mon, 21 Jun 2021 16:41:13 -0400
X-MC-Unique: CT7d7j36NwqHef497rDiqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 619C9362F8;
        Mon, 21 Jun 2021 20:41:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9A3610016FE;
        Mon, 21 Jun 2021 20:41:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Andrew W Elble <aweits@rit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] netfs, afs: Fix write_begin/end
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2842347.1624308062.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 21 Jun 2021 21:41:02 +0100
Message-ID: <2842348.1624308062@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you pull this please?  It includes patches to fix netfs_write_begin(=
)
and afs_write_end() in the following ways:

 (1) In netfs_write_begin(), extract the decision about whether to skip a
     page out to its own helper and have that clear around the region to b=
e
     written, but not clear that region.  This requires the filesystem to
     patch it up afterwards if the hole doesn't get completely filled.

 (2) Use offset_in_thp() in (1) rather than manually calculating the offse=
t
     into the page.

 (3) Due to (1), afs_write_end() now needs to handle short data write into
     the page by generic_perform_write().  I've adopted an analogous
     approach to ceph of just returning 0 in this case and letting the
     caller go round again.

It also adds a note that (in the future) the len parameter may extend
beyond the page allocated.  This is because the page allocation is deferre=
d
to write_begin() and that gets to decide what size of THP to allocate.

Thanks,
David

Link: https://lore.kernel.org/r/20210613233345.113565-1-jlayton@kernel.org=
/
Link: https://lore.kernel.org/r/162367681795.460125.11729955608839747375.s=
tgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/162391823192.1173366.9740514875196345746.s=
tgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/162429000639.2770648.6368710175435880749.s=
tgit@warthog.procyon.org.uk/ # v3

Changes
=3D=3D=3D=3D=3D=3D=3D

ver #3:
   - Drop the bits that make afs take account of len exceeding the end of
     the page in afs_write_begin/end().

ver #2:
   - Removed a var that's no longer used (spotted by the kernel test robot=
)
   - Removed a forgotten "noinline".

ver #1:
   - Prefixed the Jeff's new helper with "netfs_".
   - Don't call zero_user_segments() for a full-page write.
   - Altered the beyond-last-page check to avoid a DIV.
   - Removed redundant zero-length-file check.
   - Added patches to fix afs.

---
The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33=
d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/netfs-fixes-20210621

for you to fetch changes up to 827a746f405d25f79560c7868474aec5aee174e1:

  netfs: fix test for whether we can skip read when writing beyond EOF (20=
21-06-21 21:24:07 +0100)

----------------------------------------------------------------
netfslib fixes

----------------------------------------------------------------
David Howells (1):
      afs: Fix afs_write_end() to handle short writes

Jeff Layton (1):
      netfs: fix test for whether we can skip read when writing beyond EOF

 fs/afs/write.c         | 11 +++++++++--
 fs/netfs/read_helper.c | 49 ++++++++++++++++++++++++++++++++++++---------=
----
 2 files changed, 45 insertions(+), 15 deletions(-)

