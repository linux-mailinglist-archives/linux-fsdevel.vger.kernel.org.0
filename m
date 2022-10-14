Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9365FEAF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 10:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJNItr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 04:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJNItq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:49:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2151030;
        Fri, 14 Oct 2022 01:49:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n9so2680888wms.1;
        Fri, 14 Oct 2022 01:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wHqdtxQx6Lod0jir/zBNpgI20jHW/S0hFQeJ5vK6PO4=;
        b=N9gYQbXaDNOz60O1rGTwGAjGRkq26mCTJsSZ3Jl4CQJYVz6LnL3CEIbjWZXe/YyMjs
         gtwg7xQGLuu25bH8Bj/nCImI1XEQqMT17gdEQdSE8inJ9hRursDVOO4SFDpS+j7vXzDp
         l9Eyv8vq99kfP/PU6beqm5XC047H5YCmiZX7f2rYy+M+dj9XByokyFDl0TfAweEpLaMt
         jsdjn9arPU57YQ4xvGsoTMVznDmE3IQJMkoVxedNqoNcxAJztCc76He+bvHxvG0KegSr
         EpetSFUehs8I/SNoIWsmR5gk3XJ8CZ590VLkdE2nJzu7l5EBmxruFF9o54RIGIJrl3Di
         iLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHqdtxQx6Lod0jir/zBNpgI20jHW/S0hFQeJ5vK6PO4=;
        b=W3fpSPGEFQ8ry3+Tfxj4LVoNRrTQEYV0GZkJicS/EeTpxWl6AQqdAgdA+PeUIkCliy
         NrzeIN0F2sxIeaoeC0HSsrn5xuuHLYXBk9gc72qB+2puevrMo09ljWAd4vXsb78YCWTH
         MWdjztoPIHn0OUL7EDW+tBbAoFtm0DGDErfVP2M68N8PbhUpNaCto6BDC0S/0pZOrQQV
         qFSOA1KfCLX146xsVC2IxeDrgAqY2qLS5m7PpWo/ignHJXJU8DkRuBltkMcDHQZ4pHZX
         LCuRwSpSnzX7JN18TtD5/5hWkWU2svYzoPueu1+JGgqqwCsssH4kKZtRZoy+ZPeCOMUf
         AKcQ==
X-Gm-Message-State: ACrzQf3CVxwf0iM0sZhNDBWoTOIY8d1Ejv/J8nn9w4MgfIsfbVeLaqc/
        OWYqjMKxo/wKwcEH6XZQJ8EnjEbopwXEA+b2Kr8=
X-Google-Smtp-Source: AMsMyM6mWW8W5+zs3haCkV7ucZ6ZM2NWaZWE4PI1Pq5xhk7qS5b4ull48XoOSMyebfkTABFFU7lq3A==
X-Received: by 2002:a05:600c:19c9:b0:3c2:7fff:a689 with SMTP id u9-20020a05600c19c900b003c27fffa689mr9647430wmq.85.1665737380822;
        Fri, 14 Oct 2022 01:49:40 -0700 (PDT)
Received: from hrutvik.c.googlers.com.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm1547372wmz.34.2022.10.14.01.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:49:40 -0700 (PDT)
From:   Hrutvik Kanabar <hrkanabar@gmail.com>
To:     Hrutvik Kanabar <hrutvik@google.com>
Cc:     Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH RFC 0/7] fs: Debug config option to disable filesystem checksum verification for fuzzing
Date:   Fri, 14 Oct 2022 08:48:30 +0000
Message-Id: <20221014084837.1787196-1-hrkanabar@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hrutvik Kanabar <hrutvik@google.com>

Fuzzing is a proven technique to discover exploitable bugs in the Linux
kernel. But fuzzing filesystems is tricky: highly structured disk images
use redundant checksums to verify data integrity. Therefore,
randomly-mutated images are quickly rejected as corrupt, testing only
error-handling code effectively.

