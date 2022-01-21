Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2924967A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 22:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiAUV5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 16:57:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231180AbiAUV5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642802267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LbdPydri53Ys0YI/ksP8tcx8qE6UcE8forSIwOZlU4M=;
        b=U9n2EofyAOsAjly7aYJnBzkl3S39PLGgGi6Pa4k4zISVYFwjCUNL1cgzOckrPXM8cuXO3k
        vWkfwjfODh/J7NP1fh8aRBHpJDpEMlXTH0MvkFlIKAR77WiCcBtaF4sPYuPrpTTRyQjVma
        6Iv0mw96RHUgP9cgI5cRqT+RX4zqnpk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-Va8Qp28gP3G0ynu2Pd9lOg-1; Fri, 21 Jan 2022 16:57:43 -0500
X-MC-Unique: Va8Qp28gP3G0ynu2Pd9lOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 739B419251A0;
        Fri, 21 Jan 2022 21:57:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A28712E1C;
        Fri, 21 Jan 2022 21:57:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        Steve French <smfrench@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fscache: Fixes and minor updates for rewrite
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1339461.1642802244.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 21 Jan 2022 21:57:24 +0000
Message-ID: <1339462.1642802244@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you pull this set of fixes and minor updates for the fscache
rewrite[1] please?

 (1) Fix mishandling of volume collisions (the wait condition is inverted
     and so it was only waiting if the volume collision was already
     resolved).

 (2) Fix miscalculation of whether there's space available in cachefiles.

 (3) Make sure a default cache name is set on a cache if the user hasn't
     set one by the time they bind the cache.

 (4) Adjust the way the backing inode is presented in tracepoints, add a
     tracepoint for mkdir and trace directory lookup.

 (5) Add a tracepoint for failure to set the active file mark.

 (6) Add an explanation of the checks made on the backing filesystem.

 (7) Check that the backing filesystem supports tmpfile.

 (8) Document how the page-release cancellation of the read-skip
     optimisation works.

And I've included a change for netfslib:

 (9) Make ops->init_rreq() optional.

Note that I dropped the patch that I had to add IS_KERNEL_FILE() as the
naming of S_KERNEL_FILE is undergoing late discussion[2] and I dropped the
patch to rewrite cifs's fscache indexing as SteveF has taken that into his
tree.

Thanks,
David


Link: https://lore.kernel.org/r/510611.1641942444@warthog.procyon.org.uk/ =
[1]
Link: https://lore.kernel.org/r/CAOQ4uxjEcvffv=3DrNXS-r+NLz+=3D6yk4abRuX_A=
Mq9v-M4nf_PtA@mail.gmail.com/ [2]
Link: https://lore.kernel.org/r/164251396932.3435901.344517748027321142.st=
git@warthog.procyon.org.uk/ # v1
---
The following changes since commit 455e73a07f6e288b0061dfcf4fcf54fa9fe0645=
8:

  Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/g=
it/clk/linux (2022-01-12 17:02:27 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/fscache-fixes-20220121

for you to fetch changes up to cef0223191452b3c493a1070baad9ffe806babac:

  netfs: Make ops->init_rreq() optional (2022-01-21 21:36:28 +0000)

----------------------------------------------------------------
fscache fixes

----------------------------------------------------------------
David Howells (7):
      fscache: Fix the volume collision wait condition
      cachefiles: Calculate the blockshift in terms of bytes, not pages
      cachefiles: Make some tracepoint adjustments
      cachefiles: Trace active-mark failure
      cachefiles: Explain checks in a comment
      cachefiles: Check that the backing filesystem supports tmpfiles
      fscache: Add a comment explaining how page-release optimisation work=
s

Jeffle Xu (2):
      cachefiles: set default tag name if it's unspecified
      netfs: Make ops->init_rreq() optional

 fs/cachefiles/cache.c             |  17 ++++---
 fs/cachefiles/daemon.c            |  11 ++++
 fs/cachefiles/internal.h          |   2 +-
 fs/cachefiles/io.c                |   2 +-
 fs/cachefiles/namei.c             |  12 +++--
 fs/ceph/addr.c                    |   5 --
 fs/fscache/volume.c               |   4 +-
 fs/netfs/read_helper.c            |   3 +-
 include/linux/fscache.h           |   5 ++
 include/trace/events/cachefiles.h | 103 ++++++++++++++++++++++++++-------=
-----
 10 files changed, 113 insertions(+), 51 deletions(-)

