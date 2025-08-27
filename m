Return-Path: <linux-fsdevel+bounces-59435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2CDB38A67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 21:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA453ABF1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C421F2E3AFE;
	Wed, 27 Aug 2025 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2W4noo7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2E527144E
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323803; cv=none; b=FW3fnklc+hHTGtncuGeEV+f4zOYoLieqPFpKKrWjnLX1KLvCoyyuhrFHJ728uubYn6pyoZlpq9ikXz9EkrrNTMtcsvzhg1oBtcXKLhprKWIe18XSmJeN4uS3onuBKBx8d9ZK7X4Wt6PBNsKcC/MlpYW5yfpG+3E1Mbko7nfrNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323803; c=relaxed/simple;
	bh=1HYUpOApmx+Gv4YvCaUtB1vo/dyBTlyK6fXsMRaw6Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KnlFQ5gEtkXgDlhH2KUvHfn6NuPUQsutRH1KsYV2neP1lwwZAbNYcTuUfAJOlFrbVZwrxfWJLngpT4Ky51Gd0w4yh//MTc/1mYN/JpvcVOm4/Q3jIaBWe6s+zIVwlxy+bUidzxC9FKDJa/ZpH7po887uSFkgB4uc9Zg5XT7waI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2W4noo7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afedbb49c26so29114866b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756323800; x=1756928600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gOib3772jPMD0+XBNoRjjKyVNQ+YTSzBftsJB7rx9Qo=;
        b=Y2W4noo7Ehn9UqgoWogpd9YBI1qPDUFMpgcV+84TRASM48NRvvFW9Ze8hM02+L5v9D
         qJqpkgYdSuS1umH9sUMBeQYlkBj1ODi/qCHxCQ3ri1LM8G+rn/c7ffZUdKNzZl/OV9LJ
         Zh23VeE2VbHKwFwYyB2Dtrq8HBTI+mX9fbpM2goWOu7Vd12P5xPXPx7JXYTpBhem6yor
         Fo6Zcg8ih76gq1zY4s7Kl4uPJlLJTTUK5lrm254YwMoA0aRqv14smiwMQJwe3Co9nM6f
         1sneCoCLsMoT/GCJ4hlJuEwEw1c+BqNTb3fxH5lH54dvsHvxna6KpYC2mb+l5IU46UZH
         tCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756323800; x=1756928600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOib3772jPMD0+XBNoRjjKyVNQ+YTSzBftsJB7rx9Qo=;
        b=QzdxY2OoHxwsTCTE/T3oTkdSgxSQw4YxAq37M2q3v7E3H+eFIS695q1/72lE1ZX32i
         Vv+ldreu+irUuIu2SWtOXexAiY2Jt6e8JS6wWB7YZhWzsjEST88B0dHMp7EOHIrMzyU2
         y1LuP6/prUDebS0l7CQ9Qy5K0zffwXwHspJzxivCyaQA5dJFdlluVfa13PB8hnWeXeJg
         y3mZQfoXahsvupZjarO9Gnzn8HXCsj12SrKSeXXB6dY+qbD0+CHdeXmKn0Dqy6IRdp4f
         0gH9MPeZrXKDYHTyACEBSFa75PSbBYTkvdM07OVv7SQSmurI9vtACMbJXpaMT5C76Vlz
         FHSw==
X-Forwarded-Encrypted: i=1; AJvYcCWo2Meg/Zt6op9DKaVpab+S9GTvFlLmMNyT1Ro8Jwv+QjQW7qCmPviyqSFZ3BCN0SDwkZOh1viGDkVMXq56@vger.kernel.org
X-Gm-Message-State: AOJu0YznHismkn7/hxHf+FEvL30fcvWNJlkbOcGs/zShurYuE5c0CFax
	m/i7k0PYgVSIuRaAZNi5T/N5iOlUuRAOeve/wsnRUiBcZiC+ZkS7NOmG6cV+UKEO
X-Gm-Gg: ASbGnctGd7SKDZgC11+3HExEvbFMS460WZJNyxST5Rsd6yiznFwFiG9tnkozFiiQtsZ
	FHO4Wes/t9u3nQ5QK495abY4xhoCPIuNwJwq3iyDK/uqq0TIQhkY24PRYziNhF+QwOHc5a9J6zX
	Fpw8+Gzqe3vrKbv/C7+04P17/VdH74eMKkCXQWK5LuiuLRqc00Ax2h68iWK3yZPMarGvSLBj2Lg
	b7fTudSYDIiJfl4em7pUGvkWsFFD2tm5ae2T2VZKeIT/j9TGc58EL504RWSaMfDyK/HHFjWtTMt
	DZYe7EoSsBsuBHWYVI9pDvBjwcCYCqyrl7Pa4tpYHHCYLI5KSFAk4r0v4mv3jnhCDq/6pAO6ZWP
	2zIXK1rrIqH2IWlVVLyxqNTUmZGt2DURbwnXgZiltgoVr3bB3prc1sfWXNpZ5SdHpO0GVuc8QDm
	f6Agn2KlxIdkPN
X-Google-Smtp-Source: AGHT+IGPQ+cu94O0BEKqnqJe2Qn0D/drsU7pjxOcV3xTkrxcPC0+Vx3I3bC+86VdF/C0jtH+kbPTLg==
X-Received: by 2002:a17:906:6c1:b0:afe:94ca:1681 with SMTP id a640c23a62f3a-afe94ca2fc6mr719611266b.63.1756323799382;
        Wed, 27 Aug 2025 12:43:19 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe91744c3asm582054666b.91.2025.08.27.12.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 12:43:18 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fhandle: use more consistent rules for decoding file handle from userns
Date: Wed, 27 Aug 2025 21:43:09 +0200
Message-ID: <20250827194309.1259650-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 620c266f39493 ("fhandle: relax open_by_handle_at() permission
checks") relaxed the coditions for decoding a file handle from non init
userns.

The conditions are that that decoded dentry is accessible from the user
provided mountfd (or to fs root) and that all the ancestors along the
path have a valid id mapping in the userns.

These conditions are intentionally more strict than the condition that
the decoded dentry should be "lookable" by path from the mountfd.

For example, the path /home/amir/dir/subdir is lookable by path from
unpriv userns of user amir, because /home perms is 755, but the owner of
/home does not have a valid id mapping in unpriv userns of user amir.

The current code did not check that the decoded dentry itself has a
valid id mapping in the userns.  There is no security risk in that,
because that final open still performs the needed permission checks,
but this is inconsistent with the checks performed on the ancestors,
so the behavior can be a bit confusing.

Add the check for the decoded dentry itself, so that the entire path,
including the last component has a valid id mapping in the userns.

Fixes: 620c266f39493 ("fhandle: relax open_by_handle_at() permission checks")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fhandle.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 68a7d2861c58f..a907ddfac4d51 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -207,6 +207,14 @@ static int vfs_dentry_acceptable(void *context, struct dentry *dentry)
 	if (!ctx->flags)
 		return 1;
 
+	/*
+	 * Verify that the decoded dentry itself has a valid id mapping.
+	 * In case the decoded dentry is the mountfd root itself, this
+	 * verifies that the mountfd inode itself has a valid id mapping.
+	 */
+	if (!privileged_wrt_inode_uidgid(user_ns, idmap, d_inode(dentry)))
+		return 0;
+
 	/*
 	 * It's racy as we're not taking rename_lock but we're able to ignore
 	 * permissions and we just need an approximation whether we were able
-- 
2.50.1


