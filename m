Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69083244042
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 23:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHMVEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 17:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgHMVE1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:04:27 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C99C061384
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:26 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b79so6502854qkg.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B2hh6MpQwu6Rqj6uOiklAGWqGW54Mh8HhVSMxBFaJos=;
        b=ejNsa+jphEK3859SCEU0roKfiKmiiVa2ALt77VinrUqepgftjIRozCHn5PCiDJA+G+
         sM9Cr1E3IVkgOtNWe4JkL03D6EnuXxN5yH41MS0Gksym+5Z3jmh1e2JPffSnVfswMRAd
         98iMI1p72ITKNH2G324zgWTmP4IgYYRs5wQBvxNEe4v2V0hiVz51M+pj8/J4miX2puC9
         7VSQfvyMpYDBA21Z6skpxhPp8gOGtYg/5Ypq1eq+AtD2iT3foLq3VdKZk9nwuWDZ9kmH
         Cq5o0knbL5g075H/aSxfGDHHpOKOGIc8qg+HBNwx1NZKvSZvY84c6r6OCtyNJqNPcQJ5
         FuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B2hh6MpQwu6Rqj6uOiklAGWqGW54Mh8HhVSMxBFaJos=;
        b=euMz+i++zZlwdvCx0Dtjbw2IBRQpxbccKC89yJ6freC3qcxJtUYhCHTV8MSvAO0PUb
         SJjnTh5SWv8gDNNdCXFP/rlS/z3Zu9Nrg41mO0SW15DzhiXf149QkwCaxN64vwUrJJTG
         Yr3RjXzzonNa4c3mdQyrAOobj9TvLh96GO6YOsIANi4l8hLA1mFJ95LauOS8EP4NlioA
         MCPut68bJQj0iyy9sTda5uaKJKHA5+mD95tjPp55Nomx1s3vvMzb8UM6osUoVA9uc5Uy
         7q0wVyBj6h+3JjOOadyMX6hDO2Pb9VLDbd+W7vd6D48m/95acsL4xSEgOVn9sPkGvfAf
         ngdw==
X-Gm-Message-State: AOAM532b22cFWncvvurUdZ3xM4M6RUyTq7eAyAiw3w1xeF16+0N3hAf7
        toUZvl3HmJmg5nsz3l3cjiobGA==
X-Google-Smtp-Source: ABdhPJykx6IW8mEtdDEkJz+B1eYT2YTUFbfFsDCkybScvXjr8caKjUwYhlC5o1X3Vm0IZh17dtYxgQ==
X-Received: by 2002:a37:5d01:: with SMTP id r1mr6634316qkb.18.1597352665792;
        Thu, 13 Aug 2020 14:04:25 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j15sm6397355qkl.63.2020.08.13.14.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:04:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@fb.com
Subject: [PATCH 5/6] parport: rework procfs handlers to take advantage of the new buffer
Date:   Thu, 13 Aug 2020 17:04:10 -0400
Message-Id: <20200813210411.905010-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813210411.905010-1-josef@toxicpanda.com>
References: <20200813210411.905010-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The buffer coming from higher up the stack has an extra byte to handle
the NULL terminator in the string.  Instead of using a temporary buffer
to sprintf into and then copying into the buffer, just scnprintf
directly into the buffer and update lenp as appropriate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/parport/procfs.c | 108 +++++++++++++--------------------------
 1 file changed, 36 insertions(+), 72 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index d740eba3c099..453d035ad5f6 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -37,9 +37,8 @@ static int do_active_device(struct ctl_table *table, int write,
 		      void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
-	char buffer[256];
 	struct pardevice *dev;
-	int len = 0;
+	size_t ret = 0;
 
 	if (write)		/* can't happen anyway */
 		return -EACCES;
@@ -48,24 +47,19 @@ static int do_active_device(struct ctl_table *table, int write,
 		*lenp = 0;
 		return 0;
 	}
-	
+
 	for (dev = port->devices; dev ; dev = dev->next) {
 		if(dev == port->cad) {
-			len += sprintf(buffer, "%s\n", dev->name);
+			ret += scnprintf(result + ret, *lenp - ret, "%s\n",
+					 dev->name);
 		}
 	}
 
-	if(!len) {
-		len += sprintf(buffer, "%s\n", "none");
-	}
-
-	if (len > *lenp)
-		len = *lenp;
-	else
-		*lenp = len;
+	if (!ret)
+		ret = scnprintf(result, *lenp, "%s\n", "none");
 
-	*ppos += len;
-	memcpy(result, buffer, len);
+	*lenp = ret;
+	*ppos += ret;
 	return 0;
 }
 
