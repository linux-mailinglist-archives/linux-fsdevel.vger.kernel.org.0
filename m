Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD64017CF24
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 16:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgCGPom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Mar 2020 10:44:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45665 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgCGPom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Mar 2020 10:44:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id v2so5795221wrp.12;
        Sat, 07 Mar 2020 07:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nyg6TKy7+Fqp191RefgM+5lFgqJLgXxO7mzKRJSy2Ps=;
        b=S+geA0KAZcjOYk61LLzRWCM8Zr2ZibLk8dJ8JZAEz+UfftfJkpDDjJUiSWOkDF2rAc
         0YT1BD4EVM/pwuXYIodMzE1aFHv+Kso2n38yfZa4oni4amIt7myrVX+qmhdD2YR8vbGi
         ZJBBqajElFeof58kwBI3Odh/9hGMHJTaYJXw4IsGYJvEOJcNmHHAzSyMlLMLUExQJQpr
         c8amRa0arGO83pPRxx/csJFFOMUTdFw9/s1XzC6gH9lQooR4r4u8W7CjYp93myGpBjyT
         bsMzbx/rc62uL7jMfywJIerqYb1r9Uz5fNJyoFTzX6pxvbImzQoDZvEtbVq9EHlRdkHY
         C2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nyg6TKy7+Fqp191RefgM+5lFgqJLgXxO7mzKRJSy2Ps=;
        b=NtiFLQia5hs9RmhW9iQO0DRsYERUlEp2I+hYlXiLmkKn+mjwbX3WGf5HDi3xvTBJMb
         84R+gWl97abK7Klo0txBuEiddshlLxo3gH4EM43+MA6HlHeaDzJnyaPHq2dybpbtzFAF
         6hlqAls0aGeX9stsTZ19KiC8TstQ2QBIFqEmpu66W+HBidGweXSpkopsSzUSw/vQ2hNc
         qDhQRU2iMpxIG78GAqELq28m9UUOtb9ZzKzHPcSueYgX5RHOpX1BjqEsnnVnOT+QOeNg
         zBTUjx7lDf5WCZE6iBE2p/8LwfKwsXdtD0X/TNsXf7OKZ69WXZr0rijUhVyB0hNUK0IM
         9ATw==
X-Gm-Message-State: ANhLgQ2KOCHT283wRLonMlWOrGuHjw7Ozj4pudv7szNFW+ddk4tLUWlc
        hQaRjVx3KNUduaLDXIgo0PnOwyE=
X-Google-Smtp-Source: ADFU+vvoL44fhBh3tNhd2G+NxJgpiwLos+iPgdzRBDuyAv8MUR87npUKHBK9WkI1lQF5mgY44+Z6ug==
X-Received: by 2002:a5d:6a4a:: with SMTP id t10mr2851835wrw.356.1583595878148;
        Sat, 07 Mar 2020 07:44:38 -0800 (PST)
Received: from avx2 ([46.53.250.34])
        by smtp.gmail.com with ESMTPSA id y1sm16811929wrh.65.2020.03.07.07.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 07:44:37 -0800 (PST)
Date:   Sat, 7 Mar 2020 18:44:35 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: speed up /proc/*/statm
Message-ID: <20200307154435.GA2788@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

top(1) reads all /proc/*/statm files but kernel threads will always have
zeros. Print those zeroes directly without going through seq_put_decimal_ull().

Speed up reading /proc/2/statm (which is kthreadd) is like 3%.

My system has more kernel threads than normal processes after booting KDE.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/array.c |   39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -635,28 +635,35 @@ int proc_tgid_stat(struct seq_file *m, struct pid_namespace *ns,
 int proc_pid_statm(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task)
 {
-	unsigned long size = 0, resident = 0, shared = 0, text = 0, data = 0;
 	struct mm_struct *mm = get_task_mm(task);
 
 	if (mm) {
+		unsigned long size;
+		unsigned long resident = 0;
+		unsigned long shared = 0;
+		unsigned long text = 0;
+		unsigned long data = 0;
+
 		size = task_statm(mm, &shared, &text, &data, &resident);
 		mmput(mm);
-	}
-	/*
-	 * For quick read, open code by putting numbers directly
-	 * expected format is
-	 * seq_printf(m, "%lu %lu %lu %lu 0 %lu 0\n",
-	 *               size, resident, shared, text, data);
-	 */
-	seq_put_decimal_ull(m, "", size);
-	seq_put_decimal_ull(m, " ", resident);
-	seq_put_decimal_ull(m, " ", shared);
-	seq_put_decimal_ull(m, " ", text);
-	seq_put_decimal_ull(m, " ", 0);
-	seq_put_decimal_ull(m, " ", data);
-	seq_put_decimal_ull(m, " ", 0);
-	seq_putc(m, '\n');
 
+		/*
+		 * For quick read, open code by putting numbers directly
+		 * expected format is
+		 * seq_printf(m, "%lu %lu %lu %lu 0 %lu 0\n",
+		 *               size, resident, shared, text, data);
+		 */
+		seq_put_decimal_ull(m, "", size);
+		seq_put_decimal_ull(m, " ", resident);
+		seq_put_decimal_ull(m, " ", shared);
+		seq_put_decimal_ull(m, " ", text);
+		seq_put_decimal_ull(m, " ", 0);
+		seq_put_decimal_ull(m, " ", data);
+		seq_put_decimal_ull(m, " ", 0);
+		seq_putc(m, '\n');
+	} else {
+		seq_write(m, "0 0 0 0 0 0 0\n", 14);
+	}
 	return 0;
 }
 
