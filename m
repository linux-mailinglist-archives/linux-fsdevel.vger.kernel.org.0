Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74A0C118BE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 16:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfLJPD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 10:03:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50677 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727272AbfLJPD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575990234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ctv0kLNPgQexp4KT/v6CaCSy03n0G++6iZ8OEuUJBmw=;
        b=EBNwSkEhngFBtGqJbpONqFSW2b54A8nuVKex0x1q4N2LEfEBFRmzVgijebv/RW0ItegxpK
        VWmvoEQumLmeBo0Jxj48BWGYFru4ELDIEmSNSOVI61gOWYth/6qndAKHRjBXZHSHpgg1sp
        2iDbD83MCzUDeldstg7nrDurrjNHXSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-rxSE3KR_NbijXUnHUzRhfg-1; Tue, 10 Dec 2019 10:03:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8C68802C9E;
        Tue, 10 Dec 2019 15:03:50 +0000 (UTC)
Received: from orion.redhat.com (ovpn-205-230.brq.redhat.com [10.40.205.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD24C1001B03;
        Tue, 10 Dec 2019 15:03:49 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de
Subject: [PATCH 0/5] Refactor ioctl_fibmap() internal interface
Date:   Tue, 10 Dec 2019 16:03:39 +0100
Message-Id: <20191210150344.112181-1-cmaiolino@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: rxSE3KR_NbijXUnHUzRhfg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi,

This series refactor the internal structure of FIBMAP so that the filesyste=
m can
properly report errors back to VFS, and also simplifies its usage by
standardizing all ->bmap() method usage via bmap() function.

The last patch is a bug fix for ioctl_fibmap() calls with negative block va=
lues.

This new version just includes small kbuild test robot warnings caused by
ommited parameter names, and remove changelogs from patches description, mo=
ving
them to this cover-letter.


Changelog:

V7:

=09- Rebased over linux-next
=09- Add parameters names to function declarations
=09  Reported-by: kbuild test robot <lkp@intel.com>
=09- Remove changelog entries from patches's commit logs

V6:

        - Add a dummy bmap() definition so build does not break if
          CONFIG_BLOCK is not set
          Reported-by: kbuild test robot <lkp@intel.com>

        - ASSERT only if filesystem does not support bmap() to
          match the original logic

=09- Fix bmap() doc function
=09  Reported-by: kbuild test robot <lkp@intel.com>

V5:

        - Rebasing against 5.3 required changes to the f2fs
          check_swap_activate() function

V4:

        - Ensure ioctl_fibmap() returns 0 in case of error returned from
          bmap(). Otherwise we'll be changing the user interface (which
          returns 0 in case of error)
V3:
        - Rename usr_blk to ur_block

V2:
        - Use a local sector_t variable to asign the block number
          instead of using direct casting.



Carlos Maiolino (5):
  fs: Enable bmap() function to properly return errors
  cachefiles: drop direct usage of ->bmap method.
  ecryptfs: drop direct calls to ->bmap
  fibmap: Use bmap instead of ->bmap method in ioctl_fibmap
  fibmap: Reject negative block numbers

 drivers/md/md-bitmap.c | 16 ++++++++++------
 fs/cachefiles/rdwr.c   | 27 ++++++++++++++-------------
 fs/ecryptfs/mmap.c     | 16 ++++++----------
 fs/f2fs/data.c         | 16 +++++++++++-----
 fs/inode.c             | 30 +++++++++++++++++-------------
 fs/ioctl.c             | 32 ++++++++++++++++++++++----------
 fs/jbd2/journal.c      | 22 +++++++++++++++-------
 include/linux/fs.h     |  9 ++++++++-
 mm/page_io.c           | 11 +++++++----
 9 files changed, 110 insertions(+), 69 deletions(-)

--=20
2.23.0

