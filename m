Return-Path: <linux-fsdevel+bounces-22247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E75359152DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 17:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D17A1F22F8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F26019D881;
	Mon, 24 Jun 2024 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bIpyUH9u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5713954276
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244242; cv=none; b=MdEHe/8C5EdYLCBO7axrFUY3jBtrxu4HjcuNb7DuL3FtOTNfdFyx+CHEQhzSDlGTleoGAv97UR9jvYl+5eYweffQtZYrgbRvUv/Ir7n5u7VInLWsHMEALDfVrEvwJlf4hGQFqoHSrAizG2GLRL8dhKJYwTNvGj38U+TriSjHam8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244242; c=relaxed/simple;
	bh=NKlVLeAlB/O4BqR1dTzw3WF3hpAo8lWj2ebWanDhls4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZ44vmffCfr/nmBf1S3knA0urdX1d7lvj65eVlC4UGd4+pqT3ocbXZnlLuKcfAD5FOsfoXpAyGUsqeaSw0FLIRJK0RFnspH782GSIghh59DhcbTGzbBQOC5RXVzn0q0N9rfSbIy6EHgYr1eNJIVU4jOdD/5TGUoRoiartfqN950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=bIpyUH9u; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-63bd10df78dso41713647b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719244240; x=1719849040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkm1rXAti7t12K0xpdW01teSJVvN4Hn65SQw4TAqa5U=;
        b=bIpyUH9urYxtJVtLhGRxI63reAH4p8RRgk4Razn4lcF1VefXL+oAmWoofsA9i8bkBX
         QCUsGGRrorzk3+wUtTQTZxSlPmy2kfskGqEoci3TgkgcaD5xgXf1btYGQfzEajLpQNvj
         ny3AJ09a74ahjkt7eFzaUiHfBhUoEgXJl3VfUzDu0fW1fht7in2q0SCjA52b/rduC4jE
         6dNSn+X95CLws+Ty7fGdI+Mz3Y176biRAAhxGblvY2hjnJe0XPm3v/V3ljR2c0RRfc7d
         oG+2VRxu+IHqFVv7wvKjAKZobNSP7frTQtENm3mqsltNJY9Ak/SOBVDjT7+phMVpis+h
         SWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244240; x=1719849040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkm1rXAti7t12K0xpdW01teSJVvN4Hn65SQw4TAqa5U=;
        b=TrD8JLWYoejFuYtVBhplercRjdM9bro12eJZYlUcLWbFbb/eR34An2PBu1yVjF9UA4
         N3eTS6OVuQ0+PAP2IuFso/StNxtvEzdtxd82pM8pweiZqrGt/LfBgx6jkPNMbdXhTFKc
         BeC2s4RrjQF/xaSMrL6SCWFQgVBhnNpL6nPcj1tOKmhCj41vbzvn6lVWr1YlDzZnrA2u
         sHSeAy2JMO3zHoPvBOTR2n7sHfvxk7tJcy6sl3pdOV3sf7iNMOI0hLMu8x2RzRwm3t0S
         SsVrZq+y+7m4PtILtiym7XTGocHxZC5vQxRhd4gdoxSv4zd1FkM0Nxuxvfk1TjRu8o7a
         tm7A==
X-Gm-Message-State: AOJu0Yw+vEM+2LuERoQOnzeKP1BhPeWSNJhzt3L9BqaD5NB8WZ/8fq5F
	CRnr15AgdWI3mnGggjqRR4Qgy8Ht8x0VC7ehHaEPBovN9jCPBhOfwg1NcPGraQsGwy8ScJ3aig8
	D
X-Google-Smtp-Source: AGHT+IGl01cxu0A+BNMzJ7rD+/DpNgA2kt0JVSdstEnb1cOoFJhIiX3z9uZSWjq7GjFfQ7nZ6q0U/w==
X-Received: by 2002:a81:ad26:0:b0:645:25d:b741 with SMTP id 00721157ae682-645026cf997mr27543967b3.11.1719244240220;
        Mon, 24 Jun 2024 08:50:40 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63f1192454fsm29770147b3.39.2024.06.24.08.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:50:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/8] fs: relax permissions for listmount()
Date: Mon, 24 Jun 2024 11:49:44 -0400
Message-ID: <8adc0d3f4f7495faacc6a7c63095961f7f1637c7.1719243756.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719243756.git.josef@toxicpanda.com>
References: <cover.1719243756.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

It is sufficient to have capabilities in the owning user namespace of
the mount namespace to list all mounts regardless of whether they are
reachable or not.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 4238c886394d..253cd8087d4e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5107,7 +5107,7 @@ static ssize_t do_listmount(u64 mnt_parent_id, u64 last_mnt_id, u64 *mnt_ids,
 	 * mounts to show users.
 	 */
 	if (!is_path_reachable(real_mount(orig.mnt), orig.dentry, &root) &&
-	    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN))
+	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	ret = security_sb_statfs(orig.dentry);
-- 
2.43.0


