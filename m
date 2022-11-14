Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89019627582
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 06:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbiKNFVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 00:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiKNFVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 00:21:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D25E1659D
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Nov 2022 21:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668403176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tPCih+fFucBD04N2ze9Ac2gJMHrR+hhC//UJa4VjJH8=;
        b=MC+kCMEjv5bsibivImjcGJz2K+aN00uBjccgOH2q2/OWIH3onZOa43MtSWgeaNe4AhydPq
        hCiYHC3Wg0nv8uiefkRxVfTFT96r4eVdpG5zybpxq2pQGKAbTGos124mwedy4Bb4LHv7Vy
        a7Z0mUB87OsLDMkZ2JANuMMn+L/LnZI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-Uoc03cbuNqyzvNpwhJSkZQ-1; Mon, 14 Nov 2022 00:19:23 -0500
X-MC-Unique: Uoc03cbuNqyzvNpwhJSkZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19443833A0E;
        Mon, 14 Nov 2022 05:19:23 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 786FC2024CC5;
        Mon, 14 Nov 2022 05:19:19 +0000 (UTC)
From:   xiubli@redhat.com
To:     ceph-devel@vger.kernel.org, jlayton@kernel.org, idryomov@gmail.com,
        viro@zeniv.linux.org.uk
Cc:     lhenriques@suse.de, mchangir@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 0/2 v2] ceph: fix the use-after-free bug for file_lock
Date:   Mon, 14 Nov 2022 13:18:59 +0800
Message-Id: <20221114051901.15371-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Changed in V2:
- switch to file_lock.fl_u to fix the race bug
- and the most code will be in the ceph layer

Xiubo Li (2):
  ceph: add ceph_lock_info support for file_lock
  ceph: use a xarray to record all the opened files for each inode

 fs/ceph/file.c                  |  9 +++++++++
 fs/ceph/inode.c                 |  4 ++++
 fs/ceph/locks.c                 | 35 +++++++++++++++++++++++++++++----
 fs/ceph/super.h                 |  4 ++++
 include/linux/ceph/ceph_fs_fl.h | 26 ++++++++++++++++++++++++
 include/linux/fs.h              |  2 ++
 6 files changed, 76 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/ceph/ceph_fs_fl.h

-- 
2.31.1