The Janus [1] and Hydra [2] projects probe filesystem code deeply by
correcting checksums after mutation. But their ad-hoc
checksum-correcting code supports only a few filesystems, and it is
difficult to support new ones - requiring significant duplication of
filesystem logic which must also be kept in sync with upstream changes.
Corrected checksums cannot be guaranteed to be valid, and reusing this
code across different fuzzing frameworks is non-trivial.

Instead, this RFC suggests a config option:
`DISABLE_FS_CSUM_VERIFICATION`. When it is enabled, all filesystems
should bypass redundant checksum verification, proceeding as if
checksums are valid. Setting of checksums should be unaffected. Mutated
images will no longer be rejected due to invalid checksums, allowing
testing of deeper code paths. Though some filesystems implement their
own flags to disable some checksums, this option should instead disable
all checksums for all filesystems uniformly. Critically, any bugs found
remain reproducible on production systems: redundant checksums in
mutated images can be fixed up to satisfy verification.

The patches below suggest a potential implementation for a few
filesystems, though we may have missed some checksums. The option
requires `DEBUG_KERNEL` and is not intended for production systems.

The first user of the option would be syzbot. We ran preliminary local
syzkaller tests to compare behaviour with and without these patches.
With the patches, we found a 19% increase in coverage, as well as many
new crash types and increases in the total number of crashes:

Filesystem | % new crash types | % increase in crashes
—----------|-------------------|----------------------
  ext4     |        60%        |         1400%
  btrfs    |        25%        |         185%
  f2fs     |        63%        |         16%


[1] Fuzzing file systems via two-dimensional input space exploration,
    Xu et al., 2019, IEEE Symposium on Security and Privacy,
    doi: 10.1109/SP.2019.00035
[2] Finding semantic bugs in file systems with an extensible fuzzing
    framework, Kim et al., 2019, ACM Symposium on Operating Systems
    Principles, doi: 10.1145/3341301.3359662


Hrutvik Kanabar (7):
  fs: create `DISABLE_FS_CSUM_VERIFICATION` config option
  fs/ext4: support `DISABLE_FS_CSUM_VERIFICATION` config option
  fs/btrfs: support `DISABLE_FS_CSUM_VERIFICATION` config option
  fs/exfat: support `DISABLE_FS_CSUM_VERIFICATION` config option
  fs/xfs: support `DISABLE_FS_CSUM_VERIFICATION` config option
  fs/ntfs: support `DISABLE_FS_CSUM_VERIFICATION` config option
  fs/f2fs: support `DISABLE_FS_CSUM_VERIFICATION` config option

 fs/Kconfig.debug            | 20 ++++++++++++++++++++
 fs/btrfs/check-integrity.c  |  3 ++-
 fs/btrfs/disk-io.c          |  6 ++++--
 fs/btrfs/free-space-cache.c |  3 ++-
 fs/btrfs/inode.c            |  3 ++-
 fs/btrfs/scrub.c            |  9 ++++++---
 fs/exfat/nls.c              |  3 ++-
 fs/exfat/super.c            |  3 +++
 fs/ext4/bitmap.c            |  6 ++++--
 fs/ext4/extents.c           |  3 ++-
 fs/ext4/inode.c             |  3 ++-
 fs/ext4/ioctl.c             |  3 ++-
 fs/ext4/mmp.c               |  3 ++-
 fs/ext4/namei.c             |  6 ++++--
 fs/ext4/orphan.c            |  3 ++-
 fs/ext4/super.c             |  6 ++++--
 fs/ext4/xattr.c             |  3 ++-
 fs/f2fs/checkpoint.c        |  3 ++-
 fs/f2fs/compress.c          |  3 ++-
 fs/f2fs/f2fs.h              |  2 ++
 fs/f2fs/inode.c             |  3 +++
 fs/ntfs/super.c             |  3 ++-
 fs/xfs/libxfs/xfs_cksum.h   |  5 ++++-
 lib/Kconfig.debug           |  6 ++++++
 24 files changed, 86 insertions(+), 25 deletions(-)
 create mode 100644 fs/Kconfig.debug

-- 
2.38.0.413.g74048e4d9e-goog

