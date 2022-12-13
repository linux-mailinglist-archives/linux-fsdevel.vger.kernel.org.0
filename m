Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDD564BB02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 18:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbiLMRam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 12:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbiLMRa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:30:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A6023153
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670952581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lVr9+aR/wvYloM4gTfWoNAl50pqF1s4+AyNKgrJPMhA=;
        b=KFg7p851ho8PglnSfPJ7rpbcCXr9FXfRRbisicUEzQRu0yW1ltNPfw9e1PiEYmral/HV4A
        ZqpiePeZrQxRiSk4xQvpL46tWYmkP2qakLHQm0tCz45U9AalNKc4FpP0IMRmMmDMmHG8s/
        TtsPyOv6wsGHOYk4cUUBKSzP95RizI4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-418-qp6lR42NO_i_qUnrXNK_KQ-1; Tue, 13 Dec 2022 12:29:40 -0500
X-MC-Unique: qp6lR42NO_i_qUnrXNK_KQ-1
Received: by mail-ed1-f72.google.com with SMTP id j11-20020aa7c40b000000b0046b45e2ff83so7673341edq.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVr9+aR/wvYloM4gTfWoNAl50pqF1s4+AyNKgrJPMhA=;
        b=8GwKNshLIZVI2OCl7K6QB7pWFHCC9hhkWH4+ok8yMvQQUnopghhvvE7Hb7jhWv3P6U
         LjiQYSqJBp185dKlfvOm0syDsiG6TrUbGITP+LuMH3zDUm2RU0i8HaH80IGjUMIitsA0
         PtFd43MIXf2oieEkXIxGoPs2dxpq4Ap62g41lSNzNDNh/WGqhIA2QeVUZg+RD/PqTmHN
         4XrIQTMK3VFCeqftDJ0+ZfJCAhnyxCd8S6F4lAsLa97g7wHkDlxfxybUHkulx46gi64f
         Asj/r8OH6q0xKBIAPC375iDFKvG7dS2HBxWt5ARtUlhQuTKSXa74WQf1HGSE2BJvZm45
         kj+g==
X-Gm-Message-State: ANoB5pmpleM0K8jmGIxWW+Nx62Xeqx/yvt0mhu/I6pD/VY4nDNBfJP12
        9tn/ELBsErW1+mo49khMBZuaGXHKNBV1Y5Q5ivRzS3CZzZOCbiVwRQGYF4bYWgUJO6Y8QeL8TNL
        7U4IBS7ki0SYMF3j4VJRyWPTa
X-Received: by 2002:a05:6402:1a36:b0:46d:b89a:de1e with SMTP id be22-20020a0564021a3600b0046db89ade1emr19314083edb.1.1670952578903;
        Tue, 13 Dec 2022 09:29:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6s1TsxnWc12yy+hI0iDujZQBCEUUCldUqlE+/gAjNXiqJyG6PRfql5MTIcYS32VARxI/DZGw==
X-Received: by 2002:a05:6402:1a36:b0:46d:b89a:de1e with SMTP id be22-20020a0564021a3600b0046db89ade1emr19314070edb.1.1670952578736;
        Tue, 13 Dec 2022 09:29:38 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ec14-20020a0564020d4e00b0047025bf942bsm1204187edb.16.2022.12.13.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:29:38 -0800 (PST)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [RFC PATCH 00/11] fs-verity support for XFS
Date:   Tue, 13 Dec 2022 18:29:24 +0100
Message-Id: <20221213172935.680971-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This patchset introduces fs-verity [5] support for XFS. This
implementation utilizes extended attributes to store fs-verity
metadata in comparison to ext4/f2fs which store that after EOF. The
pages are stored in the remote extended attributes.

A few starting points:
- The xattr name of a each Merkle tree page is binary
- fs-verity doesn't work with multi-page folios yet. Thus, those are
  disabled when fs-verity is enabled on inode.
- Direct path and DAX are disabled for inodes with fs-verity
- Pages are verified in iomap's read IO path (offloaded with
  workqueue)
- New ro-compat flag is added as inodes with fs-verity have new
  on-disk diflag

Not yet implemented:
- No pre-fetching of Merkle tree pages in the
  read_merkle_tree_page()
- No marking of already verified Merkle tree pages (each read, the
  whole tree is verified).

Preliminary testing:
- fstests 1k, 4k
- More in-depth testing is on the way :)

This patchset depends on Allison's Parent Pointer patchset [1],
which introduces binary names for extended attributes. Particularly,
patch "[PATCH v6 13/27] xfs: Add xfs_verify_pptr" [3] is needed.

The first patch moves setting of large folio support flag to more
appropriate location - xfs_setup_inode(), where other flags are set.
The second one adds wrapper which would be used when already
existing inode is sealed with fs-verity. The rest adds fs-verity
support.

Allison's Parent Pointer patchset v6:
[1]: https://lore.kernel.org/linux-xfs/20221129211242.2689855-1-allison.henderson@oracle.com/

Allison's Parent Pointer branch:
[2]: https://github.com/allisonhenderson/xfs/tree/xfs_new_pptrsv6

Patch which adds handling of xattr binary names:
[3]: https://lore.kernel.org/linux-xfs/20221129211242.2689855-14-allison.henderson@oracle.com/

This patchset branch:
[4]: https://github.com/alberand/linux/tree/xfs-verity

fs-verity docs:
[5]: https://www.kernel.org/doc/html/latest/filesystems/fsverity.html

I'm looking forward for your comments.

Thanks!
Andrey

Andrey Albershteyn (11):
  xfs: enable large folios in xfs_setup_inode()
  pagemap: add mapping_clear_large_folios() wrapper
  xfs: add attribute type for fs-verity
  xfs: add fs-verity ro-compat flag
  xfs: add inode on-disk VERITY flag
  xfs: initialize fs-verity on file open and cleanup on inode
    destruction
  xfs: disable direct read path for fs-verity sealed files
  xfs: don't enable large folios on fs-verity sealed inode
  iomap: fs-verity verification on page read
  xfs: add fs-verity support
  xfs: add fs-verity ioctls

 fs/iomap/buffered-io.c         |  80 ++++++++++++-
 fs/xfs/Makefile                |   1 +
 fs/xfs/libxfs/xfs_attr.c       |   8 ++
 fs/xfs/libxfs/xfs_da_format.h  |   5 +-
 fs/xfs/libxfs/xfs_format.h     |  14 ++-
 fs/xfs/libxfs/xfs_log_format.h |   1 +
 fs/xfs/libxfs/xfs_sb.c         |   2 +
 fs/xfs/xfs_file.c              |  22 +++-
 fs/xfs/xfs_icache.c            |   2 -
 fs/xfs/xfs_inode.c             |   2 +
 fs/xfs/xfs_inode.h             |   1 +
 fs/xfs/xfs_ioctl.c             |  11 ++
 fs/xfs/xfs_iops.c              |   9 ++
 fs/xfs/xfs_mount.h             |   2 +
 fs/xfs/xfs_super.c             |  12 ++
 fs/xfs/xfs_trace.h             |   1 +
 fs/xfs/xfs_verity.c            | 203 +++++++++++++++++++++++++++++++++
 fs/xfs/xfs_verity.h            |  19 +++
 fs/xfs/xfs_xattr.c             |   3 +
 include/linux/iomap.h          |   5 +
 include/linux/pagemap.h        |   5 +
 21 files changed, 393 insertions(+), 15 deletions(-)
 create mode 100644 fs/xfs/xfs_verity.c
 create mode 100644 fs/xfs/xfs_verity.h

-- 
2.31.1

