Return-Path: <linux-fsdevel+bounces-28653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A48196C8A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C292824C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAAE149DE4;
	Wed,  4 Sep 2024 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BNU4x8WC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75166148848
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481981; cv=none; b=iCtYlaAlkmd9dyCG0qTPcCN5rG7kQbSbzVHEWArcowv+liUvUaJEm7pEM8BgtZJG2k3U86l1lDXJpaSuz4zR+GZ51uWypPstcef0ooymQ+NUsC9ftjUYz/AyUkMF2rMozff1paopRhqbSEretp2q16eltAof8U2HqMeXMhMQj3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481981; c=relaxed/simple;
	bh=K+CbyYwwAbVTU6/pJMTuy8luxTt3cvtD/fieWJHfmHE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ng7auwxTYEMJMRZqlW1gyVL5v7C3nfuyifbWO4RvsElBzrRFfNSQfZ5J2p8ADtIDjMBKN7EC/crakuM526IrN6TJ3BkG++6W07NZ3ZasYkgvDo2ENhn3AZc0lCU+PcsBv8dRKhrfe89CSkg2zUSJVGSR6Q2j5wkMkZFP39NrKLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BNU4x8WC; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9782651bdso99398585a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 13:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481979; x=1726086779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7/V8rcbkowuGgIBpEivXhCW6ycCfF2REla3TxQUkdA=;
        b=BNU4x8WCEJHxOiQTdZKGdjc7GcIoP1+KAc11qBo1ODPRsIQL70ZyKqzbY4GffOl4YZ
         yv04+n2jWWk4v2oE5U0r6lpRnQ2xk2FUuY1jl7UtlJewkDR+CBw0++4J5xTzqyPjjbaV
         b1bkRL8LJwHzBh3vOGh58IHAcNCQiPgVw8F845UkSLdfHwqL2bAICFZs+XVEEKVe0M/G
         1rbcnYw52j0N4C2eFFFeLn2BrCb7gEkT+SKcKzwhO5oZDxP0FrCIBqr/jTkDNZhWkcvj
         gzbwaQSpj3QUxMEQKwTr9BOhPtFARdzdxSrHLxwEdoIb0pkMs6P9RYh6bHL14gz4KfHy
         nSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481979; x=1726086779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7/V8rcbkowuGgIBpEivXhCW6ycCfF2REla3TxQUkdA=;
        b=aX82fUbx+rSS12Wr/Q5ZIMTSjdHwxccgG9fGwqa4giVFDjcNEePIStCXK3ZTx8LV++
         Y4DSReRfBRbYHbWLFdXivrxwEw35rnvkqhjcP8zjJJg72D3N6iDCg1fTdeFwox7r2M4V
         IC7DtgAHK3wqr8FBTnRs9B8T9+TRBTfDG59JZQAGDfaMS/5LiTuP11DAQUTyFbaKScic
         dSwf8bUfMdztO+H1K1UPsAdKzjz+qoVXL0fX5Yv9e+8xXvuqNxTp+7bBsgu5Ml5x1lIx
         rxd9SfuOLLMebZvjV1qWd6oiFvK2zU0cvTdF0js7/c1xHMw5ykvW7z41I6rvASgZ8yx0
         uTBw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ2+lv+C8+8CUdTxiCK7mxFxwEL3pyL6kkoi7LYZDMqnFL9mZsY4N2KR/B4EFg5nAGH9FYGN5wMCh2GEKV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9etSA3ulgc5e2UM6u5mc9zfNi5Le/txNjsoPdotXxI1DYvizP
	SFv+ln352sxna21jVxEA1TXpTRBQ/3+VrB42u71V569A2YMAwZ3EFXsnMQi/CaTxy2CpbDIxDQY
	G
X-Google-Smtp-Source: AGHT+IHKNpoltll7NBTDqQCuhHqYQuClaMHU5uVpi5A3kCLXHERCnznscWdXcRmCYd38T+LoIPEUew==
X-Received: by 2002:a05:620a:1a09:b0:7a4:d54f:7fe8 with SMTP id af79cd13be357-7a9888a02f0mr526852385a.19.1725481979373;
        Wed, 04 Sep 2024 13:32:59 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98efeaf87sm15689085a.76.2024.09.04.13.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:32:58 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fstests: add a test for executing from a precontent watch directory
Date: Wed,  4 Sep 2024 16:32:49 -0400
Message-ID: <01dd22e13ea532321b968a79f6b88d6b4dd23e4e.1725481837.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725481837.git.josef@toxicpanda.com>
References: <cover.1725481837.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main purpose of putting precontent hooks in the page fault path is
to enable running an executable from a precontent watch.  Add a test to
create a precontent watched directory with bash in it, and then execute
that copy of bash to validate that we fill in the pages properly and are
able to execute.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/801     | 64 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/801.out |  2 ++
 2 files changed, 66 insertions(+)
 create mode 100644 tests/generic/801
 create mode 100644 tests/generic/801.out

diff --git a/tests/generic/801 b/tests/generic/801
new file mode 100644
index 00000000..7a1cc653
--- /dev/null
+++ b/tests/generic/801
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 801
+#
+# Validate the pre-content hooks work properly with exec
+#
+# Copy bash into our source directory and then setup the HSM daemon to mirror
+# into the destination directory, and execute bash from the destination
+# directory to make sure it loads properly.
+#
+. ./common/preamble
+_begin_fstest quick auto fsnotify 
+
+_cleanup()
+{
+	cd /
+	rm -rf $TEST_DIR/dst-$seq
+	rm -rf $TEST_DIR/src-$seq
+}
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_test_program "precontent/populate"
+_require_test_program "precontent/remote-fetch"
+
+dstdir=$TEST_DIR/dst-$seq
+srcdir=$TEST_DIR/src-$seq
+
+POPULATE=$here/src/precontent/populate
+REMOTE_FETCH=$here/src/precontent/remote-fetch
+
+mkdir $dstdir $srcdir
+
+# Copy bash into our source dir
+cp $(which bash) $srcdir
+
+# Generate the stub file in the watch directory
+$POPULATE $srcdir $dstdir
+
+# Start the remote watcher
+$REMOTE_FETCH $srcdir $dstdir &
+
+FETCH_PID=$!
+
+# We may not support fanotify, give it a second to start and then make sure the
+# fetcher is running before we try to run our test
+sleep 1
+
+if ! ps -p $FETCH_PID > /dev/null
+then
+	_notrun "precontent watches not supported"
+fi
+
+$dstdir/bash -c "echo 'Hello!'"
+
+kill -9 $FETCH_PID &> /dev/null
+wait $FETCH_PID &> /dev/null
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/801.out b/tests/generic/801.out
new file mode 100644
index 00000000..98e6a16c
--- /dev/null
+++ b/tests/generic/801.out
@@ -0,0 +1,2 @@
+QA output created by 801
+Hello!
-- 
2.43.0


