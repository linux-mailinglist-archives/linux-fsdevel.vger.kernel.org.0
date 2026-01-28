Return-Path: <linux-fsdevel+bounces-75724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHEHL2ceemlS2QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:34:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 236B7A2D35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31FF83019526
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 14:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6471A35295A;
	Wed, 28 Jan 2026 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiUkuHF1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CC7284B2E
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610725; cv=none; b=iQ2phBSdYrXcgREl76A9Mj+HCE1DFU/nDXZX8fnDeeQFQMToZsrV6kxV3VnJCFggivgK0LmBVGQsFNmW9P5Rq49WWOhM1L2BCG5Dz+bXZFAYOcfRbHLCAiTEL5GiiJdSMiJJ1gkNb8XuDA9DbWDvdjmcgq5wJxYFPIuf5EHEPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610725; c=relaxed/simple;
	bh=njlIHbP+kHpwbuEK6CMZKWoivuq8ubjI6YAoxGzSxqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPF3q5yZS8OECdpgtWJJfHB7SIn6bjREovIR9XkeA3rHxRQC4WS4WnDC7qAidqxYto56SkhLSa6KNK6mKfAhKzHzogo3JK2wOPcPPs/bGeF4azVulXWNdIgNkwWG+qWqarhE15UMTIAUTLRwcWCNn5oCBLX1SvcPyxoZlLSfUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiUkuHF1; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-894676e6863so76657896d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 06:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769610723; x=1770215523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xDdOn59pevwEMRGwNE16p+LWrsT/4kXzeeUQVUzRuec=;
        b=SiUkuHF1MnlJ/p72kSXQ2Mf74MqK6wIOMOXZvETRLQ9MmtaqPQSKSXjxlCvt9Jyp0C
         v/1nFVqxhKh/Gzzv5IwCtw6a4N42EaWxjO51Gxpp3GxMEK1C1SYrMTKx5PyI2COJh0Vd
         K+bHYIuGXQtg9AqYfitfzomRMy0WpqLHqxU6NjjbuqQ5hlegqRXP5z7oDfFD4+0tPvS2
         NCFpLaGMB2zDRxMVyw9owxDIryeK+9rFGK/jJ7k9PyGpiGvPfD9OqeR5ovAY3UBM00yi
         WjAtlxLFQc1qNfPDX/+OQhrAx5x6Q21ChliIet6o6RrWyCXiI7sCg3tL0d/9aH5QfLYr
         DwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769610723; x=1770215523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDdOn59pevwEMRGwNE16p+LWrsT/4kXzeeUQVUzRuec=;
        b=RLClc4EjvFhjI/K79Bx+OX4ASHvCubLh90SQW3Qg9oNE9T5judhf0RX49Ux2vPiRG0
         t6XOIaF1XSc4NQGM04GMlSma+RlHxznr/iShvFERt3DkQtRoJqXPqjNiBoOX3Q3VwM9p
         OCr6Qskugl1F72jV14dJeXocUsEKqMHNY7oBGnfniD0RuEnLb8FP2fuAl/JNaVQ7S47O
         eVU3BK/rihMDz3A46IfkX52fql5hMX0njE3HsEPsWPYTN5rXQ3jDCMtNvXI+1siszH2b
         io9ETTDZVGFeqq8hXBMwpIQPjg2/piDcycQcRAk9bFmA4L+bz00VC1NC/db5N+eU7u/J
         1WOg==
X-Gm-Message-State: AOJu0Yw1OlpWss96A5jVi3xcW15RsYczkWs95sUsVhTM7wICsLOfn9fs
	ExMpyAFzGBxFqQ3ixPdH3cPVKr6Vtlzvza+lKM94DKGqnPRwjSUnU+EF
X-Gm-Gg: AZuq6aIGUeTfhHtjyUp6Zn9CFX4At8db+Z4bI3aXI+7OquCw4R26tcLyecLQZVjOqa/
	EHdhGdwXO6oBYHw0L+sZTZydsPbPz4osVPDRdz6kpYhBONTtxMWuXyVIeJmwIyRlV5YwxSgrP77
	KuUYO7IaZ31yXbt8xZjkndv4+6OoEJmDPUKIx0CYP5c7RqUdndMvRTbyv+0kKChMBQwX1Dw+I3L
	Y5VMHp4D79fk0ViyoUCTSVLRVxSqKgCDnfNyUpXYE0SKk78Q2QZcxE+TGL1XLx5x1VNarMdB0fB
	8ziWO4ORr+cRv4Vc0zzIW/QqOfqM+/WfikN3UH+dgqvBZ1fYlab4mm2meJhzDYaR35teWr77h2z
	UyllYL+kGuEEm/NJG5UxK8PAucynFXFRK+pIHKTqa6yKCkU+hsz4xKrN4MvdaK6UyYXfgdPppfO
	AjhPZHuLWB8LoR29rcOsyH75F+4+/YUmZCwHZOLOCzhVGaYTn2cg==
X-Received: by 2002:a05:6214:1d03:b0:888:5890:2d55 with SMTP id 6a1803df08f44-894cc91366fmr80070276d6.47.1769610723277;
        Wed, 28 Jan 2026 06:32:03 -0800 (PST)
Received: from cr-x-redhat96-client-1.fyre.ibm.com ([129.41.87.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375f3casm18071576d6.47.2026.01.28.06.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 06:32:02 -0800 (PST)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v2] fs: dcache: fix typo in enum d_walk_ret comment
Date: Wed, 28 Jan 2026 06:31:50 -0800
Message-ID: <20260128143150.3674284-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-75724-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chelsyratnawat2001@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 236B7A2D35
X-Rspamd-Action: no action

Fix minor spelling and indentation errors in the
documentation comments.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 fs/dcache.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 66dd1bb830d1..f995c25fb52b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1298,8 +1298,8 @@ void shrink_dcache_sb(struct super_block *sb)
 EXPORT_SYMBOL(shrink_dcache_sb);
 
 /**
- * enum d_walk_ret - action to talke during tree walk
- * @D_WALK_CONTINUE:	contrinue walk
+ * enum d_walk_ret - action to take during tree walk
+ * @D_WALK_CONTINUE:	continue walk
  * @D_WALK_QUIT:	quit walk
  * @D_WALK_NORETRY:	quit when retry is needed
  * @D_WALK_SKIP:	skip this dentry and its children
@@ -1722,7 +1722,7 @@ void d_invalidate(struct dentry *dentry)
 EXPORT_SYMBOL(d_invalidate);
 
 /**
- * __d_alloc	-	allocate a dcache entry
+ * __d_alloc - allocate a dcache entry
  * @sb: filesystem it will belong to
  * @name: qstr of the name
  *
@@ -1806,7 +1806,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 }
 
 /**
- * d_alloc	-	allocate a dcache entry
+ * d_alloc - allocate a dcache entry
  * @parent: parent of entry to allocate
  * @name: qstr of the name
  *
@@ -2546,7 +2546,7 @@ static void __d_rehash(struct dentry *entry)
 }
 
 /**
- * d_rehash	- add an entry back to the hash
+ * d_rehash - add an entry back to the hash
  * @entry: dentry to add to the hash
  *
  * Adds a dentry to the hash according to its name.
-- 
2.47.3


