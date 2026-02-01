Return-Path: <linux-fsdevel+bounces-76010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ODWCCmJf2mptAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 18:11:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2C4C6A2A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 18:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BB3F30075E8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Feb 2026 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B202749D9;
	Sun,  1 Feb 2026 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIaHm2jB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC2E23957D
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Feb 2026 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769965855; cv=none; b=pc4Wkr4BknCTAnxim3Nh3cVI1AR1ge/CgiEJYxXhm+HBT3kUWIDt21xSpwAJwUJnlrPP31Zk8wCQ+/tgUEUjgqkVxSngjo3czom4V9VpD78YVunPae/YV3tt+Bo0/k7l35OaS1wUaE4vxD5uDbLKv48b/wPgE6z9HO3MlkUO8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769965855; c=relaxed/simple;
	bh=IqXOmJBjm/ca3HDEihX+rtcdfBaG3yEMxjxvhM8LOIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V9Dga6j/n/kP80XpfYLnJGf8AfxMQNnk0R7CO8HRjejisucPN7om6dM+QWvmC+mxWttu2tTwJToUk92MSrckXX6CkY1DOZyHg6e+op9dUdmOKOTPHD9KucyWCEisyPv4fg66lWxmo1HmFqN6pBnxbU7LGtddudfuhrAGmp9wyiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIaHm2jB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81dab89f286so1799817b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Feb 2026 09:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769965854; x=1770570654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u54ua+qu21FHBsf3zLWVG9pnVP6xgcSXcYQSK/iMf0g=;
        b=jIaHm2jB99L0jaqdNmi4tZA2GNTfDtVc5uiz+E+jDxtmTQiB67gj0YkROFbDP1wuo0
         vaslkbCDmvq2mgLdCgF+WTIR5l8dFOw8eXlbVrKqcyCd1ncCcGfst9MK2Z1nqbO3SRgW
         64vQ1mhowu1MgmFEgvdZHm8pYsCrVLauDVQ0U3KeqDRWL+G+77Wn1Tz66KlTqPm8vvXM
         Vljf3msOuylWYNwJFfha/QP7ZhiEcGMWS+9eNhryI58fV3fU3wQBpIta310oxmNBEqV9
         auoaPvbNL+UuIa6iSmc2DjAz5R5YF/fw01pIRFrKBrUlgHcldrz5mVYb4VBAbAMg7lkN
         f8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769965854; x=1770570654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u54ua+qu21FHBsf3zLWVG9pnVP6xgcSXcYQSK/iMf0g=;
        b=gOd4gorFTeOhPQjhXvyU98cfcCaBoTfJz2AWWOh+Vw7TjGVHSz05gWygi+cs9095Um
         SRNqK/wd9bmp5ejJuIpnrYKDOR85JJpdVWHTu4DNPH2PQ9lTGeskuvAXYD9szRpHANv9
         5uUxJKlIjUMgSbkNJGb51mZ9tZ7YKacqZNnYuruIV0VC98rDYZurVFQk6YuU3KVOKk3w
         RNnxLvXLlqVLJJAOO2jkG6ulGA2pREAA9a8AoCk3MM0vTzEuJaXbmzu85kfhzyXJpgoX
         tTcSsfNz7Q6z1d3fJtI9kVbPDPw2o14OTwJU7NMUFFG85bp8d+Jy50Q12/FNsqsU9k7I
         2MFA==
X-Gm-Message-State: AOJu0Yzt/+UM122lQ52gexZW25tHQifyqrgXn06EMkjUZaRo3v1Ho34a
	sMz2nPShb1X95Ak4KrAbqFmKb4GIVGomDjIQM+tdNHzWHdajuokYFlHe
X-Gm-Gg: AZuq6aI7v0IYI86Xkokq1U+RRuLrLvsiy4x2uq9bKeumSSbgu+pRkB/Hb7lkq7/H9SS
	i3x8gIkDKoT0Os+rpOQ9wxOtKXRNohEbeGTBmDgmjZYwrMg6I5MbroEuOZtiGrkGitKk6Uxm09I
	HqqVkiy/4MSu0xKOCdOyApUdqDlio/jq6Q0p6u3nwXlRNBClojqIMVh8fm4LUyePeZ/xvXSCv9B
	jB40V6bBGCuvTRWuESUpGg+bJcoFS0Zr7acyMC3sOseQiKmr0vqS1CFzitFaqXr6BQN8Q5RXJIB
	Ip91XlATYtk02cjNW6wCUhAzHU22ABT2DCV5Y9W35uWTB4eWgb/YOCBUk/V9J+VONnam+1rXzDR
	bk+o+UTzkLiG/4lAH6bramU+a83dyJG/cD36iIgMBFDMrc9L7Fnd9F6i2QIPaQ1IYj5X4QbD26i
	Uu3WZ6IZdYBCWfgYVv
X-Received: by 2002:a05:6a20:6a05:b0:38d:fe2a:4b0a with SMTP id adf61e73a8af0-392e006f5b3mr9449061637.33.1769965854039;
        Sun, 01 Feb 2026 09:10:54 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:eb8e:fb38:51dd:c774])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642add5199sm11579118a12.31.2026.02.01.09.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:10:53 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Cong Wang <cwang@multikernel.io>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] dma-buf: add SB_I_NOEXEC flag to dmabuf pseudo-filesystem
Date: Sun,  1 Feb 2026 09:09:52 -0800
Message-Id: <20260201170953.19800-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-76010-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiyouwangcong@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,multikernel.io:email]
X-Rspamd-Queue-Id: 7A2C4C6A2A
X-Rspamd-Action: no action

From: Cong Wang <cwang@multikernel.io>

The dmabuf filesystem uses alloc_anon_inode() to create anonymous inodes
but does not set the SB_I_NOEXEC flag on its superblock. This triggers a
VFS warning in path_noexec() when userspace mmaps a dma-buf:

  WARNING: CPU: 6 PID: 5660 at fs/exec.c:118 path_noexec+0x47/0x50

The warning exists to catch anonymous inode filesystems that forget to
set SB_I_NOEXEC, as anonymous files should not be executable. All other
pseudo-filesystems that use alloc_anon_inode() properly set this flag:

  - fs/anon_inodes.c: sets SB_I_NOEXEC
  - fs/aio.c: sets SB_I_NOEXEC
  - mm/secretmem.c: sets SB_I_NOEXEC

Add the missing SB_I_NOEXEC flag to dma_buf_fs_init_context() to fix the
warning and maintain consistency with other anonymous inode filesystems.

This was triggered when testing DAXFS (https://github.com/multikernel/daxfs)
and was 100% reproducible with CONFIG_DEBUG_VFS=y.

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 drivers/dma-buf/dma-buf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index edaa9e4ee4ae..e2e1f77aca80 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -192,6 +192,7 @@ static int dma_buf_fs_init_context(struct fs_context *fc)
 	ctx = init_pseudo(fc, DMA_BUF_MAGIC);
 	if (!ctx)
 		return -ENOMEM;
+	fc->s_iflags |= SB_I_NOEXEC;
 	ctx->dops = &dma_buf_dentry_ops;
 	return 0;
 }
-- 
2.34.1


