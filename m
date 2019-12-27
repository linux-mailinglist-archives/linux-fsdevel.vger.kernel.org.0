Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 378FE12B014
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 02:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfL0BAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 20:00:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46787 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfL0BAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 20:00:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id n9so6096455pff.13;
        Thu, 26 Dec 2019 17:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44qeSbgK4fjxtx3Jl3gaoujj676TRWsAIPJoecKwxeA=;
        b=Vn50N8j/tjWROXYPVqiazH69KDR9POr+3lErHzubQvZT+V5huf7MhhUleCplm9Lf0K
         Ymry87zOQmn/Lzunqk2RR5XcdfCgaxFuXRd2HplsnNWWjfXuS+hUiX8VbRrQbH3eJwMR
         LumeSiMzI40fOSID7NKsz30KTufqFWxUqZrjRqdYcRy3M8/r5wjkeUmJqDucJZkK1iXd
         BUcE6kMsp78UqW+w89VyVP5n6UlZeo2v19BhO2mo647EO0DO7CMqS9sQy+aglAwHwyKr
         jjpxDLhi8HPBh56sBy9jsm+eJnihGPaKrS6Jw1ydLXMXlwdGR1/xvNMT+UPF/GTs0D1M
         EROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44qeSbgK4fjxtx3Jl3gaoujj676TRWsAIPJoecKwxeA=;
        b=PTRVxnOhkAMiZoaapPmAkn8ftKNS27TXkBG35vV+4Y86EB53EE+Bye/mV6KDFObedX
         xUEXsXucnRMinE8eIRINBFyPP+eo6tBAZry+xaRfgLBz1EnaXa9v88gqP6zNRjxD7Cy2
         3xeKdmqfOEPytxwKneFeQ4JSt8+FIxClQwx3uhIdvkAGE5jLAthol/NuvuxGP//un/LK
         qU5rng/6z8vqBDvJPPzzNQh7uYSmZ4hRi9z8MmvsupT4YBlzbRPedjo1W4TWIpiKN4vY
         sopILbs9kRWOjaNEniY2laR4Z6URa3b5ni7Rk/bK+PiCB5614Rpa9CpcJ/p84OogeA8B
         PuNg==
X-Gm-Message-State: APjAAAWs2xyhmzvdc0COCRXl079rG4lLUO0B1f6X24knlppPnS3RlX23
        QQs2slFUlVW+eD1czNVwhfY=
X-Google-Smtp-Source: APXvYqxA7fUPenla1wmNjprezXBoLMHCH166OsttVNrdQKg7iRnkv0Mnm7CF9SlsrPU4D+amEYGwXA==
X-Received: by 2002:a62:f842:: with SMTP id c2mr52061691pfm.104.1577408453895;
        Thu, 26 Dec 2019 17:00:53 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id 65sm39640144pfu.140.2019.12.26.17.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 17:00:53 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     viro@zeniv.linux.org.uk
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: seq_file.c: Fix warnings
Date:   Thu, 26 Dec 2019 22:00:35 -0300
Message-Id: <20191227010035.854913-3-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191227010035.854913-1-dwlsalmeida@gmail.com>
References: <20191227010035.854913-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warnings:

fs/seq_file.c:40: WARNING: Inline strong start-string without end-string.
fs/seq_file.c:40: WARNING: Inline strong start-string without end-string.
fs/seq_file.c:40: WARNING: Inline strong start-string without end-string.
fs/seq_file.c:40: WARNING: Inline strong start-string without end-string

By escaping the parenthesis in the affected line. Line breaks were added
for clarity.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 fs/seq_file.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 1600034a929b..aad4354ceeb0 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -38,10 +38,18 @@ static void *seq_buf_alloc(unsigned long size)
  *	@op: method table describing the sequence
  *
  *	seq_open() sets @file, associating it with a sequence described
- *	by @op.  @op->start() sets the iterator up and returns the first
- *	element of sequence. @op->stop() shuts it down.  @op->next()
- *	returns the next element of sequence.  @op->show() prints element
- *	into the buffer.  In case of error ->start() and ->next() return
+ *	by @op.
+ *
+ *	@op->start\(\) sets the iterator up and returns the first
+ *	element of sequence.
+ *
+ *	@op->stop\(\) shuts it down.
+ *
+ *	@op->next\(\) returns the next element of sequence.
+ *
+ *	@op->show\(\) prints element into the buffer.
+ *
+ *	In case of error ->start() and ->next() return
  *	ERR_PTR(error).  In the end of sequence they return %NULL. ->show()
  *	returns 0 in case of success and negative number in case of error.
  *	Returning SEQ_SKIP means "discard this element and move on".
-- 
2.24.1

