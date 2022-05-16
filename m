Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4132B52840A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 14:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241530AbiEPMVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 08:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiEPMVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 08:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C419D219B
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652703664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2vplNptXwHAMGh0lZxOAIZAEP+KO2WKTxJNAPuttPjw=;
        b=CCPkl9w+QwrSsYRk4TmgoReA4bfuCxCkk1DnVjyEpQSnHWcalBoEMY78cEzVV2Num8RSDk
        mBN8kfhJQbEWEqwwCQh13h6FZPf4de8AJJF+yHT5S+ZLuaouxrrUQrj+RcLPARJbwfItwm
        xdKFufggmztdb4yvHJFC+rMWDNpQvrQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-ZG7EnukvMz-mjwpNc69W2g-1; Mon, 16 May 2022 08:21:01 -0400
X-MC-Unique: ZG7EnukvMz-mjwpNc69W2g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCE4A10DEB2A;
        Mon, 16 May 2022 12:20:55 +0000 (UTC)
Received: from localhost (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 203F61121315;
        Mon, 16 May 2022 12:20:54 +0000 (UTC)
From:   Xiubo Li <xiubli@redhat.com>
To:     jlayton@kernel.org, viro@zeniv.linux.org.uk
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, mcgrof@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 0/2] ceph: wait async unlink to finish
Date:   Mon, 16 May 2022 20:20:44 +0800
Message-Id: <20220516122046.40655-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Xiubo Li (2):
  fs/dcache: add d_compare() helper support
  ceph: wait the first reply of inflight unlink/rmdir

 fs/ceph/dir.c          | 55 ++++++++++++++++++++++++++++++---
 fs/ceph/file.c         |  5 +++
 fs/ceph/mds_client.c   | 69 ++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h   |  1 +
 fs/ceph/super.c        |  2 ++
 fs/ceph/super.h        | 18 ++++++++---
 fs/dcache.c            | 15 +++++++++
 include/linux/dcache.h |  2 ++
 8 files changed, 157 insertions(+), 10 deletions(-)

-- 
2.36.0.rc1

