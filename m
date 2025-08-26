Return-Path: <linux-fsdevel+bounces-59265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B855B36E94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E3C7C14C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80363369970;
	Tue, 26 Aug 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zolhkLjL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B7536933A
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222899; cv=none; b=a8gZN8CuHWArAPz8E1/j5nC6MK/J6CgJZ75vVTW+KmfEcxjy3vpQEUOxfaAM67E3ekslRZZLQl3zsdp++nvHNp68i2sEu2x+BYLBU54KmqM7Ewu4G9KmjCPatnNo3mjswrw04/b6BbqkrijBlTWlG1J37eSG32+6+F8g0ss4vJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222899; c=relaxed/simple;
	bh=G1aMNZNoFlDJqDOwcnIWhE+hsa6d2Luem9buE1zdqp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDY3pfhM8N+V+nAwOj4e53/f8dtFpxQlCQxigw2Shw18XuiLdLHclyBDTOXlNUXIrygl7ll7bXEDeoH9maT9RJnD9+gTvdzvXHtpqO+jCKx6cHRIGULRPqrZJ3vvLd/k//DRtBtP/OQqsVZm2sPQ6VstIhW4Q5iTwlSKecZI0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zolhkLjL; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e931cad1fd8so4824617276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222895; x=1756827695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8Pc8K7etH/ssaBOvhPppI+emHRcMCSy0sOBGONM6UY=;
        b=zolhkLjL4uPpQwgP0XbbIbRpbEVe3mlgpIZOJGifgLtwi197982ES22x2P7/Hppai5
         LMDylOyo6qBBgahg325iQ3IRwVIUfApE3nXkxlsb738isdDtPpaCZ8KdxxRDixjvXkCk
         hwU89wL0UvfUaGUEb+ZbKRgjzq1zL1Hwx8WjyfOQjekEUjNrE4BZqbsSJhsS+oYRebmz
         zCtHONbssV77ez2SAvEIxY1v4yOHuzDZjQGnLQm3SSB/XQTdEenCkTE9z7xHhr6DXsoN
         i1sII54P4yoD6tlpNfUA1okSZ0SRwRlrmNNP1nYhTIiJbGkKyWHEVszTGwEQNlorKM6E
         RBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222895; x=1756827695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8Pc8K7etH/ssaBOvhPppI+emHRcMCSy0sOBGONM6UY=;
        b=Ve2XAZZH4au4V3kCVhX4XnN0Y3VBZRX14mp6xh4+yy6ZbMO7kAfIriioBQOUeK8fN1
         GmEzi0ysWc3hn+QGr6xV5989rhTvNVtoUcjf5ZiKJIWWhwQW+SSia551goQ/25wwv8zg
         fSvrhecaYmJZM18SBuG2K9y/McMZ5CbXe66Ba1saHREX+TXF9C6do2y5m3DQa9tgsq8C
         +2QNYDBv6hQl0hwr5nmOXcztiVgCRuvxaMfJSKPqyUN852vXlUnH1syLwqJx27uqQej8
         p8ElxctiFhGMwKWH+74bQ26azpIUI7FLidj6W5CBqqw4eTgmBvFUWZC76fXwqmpQbgX0
         8Kiw==
X-Gm-Message-State: AOJu0Yzcu9R7I7qnYmfqD4lSqZYLmXndTvCBNeD0dlhxQJ5WFyfPPftp
	NlI0pVfxY3pft9Oaxs4VRMa/Fm+wsYJC5PlhDz5KENtBs0niGIWzrkM3XQtBU6aAaSICaNpt1BT
	WhW/B
X-Gm-Gg: ASbGncuQZHNKxpPiy2TjrQWWYapX97nI3bSrs5om7tYNfJDnPa7TGLYwaNg8YTxh9bK
	WDONKx69yqwJj3ChqjgMDch3ZjD176i17iYWVlIZ6T0be+OxuW7PJdcn/CmdD2Tt5n97vUAs9uI
	oT8yoPtUOXoMR3cuhGeAUl2nvggiPVESrEiCZGvPQIkKwpLpCH1HGCxCxnLEpHVgAcDzr78N6lA
	QoVvJvbxVCjIEjD9qu2GtU5llIBM9Z521DtMtIgN0xDexFyE15OguBD8NZF9wvcaSWLZ60gHzNo
	FIc9oLkhodAq6Zmlbmdd3zaWdzLGx4s4CLAfmr3sT+HabCD0xfiFdh0ZytrhS6L5llqvRuTMEgP
	REy/zYUUFiztVcwukS9XTRxx31DUBsO7ZcCOUBEcMHcf9dKtAOueoPWZkExREwh6GI5JsaA==
X-Google-Smtp-Source: AGHT+IECWyUq5Swkb2LX4gAl0du30jLU3PMPKdvHwQvNIMFfmHVt+qIGh58VpZfE89ckqB90q+RBwQ==
X-Received: by 2002:a05:6902:220e:b0:e93:3d4b:632d with SMTP id 3f1490d57ef6-e951c2bf0d0mr16715139276.40.1756222895451;
        Tue, 26 Aug 2025 08:41:35 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96d59a5ba3sm1098948276.31.2025.08.26.08.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 32/54] bcachefs: use the refcount instead of I_WILL_FREE|I_FREEING
Date: Tue, 26 Aug 2025 11:39:32 -0400
Message-ID: <03228d047baf5100b48174b36af9b59db941cf55.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can use the refcount to decide if the inode is alive instead of these
flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/bcachefs/fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 687af0eea0c2..7244c5a4b4cb 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -347,7 +347,7 @@ static struct bch_inode_info *bch2_inode_hash_find(struct bch_fs *c, struct btre
 			spin_unlock(&inode->v.i_lock);
 			return NULL;
 		}
-		if ((inode->v.i_state & (I_FREEING|I_WILL_FREE))) {
+		if (!icount_read(inode)) {
 			if (!trans) {
 				__wait_on_freeing_inode(c, inode, inum);
 			} else {
@@ -2225,7 +2225,6 @@ void bch2_evict_subvolume_inodes(struct bch_fs *c, snapshot_id_list *s)
 			continue;
 
 		if (!(inode->v.i_state & I_DONTCACHE) &&
-		    !(inode->v.i_state & I_FREEING) &&
 		    igrab(&inode->v)) {
 			this_pass_clean = false;
 
-- 
2.49.0


