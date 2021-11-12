Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8983044E6B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 13:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbhKLMru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 07:47:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4088 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbhKLMrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:47:35 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HrJ9F4J73z67bVy;
        Fri, 12 Nov 2021 20:41:05 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 12 Nov 2021 13:44:42 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ebiggers@kernel.org>, <tytso@mit.edu>, <corbet@lwn.net>,
        <viro@zeniv.linux.org.uk>, <hughd@google.com>,
        <akpm@linux-foundation.org>
CC:     <linux-fscrypt@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 3/5] fsverity: Do initialization earlier
Date:   Fri, 12 Nov 2021 13:44:09 +0100
Message-ID: <20211112124411.1948809-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112124411.1948809-1-roberto.sassu@huawei.com>
References: <20211112124411.1948809-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Perform fsverity initialization with core_initcall(), to ensure that
fsverity is available also very early during the boot process.

More specifically, allow files in the rootfs filesystem (from an initial
ram disk) to be protected with fsverity and be checked with LSMs such as
IPE.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/verity/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/verity/init.c b/fs/verity/init.c
index c98b7016f446..910083919e1d 100644
--- a/fs/verity/init.c
+++ b/fs/verity/init.c
@@ -58,4 +58,4 @@ static int __init fsverity_init(void)
 	fsverity_exit_info_cache();
 	return err;
 }
-late_initcall(fsverity_init)
+core_initcall(fsverity_init)
-- 
2.32.0

