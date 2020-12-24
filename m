Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A1D2E2545
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Dec 2020 08:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgLXHny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Dec 2020 02:43:54 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10359 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgLXHnx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Dec 2020 02:43:53 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D1hqg1pBwz7Hn0;
        Thu, 24 Dec 2020 15:42:23 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 24 Dec 2020 15:42:59 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>,
        <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <vbabka@suse.cz>,
        <linux-fsdevel@vger.kernel.org>, <mhocko@suse.com>,
        <mhiramat@kernel.org>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH] proc_sysclt: fix oops caused by incorrect command parameters.
Date:   Thu, 24 Dec 2020 15:42:56 +0800
Message-ID: <20201224074256.117413-1-nixiaoming@huawei.com>
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

For example, "hung_task_panic=1" is incorrectly written as "hung_task_panic".

log:
	Kernel command line: .... hung_task_panic
	....
	[000000000000000n] user address but active_mm is swapper
	Internal error: Oops: 96000005 [#1] SMP
	Modules linked in:
	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.1 #1
	Hardware name: linux,dummy-virt (DT)
	pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
	pc : __pi_strlen+0x10/0x98
	lr : process_sysctl_arg+0x1e4/0x2ac
	sp : ffffffc01104bd40
	x29: ffffffc01104bd40 x28: 0000000000000000
	x27: ffffff80c0a4691e x26: ffffffc0102a7c8c
	x25: 0000000000000000 x24: ffffffc01104be80
	x23: ffffff80c22f0b00 x22: ffffff80c02e28c0
	x21: ffffffc0109f9000 x20: 0000000000000000
	x19: ffffffc0107c08de x18: 0000000000000003
	x17: ffffffc01105d000 x16: 0000000000000054
	x15: ffffffffffffffff x14: 3030253078413830
	x13: 000000000000ffff x12: 0000000000000000
	x11: 0101010101010101 x10: 0000000000000005
	x9 : 0000000000000003 x8 : ffffff80c0980c08
	x7 : 0000000000000000 x6 : 0000000000000002
	x5 : ffffff80c0235000 x4 : ffffff810f7c7ee0
	x3 : 000000000000043a x2 : 00bdcc4ebacf1a54
	x1 : 0000000000000000 x0 : 0000000000000000
	Call trace:
	 __pi_strlen+0x10/0x98
	 parse_args+0x278/0x344
	 do_sysctl_args+0x8c/0xfc
	 kernel_init+0x5c/0xf4
	 ret_from_fork+0x10/0x30
	Code: b200c3eb 927cec01 f2400c07 54000301 (a8c10c22)

Fixes: 3db978d480e2843 ("kernel/sysctl: support setting sysctl parameters
 from kernel command line")
Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 fs/proc/proc_sysctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 317899222d7f..4516411a2b44 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1757,6 +1757,9 @@ static int process_sysctl_arg(char *param, char *val,
 	loff_t pos = 0;
 	ssize_t wret;
 
+	if (!val)
+		return 0;
+
 	if (strncmp(param, "sysctl", sizeof("sysctl") - 1) == 0) {
 		param += sizeof("sysctl") - 1;
 
-- 
2.27.0

