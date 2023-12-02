Return-Path: <linux-fsdevel+bounces-4691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D704801F07
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 23:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4633E280FEB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026FD224C2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YA5NcrkM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06A9FA
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Dec 2023 13:22:21 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7b3870ee4easo123711739f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Dec 2023 13:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552141; x=1702156941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLvxvckvyomlZOIIg4Wjwswvgj0BL428CVO+nAzlFtE=;
        b=YA5NcrkM5udEWaHHh2G+rmz62ChxvRvmbuIaxK6S0HmU0dsnoYprOaEiaJ+Bbj/pE0
         X8/WCK0HfL43CDLXxWRUeqCFrVa9Xk5RwQEO79zs3ktain0CD+LqjL6cCUM3uEcRVFcX
         ADZbHiYgQnmAcZWmNncFbgqi6QMwCHkKl+XgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552141; x=1702156941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLvxvckvyomlZOIIg4Wjwswvgj0BL428CVO+nAzlFtE=;
        b=ZDx9MVHhVx/qA3hU2DCWsPoPZ0+04V8n/8xl+bVE9nEl+d3H5fUHuRRpKHTS5GKtT6
         Wiv9mhG0O2UKk2AyEcuuu8l9oapb8NyMPPAHn9YG5tBvhB2MDGM6lT5EjqGX1SzYHugT
         gH6rRLIxtujoAeBpVdt6JqGRB50s6yvjTEJSUi69mWFScXFgZzGCSQL1SXBCqaQUnBwL
         mYxR3AZJpfYbPTQOilWMKcajlAMmpqqksR0n5GYTZmK2Z4n0jcz0ddKfR72cPbOjdLAS
         3A5UASDbpKw5OyE0Ic2em8FzJZ83vzLgQG0Z8+IC8g5fu7nyxFlgT5cs9QO1fAyTiYmn
         D4cg==
X-Gm-Message-State: AOJu0YxCgy45u0JfAb8ErAt9bSS4FI57mvmJcU+qnLkmPXEQ+Uf6YM3B
	K/j8oBnCPZq9FgeGcsR8xpSKvA==
X-Google-Smtp-Source: AGHT+IGtRLKSAKTdisrEu2j2CjbfWn28z6XUA+T3NZsmq5+CR4/UtQweJAgLKCPRmDEaHRBtmwe+zA==
X-Received: by 2002:a5d:894b:0:b0:7b3:9256:628f with SMTP id b11-20020a5d894b000000b007b39256628fmr2310006iot.15.1701552141318;
        Sat, 02 Dec 2023 13:22:21 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c3c600b001cfd049528esm348997plj.110.2023.12.02.13.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:22:18 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <keescook@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 3/5] fs: Add DEFINE_FREE for struct inode
Date: Sat,  2 Dec 2023 13:22:13 -0800
Message-Id: <20231202212217.243710-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202211535.work.571-kees@kernel.org>
References: <20231202211535.work.571-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=keescook@chromium.org; h=from:subject; bh=Vr7BZE93w9hrA2pgUGte2wnKY/rdltDnNWxbve4aQVs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBla6AGSav5RcGFsYqI8ZI6gPChQFnsbC+3nI/Sq AQMSCvSeJuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWugBgAKCRCJcvTf3G3A Ji1PD/97nsFeEYnRWCY5ijYm3HvFHnw2xsSeLfCgNERlEsvkDTZnVu32g862lrZ6hmNnj1/2WLY q5BTXJyqzwbbUg83+V4Z7IWpauoICvmh5nWCVw+d1swRjKLklznh+kH+lxKH782U5N+1W/bPv70 NdRhJBCPVOIeyBMGaFNtfbgw7Q7/MKTOSU/62VCry3sVE9fgDWP9DnB0W9/AVEf5mttk4aI+XJP Jf0b1606ZtWwo4iih+TPjLRID9WD2cRTVsaeRdH6h2sVpbIWtLfBMYm7MUT4xvIE/X34XC1XbGH /mFyNY6PyZyWNI/tRahhMjKTPtLuV+I51o3tpDU6ScYTIbUYyvn1SktT2ZE2PeBRIK7UUg8Kekf uMNNH7+hll0EcFYUEBOQ4ErCJ6guTCAIxc+68VotsoujHUSgriM/jZWU+UdawDQmyw5w2Zxt2fH io2IkOg0NktS5Lz/oNbESXSgqAIcAsWZYdpz8f5sULzKfDAWY9NZCkKawVLDlwQ3EVVq3ugJ4nO /+MhL408XJIGHI6nAbKY8QyfaPWyUeqbflROQiQEI6UVXEYbPuKogAFFyNGXqSlpZfzWjwQM12w tqybXEWAcWdB/zgRVWCl3j9u393bvwCn78YpxLSABa2mDjF9niWPVYIK3247bi3TGEcoqVKm7/q lL7bpxiJe0Uvk7A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Allow __free(iput) markings for easier cleanup on inode allocations.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..7c3eed3dd1bf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2459,6 +2459,8 @@ extern int current_umask(void);
 
 extern void ihold(struct inode * inode);
 extern void iput(struct inode *);
+DEFINE_FREE(iput, struct inode *, if (_T) iput(_T))
+
 int inode_update_timestamps(struct inode *inode, int flags);
 int generic_update_time(struct inode *, int);
 
-- 
2.34.1


