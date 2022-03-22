Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134F04E359C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 01:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiCVAhA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 20:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiCVAg7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:36:59 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B58A9231B;
        Mon, 21 Mar 2022 17:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1647909333; x=1679445333;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S2Gglb0i4VWWEsOShiAVgBXLTbBDp2r7Uj95dE7SCXI=;
  b=iIBSnJHlXLaNneaEC/Whxl1DBFgFKakVPx0FH0TxFRqSHhO2qt2Hxt1E
   y9BtyS3ooMS5+Ih5CqMT5VZhTwfTyTt47RzbMPe+TyBi6LhQF9NYRP3pG
   cRhUoQBJ3UhtTkJbqYYo62OL27pHxmDhs6z7LP1LuYkrBWwycDzF4paCW
   8=;
X-IronPort-AV: E=Sophos;i="5.90,200,1643673600"; 
   d="scan'208";a="72941651"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-7a21ed79.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 22 Mar 2022 00:28:21 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-7a21ed79.us-east-1.amazon.com (Postfix) with ESMTPS id 196FD220E87;
        Tue, 22 Mar 2022 00:28:18 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 22 Mar 2022 00:28:18 +0000
Received: from 88665a182662.ant.amazon.com (10.43.160.180) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 22 Mar 2022 00:28:15 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Fix data-races around epoll reported by KCSAN.
Date:   Tue, 22 Mar 2022 09:26:51 +0900
Message-ID: <20220322002653.33865-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D45UWA004.ant.amazon.com (10.43.160.151) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series suppresses a false positive KCSAN's message and fixes a real
data-race.

Kuniyuki Iwashima (2):
  pipe: Make poll_usage boolean and annotate its access.
  list: Fix a data-race around ep->rdllist.

 fs/pipe.c                 | 2 +-
 include/linux/list.h      | 6 +++---
 include/linux/pipe_fs_i.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.30.2

