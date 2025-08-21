Return-Path: <linux-fsdevel+bounces-58684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052CFB306FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4910AE7DEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0143932AC;
	Thu, 21 Aug 2025 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KZ4kpj0e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912BB392A70
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807690; cv=none; b=tLIXhjBoxBfrTb2XFvitHwfkWzqwP2fKLXb5OSqbMZ+0uyb99gc5YH7+/ff4FukIRCfIMZqwhKYK1F4FFE/AtrX5uAD8wxaK0i3sOlRRdAIPjvWkRXBR7Oym7g1at5Kn3UTLRcKcGrVs4F+6tSaWMNhOEHWbUociHBcZ8sB1+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807690; c=relaxed/simple;
	bh=MRbjz58EJk2DIV/CMfsuQeru3Gjlj5upRwbvX0t3mqA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zv0WoGp9ya4iKDJ8kXFwwsO/pPhN8bHmTw7KgX64XUhlx/lny/NhVQ4JeKLeT7wBmxzHBUpEO5RM18OeNZcZidphwFgd2dp41E+H2upDYkLBfhH5aq4bnZX4NxSzIeDZHK8ST6J17cjojqsOnhs7WWcDA3hHOhJLBI3wv1YITHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KZ4kpj0e; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d603a269cso11779627b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807688; x=1756412488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6Y2vCrhkZTJ22Wp+VyocA6nDD0iA/acEwKo6i4LTMQ=;
        b=KZ4kpj0e+2nHxJkJfRRElwV/CGxxfwb2mzTyZ/Eo4Wk1OAJv0kQBcEsMBjZN+B0xk7
         sygR3Edm5/gldHlW/wGto0rv6MSQMWQrJDTvSm4AsOGnxGc438pY1862gpqlPHPUdxpQ
         PA9z0x5e4/bync/fbeLJ3FKHvBu7mCwEQvclxtHb5Pa/q2jJ5Lj++uQ3KgWqBMeJRB6U
         cbvfdzfaRx0duO7M1xJfBAA8lhgO9DriMnTJCA/E6hGVbK+QWsbhtNhhXdOSsjyqscfW
         RJT9eyGl3zevXuUhq/MBf839M4AeyOEFsU83Q9QpeqkqZInfNiv1nOh7EGTs9dG+28dw
         YSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807688; x=1756412488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6Y2vCrhkZTJ22Wp+VyocA6nDD0iA/acEwKo6i4LTMQ=;
        b=sLqyMLEcb5NxrMrozjhj3YfzYj6PJtBhxSfO3EGVj2AP9jTqs+JNpBfVhevCH+86xy
         /LS1IkJDnrKiBw8Rmz4yBuVNC/sxPrrp4vZ3WSMdi2PMS3uzKkcu8UX9CIDESZNycqOF
         HOl4z5jwOhVdhlBAloVY2LtQesCl5F3PviGQYudCcfwaRdAOX6G2BDnrYW7BQ9pThppt
         ydermcZBowQV6VGGMcg/PLhIK5c/BETNZmePapkrUuBkSxu2MqFFYqFCG+/YcPgLZWmt
         Ujm4ek1NUUcgFmy/K57ZEISWoASv9slhDhPouU8jGFz3efgEic05GVdn3x7owVriGSXF
         512w==
X-Gm-Message-State: AOJu0YxeVxjzi2Tb7Cp3XuwMfb4UByCOTYle/599i480X1aaMBEVIoPJ
	BKA2PIogm5hEAG+HGNooufLy4ejPmTAUyU7lcSfS91axrceU3i76Rg2VA1Dt3yi6UywQYWOgt0p
	7Eiy5ydhrjg==
X-Gm-Gg: ASbGncuUfaPwqWclJtKQXKnUm3ZzG1On0lmRdGbbx3Qyo3E4XbokkZnquJkHVyfaThC
	gJWC2hloteNOeBqhHHxNMPGp/PYYiLFUfwFd8sdH1o1sVCrCVQjEOwpJIZkXtQqyau3egHLQQcy
	tXQjpqyMCP+G6Px8Oi0y3g0sgBPKBYRgQ6IxT5/r0mxHRnt2rdPHU6o+/dWSl9btLJ8VslnqNsv
	mNcZTrpVW8CYVFz3aKdIp7/2u29IlBQ4/SiPwxbf8xz0S8MpQBcHMEVexMJFEphCEXlfcOwSrIS
	03e2tPNsaGb6asteSC50fNkdGmiPUmPoeOdmz6X9z+oGQOQXSm2M/OHPz7pcbN5mf3lBc42hAyh
	AsElpESWdVkzP+/y/BxXfh893iW9NHhmtIeSKd3ZmzBwJeUkw0eBIdoNseVc=
X-Google-Smtp-Source: AGHT+IHKd05hnDdE6pxXbgnF50bB6qaOk+UowOaZiUTYV+EFuPk1zkORqkQfdOZSuLjXIecq80ZgtQ==
X-Received: by 2002:a05:690c:6211:b0:71e:814e:c2d4 with SMTP id 00721157ae682-71fdc312ff5mr7198057b3.23.1755807688184;
        Thu, 21 Aug 2025 13:21:28 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e107145sm46178057b3.70.2025.08.21.13.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 47/50] xfs: remove reference to I_FREEING|I_WILL_FREE
Date: Thu, 21 Aug 2025 16:18:58 -0400
Message-ID: <2d12a5a95496c71929b90c298bab06fdd81d75d8.1755806649.git.josef@toxicpanda.com>
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

xfs already is using igrab which will do the correct thing, simply
remove the reference to these flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/scrub/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 2ef7742be7d3..b0bb40490493 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -1086,8 +1086,7 @@ xchk_install_handle_inode(
 
 /*
  * Install an already-referenced inode for scrubbing.  Get our own reference to
- * the inode to make disposal simpler.  The inode must not be in I_FREEING or
- * I_WILL_FREE state!
+ * the inode to make disposal simpler.  The inode must be live.
  */
 int
 xchk_install_live_inode(
-- 
2.49.0


