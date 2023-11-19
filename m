Return-Path: <linux-fsdevel+bounces-3131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF487F046D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 06:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3BE1C204F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 05:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0A05257;
	Sun, 19 Nov 2023 05:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6/Ce7S2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EC6192;
	Sat, 18 Nov 2023 21:06:28 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66d24ccc6f2so7556746d6.0;
        Sat, 18 Nov 2023 21:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700370386; x=1700975186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad+7DeeKonJPGSO2EixeCkfPYP/580kvKkx8jJr6+Sc=;
        b=U6/Ce7S20SxfDhHPfqVTdsivI2KF5mFZcQYjMCLlR7W6j6Qqu86NS+9cxXEXa8kS8u
         4JeiCWON1N2VUS4qpJ76H/8Ca9qnBgkizbmLJmlnMikoQoACOx/gUfrf/WUk8Ue9XdPa
         35ZufkeC/vYRbdGBeJb9IbXmkldNcbkPVaFQ4pq9CQ9ZMgabm6SdloYvGCn4z8neNyKO
         9FmelPl0wHlri6xkPn69FC55x2Wy9iM4XUdKXTWG4qO+S5gkf/2RNC6avuwoumLY+SDH
         gleGxC89W8EhqTzUcpxszXqmwwpkWKxUu0B7KACnzcNpHxzqwTvxJj0BDEZplG2elbCL
         FKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700370386; x=1700975186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ad+7DeeKonJPGSO2EixeCkfPYP/580kvKkx8jJr6+Sc=;
        b=LD/YF1vsdHDQx6UtEEW5N/uuBEy972fTaIDS0oX7xwhviIhapQPpcJUxc2r8FyDxS1
         qieLOputHF/eoTx7pjV8Fd+CgDUe/mE5j2/2JQUxakShx4Sr9gCVvJV3+i8KygLO2Vv6
         MYtBE37AMRzRvZtw21n/a5pA5TuDzq8CcFDJWTKP+vwZgaIDaCR5Z/A0Crya6c9/sHDG
         f7bdNN1hgv1cnJPGHpTKmtPyI5KN24UzuR1qeuXzIzOBGtMQu3qDiEDSH87ArDhEtnMS
         46RBwbb24A2G+kR9gU+dfESkEv3kn5HEBmFlqtgvsTNbUQdyaoSAoaeAfRddO7jiBlRi
         t4gQ==
X-Gm-Message-State: AOJu0YwRo0/3Snyv+NkwaNsIYu6H/q0C0B7U0hNMcl1VpCExmFtfz9fh
	lmH4tD2um4HKe1bsCFN3i8tIXYyA5VSbsfhx
X-Google-Smtp-Source: AGHT+IE6ewIOz7fWAiRRlnSfkTDbduM6WX9t/1yTRHj2fOjEVYBSYH/vPjNG9c6Q0RtzPARe+XTosg==
X-Received: by 2002:a05:6214:2341:b0:675:ac72:f4ce with SMTP id hu1-20020a056214234100b00675ac72f4cemr5209912qvb.28.1700370386558;
        Sat, 18 Nov 2023 21:06:26 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id n5-20020a0cec45000000b00679d4021621sm177070qvq.145.2023.11.18.21.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 21:06:26 -0800 (PST)
From: angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To: linux-kselftest@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernal.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	angquan yu <angquan21@gmail.com>
Subject: [PATCH] selftests:proc-empty-vm: Remove unused debug write callIn the function test_proc_pid_statm
Date: Sat, 18 Nov 2023 23:05:54 -0600
Message-Id: <20231119050554.52096-1-angquan21@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: angquan yu <angquan21@gmail.com>

In tools/testing/selftests/proc/proc-empty->because the return value of a write call was being ignored. This call was partof a conditional debugging block (if (0) { ... }), which meant it would neveractually execute.

This patch removes the unused debug write call. This cleanup resolves the compi>warning about ignoring the result of write declared with the warn_unused_resultattribute.

Removing this code also improves the clarity and maintainability ofthe function, as it eliminates a non-functional block of code.

This is original warning: proc-empty-vm.c: In function ‘test_proc_pid_statm’:proc-empty-vm.c:385:17: warning: ignoring return value of ‘write’ declared with>385 |                 write(1, buf, rv);|

Signed-off-by: angquan yu <angquan21@gmail.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index 56198d4ca..74ef8627f 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -382,7 +382,10 @@ static int test_proc_pid_statm(pid_t pid)
 	assert(rv >= 0);
 	assert(rv <= sizeof(buf));
 	if (0) {
-		write(1, buf, rv);
+		ssize_t written = write(1, buf, rv);
+		if (written == -1) {
+			perror("write failed /proc/${pid}");
+		}
 	}
 
 	const char *p = buf;
-- 
2.39.2


