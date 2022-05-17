Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D82D529677
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 03:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbiEQBDh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 21:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240605AbiEQBDc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 21:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1D744666C
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 18:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652749403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lE/6arbINVdaJPSfS4bg2zRI0CkKSQMQAL4FCFEgRWA=;
        b=Lqy+t2deEqO8YVCQ5J/cxBGEaUQ+3dmt4THnUmKGIvgwbYHYXhoGIrjBHUMVH/EhT+kyD9
        vOv+j5da/9rrKt75hYjeE+mMMbJKJPwnJ3DCcZ4L5Jj+pftYK1dW7de7tanK+Tw0ijooVS
        YGiSUaxtCtiIgDFH1n5N3qChhtsx/1M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-h0pjylsDNr6Qc_g1gqfhbQ-1; Mon, 16 May 2022 21:03:22 -0400
X-MC-Unique: h0pjylsDNr6Qc_g1gqfhbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89D65101AA46;
        Tue, 17 May 2022 01:03:21 +0000 (UTC)
Received: from localhost (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A649B7774;
        Tue, 17 May 2022 01:03:20 +0000 (UTC)
From:   Xiubo Li <xiubli@redhat.com>
To:     jlayton@kernel.org, viro@zeniv.linux.org.uk
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, arnd@arndb.de, mcgrof@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v2 0/2] ceph: wait async unlink to finish
Date:   Tue, 17 May 2022 09:03:14 +0800
Message-Id: <20220517010316.81483-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

V2:
- Add one dedicated spin lock to protect the list_add/del_rcu
- Other small fixes
- Fix the compile error from kernel test robot


Xiubo Li (2):
  fs/dcache: add d_compare() helper support
  ceph: wait the first reply of inflight unlink/rmdir

 fs/ceph/dir.c          | 70 ++++++++++++++++++++++++++++++++++++++---
 fs/ceph/file.c         |  5 +++
 fs/ceph/mds_client.c   | 71 ++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h   |  1 +
 fs/ceph/super.c        |  3 ++
 fs/ceph/super.h        | 19 ++++++++---
 fs/dcache.c            | 15 +++++++++
 include/linux/dcache.h |  2 ++
 8 files changed, 176 insertions(+), 10 deletions(-)

-- 
2.36.0.rc1

