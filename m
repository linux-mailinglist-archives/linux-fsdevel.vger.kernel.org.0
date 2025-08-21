Return-Path: <linux-fsdevel+bounces-58660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A59B3067F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B094D1BC046C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9914738CFB7;
	Thu, 21 Aug 2025 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="N+MAJGxJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96838D7E7
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807653; cv=none; b=RxEzzg+cotKFEQQXAR7KmRYWHEEPjfSsejAwtVqHXLqeTsEhw9Os5IIIYkGf5jY6qMICYD6UNNIm2T7MXeiOXYJFTV6xofWzTKmeSDCW3ET+7GCvWA6t7qo1/06gLhWG9OYpNHtmZ2nRBRImf6bQytxgb2M10T3X3QS/21tT8Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807653; c=relaxed/simple;
	bh=sjFh0mGnBKewmEu7ZBywUO603QDbf9VVtuxS1iHS3kk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCs09x6xyYtZ6N4TRfyjW3r9+f27ucrmfBQKp8IY4eTyi7xPaSut7TGhHyEYZcU8oTv2tlPqK6FXecu20gZQOUxYNpVjMlicRTUqnZXthBZWvU4WMhjSWVtNJ8PNtymwkmreNND/6yS7o9Qjirmlg2EUBzQ1lf4dMehlWo9gVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=N+MAJGxJ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d603a9cfaso11268017b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807650; x=1756412450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hjHCUvozywJVec5GzUlQUBVDNE1xIxaP2hRXA4Ep30=;
        b=N+MAJGxJfTVSv5keiL5UKcNhJcQPSc4prVDQwLcPAj1459CD+ebOxUSqLa7tsh/57O
         isB2WPfAyYk7D3u6TWkQMIbx8DaCMzCWxP3z1yafrWJM2ocQOY/hLuDfXHEUgReZUFmF
         2jrtrZht+L0NZnpijNKnIbF+cA2NV4dZab912RaftofRB0mc0QeSqhdMtxU45mux35tu
         xbpsJAQwaYA4gx/hJJF8mMkap3ovm3yonjJsLYh/p3VqOL+VGIc2IiXhlfGCQNKjk2n5
         tEE4nWVMYhK51djz0SNbbBbG1HGIev8fhFNVFCVblb67t2lpmWsoVpkdjxVGOoArOp0M
         z0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807650; x=1756412450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hjHCUvozywJVec5GzUlQUBVDNE1xIxaP2hRXA4Ep30=;
        b=YPGQ5tRokYmz7DrH38yj1liWKo8mEOzqLFe8QwhjCxvFFQAZn4V5Je/1Q5gs0yNNZJ
         tBmMUnPpfwkrTeE5cnrxxGJtrOYzy+me6gzK8PsZ8MXAUER7ZoM67oUgY3jnr3QMxiUh
         ivevwVog0LwoqJgtuqPssj707ObnJFIszlKq52RQLvX+pNd0GK7hy9Wpb1CNIzSMeU0n
         wka27Ua1jBfma/Cd6SYKGB68nCuW8sbj/MWCuWO7mNZwTId5cuaUAamEJMXiCP5x+7la
         rhBrpM2WxBn+JGUyPlBKBsRW6J928oX6brSq8kZqmn9ofs8yB954UZtlND3jSF22c0li
         rJnA==
X-Gm-Message-State: AOJu0YwTN3jZzXtJ/2Fp5DleBxOt4XFilx2eK3uSRKHAY/FWWODv4pT6
	mqQA7RhmFHI4Vz8pwFGnXqz86tBjisYHluBIP3QZ5EQ5bn2mZOn650R9/nXehLRHBP+Pe6FBkXa
	18stGD20GLA==
X-Gm-Gg: ASbGncuA4Dv5tD2EZFrlRZp/Nr42nvbhsGzI2ndPDDN5Emkd+kc7UZ9dYVJDiZePiRe
	WTx2HPqNm7+Q/IQ+rf9C7t0b96sTs9WD1j4vGmsq7SRNYHdSH4bNyVdNWg253uMcIdZRGbBGiZD
	HMKAsM8wRrzPmC8DDklbcpmIIm9cVAKnNc0wt2dO8sxUoh5Yq4Ck6M1IMXNUazNdAypChEuRDOK
	7RJdO6Bhc0GEZMezEocumwkM6aVE0yzjmKSTlh7UK+P657pgJSiZrzmSllq1WuKMfS7PdTf+k5j
	N1IJpu2fa3dxxD1rlTMx2dmwXKUULJvco5dfqoYjlqem29BXFfg9YLXaq3bNKuVvi+pFT+B8iJS
	r/M123BhpdEmtqY0S9Txy0xqqAvhnFTxyYdgQPw6kzrEjQ4F0CrrY/3fJD3Jj3Mgjt0YVsg==
X-Google-Smtp-Source: AGHT+IEkPg2uY+pXs4XweETSWm+kP/bcnOO1B2iny2nX044cCwAOn3B/brJlOgYBup4PziSrybkXoA==
X-Received: by 2002:a05:690c:9a03:b0:71f:9e46:835b with SMTP id 00721157ae682-71fdc2b147emr5716127b3.7.1755807650043;
        Thu, 21 Aug 2025 13:20:50 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e05bf0asm46252867b3.54.2025.08.21.13.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 23/50] fs: update find_inode_*rcu to check the i_count count
Date: Thu, 21 Aug 2025 16:18:34 -0400
Message-ID: <73ac2ba542806f2d43ee4fa444e3032294c9a931.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two helpers are always used under the RCU and don't appear to mind
if the inode state changes in between time of check and time of use.
Update them to use the i_count refcount instead of I_WILL_FREE or
I_FREEING.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 893ac902268b..63ccd32fa221 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1839,7 +1839,7 @@ struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_sb == sb &&
-		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
+		    refcount_read(&inode->i_count) > 0 &&
 		    test(inode, data))
 			return inode;
 	}
@@ -1878,8 +1878,8 @@ struct inode *find_inode_by_ino_rcu(struct super_block *sb,
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_ino == ino &&
 		    inode->i_sb == sb &&
-		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
-		    return inode;
+		    refcount_read(&inode->i_count) > 0)
+			return inode;
 	}
 	return NULL;
 }
-- 
2.49.0


