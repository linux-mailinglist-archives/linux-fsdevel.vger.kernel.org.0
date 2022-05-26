Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288295347F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 03:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbiEZBRr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 21:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiEZBRq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 21:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A029756FA4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653527864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=shU6WzRQpPf5gAk4uCzvRKM5GnewWBPswEj4m9OAYWs=;
        b=OPKKpP+IfBiUiKdeKxnkjeHyVnQT/E19RyuQiUQ4BsclmBpYE02IssbAV79/FoBtKRiuhm
        ZCnM+MGyxR+MLs9EGLFRI75jD8A74tC8jzOpQ1+kl2+wCMFIJ8axMcRKPhSpnP6JTg1flg
        dInHHGT6h+WHx8+WiH8x3UJnPk/+ifY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-jTzwy-XBN1--queD2yul1A-1; Wed, 25 May 2022 21:17:41 -0400
X-MC-Unique: jTzwy-XBN1--queD2yul1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BCA438041CB;
        Thu, 26 May 2022 01:17:40 +0000 (UTC)
Received: from localhost (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E33AC2166B26;
        Thu, 26 May 2022 01:17:39 +0000 (UTC)
From:   Xiubo Li <xiubli@redhat.com>
To:     jlayton@kernel.org, idryomov@gmail.com, viro@zeniv.linux.org.uk
Cc:     willy@infradead.org, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, arnd@arndb.de, mcgrof@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v6 0/2] ceph: wait async unlink to finish
Date:   Thu, 26 May 2022 09:17:35 +0800
Message-Id: <20220526011737.371483-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

V6:
- Remove the new d_compare() helper and export the d_same_name() instead
- Currently will use the EXPORT_SYMBOL_GPL instead.

V5:
- Fix the order of clearing the flag and hashtable

V4:
- Switch to use TASK_KILLABLE

V3:
- Removed WARN_ON_ONCE()/BUG_ON().
- Set the hashtable bit to 8.

V2:
- Add one dedicated spin lock to protect the list_add/del_rcu
- Other small fixes
- Fix the compile error from kernel test robot

Xiubo Li (2):
  fs/dcache: export d_same_name() helper
  ceph: wait the first reply of inflight async unlink

 fs/ceph/dir.c          | 79 +++++++++++++++++++++++++++++++++++++-----
 fs/ceph/file.c         |  6 +++-
 fs/ceph/mds_client.c   | 75 ++++++++++++++++++++++++++++++++++++++-
 fs/ceph/mds_client.h   |  1 +
 fs/ceph/super.c        |  3 ++
 fs/ceph/super.h        | 19 +++++++---
 fs/dcache.c            | 15 +++++---
 include/linux/dcache.h |  2 ++
 8 files changed, 180 insertions(+), 20 deletions(-)

-- 
2.36.0.rc1

