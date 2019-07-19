Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA56D78A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 02:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfGSADa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 20:03:30 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:40981 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfGSAD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:03:29 -0400
Received: by mail-qt1-f201.google.com with SMTP id e39so25887000qte.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 17:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9DEv8u8NV9GsQdpVG3YSkd6Fwchyp0Tmy7aGf7fvO/A=;
        b=jlECP3AShHax5jtmkNgXohpyfl7vU5w7VHrgYsRWrEm2m4hlw/rYhIrWcKnQsgM/dy
         OZKUI6y+AIE/8YlhSPji2idKxN0l15EnM8rzrdMLZV0TLJnOlEsSZXi2fPES3upK7XOP
         P6Fu8zpLaXcgEM3opBWpKQlDf9WiVxWgEuUtKWlVO+u6rMYKgmPr9aRAZf59izPvrH50
         P2eNvCymoJmAshBV+K5iW9R/VnFb0MSoMnaF9QL2N6ZCJF1ZEOrMKEF0NoPv34W3YyUn
         QvkwFcFGXXB2EJ8HkYnTFjdiARmGNnuoUjeWQCsOvq9hLKU7Q6n//i3scNYe1DmFLOqQ
         8r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9DEv8u8NV9GsQdpVG3YSkd6Fwchyp0Tmy7aGf7fvO/A=;
        b=WIKIXFlMVNktdOgi/UEuZSVD3WB0QgqcLzjiDAFLWlA1IUvgHCp/sDjFpvNsHMxugb
         /SwRDY4KRX2U6a5KXmbaAAMZkIiOwNMQx98TvWx5w8bjNeq5y1/3SEAqfgG7QS9RcblI
         ury2D7s7Hl9+lbtvy5xg8Ue+1BJ8LgAjvhkSJo8nZzlc96p4BeHuimJYa9nTlSix5+dg
         FQ/PRzSaPT3EJ94NoK40CXczQpkfL1po8iVyFWnQunE5P34cG+y4gJJIoRU/iOQPGboF
         sB+rN+yxBD6yhnXgMw6XniVia/nhANOFrNiQ3w745Su+BZk/TKJYBO4iyUfZNjSW/4Xh
         zq4g==
X-Gm-Message-State: APjAAAW5y8n3ELnrIi7O+1RuF27mVjwzML7WxMOVU+lGsZmV0Zs180HQ
        82qz/2Afa6adPk16JjpUnsRLKu6Di9o=
X-Google-Smtp-Source: APXvYqwRtX2YZ4Wg80vezuYYq+k1K3TfOAWAb15xfWjTiHcPsAy8V60Fafp8iP5EMk8uQaIB6Ld5vnGMWuw=
X-Received: by 2002:ac8:2642:: with SMTP id v2mr32821422qtv.333.1563494608664;
 Thu, 18 Jul 2019 17:03:28 -0700 (PDT)
Date:   Thu, 18 Jul 2019 17:03:20 -0700
Message-Id: <20190719000322.106163-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v3 0/2] Casefolding in F2FS
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches are largely based on the casefolding patches for ext4

v3: Addressed feedback, apart from F2FS_CASEFOLD_FL/FS_CASEFOLD_FL
    Added sysfs file "encoding" to see the encoding set on a filesystem
v2: Rebased patches again master, changed f2fs_msg to f2fs_info/f2fs_err

Daniel Rosenberg (2):
  f2fs: include charset encoding information in the superblock
  f2fs: Support case-insensitive file name lookups

 fs/f2fs/dir.c           | 126 ++++++++++++++++++++++++++++++++++++----
 fs/f2fs/f2fs.h          |  21 ++++++-
 fs/f2fs/file.c          |   9 +++
 fs/f2fs/hash.c          |  35 ++++++++++-
 fs/f2fs/inline.c        |   4 +-
 fs/f2fs/inode.c         |   4 +-
 fs/f2fs/namei.c         |  21 +++++++
 fs/f2fs/super.c         | 100 +++++++++++++++++++++++++++++++
 fs/f2fs/sysfs.c         |  23 ++++++++
 include/linux/f2fs_fs.h |   9 ++-
 10 files changed, 334 insertions(+), 18 deletions(-)

-- 
2.22.0.657.g960e92d24f-goog

