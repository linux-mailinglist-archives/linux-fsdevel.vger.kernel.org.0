Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A322E91CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 09:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbhADIii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 03:38:38 -0500
Received: from condef-02.nifty.com ([202.248.20.67]:16802 "EHLO
        condef-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbhADIii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:38:38 -0500
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-02.nifty.com with ESMTP id 1048Y6TH005974
        for <linux-fsdevel@vger.kernel.org>; Mon, 4 Jan 2021 17:34:06 +0900
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 1048WODm005342;
        Mon, 4 Jan 2021 17:32:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1048WODm005342
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1609749144;
        bh=qmFze+TdXbA/wD3L0NCQ0Ljuym3bFlZJDZseHyB2CY0=;
        h=From:To:Cc:Subject:Date:From;
        b=ADKNGAB8XqRYVqXoKtlCTwnh6Azjmqzm4Me5Si/CG62tvMuG5YZ/11/T3UE082pHS
         wo+++QX9YAZTO/RVY4JnvjFFq57L7v/hD/xidDaDczkKgBaGKDTXdrMcs1A1ADqyDH
         ZiC45WbH8qCygZ1bJSTPJfNFxeSVNJ1WsoRhMuvao+poQtJXXtwKAHVpMlIZIs1Vo9
         u0ADWeqMoDRP17qCkI8t/incqD7zjQxwYPyuG/wTthsW8SF1XGJMAT4S4L5EiEWI/V
         1B3ftxq4852PGoWZLYgzi0/vW/+hCcpK1eVg3nRQpBmEEm6rNvHsNXVHdemMHG3tV8
         v5qlQGGJJ+Xsw==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl: use min() helper for namecmp()
Date:   Mon,  4 Jan 2021 17:32:21 +0900
Message-Id: <20210104083221.21184-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make it slightly readable by using min().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 fs/proc/proc_sysctl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 317899222d7f..86341c0f0c40 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -94,14 +94,9 @@ static void sysctl_print_dir(struct ctl_dir *dir)
 
 static int namecmp(const char *name1, int len1, const char *name2, int len2)
 {
-	int minlen;
 	int cmp;
 
-	minlen = len1;
-	if (minlen > len2)
-		minlen = len2;
-
-	cmp = memcmp(name1, name2, minlen);
+	cmp = memcmp(name1, name2, min(len1, len2));
 	if (cmp == 0)
 		cmp = len1 - len2;
 	return cmp;
-- 
2.27.0

