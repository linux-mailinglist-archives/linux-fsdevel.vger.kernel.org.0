Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3D6FB391B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 13:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfIPLJ3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 07:09:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfIPLJ3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:09:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50DBD30832E1;
        Mon, 16 Sep 2019 11:09:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-72.rdu2.redhat.com [10.10.125.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC2C460BFB;
        Mon, 16 Sep 2019 11:09:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, yuehaibing@huawei.com,
        marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL afs: Development for 5.4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16146.1568632167.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 16 Sep 2019 12:09:27 +0100
Message-ID: <16147.1568632167@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 16 Sep 2019 11:09:29 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Here's a set of patches for AFS.  The first three are trivial, deleting
unused symbols and rolling out a wrapper function.

The fourth and fifth patches make use of the previously added RCU-safe
request_key facility to allow afs_permission() and afs_d_revalidate() to
attempt to operate without dropping out of RCU-mode pathwalk.  Under
certain conditions, such as conflict with another client, we still have to
drop out anyway, take a lock and consult the server.

David
---
The following changes since commit f16180739cd18a39a1a45516ac0e65d18a9f100e:

  Merge remote-tracking branch 'net/master' into afs-next (2019-09-02 11:43:44 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-next-20190915

for you to fetch changes up to a0753c29004f4983e303abce019f29e183b1ee48:

  afs: Support RCU pathwalk (2019-09-02 11:43:54 +0100)

----------------------------------------------------------------
AFS development

Tested-by: Marc Dionne <marc.dionne@auristor.com>

----------------------------------------------------------------
David Howells (3):
      afs: Use afs_extract_discard() rather than iov_iter_discard()
      afs: Provide an RCU-capable key lookup
      afs: Support RCU pathwalk

YueHaibing (2):
      afs: remove unused variable 'afs_voltypes'
      afs: remove unused variable 'afs_zero_fid'

 fs/afs/dir.c        |  54 +++++++++++++++++++++++++-
 fs/afs/fsclient.c   |   6 +--
 fs/afs/internal.h   |   1 +
 fs/afs/security.c   | 108 +++++++++++++++++++++++++++++++++++++++++++---------
 fs/afs/volume.c     |   2 -
 fs/afs/yfsclient.c  |   6 +--
 include/linux/key.h |  14 ++++++-
 7 files changed, 162 insertions(+), 29 deletions(-)

