Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C270E135A21
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 14:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgAINax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 08:30:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52428 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgAINax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578576652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MxGMOwgT3yJZu7/1A51U3iQBjvF5YZvUY4XPIgZ/7Ac=;
        b=bySd0im4Vetp/NJZgwjaFsIRjhA1r/4eM4FIbjoiQZGc7MvnfUlPC6B7w0qERFtGvFkL6G
        P576iRR87W4vYhWxXB2FhJMrsF1DI0cEm1h5d1y4LNw4RHwjJznI79Z7O3MJBbgebX8ZNg
        um4aIWMTp4wfCP5yKhPxvuJhTIX8yz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-_EZJP71rNPyj9ba4EeZCqA-1; Thu, 09 Jan 2020 08:30:50 -0500
X-MC-Unique: _EZJP71rNPyj9ba4EeZCqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 441651005512;
        Thu,  9 Jan 2020 13:30:49 +0000 (UTC)
Received: from orion.redhat.com (ovpn-205-210.brq.redhat.com [10.40.205.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03CC160CD3;
        Thu,  9 Jan 2020 13:30:47 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk
Subject: [PATCH V8 0/5] Refactor ioctl_fibmap() internal interface
Date:   Thu,  9 Jan 2020 14:30:40 +0100
Message-Id: <20200109133045.382356-1-cmaiolino@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This series refactor the internal structure of FIBMAP so that the filesys=
tem can
properly report errors back to VFS, and also simplifies its usage by
standardizing all ->bmap() method usage via bmap() function.

The last patch is a bug fix for ioctl_fibmap() calls with negative block =
values.


Viro spotted a mistake in patch 4/5 on the previous version, where bmap()
return value was not being propagated back to userland, breaking its ABI.

So, this new version, only has a change on patch 4/5 to fix this problem.


Changelog:

V8:
	- Rebased over linux-next
	- Fix an error in patch 4/5, which led to the wrong value being
	  returned by ioctl_fibmap()
V7:

        - Rebased over linux-next
        - Add parameters names to function declarations
          Reported-by: kbuild test robot <lkp@intel.com>
        - Remove changelog entries from patches's commit logs

V6:

        - Add a dummy bmap() definition so build does not break if
          CONFIG_BLOCK is not set
          Reported-by: kbuild test robot <lkp@intel.com>

        - ASSERT only if filesystem does not support bmap() to
          match the original logic

        - Fix bmap() doc function
          Reported-by: kbuild test robot <lkp@intel.com>

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
 fs/ioctl.c             | 33 +++++++++++++++++++++++----------
 fs/jbd2/journal.c      | 22 +++++++++++++++-------
 include/linux/fs.h     |  9 ++++++++-
 mm/page_io.c           | 11 +++++++----
 9 files changed, 111 insertions(+), 69 deletions(-)

--=20
2.23.0

