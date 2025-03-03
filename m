Return-Path: <linux-fsdevel+bounces-43011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6532A4CF09
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 00:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2391E3AB5BE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 23:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FE523C361;
	Mon,  3 Mar 2025 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEkhqK8W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595E238168;
	Mon,  3 Mar 2025 23:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741043069; cv=none; b=tVyeJiE6SDNsiaHf6EEqLk1zKBCg6BalADdOhPuzANTQnmXmx87FKyQOhvQodG3U0RJDkaTrlgK3jQPcrQDdE3RwPvnKxPuCvjN2T9oMhj85n3r/qSJsRxhY9II29F9Ahpw3U0hNX2/vuwX7bJdvVXmyMjHTfy8lvzxZWHRQYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741043069; c=relaxed/simple;
	bh=tEQ533kksjXGY8tD8D0SZayWWYqIXB0bcacCbhDRu2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJpK+MZTvzM87rPtYv3mi098yrpN5mDd/r4Xfq0EAAv7zNKS5SYkN+uGUH+VjbUcdh0AMHqQGuJDD+ymHccbQXxCA2DE7nvIFG5/flmkQ2GVjpo6gUXIGonYCGdJeVNxVoHJuGg2F+Ote9yGCUlKw/9QTCZwFlSKDt95YrEwAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEkhqK8W; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390e6ac844fso4355759f8f.3;
        Mon, 03 Mar 2025 15:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741043066; x=1741647866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UQjCzyJWGgkfb44zXW5IX8+lG9S3hrWSEeHbM5kGRo=;
        b=hEkhqK8WSeAxWYcbbAAmhsH39yak5AXk8o06OqdSOMLJcrtnLOAVXkEfQSkkqo3cC2
         MuK+G+OddFjOE17B0koFLdmRBluosGzzhJ6ZyGBKjQPw1mkkGDTkGg3d9td1LVMgOYkf
         utAVSV5EhpeFk4Qfmd33pgQUOUOLmjDRVT/n7/Xe2GS0WGyFMIx8HFyHtCqy9++PuicU
         SHAPlk2HcxK6R7Tpl9N1RraRejqywjm4Vs6cXU83ntcUh6Y8t5Xpj/Yc26lf7vOEdrRr
         JepB2EKh4dKMlC6ffoIP7E9z8+nG3kGPRDS6lH7aT1HMesHbm6r/qsRv3YhkcDZ4PswM
         hcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741043066; x=1741647866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UQjCzyJWGgkfb44zXW5IX8+lG9S3hrWSEeHbM5kGRo=;
        b=YVi32t+rolAlYTmsuqyTH9vpjKioMmR9FhRtrWtUORaJHNvN2mGimushzAccHqm8Ov
         nrcrrxTN4Un+nsZSQ1FFfY/hQVA+ResCX8iSwfLKP13cMVXz4iP1CLvFG1MJja52nvCJ
         pzKfaWq+8/qvLDF9MfggsS5KCU8DmPqdbH4m7TDurpLDVxq2p9dR58R30cIrdDlSih9D
         Q2VCqKwDyRBrhna9zPFFpT4K0gfIm8uHzUmRAbAB623dMf20j50QpXQ/KrS/baGD/+4q
         dC27rMpasMnW/FdNiPtpQzYgvZHpdZu/pwGAtoaifKhmYdoB8frJFFIKA33DG9gWy78K
         /aaw==
X-Forwarded-Encrypted: i=1; AJvYcCU21ZRX2zKWVsc2k4CNpAiL/XYcyNxin1yzF2b+fqnqGYbzlhA/x+BxTP6eXZFWbs2IlZSJOKomVoslLBBc@vger.kernel.org, AJvYcCVdxsCmiSb0XoDFdnmVYu9rFlksigJvyOxZ4cA/Qvxr8op8hyaywLEpSNQ89yGtoUDySLDps3KsyE6YiIuF@vger.kernel.org
X-Gm-Message-State: AOJu0YzaoB69TApVpSZ8l19sA+Swm8Uch3FvmyI/Gd7M6i+i4bkdl/Jq
	O36xfRBIsFrVVBLlosJV0d5uhl26I5wsR7h0ggKfC1fxtIH6Vdem
X-Gm-Gg: ASbGncubeSClubmIqVnyDxH+sy9/z2ZQGfohN7xfBfH5ihChtSrHpvmwZZmoVi6jR7l
	gJk+9y4N5Z6aGGormmkS/UfZG1nc6EeTsGXHh79vZm8pml3NiRCxD7462EORZMrBdAI+0Bv9HjL
	1VelucL3zHbGebzlAv9Ipf6v2PHfRZ49vaxEAtBZAeyznlOv5UTBm6BfKoAoUk4DIEG+X5X2uxp
	FYtAsUniHezT+6nTGzBsPETc9G+KANV0qE3EvGdwRLJ7Uf3fmtCDThEQSRvUKdFONt3oXbfTM1h
	rddcrseQMqakrX9DhYRAapNbo8w97PUTxmqC7yKALskJOp/8qGN3+Fm/83RN
X-Google-Smtp-Source: AGHT+IEK1ZoYabliYSlkdvkLsfTPa1S5Kb3ynKAt9CJjXUwU6rAV9fphbMObZonOP83FbfqouoIuhg==
X-Received: by 2002:a05:6000:410c:b0:38d:e304:7470 with SMTP id ffacd0b85a97d-390ec7d2099mr8375214f8f.25.1741043066308;
        Mon, 03 Mar 2025 15:04:26 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc57529fasm37679255e9.31.2025.03.03.15.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 15:04:25 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org
Cc: oleg@redhat.com,
	brauner@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/3] pipe: drop an always true check in anon_pipe_write()
Date: Tue,  4 Mar 2025 00:04:07 +0100
Message-ID: <20250303230409.452687-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303230409.452687-1-mjguzik@gmail.com>
References: <20250303230409.452687-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check operates on the stale value of 'head' and always loops back.

Just do it unconditionally. No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/pipe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 19a7948ab234..d5238f6e0f08 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -529,10 +529,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 
 			if (!iov_iter_count(from))
 				break;
-		}
 
-		if (!pipe_full(head, pipe->tail, pipe->max_usage))
 			continue;
+		}
 
 		/* Wait for buffer space to become available. */
 		if ((filp->f_flags & O_NONBLOCK) ||
-- 
2.43.0


