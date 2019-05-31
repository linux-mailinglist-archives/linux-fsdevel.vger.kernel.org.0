Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A75312BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 18:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfEaQrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 12:47:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33894 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfEaQrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 12:47:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so289813wmd.1;
        Fri, 31 May 2019 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MhsubWC4mV416H7ev/f+wsOGbdjmqcgClTA9LQel2KA=;
        b=Qja3g2NCZ8pzXs4nnsjUMAmzJ/b2jGOjx5X9orj2Imviax6qoh16l16QajqHedjgfm
         Od7lQejJVo0S8pQrkGp3WPAw255HfVqTbJ6nWPK2Gwcmv0OGE9Lj22qO3avbr9ewX1Aa
         8CgWJp1DCvxaXiJ6cHNJNAs3OPkL0o6m9VrwUSRlWACKzwewAVMs3Z2k6PafMDSPZ5IN
         CH2i7FU+/l6FDh8wBhWuzW2TSRBh+MVyxy8YQbC2pTbGsOhZXg/KtSL6HhTqtEwRAOwF
         GZSoJHNMUxxrMmJXreiboAfz5dflLQjlLhJQZqd8a0JSFgjILXzCsRv5/4UvxFhhDds5
         tVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MhsubWC4mV416H7ev/f+wsOGbdjmqcgClTA9LQel2KA=;
        b=jv8KtmyqCNqp30o8CFFy9hsYklD+I3MQ75KnaltU/GTZmJiX2ij9XbhO6tY1xWyIMN
         Ct8Qi6iTfMMht1OaBqw0qvl2PU6b5MnQRUY8AcoXZtot6PXCOczvfSH522/Oyc+Sbe1s
         IKgji7q8x7MsFJu/crUcJpasJyHFGQVg50JuqASvOLwzIZjcU+6sgHX7ayov8YKygFj8
         /0TcK468WmPz1ADTCfW94zB9aOY0NolLyHd06YyynnbaWsvrBJvLVOG6xDLxQa3lCTbF
         YvkaLMn4xw8j6mMM6sCNjuFLF7J7Cv2L8qnSMqFjl69aqL1W5j3cMwTakomFsucQcWVI
         +qJw==
X-Gm-Message-State: APjAAAUiZ8RJMwjaBLAw988s5n4qpBOrg7Sdv+156Z3YC5RHzS5ddN+e
        kk2NEBBHIztSYH9cIa7NhkP7bY1I
X-Google-Smtp-Source: APXvYqwrWKUHoyIiO6IqzhrXGZ//z2DcvLEE8mmWl2p3KUw9joXPaNuumflzmpwwksiAVuWEwF1a3w==
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr6265197wmc.45.1559321228837;
        Fri, 31 May 2019 09:47:08 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id n5sm7669593wrj.27.2019.05.31.09.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:47:08 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v4 0/9] Fixes for major copy_file_range() issues
Date:   Fri, 31 May 2019 19:46:52 +0300
Message-Id: <20190531164701.15112-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

Following is a re-work of Dave Chinner's copy_file_range() patches.
This v4 patch set includes review tags and excludes the individual
filesystem fixes that are not related to cross-device copy.
Those patches will be sent to maintainers seperately once the
dependency patch is made available on a public branch.

I did include the FUSE patch in this posting since we got an ACK
from Miklos. You may take it or leave it.

Thanks,
Amir.

Changes since v3:
- Drop per filesystem patch for file_modified()/file_accessed()
- Fix wrong likely()
- Add Reviewed-by tags

Changes since v2:
- Re-order generic_remap_checks() fix patch before
  forking generic_copy_file_checks()
- Document @req_count helper argument (Darrick)
- Fold generic_access_check_limits() (Darrick)
- Added file_modified() helper (Darrick)
- Added xfs patch to use file_modified() helper
- Drop generic_copy_file_range_prep() helper
- Per filesystem patch for file_modified()/file_accessed()
- Post copy file_remove_privs() for ceph/generic (Darrick)

Changes since v1:
- Short read instead of EINVAL (Christoph)
- generic_file_rw_checks() helper (Darrick)
- generic_copy_file_range_prep() helper (Christoph)
- Not calling ->remap_file_range() with different sb
- Not calling ->copy_file_range() with different fs type
- Remove changes to overlayfs
- Extra fix to clone/dedupe checks

Amir Goldstein (7):
  vfs: introduce generic_file_rw_checks()
  vfs: remove redundant checks from generic_remap_checks()
  vfs: add missing checks to copy_file_range
  vfs: introduce file_modified() helper
  xfs: use file_modified() helper
  vfs: allow copy_file_range to copy across devices
  fuse: copy_file_range needs to strip setuid bits and update timestamps

Dave Chinner (2):
  vfs: introduce generic_copy_file_range()
  vfs: no fallback for ->copy_file_range

 fs/ceph/file.c     |  23 +++++++--
 fs/cifs/cifsfs.c   |   4 ++
 fs/fuse/file.c     |  29 +++++++++--
 fs/inode.c         |  20 +++++++
 fs/nfs/nfs4file.c  |  23 +++++++--
 fs/read_write.c    | 126 +++++++++++++++++++++++++--------------------
 fs/xfs/xfs_file.c  |  15 +-----
 include/linux/fs.h |   9 ++++
 mm/filemap.c       | 110 +++++++++++++++++++++++++++++++--------
 9 files changed, 259 insertions(+), 100 deletions(-)

-- 
2.17.1

