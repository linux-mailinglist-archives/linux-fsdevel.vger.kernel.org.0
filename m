Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C16E9664
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 07:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfJ3GaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 02:30:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40709 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfJ3GaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 02:30:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id p5so506977plr.7;
        Tue, 29 Oct 2019 23:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QAFQpjJMQ1AiymCC034KBSTmnhi5/lZstN8G+BcUYtQ=;
        b=L+7juWxsHSAdsqLcMZaIeS2fgz1xxYZDM6BmPqKWPQ7lCOP1azhyZMa35O/w3yx3qm
         iv9x8SaVu/PjOJN2pLtuyqLR0S+N5OxGgJWAzQB/tcYjCMQJ60Nc0YmKyN+aDRhxq46U
         /cDmrPBm0S9F6iqgkWJps5DoBTCEOUQjZirHK/7c4wg5df5wFvNGq7Jg3QXtuakVkZuX
         Fh11AONhI5JPHfHXwjWsJCgQBd79ZXNhnTAuOfA/VzgRtoUeFlScdWNyxNZsvkKkRnM/
         BsGu9HfGA7dX+N40HCLolVgT55w7eicybLsmogBO+vixLwlV0B+Lijq9/7gCUF05ZweJ
         WsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QAFQpjJMQ1AiymCC034KBSTmnhi5/lZstN8G+BcUYtQ=;
        b=h4DgCGLQslM2ifqdnwus3KU0m2NjEAMdgs3H+Lj3WXEydho8EvRFrWPbziaoifb7dF
         +uhAFUETH3UmC3JDpm4c7opKTDhzfOoctvJGWRuLaOFO5OqL9uWsC+9+NP0G8MKXuW2G
         JG056Z7p7F7ZVZT/QflB0Tyb50cyHK1246nbZyQX8ez8YsRc4EwfqkuZEylotvEwCReD
         2lEysdX0ReGTqub0E5ypG7l089jffcOq/KklEE8JcaRsmM1SvLxe3TSoSoc3QcEdiG5S
         CZQzcpNSYTGbJ89YDpnwL2KFehWPZLUDMzWyKsx2XleYW0uYgL2XAJEbuXPV6cQ7sxWw
         zkAg==
X-Gm-Message-State: APjAAAWkb/f4GbH7oRCXZy/T9Zp3qwv2reEaAoEsuaHe3m2qiy0V45Pv
        pXbQKDoW5Nkh4FzIOWNHEB0QYjA=
X-Google-Smtp-Source: APXvYqyPUPfaSQLnYzy58yyAYdB3/zVlw/XMUpI8CokLVQIdCCLWG/0xSnqna2ZYajrElqtinreShA==
X-Received: by 2002:a17:902:6bca:: with SMTP id m10mr2753976plt.331.1572416999344;
        Tue, 29 Oct 2019 23:29:59 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s12sm1542146pgf.36.2019.10.29.23.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 23:29:58 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] xfs/log: protect xc_cil in xlog_cil_push()
Date:   Wed, 30 Oct 2019 14:29:40 +0800
Message-Id: <1572416980-25274-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

xlog_cil_push() is the reader and writer of xc_cil, and should be protected
against xlog_cil_insert_items().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
To: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/xfs/xfs_log_cil.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index ef652abd..004af09 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -723,6 +723,7 @@ xlog_cil_push(
 	 */
 	lv = NULL;
 	num_iovecs = 0;
+	spin_lock(&cil->xc_cil_lock);
 	while (!list_empty(&cil->xc_cil)) {
 		struct xfs_log_item	*item;
 
@@ -737,6 +738,7 @@ xlog_cil_push(
 		item->li_lv = NULL;
 		num_iovecs += lv->lv_niovecs;
 	}
+	spin_unlock(&cil->xc_cil_lock);
 
 	/*
 	 * initialise the new context and attach it to the CIL. Then attach
-- 
2.7.5

