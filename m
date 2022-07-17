Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D2C577447
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jul 2022 06:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiGQEgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jul 2022 00:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGQEgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jul 2022 00:36:01 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179FE165AC
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jul 2022 21:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1658032561; x=1689568561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sqZvYlpd+wBS7DFjLrIT4NLlKce0bGWOeOvtiO/qeU8=;
  b=d9cT2O0cBVKw3SJTnmdTsNrQHRQWLT6Pxu9X+W1KS25PrBVbMlnGaBiT
   WejsMvCVBY4lool5d9QrgDlygrys2VB3KX9AxFlR03UyZz95p+T4xYmcM
   TOC9PjsFCGy0rrwuSkumdvowSughlUCOv7ZztLiBqj5DiRnOI/b3O1lpm
   o=;
X-IronPort-AV: E=Sophos;i="5.92,278,1650931200"; 
   d="scan'208";a="219194394"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-92ba9394.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 17 Jul 2022 04:35:49 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-92ba9394.us-west-2.amazon.com (Postfix) with ESMTPS id 9486E441B4;
        Sun, 17 Jul 2022 04:35:46 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Sun, 17 Jul 2022 04:35:45 +0000
Received: from 88665a182662.ant.amazon.com (10.43.162.124) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.9;
 Sun, 17 Jul 2022 04:35:43 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3 0/2] fs/lock: Cleanup around flock syscall.
Date:   Sat, 16 Jul 2022 21:35:30 -0700
Message-ID: <20220717043532.35821-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.124]
X-ClientProxiedBy: EX13d09UWC001.ant.amazon.com (10.43.162.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The first patch removes allocate-and-free for struct file_lock
in flock syscall and the second patch rearrange some operations.

Changes:
  v3:
    * Test LOCK_MAND first in patch 2

  v2: https://lore.kernel.org/linux-fsdevel/20220716233343.22106-1-kuniyu@amazon.com/
    * Use F_UNLCK in locks_remove_flock() (Chuck Lever)
    * Fix uninitialised error in flock syscall (kernel test robot)
    * Fix error when setting LOCK_NB
    * Split patches not to mix different kinds of optimisations and
      not to miss errors reported by kernel test robot

  v1: https://lore.kernel.org/linux-fsdevel/20220716013140.61445-1-kuniyu@amazon.com/


Kuniyuki Iwashima (2):
  fs/lock: Don't allocate file_lock in flock_make_lock().
  fs/lock: Rearrange ops in flock syscall.

 fs/locks.c | 77 ++++++++++++++++++++----------------------------------
 1 file changed, 28 insertions(+), 49 deletions(-)

-- 
2.30.2

