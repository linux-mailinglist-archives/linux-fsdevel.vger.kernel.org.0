Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BE324403F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 23:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgHMVEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 17:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgHMVE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:04:29 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA7AC061383
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:28 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s16so5484981qtn.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fP9lP5J3iDMYf8rHzghnKH6TXtdMcDE1b3S5bi4nUEU=;
        b=cT3EKhb5eeN0mTmMlyXvcbBoen4kpRz9MkJyXeAirYXUWdz02tUwkvQXECmNg+TkaD
         jzU6fsqB4ZGIum35WEjTvUUcDvDvHZIzBBiA99mcqr3/lGUWb2X0BA2O0/fnivLH8p2V
         NzV95903xJU32+dWivod7qGlYAgyNtu3GJhgERYcqyCXiXKYZQsrbP0PPc8qL1MXoJ+u
         HmPvz2cLV+Jol1enJaQVaj/DEeEDovYu6GxmNm14KpsdFmjGuYlWtj9gct9fAIvvLBOs
         yY/WxWHzhr/G+ajuBOVOkYtBmLjs56+vL2Y0V/ycCP5A3KUIjBdJt5NhbmLkAZaIc7H2
         C5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fP9lP5J3iDMYf8rHzghnKH6TXtdMcDE1b3S5bi4nUEU=;
        b=oxnDbeL+J5XtzswDIWS+tmnARCE1hfqWh/8wMAoCjpcjfuVghI+O8YcZP4wceDJwp/
         TWSW7QXZhN0PFzndj4alOsaIDfCGtMBxPhafu9QZputmr9MxMzZMKUlMs0p1QMpkn4Nj
         zcmzYSWt68KzMWXh3xOSRKPeGPCQuVsC3zjdB8uptLKJx/CF/b8KPl7OPofCPQGKLq76
         YILQE+FHag64SHEsi3o+4hG/cmxcnw6U2FQ4gwAFuT8CxaooN1RwAwq7fIORV4ktJLsV
         QL5u8GfPohHBurkiAfM+bgqjImK85bfNRpLs7gKl5GfDjlm55ba0y1T0a/8xbVBfsFwa
         k+Ww==
X-Gm-Message-State: AOAM533dkRun+Gw05cJjZSR+2CVaotzDtSl9VUeynKiv4JcK3CvHBBM5
        idtsBAYn2uLz4WTBEDDaqTDyVg==
X-Google-Smtp-Source: ABdhPJzswgyzPU1h7n0HxzeOaC1WtFB0NHM2erdCX+zd7HARBrYyuExecLpPjtSgwW9qEwus5zGumw==
X-Received: by 2002:ac8:748b:: with SMTP id v11mr7121989qtq.293.1597352667526;
        Thu, 13 Aug 2020 14:04:27 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s30sm8077804qtc.87.2020.08.13.14.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:04:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@fb.com
Subject: [PATCH 6/6] sunrpc: rework proc handlers to take advantage of the new buffer
Date:   Thu, 13 Aug 2020 17:04:11 -0400
Message-Id: <20200813210411.905010-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813210411.905010-1-josef@toxicpanda.com>
References: <20200813210411.905010-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we're allocating an extra slot for the NULL terminated string,
use scnprintf() and write directly into the buffer.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/sunrpc/sysctl.c            | 10 ++--------
 net/sunrpc/xprtrdma/svc_rdma.c | 16 ++--------------
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index 999eee1ed61c..31ed530d9846 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -117,14 +117,8 @@ proc_dodebug(struct ctl_table *table, int write, void *buffer, size_t *lenp,
 		if (strcmp(table->procname, "rpc_debug") == 0)
 			rpc_show_tasks(&init_net);
 	} else {
-		len = sprintf(tmpbuf, "0x%04x", *(unsigned int *) table->data);
-		if (len > left)
-			len = left;
-		memcpy(buffer, tmpbuf, len);
-		if ((left -= len) > 0) {
-			*((char *)buffer + len) = '\n';
-			left--;
-		}
+		len = scnprintf(buffer, *lenp, "0x%04x\n", *(unsigned int *) table->data);
+		left -= len;
 	}
 
 done:
diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index 526da5d4710b..9b3a113598af 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -90,20 +90,8 @@ static int read_reset_stat(struct ctl_table *table, int write,
 	if (write)
 		atomic_set(stat, 0);
 	else {
-		char str_buf[32];
-		int len = snprintf(str_buf, 32, "%d\n", atomic_read(stat));
-		if (len >= 32)
-			return -EFAULT;
-		len = strlen(str_buf);
-		if (*ppos > len) {
-			*lenp = 0;
-			return 0;
-		}
-		len -= *ppos;
-		if (len > *lenp)
-			len = *lenp;
-		if (len)
-			memcpy(buffer, str_buf, len);
+		size_t len = scnprintf(buffer, *lenp, "%d\n",
+				       atomic_read(stat));
 		*lenp = len;
 		*ppos += len;
 	}
-- 
2.24.1

