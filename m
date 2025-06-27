Return-Path: <linux-fsdevel+bounces-53170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317E2AEB54D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 12:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CED1886975
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 10:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2772980A5;
	Fri, 27 Jun 2025 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MguarB3+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250E026E71D
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021321; cv=none; b=gL9CZhiaGH47SgHJF56ddMv63uqTp7AuhMIlwgwIfNC2JduFk9xhrQTaCsBRag2l4OJs1jQbFwq+QwzKEXrt0TumQ/ESkYgWBb+8axlCKcA/v7SLHCCOR/44SOLwbkiapj8xcrNGkMyFi2a3pCZN/aViTqL681KoippEHPntMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021321; c=relaxed/simple;
	bh=/85RuOPRdz10WhtV5tg0KaDNAsN83d7RTJXtymvnvfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PsIjcIGHZHLvbmeU8WERTJ/B6Z4e3TUJ1ZB7R88eZY1U89uLbxSJ2XXRzxmSXPL09fTUtW/oLeOahhJrLZ71kdl3mCXznGJqAz76KdtZMGkrCQHUTdeBWJYGLzUPGhlDkFCCOiWToUM6sxp7W+jklczghA9iix+EYbX4nU5reWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MguarB3+; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso3800096a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 03:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751021318; x=1751626118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sed18JzSciCIl0x61XPqbPhfFm4AeNRf1L1ILSV5G0A=;
        b=MguarB3+wfPLHo4MqvRhl9yssVGHoYZzOkVoKNVXtEm4Pf0ZMi8OAhbvhTmUvDf41R
         lVj9fu9Hv1/qJRJ9S6DjePg+IuqY/dKlVPFDtIVWDAEfH/GOIK8zmN39fo+kr1rSR7Em
         8056TBNjYrLzMwgW3lWsJxqw8KeAgttQuEvYBWoZVcYSeQQlVAiYphLpDhqnVDjtuiPo
         IFmI+bhfSmxePwKP0CPrHgZZCzt9Ddl/jYvaSFUafeCN/Y3DnU3TxAszVtWOJoEyMICG
         2HViBfLJImdJeOepg/sQV3jMG7RlmFxeQk4yiKdzi1ySPQ2tLBregjUmfPGPNY56B0hx
         KqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751021318; x=1751626118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sed18JzSciCIl0x61XPqbPhfFm4AeNRf1L1ILSV5G0A=;
        b=v9XpagHOUZ0l0XAGIxKse20fN+t7Um83ynIsKzZ+48MxRXTPXYtikUqNok1MrreJl0
         IrXO2fd4B7HYnchc+bRJNOGRYUwPQC9MVr0L3Zu65MqwPw+VdID+hqUN1XeDd6IePrmr
         9Er/iYgclSF7gL9ZZKibQbkfDp8NXh+MHykM4GjSMODm8OynMuHAPrGgubhWD1CVCHuP
         jWvqR/0lXj8RPc2n26hbCR7+IzCvy9ohBVSTXCU0uL+7WS5jY/6EeQjuEE0RjsFeYxRE
         XHiwNoZAoemmlDTmW61+5+4VvjER0w4h05R52tdHZWDYjWMChEDv40jtifkWb32Iyf40
         UFkA==
X-Forwarded-Encrypted: i=1; AJvYcCWoziKspfInPtFrzjEOb8ch2JD+TefSqfrbHvI7ZAFqHQ/V40ro5A1sie9IL6XL57vIZQvFL3gbEWi/5nnA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7yIcIGqtx5AVkeoDIwNjy7ff3LU7nNW3xvEFPs1ytyAXC9Iv9
	4ZkbnE9Ldu/Jq95e399PF4ATExFNa+Sv1m1oeIGevniX6ygF75+wM4ee
X-Gm-Gg: ASbGnctuGRygZKB8sc9R6wPnJCKYfLqjOklXmFowjIW9DRXl8kU1tWIkGfBh3u/MKYd
	BJkMpGnZB0CL2Eh5SwCymZ+yq4w8xyy73kD54HcHScS7bl2gXxjJTcdYqvvQbtrZk2lYIz5BPK1
	snpc4qhLLbutVKNkQrhV6bIpCGMOSLUZSULQmbIRj0/fETNEtDbFuI7NCb3X3Fyuw6HS2gvrjbO
	LXC57gLQ9mqd+bbcsGenuXcRoACYHSyjSwLmDk96HatGWtI6a8ngGxf8IJqITsG9HS/3ZHRdgp3
	MqqdnTK46717Ar933Qa3TIpuHzK2CArB8G/FKBMmuM30YDvaN7gpDldU85/D/1rvddP+7m+Q4Fb
	ga1uVDQaQO222A+AwfuVtYNlslHeO4ofNL6eBwiFQG4fv1Zpa7fjbStyv0Fc=
X-Google-Smtp-Source: AGHT+IE33cdPsNxB6F5M8JBNZXmSKLSJKxjzCLf/2mzLRwTjZFX8R25CTiPfEWoVc9voh5QbNpXJyA==
X-Received: by 2002:a05:6402:27d4:b0:60c:44d6:281f with SMTP id 4fb4d7f45d1cf-60c88b2eda0mr2269459a12.7.1751021317975;
        Fri, 27 Jun 2025 03:48:37 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c831d5fecsm1296565a12.63.2025.06.27.03.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:48:37 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: sanitize handle_type values when reporting fid
Date: Fri, 27 Jun 2025 12:48:35 +0200
Message-ID: <20250627104835.184495-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike file_handle, type and len of struct fanotify_fh are u8.
Traditionally, filesystem return handle_type < 0xff, but there
is no enforecement for that in vfs.

Add a sanity check in fanotify to avoid truncating handle_type
if its value is > 0xff.

Fixes: 7cdafe6cc4a6 ("exportfs: check for error return value from exportfs_encode_*()")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

This cleanup is a followup to the review of FILEID_PIDFS.
The Fixes commit is a bit misleading because there is no bug in the
Fixes commit, it's a just a fix-it-better statement, which is
practical for stable backporting.

Thanks,
Amir.

 fs/notify/fanotify/fanotify.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 3083643b864b..bfe884d624e7 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -454,7 +454,13 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	dwords = fh_len >> 2;
 	type = exportfs_encode_fid(inode, buf, &dwords);
 	err = -EINVAL;
-	if (type <= 0 || type == FILEID_INVALID || fh_len != dwords << 2)
+	/*
+	 * Unlike file_handle, type and len of struct fanotify_fh are u8.
+	 * Traditionally, filesystem return handle_type < 0xff, but there
+	 * is no enforecement for that in vfs.
+	 */
+	BUILD_BUG_ON(MAX_HANDLE_SZ > 0xff || FILEID_INVALID > 0xff);
+	if (type <= 0 || type >= FILEID_INVALID || fh_len != dwords << 2)
 		goto out_err;
 
 	fh->type = type;
-- 
2.43.0


