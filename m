Return-Path: <linux-fsdevel+bounces-72176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 335F4CE6D45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 14:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38670300FF8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 13:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ED4313E2F;
	Mon, 29 Dec 2025 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYyyUlGw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA43126A8
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767013082; cv=none; b=C31L5LZqnKacLw8CAfHBtdXfB+HdCFYtMPpUHD6jRAcfdjsioXFAJEiMfqxoj1Y/2Ath6wv9m5ia+sTkhfzpGDKRFPgMPv8LTfrN2niJbf/9MkxMbFJfRH1hqkFty92rpcI8PadCctx6RXKrQaOvPjuRIuu3yNpHXxp0qjGCPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767013082; c=relaxed/simple;
	bh=ta7lZGA+hai2JyTArwPNBQWsuum5zr06k8vH75DR8FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CDbsiSRac2zSX6OiwU4QUPt5Mf0cqpILAI4FZEDenDNah0ljNRSo/pDQeJFapjdrqC7OX9vk0cLGR06aJF9ecLrYIMRPqi350bxRLpoZs6NDiCIQhbNzOoHg97GsFVZX9megyNvFHTBvknRciTorTonk/UeLXf3vO029zvARxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYyyUlGw; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b79d6a70fc8so1583152166b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 04:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767013079; x=1767617879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JFlgmBF+dAOw4m3iy7iEt5EI8FOvkwW5KU9tIs4MiuQ=;
        b=fYyyUlGwpYCQpnOw3v8CQ3Fo9QA8NypAJm0pUAkfJfrGu2EFygMy0+VXQrW291GAPg
         Jnge5S11aOnQiOz7o1aj3wpTm97BFXNJWVUheDQjKc1KVfpPVMsj65AhK3Iw1UsDufsC
         1Q/ycGlbBu0I+AnSMOkZr6cJBbPCM4+3OTnaDLxJr9pGtWRRwkRUgjT8DtiD4akUu+Kp
         r1E+PUYu2dzUOcV+ZLpRxVygqc8ilcMjO9iLmSfGAJ2Pb1gD3pIMJ19L2EYq6ybUC0yv
         GHC8+quRvzc2LSrRY6GUMDti//3yB+uw4JuCiQFiOamyO81eTXPZgyuBvF2d3K5v1OGv
         hVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767013079; x=1767617879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFlgmBF+dAOw4m3iy7iEt5EI8FOvkwW5KU9tIs4MiuQ=;
        b=KNYiiwTFrGGipUpNUfiAsIOxUmnhu1xtC+m8jY2O/gC2WwsKPUBw3mQ3Gl85BkFQD/
         tltDMPlwHcd0f2y6zh1T526Fg6ixEKRtzuV6BaMlWp7k7iQgCIkyzTZqogRzaTw8kg9S
         /m+mZKIF76Z1yEt3ogf0qOAMe+Lu07Etns7CI1dSki5L39UA+33uZfzXox8w2EjCjENL
         /aXoC+2HNEUEyrb8mO9QDwiuZ/h9tYITNcyBZZ8VMmCsRIgXFd/4ySG/VyD9+rNv0A+/
         ddXjKaQtG6nO8wMqkge5EP5E5oYAYgVdzDVdQeDJXgpA2kCHI1PszAkKMxg5dAVC9FfC
         vipw==
X-Forwarded-Encrypted: i=1; AJvYcCV2teVFyukr3kKKKZrHqxAExo2PxfF3FsYyq617roa+r/fsU3EFfSWqYF9XabLLN+mqnHvq2fFb6qJcJQ6D@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+CP3PFZ6DxL1ts8H76uVqPk8OWk1ZCJ1jH8teDO/QeiSOkOb
	iNWsAOrQc3nT3mJZ30qOIa21hDViOFUHopuHdh+1NrA/kCyMFO8ARgF7
X-Gm-Gg: AY/fxX6HfV3e3TdRDQEHVGLec7R9MFm4qzViR7O6xhc2X6vim45yZ3rZgBw+croEoBS
	OGxYU1Zcbcu0aaIHM+DAOkiDO9uVxeMRwp3IUhfUjwpvTXWo7HJI1Np6fSWuJmQDwiymQDsbRgf
	ouVHaJtT1/SQkp+cD3LM1eHCpH2nguAI73MzpxPgR8DJxBB2TzxaKDalVkZloh6dC9q49oOChOE
	KPNlqq696fK8PdnJjtATF9EBvVG1El71GbzbUeBp9G5OQEQoGTJxyO5/8+zfpPIYA3yi6gE8fbi
	EOzmams17zTPUkTl40MTNbLCwqsya3elW27LkmQVywPlPUxX+8GC9bj2C7vn7P7C77zFGyWMhAj
	/FFw2IvRbysBRgMP3UCT/1ZPJ+KAFKrVJF9ngybnLPevfRcoXqlw80sqervI689LiszFXdmuI/C
	8Jx0qJc64tJW0RIGGmYBqHVwFx9fGc0bUR/o09FwoHytWRBNkeo/qYcnn0M8l7gg==
X-Google-Smtp-Source: AGHT+IHYbDO6SQ29ghTpyGHFbkDHeKHNdJl/FrDAFqwDNAjYU07KwKyrkDXE8N5Al3/Rd52qAimBcw==
X-Received: by 2002:a17:907:fdca:b0:b76:3bfd:8afe with SMTP id a640c23a62f3a-b8036ebdd5bmr3185431666b.5.1767013078944;
        Mon, 29 Dec 2025 04:57:58 -0800 (PST)
Received: from f.. (cst-prg-87-163.cust.vodafone.cz. [46.135.87.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a60500sm3300549066b.13.2025.12.29.04.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 04:57:58 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: only assert on LOOKUP_RCU when built with CONFIG_DEBUG_VFS
Date: Mon, 29 Dec 2025 13:57:51 +0100
Message-ID: <20251229125751.826050-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calls to the 2 modified routines are explicitly gated with checks for
the flag, so there is no use for this in production kernels.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index f7a8b5b000c2..9c5a372a86f6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -879,7 +879,7 @@ static bool try_to_unlazy(struct nameidata *nd)
 {
 	struct dentry *parent = nd->path.dentry;
 
-	BUG_ON(!(nd->flags & LOOKUP_RCU));
+	VFS_BUG_ON(!(nd->flags & LOOKUP_RCU));
 
 	if (unlikely(nd->flags & LOOKUP_CACHED)) {
 		drop_links(nd);
@@ -919,7 +919,8 @@ static bool try_to_unlazy(struct nameidata *nd)
 static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 {
 	int res;
-	BUG_ON(!(nd->flags & LOOKUP_RCU));
+
+	VFS_BUG_ON(!(nd->flags & LOOKUP_RCU));
 
 	if (unlikely(nd->flags & LOOKUP_CACHED)) {
 		drop_links(nd);
-- 
2.48.1


