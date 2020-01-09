Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C21D9135CE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 16:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbgAIPhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 10:37:21 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:35729 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgAIPhU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:37:20 -0500
Received: by mail-qk1-f176.google.com with SMTP id z76so6367689qka.2;
        Thu, 09 Jan 2020 07:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44qeSbgK4fjxtx3Jl3gaoujj676TRWsAIPJoecKwxeA=;
        b=noa0a510xUsCS83uXW9qp66lUzBtzCWLZCNOz+h/lTvAlhnXI2GABGdvyDVPFMzEcH
         wZK4fb8EYbCh4foaOpydy1F4EusJwlS8NhTvSgnRSZlEKliGYglDwi61QL/zlQ7noqE0
         3X4EEGTdyw3+WSZpyzcySaoxn5erAYcfg9l8A8Gar7h2l0CZ4B41M5xrtuQR5zFZt5fp
         3kHzDPdAN+WEZl9DSILegCRA0+AZ4xHC4i8Gz3E2ZhAkcIOzjXq9pv7VBbpu0yS04qSx
         kXXXgPHcJ2klqc/o5Lgs8+bbzmo4lJXgxXOwEBD5C65z27dXKFueLGDAXoNnfUrXIgHM
         0AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44qeSbgK4fjxtx3Jl3gaoujj676TRWsAIPJoecKwxeA=;
        b=MNMu6r3SEqkw8PxloHK2rBeE2yG8K0G4temtNNTBAW5uDtg31ptSQ9kfbbpZd1L3FC
         jTf7AXHZvEfiz+J0BaxeGvWER1oGVCIAkC6/GOgpTjsqdk1/XhzbxO1Rb/OvBnqNUD5v
         GzqO7TIwXOt0y8oWbxdzlzUcF9hwxCkWNZDKV/KOkHirOb2+YkMo3Vgp/nImJKnWFDWV
         oyzEsrhBsZZY/cE7bNOqWhGENvimPhp373rdwkyVPW33/k1YeIgxt5eQIR7a3uOuKhdD
         iQ+tatkgp0nvAEdXigUj4J12/jiG22t1kzGrKlSK3aL9c60MMqHJk1HJBFCPslJS1Rbr
         muvg==
X-Gm-Message-State: APjAAAW+VnGn1cvDxNvZ3jVP+iNfTZy5f4mG6fUqP4QLw/RO1/kgn4XO
        BwDbV/IZ9ZvLbRTbjSdkuPgyOyZ/yrM=
X-Google-Smtp-Source: APXvYqzqA3NMUhSuJbSsfbCvQfcWyNR0IMB4i9uRm/zTmXCuUbC6swcJY7SbRpsMEcQotMbC0rW2zw==
X-Received: by 2002:a05:620a:128f:: with SMTP id w15mr9779885qki.472.1578584239612;
        Thu, 09 Jan 2020 07:37:19 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id u16sm3122008qku.19.2020.01.09.07.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 07:37:19 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     viro@zeniv.linux.org.uk
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RESEND] fs: seq_file.c: Fix warnings
Date:   Thu,  9 Jan 2020 12:37:08 -0300
Message-Id: <20200109153708.1021891-2-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109153708.1021891-1-dwlsalmeida@gmail.com>
References: <20200109153708.1021891-1-dwlsalmeida@gmail.com>
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

