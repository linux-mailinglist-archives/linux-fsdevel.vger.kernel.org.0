Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71E0393884
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 00:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhE0WG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 18:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbhE0WGY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 18:06:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA0BC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 15:04:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q5so1320601wrs.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GIBwG8U0VtrhX6b02bNOMwodqYUD3wGIXiZ91uqobPE=;
        b=O0+3poSPsNTeaIoSf6t8TWIYHLkSgs3oq1kgU9iY7NNXmXGU8I1EM+7VpATDhdIsR3
         11KDk4H5XZCzv5LMwSTUE6lqYNMKbvGiPFF7fhJ7Z/ZcUYFATXci9YVSqv2QFpfcBeiN
         w4YbYDeYx17QZt6oEa5AJGaZMjPPyRCaf8cXqVyHdVjF8i3yvcUgulgzYnY6imOi9Ynz
         4FVw6wAdQGbGhLd8a8vCAMqN3CKn85z67xkBJF2jeK8CSC9ZcG2HXKtYNWGHFOzcCVi+
         ilmpgQ6ZGpU9NHsrsiYyDuxrsOwDt/5CjD5/RBxHTUj3V49uAOKvEWosQW/EfesWjw47
         +m/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GIBwG8U0VtrhX6b02bNOMwodqYUD3wGIXiZ91uqobPE=;
        b=QUKaagTPOQHoOydy9qqxJyiFTModqjgeL59xQbjTP1xaByY6mNBjC42YIkGKYUb3Cm
         j1mnDBsruPw/6wavpYD2JZmAQubZoeIqGWpu+wTgXsM7clQ7VZsDpf+m35Xfs42ibmHu
         O8Ex65JphLqf1vkOek4tLaRfz4a+W6nyQ+IQlydHXPng47FD/hzhsIYsxHLdCrs6k6ph
         Rur//Fci3HLP5VqaKvIsRaofzS0V35b8N0RgCz08HF3lY1HXHM6XT7LUyeQmzeMqEtX0
         ige5Q9sVbSlPny9s0tN4G38TJrFoCYi+7X7AQ8kh5CyZ5ZUszzcqvbiGnlUePvRILWG8
         sMzg==
X-Gm-Message-State: AOAM531Zu4AAmkIRaiuQzV2UPd2Ks+AAd/0/zg3Rwsyim9Gw3ME7/rVd
        sFOnQV9PnVoNkd4/BUL4zWJH75kgEA==
X-Google-Smtp-Source: ABdhPJw6prljWIL7nBjKKqVekWrsqToWFxcnhrZXOcBiINCJmVikt9V/mWKuC+LNiYJAtLs9ZEIFFA==
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr5349567wrm.212.1622153088764;
        Thu, 27 May 2021 15:04:48 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.5])
        by smtp.gmail.com with ESMTPSA id w8sm3706913wre.70.2021.05.27.15.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 15:04:47 -0700 (PDT)
Date:   Fri, 28 May 2021 01:04:46 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     dhowells@redhat.com
Cc:     linux-afs@lists.infradead.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] afs: fix tracepoint string placement with built-in AFS
Message-ID: <YLAXfvZ+rObEOdc/@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I was adding custom tracepoint to the kernel, grabbed full F34 kernel
.config, disabled modules and booted whole shebang as VM kernel.

Then did

	perf record -a -e ...

It crashed:

	general protection fault, probably for non-canonical address 0x435f5346592e4243: 0000 [#1] SMP PTI
	CPU: 1 PID: 842 Comm: cat Not tainted 5.12.6+ #26
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
	RIP: 0010:t_show+0x22/0xd0

Then reproducer was narrowed to 

	# cat /sys/kernel/tracing/printk_formats

Original F34 kernel with modules didn't crash.

So I started to disable options and after disabling AFS everything
started working again.

The root cause is that AFS was placing char arrays content into a section
full of _pointers_ to strings with predictable consequences.

Non canonical address 435f5346592e4243 is "CB.YFS_" which came from
CM_NAME macro.

The fix is to create char array and pointer to it separatedly.

Steps to reproduce:

	CONFIG_AFS=y
	CONFIG_TRACING=y

	# cat /sys/kernel/tracing/printk_formats

Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
---

 fs/afs/cmservice.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -30,8 +30,9 @@ static void SRXAFSCB_TellMeAboutYourself(struct work_struct *);
 static int afs_deliver_yfs_cb_callback(struct afs_call *);
 
 #define CM_NAME(name) \
-	char afs_SRXCB##name##_name[] __tracepoint_string =	\
-		"CB." #name
+	const char afs_SRXCB##name##_name[] = "CB." #name;		\
+	static const char *_afs_SRXCB##name##_name __tracepoint_string =\
+		afs_SRXCB##name##_name
 
 /*
  * CB.CallBack operation type
