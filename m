Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB422E111
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 18:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgGZQEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 12:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgGZQEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:04:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A447C0619D2;
        Sun, 26 Jul 2020 09:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IQmgLN+siDw4xLbsM2TTfog5zbp64pb+O9vGfX9FNWk=; b=BK0Lolwr5nIbxuWVDb6/qrVCb5
        25vqTL6qobU3dMsborvPYTnXbm35qce3kMPa12DmYZdamPIlr8+AuCicemOxLxH8ywagLsLNwKw/x
        xzOHwVf2CFnQFOHy4UeUnAzNyrctD5T29XiGJdO+KwJM88lM0KyoDlkw0KKrk2W2IIxXNMEi5MF6P
        bVy+coo8m2T1Ml45M+pAog0kgFqbIYvHHxJPysOY3c+aP85TWkW9NC+S0FsxhYExVxSd91+IaSBk8
        k+MGToUR5VuBl930hhw1a0IJYeeOUPHXIph200S6qZQ0MMefK4lOUnfdIggfmqech4HpgZohOl/8y
        UXSwqjbg==;
Received: from [2001:4bb8:18c:2acc:2375:88ff:9f84:118d] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzj88-0000Yn-RM; Sun, 26 Jul 2020 16:04:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Jan Kara <jack@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 1/4] arm64: stop using <asm/compat.h> directly
Date:   Sun, 26 Jul 2020 18:03:58 +0200
Message-Id: <20200726160401.311569-2-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726160401.311569-1-hch@lst.de>
References: <20200726160401.311569-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Always use <linux/compat.h> so that we can move more declarations to
common code.  In two of the three cases the asm include was in addition
to an existing one for <linux/compat.h> anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/include/asm/stat.h | 2 +-
 arch/arm64/kernel/process.c   | 1 -
 arch/arm64/kernel/ptrace.c    | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/stat.h b/arch/arm64/include/asm/stat.h
index 3b4a62f5aeb0c3..1b5ac1ef5d04cc 100644
--- a/arch/arm64/include/asm/stat.h
+++ b/arch/arm64/include/asm/stat.h
@@ -10,7 +10,7 @@
 #ifdef CONFIG_COMPAT
 
 #include <linux/time.h>
-#include <asm/compat.h>
+#include <linux/compat.h>
 
 /*
  * struct stat64 is needed for compat tasks only. Its definition is different
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6089638c7d43f4..70381900ef9b8a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -46,7 +46,6 @@
 
 #include <asm/alternative.h>
 #include <asm/arch_gicv3.h>
-#include <asm/compat.h>
 #include <asm/cpufeature.h>
 #include <asm/cacheflush.h>
 #include <asm/exec.h>
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 1e02e98e68dd37..0497aaea782451 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -30,7 +30,6 @@
 #include <linux/tracehook.h>
 #include <linux/elf.h>
 
-#include <asm/compat.h>
 #include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
 #include <asm/fpsimd.h>
-- 
2.27.0

