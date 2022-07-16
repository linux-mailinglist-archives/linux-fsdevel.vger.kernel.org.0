Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B582F577277
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jul 2022 01:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiGPXeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jul 2022 19:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiGPXeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:34:21 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E8E6366
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jul 2022 16:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1658014461; x=1689550461;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cz5iCRgjN7LV9zbp7CVDzhaSkodqqXJ++iWq1Od5Cgo=;
  b=qvGVaTjrbjby3sd6fqKcyXmGTTitN5SZQ+nJDo4SJ2yEEq5j/JWgOLdg
   QM+gBEUC0xb8i/emuwN4KoKq1tWa/LMPWRtCQMdNeDHDbi8buaKJJIoTe
   VQf+C6XuEMQ3L6d/TR/MztrRmcCNqG05arwKVI7lu3FIjPUIslPMvdDnc
   U=;
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 16 Jul 2022 23:34:10 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com (Postfix) with ESMTPS id B1FB989305;
        Sat, 16 Jul 2022 23:34:09 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Sat, 16 Jul 2022 23:34:06 +0000
Received: from 88665a182662.ant.amazon.com (10.43.162.124) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.9;
 Sat, 16 Jul 2022 23:34:04 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2 0/2] fs/lock: Cleanup around flock syscall.
Date:   Sat, 16 Jul 2022 16:33:41 -0700
Message-ID: <20220716233343.22106-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.124]
X-ClientProxiedBy: EX13D03UWA003.ant.amazon.com (10.43.160.39) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The first patch removes allocate-and-free for struct file_lock
in flock syscall and the second patch rearrange some operations.

Changes
  v2:
    * Use F_UNLCK in locks_remove_flock() (Chuck Lever)
    * Fix uninitialised error in flock syscall (kernel test robot)
    * Fix error when setting LOCK_NB
    * Split patches not to mix different kinds of optimisations and
      not to miss errors reported by kernel test robot

  v1: https://lore.kernel.org/linux-fsdevel/20220716013140.61445-1-kuniyu@amazon.com/


Kuniyuki Iwashima (2):
  fs/lock: Don't allocate file_lock in flock_make_lock().
  fs/lock: Rearrange ops in flock syscall.

 fs/locks.c | 66 +++++++++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 43 deletions(-)

-- 
2.30.2

