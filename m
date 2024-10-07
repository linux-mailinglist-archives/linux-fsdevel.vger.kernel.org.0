Return-Path: <linux-fsdevel+bounces-31152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA622992792
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 10:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7516AB22CA8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E601D18C012;
	Mon,  7 Oct 2024 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BghIaYr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB3618BBB4;
	Mon,  7 Oct 2024 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291190; cv=none; b=kJ8aMReskSkPX0QwdeOOgKUBamySi1+Yw/Fa9wINwwFQuWoPscIpwJEd3XpNdhxpBkMhbclUDTD/wrVjqTd582g/kxQxjtQQB4Znmq83HBneX3mffyh9icY4EF/pCSX4T3pHGdf9YnVHQBWCLRqxsWo1p1u9p4QW1UInv3IAI3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291190; c=relaxed/simple;
	bh=Dt8anasy0laNKdHF0W5V+tqgv3LYZ9v/t1hjF/BjQgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAE0h3kACBZJM5lNo4L2fGcH39xgWf03JeSX0+tBvN/HYzNZqSgcPbTMGptCo8uIVyye5DR+ykcV/h1zDUkNv4d5bZJHxRTXJykFfWzAfhjiT/fm4usvlZB3FkrIvmdbSdBM6L9flJiYW0o90Fzgp5p+gXx2cTCkfvr3UMU39XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BghIaYr0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42e5e758093so35356305e9.1;
        Mon, 07 Oct 2024 01:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728291187; x=1728895987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9e53axX5+JQ6EBke6BbptR+qC5MfqAfQKE74IO6eBWA=;
        b=BghIaYr0OezwccUoXy8n9iqvo8zZrhncpwdEF9xsV4yZoLoqj4OOeyrmTShWNc+bE8
         V79EIql6D3c3plsdl9cBlMmX1aMUeqqOsfQcZUTSW5jpGIYGj27gCJ479Bx/jPr+8SHa
         PpBu3mk6NaO7OwTnZDq490B0PHvvUAkvEHkpsaXBFTJYJVQhLHUf7pD2dEOB55VoijeY
         HfzbOdO1cPzHiajUavgNskX4HNMc81rl8hGKmyJ5NVJ99JxGMI6KZ5triP/9CCVpJQtr
         UR9jwy6HE+dC7dm9T0C6HOqU7w/CGiyI/4D16Hwv6TnqKw0uFaIq5ECEI1mSdE9ehAnj
         05Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728291187; x=1728895987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9e53axX5+JQ6EBke6BbptR+qC5MfqAfQKE74IO6eBWA=;
        b=PEru1w1kGNYCx/iXyEflKgptfCoAmHpJ/0oLYT7XwNu0q0mmj7ShD+yfVeyAFwbE1J
         zT2O2psxn2UDoHutTqrhjitIfHUqaK89Yc4BtajozVMw7VP2LE00r7ryaRCUp1qO8y1S
         QZ0OPs7e3Uc+czUm7yCRcwuYyvstsGORwDLL10YFQcePfBUzL4K5QawFvCmOJBE4Qa0c
         MRM801g6h/jsiWQ5xSyP/tnslxjZDpTAcjcvyYN1UYLuiF2J3U4RWl+OS7jFz1SJJZmI
         tOKs77RoVEyfBjhNN24kjOhj+5PvFeAsFa0wZBO8W0UraAaO5ZQbU75O34kgb9epgvK0
         pEEg==
X-Forwarded-Encrypted: i=1; AJvYcCWwTGZ69SHBfqm5d1yE6dAOeSBj527zZdL4zSbz6pu6l+gAStoKHl0x6khABTcCnnR5cTUljW8sYYrxFUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGV+zxN5f3kkzlxhJ2Vjn9kKYdtgvBDiugLlDXZ8QXaITTFTBX
	J5N2yTguIQWfqeT9OBxBBEqVvA1p2ZimfV/054vBGGpiqbb9GwWvrgCjBPa7h6w=
X-Google-Smtp-Source: AGHT+IEOCqzTwmrbjB1VBZ0KaELcwYeEQJz8mgwHyCVQIEqwxF3yAa9d9z05gmbVhoYy8tqATTLd9Q==
X-Received: by 2002:a05:600c:524c:b0:42c:bae0:f065 with SMTP id 5b1f17b1804b1-42f85aa32famr80686945e9.5.1728291186493;
        Mon, 07 Oct 2024 01:53:06 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed9d4bsm68244295e9.42.2024.10.07.01.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:53:06 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] namespace: Use atomic64_inc_return() in alloc_mnt_ns()
Date: Mon,  7 Oct 2024 10:52:37 +0200
Message-ID: <20241007085303.48312-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation and ease register pressure around
the primitive for targets that implement optimized variant.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 93c377816d75..9a3c251d033d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3901,7 +3901,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 	}
 	new_ns->ns.ops = &mntns_operations;
 	if (!anon)
-		new_ns->seq = atomic64_add_return(1, &mnt_ns_seq);
+		new_ns->seq = atomic64_inc_return(&mnt_ns_seq);
 	refcount_set(&new_ns->ns.count, 1);
 	refcount_set(&new_ns->passive, 1);
 	new_ns->mounts = RB_ROOT;
-- 
2.46.2


