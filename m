Return-Path: <linux-fsdevel+bounces-43255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CBAA4FEC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 13:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D6C3A8DD8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 12:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE24248883;
	Wed,  5 Mar 2025 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7OG+B6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634C720551D;
	Wed,  5 Mar 2025 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178220; cv=none; b=R1a1xYTnychYfJxVIQUT5rlyVxC0rhVKpUglsT6Qi2ByUzysU6FE0VzdiCotDbxeuvQdmgJYCOckNT9y0cdkcAO4Zgm2A85P3ytRjt//IBV1/2umXzq3ScFi6zYEjX9q8ewocqm8vx3AcsXXepNPdTE8aQUfZpQlLx5pMOjCGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178220; c=relaxed/simple;
	bh=5uPV6u6EoDWFX9T8+OqpJcxy9wCcoz5cTg+5Qc1MY34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCtvrhicWqOFivpsutDwnr96WCI2d3uUkX3hY6AXNBYUqxn18rFNKq9J5drQJINK7P/w6BbB1UkIPzgOV41K6qf3tNmav1ahoCl0B8EuZS5Z4vOI1eqb8ED2AiwTNqCqM+Cx/BIsOmmozrOdA1IY1Svd0I4VOMaUh1kWBBqgEk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7OG+B6O; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so1754845a12.0;
        Wed, 05 Mar 2025 04:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741178216; x=1741783016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihb5fa+ewtwZTTtF9ovoC44tIaJrnCvIe17/DExrK8c=;
        b=N7OG+B6OJpRcqVlFKCXvNKuQoPBzEV/I5ZjiU2k864sHF5ZfW5Hmm1b6HlsU3gUO04
         xKFWtRRNDDt6T2i8wIeXoEPNXh7oWuqPtDIJ+4bVAWJLfodVbVaLxdqVzX/PJiMpV23B
         mAJYv1cfBtGaYG8JTIfkcyeqJBAGxkD8y5m4L9kzW1YB3Op7murvRinAGHbTQT7KC/I+
         WsoNSS7hBCE84n4j5rC1G6FtUDsfnlXINJF8FcdvmN8fyB3j+YV4VWxJM4MyXLyq6ViH
         dGQ/ln/0QumINA+0hjGea7qf4wnO2EcMx5G3GKuhHRP7jfT7qa/xGfWoz9vWdubSiuAL
         rMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178216; x=1741783016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ihb5fa+ewtwZTTtF9ovoC44tIaJrnCvIe17/DExrK8c=;
        b=j4e7EbFzx8oYpNZNyARlK6RbNIaz6XQalsePkGU6j/YoxcsNK9NtmnGlRsdCcgy77H
         3xr6CCKx5qMytm8DIRTxHSXig7tmKfV817VshLkHHKUxIf5BWB8NPbG95ur5r6d6grtO
         5anEULziS6XbNqnbI81T6/3gK+weY2UdXGT3r4fWzUCHsUkNk3kIubMXvjVT4IVuCWf7
         ixXHmGmaYlH3OLsRJTYZZanUj0MgR/zdjRE0+Y/3zkHAl3PN/Lsp6gphnPfV41nJFznY
         NzsFfk5Aa+0q9sYjaMqUtqoOOjkC9kkb6x9izbEKWggsY1QI40FCtnb4tyNPGj5p6dgG
         rC2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7XtKgqzsZPxg4Kp3yJ62VolhUJjzXfkXO9t84VLdD/pn8t8euGFCDrmvzDZImNg+2CLAa3rbIK/XYh7v+@vger.kernel.org, AJvYcCXNCb414S6tHjrrXrRVzLiaQ1k+KjebzTc3I6PTM/LPgpMhEVv81pFqJUouHjrBPu+LT3GId7PWzx9CEXAu@vger.kernel.org
X-Gm-Message-State: AOJu0YwdibOIdjaxrf6TEx/JsDinZVStPYBMyP+OyHbF1BJVHpjwOm10
	dRceLSnbCSCUIMAxnkKPbEGQTt7uCTufzEV+l3J4AUcoC/Chtc5+
X-Gm-Gg: ASbGncumyp39lGbvmd+2F5Muc5+FUS3By3fhxkkYwZqtDJu879gHQCBa1f4CR0gWhJe
	/Nh/xO0hXSGj6H/ydx8RXOsm8yCAv11/OHgOMlclq+kJzzqso48CKQik4zcjT8OIM2KhjkllaDe
	1WVnUP6Lpi4zBJ+7OgHonAl0MoRC8M4RlwlhG4B8Ub5BHCKy02OKzTfJ7hb8Z6oCQNCPFUkhvMS
	CKhGwexkVLo81cNqBtOZKzhC5JsAVuwY1LQ3av32wWuU6Yz0rUO8ZYAXp2cquQrfuT818Flu/F/
	/qUTBToibwObbI7pVWakmvSofx716Pswy6Z0mM732PQOuemRRr/FiNSinwmt
X-Google-Smtp-Source: AGHT+IGa4M++3EToLwZVWWaLP7erRKKGe3l3GeVT3S3aocMyh/TKoZrE6dig4uXC/MDemY1hzVtQ2A==
X-Received: by 2002:a05:6402:1cc1:b0:5e4:95fc:d748 with SMTP id 4fb4d7f45d1cf-5e584e2916bmr6730421a12.5.1741178216292;
        Wed, 05 Mar 2025 04:36:56 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6cfc4sm9632068a12.18.2025.03.05.04.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 04:36:55 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 3/4] fs: use fput_close() in filp_close()
Date: Wed,  5 Mar 2025 13:36:43 +0100
Message-ID: <20250305123644.554845-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305123644.554845-1-mjguzik@gmail.com>
References: <20250305123644.554845-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tracing a kernel build over refcounts seen this is a wash:
@[kprobe:filp_close]:
[0]                32195 |@@@@@@@@@@                                          |
[1]               164567 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

I verified vast majority of the skew comes from do_close_on_exec() which
could be changed to use a different variant instead.

Even without changing that, the 19.5% of calls which got here still can
save the extra atomic. Calls here are borderline non-existent compared
to fput (over 3.2 mln!), so they should not negatively affect
scalability.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/open.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index f2fcfaeb2232..bdbf03f799a1 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1551,7 +1551,7 @@ int filp_close(struct file *filp, fl_owner_t id)
 	int retval;
 
 	retval = filp_flush(filp, id);
-	fput(filp);
+	fput_close(filp);
 
 	return retval;
 }
-- 
2.43.0


