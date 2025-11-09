Return-Path: <linux-fsdevel+bounces-67600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFB7C44537
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 19:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 117964E20E6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 18:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A628222FDE6;
	Sun,  9 Nov 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAIdjjVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A991E1E1C
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762714473; cv=none; b=CXIijUCiBYZdq+KwZaruf28/YN9vPo7xtgmOL3XhcTYOsxZuW+pPFQwviee2lM0dIteY5n3A5moyvIPIjE637PvpGDxnAlw0n9teWErAlNfj9Yl9Ld/72mSwEKp6hPZg/lhVE/PrgMNq+0xwJIE1D4/7BRI4LKGQPkM3ZRvsjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762714473; c=relaxed/simple;
	bh=J3Eapg6FSMiLMLlHLu7Lcc7HuutFBLZ75dfOfkEO7O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ABdCvxddgE+DbCSBSgzsrHxJSlxn03hRbg8LBJhjOzy+fTsco5v/dhtrsabMYhgmXdEV6f7UtGCYzlEjHseLeHBWEpENuaEwFa3GmriquYG/+/Yo5NdQcdp3byNykMuRfzOspUbCBTU7bG52Ly+pjnCSZsU8E2xovQUTdPftWyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAIdjjVC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6407e617ad4so3950399a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 10:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762714470; x=1763319270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8iwkTig1PIiP3eBZ+a+R9WXt8C51PQf0ZsMJF1LX55s=;
        b=CAIdjjVCcwCbfpSnMGxbBl0mu7lxqbl+fXAkirVoM88YIn+3HNuWAfwh4305rk4lQ4
         Eu8ehCbZz4j59bc97YY8VD28pyyka8ueeFp870yhXZmubPHPoJmwXObzDSKH/CKDkwnv
         P0BZ2DE70m6WxNAbraTFfWXu8DOr7yc9E64w5dZLEyk7021aPZnlhy3/tZ7mmw6MXk+q
         tWjEcxyKrQny6g+V2YWiO0QPnSc/3largxaQeoZh5qsQq6dfIKYKisHwqILQ/mTXHRgR
         UQ43uxWFfY7XhP+J8LL+gHQxNOicaWWAq79XvDOz4dchnhUdXjvd+vscqAckHrYO8LTg
         S15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762714470; x=1763319270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iwkTig1PIiP3eBZ+a+R9WXt8C51PQf0ZsMJF1LX55s=;
        b=R0ALsZ+tyAVlrS5OLHjQT3k281aTi2sKOM9kfeUKay+rroqsqHbUSa6KvebSCFei6m
         DXZ7r/ccH89vSRF586IwpNnzEzBrjsZFwlYzdpySYhElqCT2FJVOKqjhv2mARgeaR2MQ
         qwbbsu5B92L0I2gBxQfHIJFoxvTw/aUufjRwWzHdcV1Eg65NMHBUVc6DEmig38nLl/nJ
         N5aYHn+ubt7gkrRXSUwqgJJsKhrrGZ4jmBgDxJPBLcByRQ+m+a8/kRgJ9Du1CVC/Yk8F
         r0hWCGvaLVjzQFOlwVpIi/+qTp43/LNXK402r/5JR3GopAqFyUsT11w7gXKKQhR+AO46
         gVqw==
X-Forwarded-Encrypted: i=1; AJvYcCWn7ZL4JfFzgUB/fJu16lze65pVIrD2j0yRBdZGu6ZCMVHEnAt7fEEtqrsBwath6wqJajNWpETZMlYCqJ2U@vger.kernel.org
X-Gm-Message-State: AOJu0YxgZfh4ZKb6WSMXfcM0/h0YmJW670nmoy7TZNkwyXiFL9eGQWyh
	6GUAV4Wrd2dsC4YAg0qcoYgl00QfI7iPM/2M9Rv6Me7rcVarnYLq0guH
