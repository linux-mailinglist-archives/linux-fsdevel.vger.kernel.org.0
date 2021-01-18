Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6792FA263
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 15:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392255AbhAROBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 09:01:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11109 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392354AbhARNbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:31:35 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DKCLk688Xz15vRH;
        Mon, 18 Jan 2021 21:29:34 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Mon, 18 Jan 2021 21:30:34 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>,
        <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
        <mhocko@suse.com>, <mhiramat@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <stable@kernel.org>,
        <hkallweit1@gmail.com>, <rdunlap@infradead.org>, <vbabka@suse.cz>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH v4] proc_sysctl: fix oops caused by incorrect command parameters.
Date:   Mon, 18 Jan 2021 21:30:29 +0800
Message-ID: <20210118133029.28580-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The process_sysctl_arg() does not check whether val is empty before
 invoking strlen(val). If the command line parameter () is incorrectly
 configured and val is empty, oops is triggered.

For example:
  "hung_task_panic=1" is incorrectly written as "hung_task_panic", oops is
  triggered. The call stack is as follows:
    Kernel command line: .... hung_task_panic
    ......
    Call trace:
    __pi_strlen+0x10/0x98
    parse_args+0x278/0x344
    do_sysctl_args+0x8c/0xfc
    kernel_init+0x5c/0xf4
    ret_from_fork+0x10/0x30

To fix it, check whether "val" is empty when "phram" is a sysctl field.
Error codes are returned in the failure branch, and error logs are
generated by parse_args().

Fixes: 3db978d480e2843 ("kernel/sysctl: support setting sysctl parameters
 from kernel command line")
Cc: stable@kernel.org # v5.8-rc1+
Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

---------
v4: According to Vlastimil Babka's recommendations
  add check len == 0, and cc stable
v3: https://lore.kernel.org/lkml/20210112033155.91502-1-nixiaoming@huawei.com/
  Return -EINVAL, When phram is the sysctl field and val is empty.

v2: https://lore.kernel.org/lkml/20210108023339.55917-1-nixiaoming@huawei.com/
  Added log output of the failure branch based on the review comments of Kees Cook.

v1: https://lore.kernel.org/lkml/20201224074256.117413-1-nixiaoming@huawei.com/

---------
---
 fs/proc/proc_sysctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 317899222d7f..d2018f70d1fa 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1770,6 +1770,12 @@ static int process_sysctl_arg(char *param, char *val,
 			return 0;
 	}
 
+	if (!val)
+		return -EINVAL;
+	len = strlen(val);
+	if (len == 0)
+		return -EINVAL;
+
 	/*
 	 * To set sysctl options, we use a temporary mount of proc, look up the
 	 * respective sys/ file and write to it. To avoid mounting it when no
@@ -1811,7 +1817,6 @@ static int process_sysctl_arg(char *param, char *val,
 				file, param, val);
 		goto out;
 	}
-	len = strlen(val);
 	wret = kernel_write(file, val, len, &pos);
 	if (wret < 0) {
 		err = wret;
-- 
2.27.0

