Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9740D24347C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 09:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHMHL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 03:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgHMHLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:11:25 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B50BC061383
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 00:11:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y206so2332291pfb.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 00:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G9/MRbSniafF+tmInqqY6EgeuuddaMrfD+FPrAe1c3k=;
        b=auafXH/h/BS2v4XY4d23CBP8Q+rom7Vw45meTCnRZxfNc61LMxJ3KutMhbch6ESkQb
         nW4PjngHgcnrSIaa3+ugdWtrfRnK9izCxneokoKNHWklutR5GeMvGSPmY/+/5izsRKya
         ozQ0MoDQ0QCPFsDHIZq1Od7tlHEJHH3ubM99w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G9/MRbSniafF+tmInqqY6EgeuuddaMrfD+FPrAe1c3k=;
        b=piQosA8y4HeENA94IAjqIWpZaNXW1BGrrlgoSpMujDn5dLl8EVBKT/Ph69ZVOqvHLb
         blWIBSujAYkqxWXU6175jB7UdQhlpdAOIbGERVoz7CXqXRtpNrh0JfFGkyqrRZ1aPNXl
         P6ekfNJEdEQb+5p6b8SgMpj8KICAjVSC+nsJ0F4MBptsVSiOqfAcZhD8Pc/cTHN5w6+G
         Q9U0WnEbxbWJtBzm89mjjatbE313Ch+IM2CVLW1N7Z6cjlE3sB+V/6JWvNUrdTYca0ba
         Ke1QjXqkX0SqxO4qNv+JTuxumJHIyuvIa2mixcbucSeiqz0odzQJbuaf6JW3vq8NysQc
         zV0w==
X-Gm-Message-State: AOAM532f1hS0gtTlox4nmlDbxSw1LJpd+GQ+Tj31vjf81MCXxpBaZYah
        DZ/FXlQQT6WXBsAQeMj1ju80AQ==
X-Google-Smtp-Source: ABdhPJwA4ScZ/g4gwKJAYk2J+VpS9Mby9im7QqJEYyaRLLT3P3c7Z0f3DiW7ItusFGiA6xgppRIP/A==
X-Received: by 2002:a63:6fc7:: with SMTP id k190mr2523354pgc.54.1597302685163;
        Thu, 13 Aug 2020 00:11:25 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-b095-181e-17b3-2e29.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:b095:181e:17b3:2e29])
        by smtp.gmail.com with ESMTPSA id c207sm4543992pfc.64.2020.08.13.00.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 00:11:24 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH] fs/select.c: batch user writes in do_sys_poll
Date:   Thu, 13 Aug 2020 17:11:20 +1000
Message-Id: <20200813071120.2113039-1-dja@axtens.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When returning results to userspace, do_sys_poll repeatedly calls
put_user() - once per fd that it's watching.

This means that on architectures that support some form of
kernel-to-userspace access protection, we end up enabling and disabling
access once for each file descripter we're watching. This is inefficent
and we can improve things by batching the accesses together.

To make sure there's not too much happening in the window when user
accesses are permitted, we don't walk the linked list with accesses on.
This leads to some slightly messy code in the loop, unfortunately.

Unscientific benchmarking with the poll2_threads microbenchmark from
will-it-scale, run as `./poll2_threads -t 1 -s 15`:

 - Bare-metal Power9 with KUAP: ~48.8% speed-up
 - VM on amd64 laptop with SMAP: ~25.5% speed-up

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 fs/select.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 7aef49552d4c..f58976da9e63 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1015,9 +1015,19 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 		struct pollfd *fds = walk->entries;
 		int j;
 
+		if (!user_write_access_begin(ufds, (sizeof(struct pollfd) *
+						    walk->len)))
+			goto out_fds;
+
 		for (j = 0; j < walk->len; j++, ufds++)
-			if (__put_user(fds[j].revents, &ufds->revents))
-				goto out_fds;
+			unsafe_put_user(fds[j].revents, &ufds->revents, loop_fault);
+
+		user_write_access_end();
+		continue;
+
+loop_fault:
+		user_write_access_end();
+		goto out_fds;
   	}
 
 	err = fdcount;
-- 
2.25.1

