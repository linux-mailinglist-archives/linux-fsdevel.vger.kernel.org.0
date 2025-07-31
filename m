Return-Path: <linux-fsdevel+bounces-56407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08820B17155
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7426318961B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE206230BC6;
	Thu, 31 Jul 2025 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBiqWJLy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8864208CA;
	Thu, 31 Jul 2025 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965369; cv=none; b=tFr5BtM5apJMUb+Dq03AtsNtCfbq0qKxvLU6hWh+UU8Qxvj296BBXnDPTy/nTkjQNAE7KQbQDEzDzwsxteMAYP5T20l6yUROLkg71jQR9kYj6wKRSn9cmkNo6vJACAfEIQSobrlo28sEdNYuogHeU7rwbEOK7Ko/LwBA+Oy/WQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965369; c=relaxed/simple;
	bh=VQ5RkV649ShLCp8RYXjzbLSPMRZaQRIO7X/LgY6t39o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TeJhCfTw/5GG8/SejQGzUAnm726DaWUxuhmiwcmf/hLOO7g+Zm/Y14OgNDxIvFIl2KcggaribstqQRdQOApUKz5iTs7uuRg8ehSnkZnLn3aaxhWenTrd4/UspqxnQoX2KIdWxpW3AD63NIpGLfeFLSDKZYDmb0UnZrbdZfKKapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBiqWJLy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76858e9e48aso271941b3a.2;
        Thu, 31 Jul 2025 05:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753965366; x=1754570166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMGdjRkUKQxi3N9cwTVbJiWeKpGES0J9F5psy5nyjyA=;
        b=NBiqWJLyqZQ61gXOUFumxttjEoxrOg0lZWqsw7QIg+GAz+MUKHrCGgjFe4e+3UR5Uw
         L2KcDWaH8CPdTgUj1Fbla0sJcIVDazoDXnP78ActNvkzj7r+2Y0hfPPzlqKriMUEaXkk
         xsAkXtDJ8wQDxNbjUzglGIQqiF7d38RxC+86C2uMfwvdPPjgzjL3+V5ItjdSyzoKif3d
         CKAxOAPi8Mm70apUTUbdhtjkB9dqdJE9AwvUZeJHoZGX3Z0HPAR6inKmHjB2MWInT/sn
         zPblEAQH29KAzf/Fe8rZsFKxPN8PXtzJNavP42fKndZCF0z9WFv4OhcUlKVI+XfOPAEi
         hJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753965366; x=1754570166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMGdjRkUKQxi3N9cwTVbJiWeKpGES0J9F5psy5nyjyA=;
        b=YM2QhmKYdPnTegQUChChB8lPYGYxRzFEGnsGcOER0r1O2vRvAAPxhsoF5AHV8T2I6s
         8Qo2MWPvStkaleV90Hd52Z8zlyA/5xacQtdoBUV/0l6cKOuK72gXo3YBzRhnw4cmuNau
         HWHNIgGDw+/x0nGUTX1TQLJbmYzkJU2huNyTrqQ6NoJpbhZd439oKUG9h4dvYg0kbJnA
         lkKS10BWxID9zgBLpPzu/+9z5X85hJHNekibcb5yo/yAjRwDP42sApdyJUE7Qt11AWci
         RnXrfOj+PciKLE3TWpR8TaphTzKQbS406mc87Rq+1jv/h66q3c0+4+7/i4uosVl7xrc0
         sc2Q==
X-Gm-Message-State: AOJu0YxLS5yHikDJisr2Sqzdnsm2e8PTW8FVaHKw/ntW7/yvL0mPWNzo
	wO3MtipoTqQe51JQv/9yLIP5r2oT8O8stRlRkOG6E8pph2USP8qaurfhDUgzlvbK
X-Gm-Gg: ASbGnctPML5HR6Vxm550ENuyUzCkJSHM90aYvYHLhu7/hizVF31l/I7AmrUblWJTmOH
	Y4yiXXXhw17bCXgxfiGITma/YBctsGpee4oWeCj8S2NwjEcbhlKPt0uAjNB/vrfE/P7tzqa1znm
	E9nr97MqsLTlCBnsPvE/05rbNhrqb69A9mBYqca99CDQ1qxz/lEdZ4F9CpzWTfUMCo+OkHKoCe4
	HKXBeC+57kAiIUtMGePKNq0pMkAu0qgbnMnZNkG8slJedJxB7gI1c6gfKdobjNrB9PkdC5BYv0v
	ogqPtPa3MTEaKddZ9H196Hj8NhweSPNgzPrc7hNDS7hIzCfC6lLFs5J+mTM1aGX61nHxRiibV2+
	OO1s6/gEWSAPTIfS9p4ix2ZXQVkdh
X-Google-Smtp-Source: AGHT+IFhH05CP/gavPvxgQzMAgX2xTDytzArq+tkSa9MWharXxvWoodCSrNV+35rpXT4Wud8TPTeaA==
X-Received: by 2002:a05:6a00:10c6:b0:76b:d7aa:e00c with SMTP id d2e1a72fcca58-76bd7aae8ebmr462291b3a.14.1753965366462;
        Thu, 31 Jul 2025 05:36:06 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd0e78sm1510625b3a.99.2025.07.31.05.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:36:05 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 1/2] aio-dio-write-verify: Add O_DSYNC option
Date: Thu, 31 Jul 2025 18:05:54 +0530
Message-ID: <28abb8a0c4031ce07b475bf9026eedc23892868b.1753964363.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds -D for O_DSYNC open flag to aio-dio-write-verify test.
We will use this in later patch for integrity verification test with
aio-dio.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 src/aio-dio-regress/aio-dio-write-verify.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/aio-dio-regress/aio-dio-write-verify.c b/src/aio-dio-regress/aio-dio-write-verify.c
index 513a338b..0cf14a2a 100644
--- a/src/aio-dio-regress/aio-dio-write-verify.c
+++ b/src/aio-dio-regress/aio-dio-write-verify.c
@@ -40,6 +40,7 @@ void usage(char *progname)
 	        "\t\tsize=N: AIO write size\n"
 	        "\t\toff=M:  AIO write startoff\n"
 	        "\t-S: uses O_SYNC flag for open. By default O_SYNC is not used\n"
+	        "\t-D: uses O_DSYNC flag for open. By default O_DSYNC is not used\n"
 	        "\t-N: no_verify: means no write verification. By default noverify is false\n"
 	        "e.g: %s -t 4608 -a size=4096,off=512 -a size=4096,off=4608 filename\n"
 	        "e.g: %s -t 1048576 -a size=1048576 -S -N filename\n",
@@ -298,7 +299,7 @@ int main(int argc, char *argv[])
 	int o_sync = 0;
 	int no_verify = 0;
 
-	while ((c = getopt(argc, argv, "a:t:SN")) != -1) {
+	while ((c = getopt(argc, argv, "a:t:SND")) != -1) {
 		char *endp;
 
 		switch (c) {
@@ -316,6 +317,9 @@ int main(int argc, char *argv[])
 		case 'S':
 			o_sync = O_SYNC;
 			break;
+		case 'D':
+			o_sync = O_DSYNC;
+			break;
 		case 'N':
 			no_verify = 1;
 			break;
-- 
2.49.0


