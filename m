Return-Path: <linux-fsdevel+bounces-33951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A889C0EBC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3274A1F28078
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 19:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE4B217463;
	Thu,  7 Nov 2024 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfyW+4Df"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D22217659
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007050; cv=none; b=X9HfcZhl1oAaChDZTyS67qGwkzl3FaF9kW/jCuryRDz3vB+gjDFrbB7bisQ50nXDdPy9GwBDe2Kq+5zAE61j0ZvbAHjEqaOq8spM75wBUlEvDfJ4szHxtpV5H5qMv9QVbrZsMN8MmOc1tkc6vjmCOco7Cu722Scdx1VynjxFn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007050; c=relaxed/simple;
	bh=Vyk5LdXUPCJ5WnYil+TLoGEb7TvxgkoZNZe/xBB3dWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vve8zfP1WpWBuQbWe0JGYryZhchXS3fvRDyYz9dFSh2RJWEChVrqhoj5l4PGahmJ54UvJwzmzaq4JbDOif2ceGX0fb2pnKrM3TKsKUSemr3AS9fylOXFGDE/vXIpHJoyhmFdy/Uw8SQmlDaLkE/zlb6OgvGcHdxePmmCjtSAgOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfyW+4Df; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e35bf59cf6so23781197b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 11:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731007047; x=1731611847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnCvLTbTmq6xS6wpFSTKmY1gePcY6efLtCHlkRWy6SY=;
        b=cfyW+4DfXI6URka2fb/UJuptnM1AmhT3r8D/IN+Tjjh24syMdl3+CaNJt+1xEOas2l
         os+aS4yUY7af+XV9ilgbiDcIe1Ji1UpFm3GK5HKfrr8XhomgN0uJLQ39GZi/nYUPAL3n
         IXNQZYRyZ3YqQMLX3mt1S/v+piNU3YIpOxRRPcMroQ92DUI9Cv/o6+muKHNNlF8CAeRZ
         t/5wk5L/c5nYz76TI7wGs4Chfwogvne+QBQjPeb4SyTnezW3dSI5nvXGCwwWQxeDij32
         Dy990YH6sfILg7KuQZAxjz6yzhJqyEgHdFDa55I4+gGPZRPlsBiCRT7D/O+OQcUo9tlu
         tILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007047; x=1731611847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnCvLTbTmq6xS6wpFSTKmY1gePcY6efLtCHlkRWy6SY=;
        b=JHLARGVivx6mLfAL+22NLtum9kXdQiVeVsYfGyYSlGIbE0WM1QBC60lsivQv8aARjl
         prwYtGOPPwO/xMFmx2jCgv3B+TVZo5NV6olYgAkcW3IdR+v09EzWp2uUeiLa+bpvxTT8
         /+ccvuw/V3QQyGUXBw4O7OlfspXELESi3S/V+ib4Tvoqi7nJaxV/SxbRXpo4g4Az/Go1
         cCpHACzFtKwtF7XTMj9EdmqyyfF3uAQaV2Lv4nAUDyYBupTb3Ug9novouj7tU6bal54E
         GWFFnGn/ozfeonTjQuKttFiJrbXwrQWjtrEUt8lpveVvfdY31RvYlrzS5FUHXgsihAW2
         tmvg==
X-Forwarded-Encrypted: i=1; AJvYcCWr18fuL64LXkbLq3yI5uKSY3FuYHU+LMA1Qn8iiia4P36y3v4LuD/EqWEl9QloTcHJKKJdtGb2x9mNU6+r@vger.kernel.org
X-Gm-Message-State: AOJu0YzBN1w8/CQSqMSYGvsn+Zw8/0/Srp6M0BGmst2MZxtl4UKYjGyc
	aM7qd2mLDg4c1b+aloQyVT7+ghILsUX3G7Wu69NNYZL6fHd2YwJC
X-Google-Smtp-Source: AGHT+IFHLm1F5SVScEjFhzgLOTEvXi9gcszMcWHxca2UHg5tDjnu1mcg7x+SjCqmp89fKz//T9WiJA==
X-Received: by 2002:a05:690c:4804:b0:6e9:e097:e9d2 with SMTP id 00721157ae682-6eadc0daba4mr7442157b3.6.1731007045976;
        Thu, 07 Nov 2024 11:17:25 -0800 (PST)
Received: from localhost (fwdproxy-nha-008.fbsv.net. [2a03:2880:25ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb65f80sm3999417b3.91.2024.11.07.11.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 11:17:25 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v3 3/6] fs/writeback: in wait_sb_inodes(), skip wait for AS_WRITEBACK_MAY_BLOCK mappings
Date: Thu,  7 Nov 2024 11:16:14 -0800
Message-ID: <20241107191618.2011146-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107191618.2011146-1-joannelkoong@gmail.com>
References: <20241107191618.2011146-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For filesystems with the AS_WRITEBACK_MAY_BLOCK flag set, writeback
operations may block or take an indeterminate time to complete. For
example, writing data back to disk in FUSE filesystems depends on the
userspace server successfully completing writeback.

In this commit, wait_sb_inodes() skips waiting on writeback if the
inode's mapping has AS_WRITEBACK_MAY_BLOCK set, else sync(2) may take an
indeterminate amount of time to complete.

If the caller wishes to ensure the data for a mapping with the
AS_WRITEBACK_MAY_BLOCK flag set has actually been written back to disk,
they should use fsync(2)/fdatasync(2) instead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fs-writeback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index d8bec3c1bb1f..c80c45972162 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2659,6 +2659,9 @@ static void wait_sb_inodes(struct super_block *sb)
 		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
 			continue;
 
+		if (mapping_writeback_may_block(mapping))
+			continue;
+
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
 
 		spin_lock(&inode->i_lock);
-- 
2.43.5


