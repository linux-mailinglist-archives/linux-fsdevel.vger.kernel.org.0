Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9FF52A231
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 14:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346750AbiEQM5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 08:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346753AbiEQM4Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 08:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E1DC3C70B
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 05:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652792183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Ilh7SutzGqct7DoxMOyniVDVZYj7Cp6A98zhpaDZQg=;
        b=FLUZcGXcGKaUlrSr/SlIw7nkVpDtXxrTV4sSIW1C7N/StomIUKuaYzq+4DLzy8K4m+hJhR
        eyW/5CALM9QQVk3KguzfVkbXM9d5Le5YGje5bGvU5eknFxo0Jpjho+vBAK3uG9XAdGMTY+
        BbldUXAkz4xxqtVjPLk/LEA4Ft4MRGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-pWz1Aj3EN-CYaJxZ5D94jQ-1; Tue, 17 May 2022 08:56:19 -0400
X-MC-Unique: pWz1Aj3EN-CYaJxZ5D94jQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DEB78015BA;
        Tue, 17 May 2022 12:56:18 +0000 (UTC)
Received: from localhost (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB0762166B2F;
        Tue, 17 May 2022 12:56:09 +0000 (UTC)
From:   Xiubo Li <xiubli@redhat.com>
To:     jlayton@kernel.org, viro@zeniv.linux.org.uk
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, dchinner@redhat.com, hch@lst.de,
        arnd@arndb.de, mcgrof@kernel.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v3 0/2] ceph: wait async unlink to finish
Date:   Tue, 17 May 2022 20:55:47 +0800
Message-Id: <20220517125549.148429-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

V3:
- Removed WARN_ON_ONCE()/BUG_ON().
- Set the hashtable bit to 8.

V2:
- Add one dedicated spin lock to protect the list_add/del_rcu
- Other small fixes
- Fix the compile error from kernel test robot


Xiubo Li (2):
  fs/dcache: add d_compare() helper support
  ceph: wait the first reply of inflight async unlink

 fs/ceph/dir.c          | 70 +++++++++++++++++++++++++++++++++++++---
 fs/ceph/file.c         |  4 +++
 fs/ceph/mds_client.c   | 73 ++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h   |  1 +
 fs/ceph/super.c        |  3 ++
 fs/ceph/super.h        | 19 ++++++++---
 fs/dcache.c            | 15 +++++++++
 include/linux/dcache.h |  2 ++
 8 files changed, 177 insertions(+), 10 deletions(-)

-- 
2.36.0.rc1

