Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FEB22F6DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 19:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgG0Rk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 13:40:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49847 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbgG0Rk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:40:56 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k077O-0001vZ-V6; Mon, 27 Jul 2020 17:40:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] binfmt_elf: fix unsigned regset0_size compared to less than zero
Date:   Mon, 27 Jul 2020 18:40:54 +0100
Message-Id: <20200727174054.154765-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable regset0_size is an unsigned int and it is being checked
for an error by checking if it is less than zero, and hence this
check is always going to be false.  Fix this by making the variable
regset0_size signed.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 0f17865d8847 ("introduction of regset ->get() wrappers, switching ELF coredumps to those")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 6a171a28bdf7..13d053982dd7 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1821,7 +1821,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 				 long signr, size_t *total)
 {
 	unsigned int i;
-	unsigned int regset0_size;
+	int regset0_size;
 
 	/*
 	 * NT_PRSTATUS is the one special case, because the regset data
-- 
2.27.0