@@ -75,8 +69,7 @@ static int do_autoprobe(struct ctl_table *table, int write,
 {
 	struct parport_device_info *info = table->extra2;
 	const char *str;
-	char buffer[256];
-	int len = 0;
+	size_t ret = 0;
 
 	if (write) /* permissions stop this */
 		return -EACCES;
@@ -85,30 +78,24 @@ static int do_autoprobe(struct ctl_table *table, int write,
 		*lenp = 0;
 		return 0;
 	}
-	
+
 	if ((str = info->class_name) != NULL)
-		len += sprintf (buffer + len, "CLASS:%s;\n", str);
+		ret += scnprintf(result + ret, *lenp - ret, "CLASS:%s;\n", str);
 
 	if ((str = info->model) != NULL)
-		len += sprintf (buffer + len, "MODEL:%s;\n", str);
+		ret += scnprintf(result + ret, *lenp - ret, "MODEL:%s;\n", str);
 
 	if ((str = info->mfr) != NULL)
-		len += sprintf (buffer + len, "MANUFACTURER:%s;\n", str);
+		ret += scnprintf(result + ret, *lenp - ret, "MANUFACTURER:%s;\n", str);
 
 	if ((str = info->description) != NULL)
-		len += sprintf (buffer + len, "DESCRIPTION:%s;\n", str);
+		ret += scnprintf(result + ret, *lenp - ret, "DESCRIPTION:%s;\n", str);
 
 	if ((str = info->cmdset) != NULL)
-		len += sprintf (buffer + len, "COMMAND SET:%s;\n", str);
-
-	if (len > *lenp)
-		len = *lenp;
-	else
-		*lenp = len;
+		ret += scnprintf(result + ret, *lenp - ret, "COMMAND SET:%s;\n", str);
 
-	*ppos += len;
-
-	memcpy(result, buffer, len);
+	*lenp = ret;
+	*ppos += ret;
 	return 0;
 }
 #endif /* IEEE1284.3 support. */
@@ -117,8 +104,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
 				 void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
-	char buffer[20];
-	int len = 0;
+	size_t ret;
 
 	if (*ppos) {
 		*lenp = 0;
@@ -128,15 +114,10 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += sprintf (buffer, "%lu\t%lu\n", port->base, port->base_hi);
-
-	if (len > *lenp)
-		len = *lenp;
-	else
-		*lenp = len;
-
-	*ppos += len;
-	memcpy(result, buffer, len);
+	ret = scnprintf(result, *lenp, "%lu\t%lu\n", port->base,
+			port->base_hi);
+	*lenp = ret;
+	*ppos += ret;
 	return 0;
 }
 
@@ -144,8 +125,7 @@ static int do_hardware_irq(struct ctl_table *table, int write,
 			   void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
-	char buffer[20];
-	int len = 0;
+	size_t ret;
 
 	if (*ppos) {
 		*lenp = 0;
@@ -155,15 +135,10 @@ static int do_hardware_irq(struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += sprintf (buffer, "%d\n", port->irq);
+	ret = scnprintf(result, *lenp, "%d\n", port->irq);
 
-	if (len > *lenp)
-		len = *lenp;
-	else
-		*lenp = len;
-
-	*ppos += len;
-	memcpy(result, buffer, len);
+	*lenp = ret;
+	*ppos += ret;
 	return 0;
 }
 
@@ -171,8 +146,7 @@ static int do_hardware_dma(struct ctl_table *table, int write,
 			   void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
-	char buffer[20];
-	int len = 0;
+	size_t ret;
 
 	if (*ppos) {
 		*lenp = 0;
@@ -182,15 +156,10 @@ static int do_hardware_dma(struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += sprintf (buffer, "%d\n", port->dma);
-
-	if (len > *lenp)
-		len = *lenp;
-	else
-		*lenp = len;
+	ret = scnprintf(result, *lenp, "%d\n", port->dma);
 
-	*ppos += len;
-	memcpy(result, buffer, len);
+	*lenp = ret;
+	*ppos += ret;
 	return 0;
 }
 
@@ -198,8 +167,7 @@ static int do_hardware_modes(struct ctl_table *table, int write,
 			     void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
-	char buffer[40];
-	int len = 0;
+	size_t ret = 0;
 
 	if (*ppos) {
 		*lenp = 0;
@@ -213,7 +181,8 @@ static int do_hardware_modes(struct ctl_table *table, int write,
 #define printmode(x)							\
 do {									\
 	if (port->modes & PARPORT_MODE_##x)				\
-		len += sprintf(buffer + len, "%s%s", f++ ? "," : "", #x); \
+		ret += scnprintf(result + ret, *lenp - ret,		\
+				 "%s%s", f++ ? "," : "", #x);		\
 } while (0)
 		int f = 0;
 		printmode(PCSPP);
@@ -224,15 +193,10 @@ do {									\
 		printmode(DMA);
 #undef printmode
 	}
-	buffer[len++] = '\n';
-
-	if (len > *lenp)
-		len = *lenp;
-	else
-		*lenp = len;
+	ret += scnprintf(result + ret, *lenp - ret, "\n");
 
-	*ppos += len;
-	memcpy(result, buffer, len);
+	*lenp = ret;
+	*ppos += ret;
 	return 0;
 }
 
-- 
2.24.1

