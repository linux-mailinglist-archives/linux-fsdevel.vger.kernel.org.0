Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2645BCE17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 16:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiISOKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 10:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiISOKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242F331DD4
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663596636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MOFU5XiP06s3IZqwV2aVep2rxPWejIYhUJW/qsO1WRc=;
        b=MQtCIyMTmVlfpgRQgQIZDHunSdzCSo1q/1f5fWf6clA7LYJ9sP5OgF7/WLLpZFbyPQZ96Q
        6k1Dg5HfZSW3hPcATITYox6Kk2EczMmciX8KPqkexCHDynBNXnbCHsgLJKLY1PIaqAyzhU
        B4hSaNcvltUsR56oyV0J1kGNV28/oHM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-125-CV5WF8vtPkC46RkwutpnNQ-1; Mon, 19 Sep 2022 10:10:35 -0400
X-MC-Unique: CV5WF8vtPkC46RkwutpnNQ-1
Received: by mail-ed1-f69.google.com with SMTP id z13-20020a05640240cd00b0045276a79364so12757538edb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=MOFU5XiP06s3IZqwV2aVep2rxPWejIYhUJW/qsO1WRc=;
        b=TqkYA4mL+0IlkrHpCfpPLK1NM6Mhy0z41FggjBYpnw3UAYVjA5a5nuS1n3YQ4hUREN
         6HY8OSAsvlSnzYc7CXvTSIk9D7MwD7yngvIgdU/815pTN/XNp4HEW51laK3DHsow639f
         XKl/iyRRbSG1SGyjPPh0bGZUXMdcl1GRhdQpJ23LEKMY0pSWih6R4qn9/Dgs6Bg9FvWf
         Db6G1A/9pFzY7IOipEIOc/pXWOUMF1hGMvxauKVByxkjy3g8UBi2Hf0/fJe8clwqrFdC
         YlN8exkNOTNSDSk6u/xmlrgHWdbIvdAlOVHLXs3dLBv8aP+u1zPGpZ8Tyn/8cIBtx9RH
         1zdw==
X-Gm-Message-State: ACrzQf0s/Xipph/kiLnQC1cHpy/qcaR9D4QFB8ZFFYdvLi9LRPiifXUV
        syPrp68ER5IVR96gabepLVvJR5TG1tHRGdebE6yigM6Xn4f/ivDwh4hVVkBPzgvHsylP/ImBCkF
        XaD+gWeKNPFS7qLbkVCTUFH6GMji9wO8yle5bVjZMIfg0xDcTFBp2xZul+UvOEJYFaIsimkPErO
        Jl/A==
X-Received: by 2002:a17:906:8448:b0:77b:e6d0:58a5 with SMTP id e8-20020a170906844800b0077be6d058a5mr13488605ejy.347.1663596633880;
        Mon, 19 Sep 2022 07:10:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6KgMuyo+4zXWjRsT+rWu9TGII9B/J7uqs1xY5jAEbUpBoX2H6ctjVSQFvvdotEm+/ONiVYvQ==
X-Received: by 2002:a17:906:8448:b0:77b:e6d0:58a5 with SMTP id e8-20020a170906844800b0077be6d058a5mr13488584ejy.347.1663596633560;
        Mon, 19 Sep 2022 07:10:33 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id lb22-20020a170907785600b0073bdf71995dsm9849951ejc.139.2022.09.19.07.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:10:32 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v2 0/8] fuse tmpfile
Date:   Mon, 19 Sep 2022 16:10:23 +0200
Message-Id: <20220919141031.1834447-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al,

Would you mind taking this?

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#fuse-tmpfile

Thanks,
Miklos

V2:
 - rename finish_tmpfile() to finish_open_simple()
 - fix warning reported by kernel test robot
 - patch description improvements

---
Miklos Szeredi (8):
  cachefiles: tmpfile error handling cleanup
  vfs: add tmpfile_open() helper
  cachefiles: use tmpfile_open() helper
  ovl: use tmpfile_open() helper
  vfs: make vfs_tmpfile() static
  vfs: move open right after ->tmpfile()
  vfs: open inside ->tmpfile()
  fuse: implement ->tmpfile()

 fs/bad_inode.c            |  2 +-
 fs/btrfs/inode.c          |  8 ++---
 fs/cachefiles/namei.c     | 67 ++++++++++++++++--------------------
 fs/dcache.c               |  4 ++-
 fs/ext2/namei.c           |  6 ++--
 fs/ext4/namei.c           |  6 ++--
 fs/f2fs/namei.c           | 13 ++++---
 fs/fuse/dir.c             | 25 ++++++++++++--
 fs/fuse/fuse_i.h          |  3 ++
 fs/hugetlbfs/inode.c      | 12 ++++---
 fs/minix/namei.c          |  6 ++--
 fs/namei.c                | 72 +++++++++++++++++++++++++++------------
 fs/overlayfs/copy_up.c    | 49 ++++++++++++++------------
 fs/overlayfs/overlayfs.h  | 12 ++++---
 fs/overlayfs/super.c      | 10 +++---
 fs/ramfs/inode.c          |  6 ++--
 fs/ubifs/dir.c            |  7 ++--
 fs/udf/namei.c            |  6 ++--
 fs/xfs/xfs_iops.c         | 16 +++++----
 include/linux/dcache.h    |  3 +-
 include/linux/fs.h        | 16 +++++++--
 include/uapi/linux/fuse.h |  6 +++-
 mm/shmem.c                |  6 ++--
 23 files changed, 219 insertions(+), 142 deletions(-)

-- 
2.37.3

