Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EE41B7B37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 18:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgDXQMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 12:12:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56781 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726849AbgDXQMa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587744749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5OM2DPWHYM7y/6bsE5cL+3KwCNnH0bhlvscHbPBdZpg=;
        b=VPTI1Zf3rWw3i6jbri76DhJd6/8sjjIyjaEOIuHn7HZvx/UoRiN1rVCq9gAVOAxcqSaIfO
        okqx1WBwIT7ABR5JJo7HaXLwo1RvIT6kno4QkbOFJt04LC3otlOTVOlFYVJjAOOwL+7EG+
        SclNYsc6QDnWHq2mjCVxI3dTm+rfROI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-tLRd7sxgNXGK1lxtdLGmnA-1; Fri, 24 Apr 2020 12:12:25 -0400
X-MC-Unique: tLRd7sxgNXGK1lxtdLGmnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1A2B107B7C4;
        Fri, 24 Apr 2020 16:12:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-129.rdu2.redhat.com [10.10.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 002201001B2C;
        Fri, 24 Apr 2020 16:12:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Miscellaneous fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3632015.1587744742.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 24 Apr 2020 17:12:22 +0100
Message-ID: <3632016.1587744742@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you pull these three miscellaneous fixes to the afs filesystem:

 (1) Remove some struct members that aren't used, aren't set or aren't
     read, plus a wake up that nothing ever waits for.

 (2) Actually set the AFS_SERVER_FL_HAVE_EPOCH flag so that the code that
     depends on it can work.

 (3) Make a couple of waits uninterruptible if they're done for an
     operation that isn't supposed to be interruptible.

Thanks,
David
---
The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d93=
6:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20200424

for you to fetch changes up to c4bfda16d1b40d1c5941c61b5aa336bdd2d9904a:

  afs: Make record checking use TASK_UNINTERRUPTIBLE when appropriate (202=
0-04-24 16:33:32 +0100)

----------------------------------------------------------------
AFS miscellany

----------------------------------------------------------------
David Howells (3):
      afs: Remove some unused bits
      afs: Fix to actually set AFS_SERVER_FL_HAVE_EPOCH
      afs: Make record checking use TASK_UNINTERRUPTIBLE when appropriate

 fs/afs/cmservice.c | 2 +-
 fs/afs/fs_probe.c  | 5 +----
 fs/afs/internal.h  | 4 +---
 fs/afs/rotate.c    | 6 +++---
 fs/afs/server.c    | 7 ++-----
 fs/afs/vl_rotate.c | 4 ++--
 fs/afs/volume.c    | 8 +++++---
 7 files changed, 15 insertions(+), 21 deletions(-)

