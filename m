Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955AD46C6C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 22:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241908AbhLGVjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 16:39:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231451AbhLGVjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638912931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AzTUawoPaBak3XDu8qExEtuPz54ZavcviXBL5By4I0o=;
        b=exc7PNCWZAc20bzeAJY6006TuAoD5beoeKcO6X04VbQZux3Qeb98ZluQEVi/mWTP+yVFsD
        UNU75FoCW3fpbkwRUgf8d6XkzTPa/cNHWIZxuYx1aEk4vN3IOewOP4BjHqarRoKrUeT8DN
        iQO7WThFAzYPj42XT51VSYkhj6n05tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445--c5lsXijPvWgGEEADum1Fg-1; Tue, 07 Dec 2021 16:35:28 -0500
X-MC-Unique: -c5lsXijPvWgGEEADum1Fg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5317613A4;
        Tue,  7 Dec 2021 21:35:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38627196F8;
        Tue,  7 Dec 2021 21:35:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Jeffle Xu <jefflexu@linux.alibaba.com>,
        jlayton@kernel.org, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] netfs: Potential deadlock and error handling fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2420478.1638912905.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 07 Dec 2021 21:35:05 +0000
Message-ID: <2420479.1638912905@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you pull these fixes for the netfs lib?  There are two:

 (1) Fix a lockdep warning and potential deadlock.  This is takes the
     simple approach of offloading the write-to-cache done from within a
     network filesystem read to a worker thread to avoid taking the
     sb_writer lock from the cache backing filesystem whilst holding the
     mmap lock on an inode from the network filesystem.

     Jan Kara posits a scenario whereby this can cause deadlock[1], though
     it's quite complex and I think requires someone in userspace to
     actually do I/O on the cache files.  Matthew Wilcox isn't so certain,
     though[2].

     An alternative way to fix this, suggested by Darrick Wong, might be t=
o
     allow cachefiles to prevent userspace from performing I/O upon the
     file - something like an exclusive open - but that's beyond the scope
     of a fix here if we do want to make such a facility in the future.

 (2) In some of the error handling paths where netfs_ops->cleanup() is
     called, the arguments are transposed[3].  gcc doesn't complain becaus=
e
     one of the parameters is void* and one of the values is void*.

David

Link: https://lore.kernel.org/r/20210922110420.GA21576@quack2.suse.cz/ [1]
Link: https://lore.kernel.org/r/Ya9eDiFCE2fO7K/S@casper.infradead.org/ [2]
Link: https://lore.kernel.org/r/20211207031449.100510-1-jefflexu@linux.ali=
baba.com/ [3]

---
The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb=
1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/netfs-fixes-20211207

for you to fetch changes up to 3cfef1b612e15a0c2f5b1c9d3f3f31ad72d56fcd:

  netfs: fix parameter of cleanup() (2021-12-07 15:47:09 +0000)

----------------------------------------------------------------
netfslib fixes

----------------------------------------------------------------
David Howells (1):
      netfs: Fix lockdep warning from taking sb_writers whilst holding mma=
p_lock

Jeffle Xu (1):
      netfs: fix parameter of cleanup()

 fs/netfs/read_helper.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

