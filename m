Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D399021AD72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 05:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgGJDWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 23:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgGJDWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:22:48 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF7DC08C5CE;
        Thu,  9 Jul 2020 20:22:48 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 145so3972069qke.9;
        Thu, 09 Jul 2020 20:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Fl+ivAharlFwSL50U2A+hogEmO/RFrZJvmtKj+3STzI=;
        b=VXmuK5krDVoUHbyfHjtpaED4/8W3ijfG3Wfok0g74rpt0NAiUjDS49kPjf+ALWPHk+
         hfE1gkaT/RUF6unlKpLVUqZu49d+z699RhQ8xs41Mpkb5YdY142F6i8lcvnBnTTA6pJl
         oWRzk+wXVjFllAJUd+lNAGCWF1UlRsl/vn5tOf+35rY1pan04BthErf3cdV+V4JavYV3
         tutPr9fX0fX8RsdKaZtxzseyEZM2Rrt0pwGpNezGH/XUjOQ8QFQAth5Y6N2zBL3Hbx4S
         +WW/epg9dKJiu/xkEbBwyR6J9RjtuwitHCqgRMS8eyzEq8zmRTi6O8xMOrdQ+iMAz27G
         Hh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fl+ivAharlFwSL50U2A+hogEmO/RFrZJvmtKj+3STzI=;
        b=TL6Mcpmi8XQoEgcBMFUmLVOzvYJMDQg2gYTawenMKsD+DtDh7tBdDecml5d4grx6fd
         ElF1/DPdWDI2n+WhUSTPhBIS3KzRzSHZanJBsFtANlvdGf6FVlFnlctcqFzJEHZeAHcj
         KZwWJ8+fquHLAZj4R3FaKAe/k5SDRfRchFyIjJXXldjJLUSYfwSlan6WMRxYIdk0k0us
         TXyg3ZIA3YMkwYitV7btsIi2S7n21QTs85rwxAhZigKYQCY5MaDs/F9pwIa0g84HNlkD
         c8GdClrPCsEYV5MTRwpEqlWnzYqIaxFcE0vDhhO17zKBPkRcaTzf0cnudapnOyyU3FwD
         exmA==
X-Gm-Message-State: AOAM5312xh0ivbFy1M9e+b1NOX2ZDuRJ9Bf3qf0O2J+QakMNX9r5k4HD
        00d3NIz3eWsF5vNNhn5Zk1E=
X-Google-Smtp-Source: ABdhPJxs9uTWnohqw0BvlDZw0Y44UFp2MCVZbM0LY/SA5jevxPSz2nDyAg8MLGMS7HW/UgawX9uUxw==
X-Received: by 2002:a37:9405:: with SMTP id w5mr65513747qkd.18.1594351367296;
        Thu, 09 Jul 2020 20:22:47 -0700 (PDT)
Received: from DESKTOP-JC0RTV5.neu.edu ([155.33.134.7])
        by smtp.gmail.com with ESMTPSA id d53sm6520507qtc.47.2020.07.09.20.22.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 20:22:46 -0700 (PDT)
From:   Changming Liu <charley.ashbringer@gmail.com>
To:     keescook@chromium.org
Cc:     mcgrof@kernel.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Changming Liu <charley.ashbringer@gmail.com>
Subject: [PATCH] sysctl: add bound to panic_timeout to prevent overflow
Date:   Thu,  9 Jul 2020 23:22:23 -0400
Message-Id: <1594351343-11811-1-git-send-email-charley.ashbringer@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Function panic() in kernel/panic.c will use panic_timeout
multiplying 1000 as a loop boundery. So this multiplication
can overflow when panic_timeout is greater than (INT_MAX/1000).
And this results in a zero-delay panic, instead of a huge
timeout as the user intends.

Fix this by adding bound check to make it no bigger than
(INT_MAX/1000).

Signed-off-by: Changming Liu <charley.ashbringer@gmail.com>
---
 kernel/sysctl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index db1ce7a..e60cf04 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -137,6 +137,9 @@ static int minolduid;
 static int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
 
+/* this is needed for setting boundery for panic_timeout to prevent it from overflow*/
+static int panic_time_max = INT_MAX / 1000;
+
 /*
  * This is needed for proc_doulongvec_minmax of sysctl_hung_task_timeout_secs
  * and hung_task_check_interval_secs
@@ -1857,7 +1860,8 @@ static struct ctl_table kern_table[] = {
 		.data		= &panic_timeout,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra2		= &panic_time_max,
 	},
 #ifdef CONFIG_COREDUMP
 	{
-- 
2.7.4

