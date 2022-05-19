Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CE852D044
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 12:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbiESKTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 06:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiESKTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 06:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0074644E3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 03:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652955549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/n56EJ3OznCmswcMZwTsA38QrHXubJEjwuHDiC/LsFY=;
        b=g1k7tUG+k3K1dr3kk9pI6orx5ioVx+xlHMs6Kl4ACrTYQ5RnRU6MHmI0dPT6a+/uy9AQdA
        s2m9ke+GMESAozd43rFn6TWXLYM6V03Rgttu7ISai+mtvrMMEJehIN6ij1Jq5gU1dpunoy
        2aY7WkXb9dNRWnRzLbZc6BTffs8q/JY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-7N-TVohpO3y4OxzBSyq_2g-1; Thu, 19 May 2022 06:19:05 -0400
X-MC-Unique: 7N-TVohpO3y4OxzBSyq_2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2942F294EDDB;
        Thu, 19 May 2022 10:19:05 +0000 (UTC)
Received: from localhost (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71CA57774;
        Thu, 19 May 2022 10:19:04 +0000 (UTC)
From:   Xiubo Li <xiubli@redhat.com>
To:     jlayton@kernel.org, idryomov@gmail.com, viro@zeniv.linux.org.uk
Cc:     willy@infradead.org, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, arnd@arndb.de, mcgrof@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v5 0/2] ceph: wait async unlink to finish
Date:   Thu, 19 May 2022 18:18:44 +0800
Message-Id: <20220519101847.87907-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
  fs/dcache: add d_compare() helper support
  ceph: wait the first reply of inflight async unlink

 fs/ceph/dir.c          | 79 +++++++++++++++++++++++++++++++++++++-----
 fs/ceph/file.c         |  6 +++-
 fs/ceph/mds_client.c   | 75 ++++++++++++++++++++++++++++++++++++++-
 fs/ceph/mds_client.h   |  1 +
 fs/ceph/super.c        |  3 ++
 fs/ceph/super.h        | 19 +++++++---
 fs/dcache.c            | 15 ++++++++
 include/linux/dcache.h |  2 ++
 8 files changed, 184 insertions(+), 16 deletions(-)

-- 
2.36.0.rc1

