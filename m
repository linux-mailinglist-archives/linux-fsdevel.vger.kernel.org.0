Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850374BBF94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 19:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbiBRSfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 13:35:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiBRSfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:35:54 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD47254A40;
        Fri, 18 Feb 2022 10:35:38 -0800 (PST)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nL82Z-0004OI-B3; Fri, 18 Feb 2022 13:31:35 -0500
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        paulmck@kernel.org, gscrivan@redhat.com, viro@zeniv.linux.org.uk,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 0/2] fix rate limited ipc_namespace freeing
Date:   Fri, 18 Feb 2022 13:31:12 -0500
Message-Id: <20220218183114.2867528-1-riel@surriel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The test case below fails on 5.17 (and a bunch of older kernels)
with unshare getting -ENOSPC, because the rate at which ipc_namespace
structures can be freed is limited by each item on the to-free list
waiting in synchronize_rcu.

Making kern_unmount use queue_rcu_work gets rid of that slowdown,
allowing a batch of vfsmount structures to be freed after each
RCU grace period has expired.

That, in turn, allows us to just get rid of the workqueue in
ipc/namespace.c completely.

With these two changes the test case reliably succeeds at
calling unshare a million times, even with max_ipc_namespaces
reduced to 1000 :)

#define _GNU_SOURCE
#include <sched.h>
#include <error.h>
#include <errno.h>
#include <stdlib.h>

int main()
{
	int i;

	for (i = 0; i < 1000000; i++) {
		if (unshare(CLONE_NEWIPC) < 0)
			error(EXIT_FAILURE, errno, "unshare");
	}
}


Rik van Riel (2):
  vfs: free vfsmount through rcu work from kern_unmount
  ipc: get rid of free_ipc_work workqueue

 fs/namespace.c                | 11 +++++++++--
 include/linux/ipc_namespace.h |  2 --
 include/linux/mount.h         |  2 ++
 ipc/namespace.c               | 21 +--------------------
 4 files changed, 12 insertions(+), 24 deletions(-)

-- 
2.34.1