X-Gm-Gg: ASbGncvqFwdz7CI78/haWgyR76Y4ghTRJUr5DKnrWLD5vquv1aW4PQXrTZOojlJGE/m
	h6RCZz24KzOEDDjaPVYlsj5CyeOn/63wQk03PZ7BAbrsw7XccyjfKlt4EM5MUMPjbq8aVQ6OxXG
	KTuiWAZ9gpV1g0iSHE296xHRoxY/QL3MQVc4438vADB0PowXX60P7jfZ3USkzzqgewtnLuMP5zc
	jL87pkfiCL32sQfeBd/VL1LVVsj4DfmrNBcPoDBfemILQbp7uaG76AwqhJksyBVISHXZAOY82p+
	P1w6EyflvPGX9WNhwpapa3OVtjQxa+bCyJGS5jpS5ZNgprNT8Jes35lVZKR60DBbwUJQ2Y71r1D
	Cw2UP6K8ZmtY0uLH3MYYAcUEoMWyD4dWTZliHacMXEr/ANwnRaRid6ugGx7m51LgpfMBc+Oyxjq
	tXEALmT2MDy9Tt6GVqKFqbmRinnSFKo4NnEdAaMi9Z8kwDllNu
X-Google-Smtp-Source: AGHT+IF8g57bavsXqBfVBq9Xek59IpECDQlYh6sOrl3meu/h5BHoAkoM+JOiNtZTqe5C2ySHS4M7rQ==
X-Received: by 2002:a05:6402:518e:b0:641:6b44:75de with SMTP id 4fb4d7f45d1cf-6416b4480aemr3311507a12.5.1762714469448;
        Sun, 09 Nov 2025 10:54:29 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713a68sm9550382a12.2.2025.11.09.10.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 10:54:28 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: avoid calls to legitimize_links() if possible
Date: Sun,  9 Nov 2025 19:54:09 +0100
Message-ID: <20251109185409.1330720-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The routine is always called towards the end of lookup.

According to bpftrace on my boxen and boxen of people I asked, the depth
count is almost always 0, thus the call can be avoided in the common case.

one-liner:
bpftrace -e 'kprobe:legitimize_links { @[((struct nameidata *)arg0)->depth] = count(); }'

sample results from few minutes of tracing:
@[1]: 59
@[0]: 147236

@[2]: 1
@[1]: 12087
@[0]: 5926235

And of course the venerable kernel build:
@[1]: 3563
@[0]: 6625425

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2a112b2c0951..d89937c2c0b2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -826,7 +826,7 @@ static inline bool legitimize_path(struct nameidata *nd,
 	return __legitimize_path(path, seq, nd->m_seq);
 }
 
-static bool legitimize_links(struct nameidata *nd)
+static noinline bool legitimize_links(struct nameidata *nd)
 {
 	int i;
 	if (unlikely(nd->flags & LOOKUP_CACHED)) {
@@ -845,6 +845,11 @@ static bool legitimize_links(struct nameidata *nd)
 	return true;
 }
 
+static __always_inline bool need_legitimize_links(struct nameidata *nd)
+{
+	return nd->depth > 0;
+}
+
 static bool legitimize_root(struct nameidata *nd)
 {
 	/* Nothing to do if nd->root is zero or is managed by the VFS user. */
@@ -882,8 +887,10 @@ static bool try_to_unlazy(struct nameidata *nd)
 
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
-	if (unlikely(!legitimize_links(nd)))
-		goto out1;
+	if (unlikely(need_legitimize_links(nd))) {
+		if (unlikely(!legitimize_links(nd)))
+			goto out1;
+	}
 	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
 		goto out;
 	if (unlikely(!legitimize_root(nd)))
@@ -917,8 +924,10 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 	int res;
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
-	if (unlikely(!legitimize_links(nd)))
-		goto out2;
+	if (unlikely(need_legitimize_links(nd))) {
+		if (unlikely(!legitimize_links(nd)))
+			goto out2;
+	}
 	res = __legitimize_mnt(nd->path.mnt, nd->m_seq);
 	if (unlikely(res)) {
 		if (res > 0)
-- 
2.48.1


