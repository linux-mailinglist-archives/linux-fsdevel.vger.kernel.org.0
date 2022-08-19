Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1915998BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 11:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347840AbiHSJbA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 05:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347106AbiHSJa7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:30:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC251E992F;
        Fri, 19 Aug 2022 02:30:56 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M8Gbh4hHfzXdhf;
        Fri, 19 Aug 2022 17:26:40 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 17:30:54 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 17:30:53 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <corbet@lwn.net>, <mcgrof@kernel.org>, <keescook@chromium.org>,
        <yzaikin@google.com>, <songmuchun@bytedance.com>,
        <mike.kravetz@oracle.com>, <osalvador@suse.de>, <rppt@kernel.org>,
        <surenb@google.com>, <mawupeng1@huawei.com>, <jsavitz@redhat.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 0/2] watermark related improvement on zone movable
Date:   Fri, 19 Aug 2022 17:30:23 +0800
Message-ID: <20220819093025.105403-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

The first patch cap zone movable's min watermark to small value since no
one can use it.

The second patch introduce a per zone watermark to replace the vanilla
watermark_scale_factor to bring flexibility to tune each zone's
watermark separately and lead to more efficient kswapd.

Each patch's detail information can be seen is its own changelog.

changelog since v1:
- fix compile error if CONFIG_SYSCTL is not enabled
- remove useless function comment

Ma Wupeng (2):
  mm: Cap zone movable's min wmark to small value
  mm: sysctl: Introduce per zone watermark_scale_factor

 Documentation/admin-guide/sysctl/vm.rst |  6 ++++
 include/linux/mm.h                      |  2 +-
 kernel/sysctl.c                         |  2 --
 mm/page_alloc.c                         | 41 +++++++++++++++++++------
 4 files changed, 39 insertions(+), 12 deletions(-)

-- 
2.25.1

