Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BABB34057C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 13:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhCRM07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 08:26:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36378 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhCRM0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:26:35 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lMrjV-0006Dy-BT; Thu, 18 Mar 2021 12:26:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@google.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] proc: fix incorrect pde_is_permanent check
Date:   Thu, 18 Mar 2021 12:26:33 +0000
Message-Id: <20210318122633.14222-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the pde_is_permanent check is being run on root multiple times
rather than on the next proc directory entry. This looks like a copy-paste
error.  Fix this by replacing root with next.

Addresses-Coverity: ("Copy-paste error")
Fixes: d919b33dafb3 ("proc: faster open/read/close with "permanent" files")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/proc/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index bc86aa87cc41..5600da30e289 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -756,7 +756,7 @@ int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
 	while (1) {
 		next = pde_subdir_first(de);
 		if (next) {
-			if (unlikely(pde_is_permanent(root))) {
+			if (unlikely(pde_is_permanent(next))) {
 				write_unlock(&proc_subdir_lock);
 				WARN(1, "removing permanent /proc entry '%s/%s'",
 					next->parent->name, next->name);
-- 
2.30.2

