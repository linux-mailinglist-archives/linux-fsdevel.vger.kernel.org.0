Return-Path: <linux-fsdevel+bounces-35619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E209D664D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 00:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C357285580
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 23:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D751C9DCB;
	Fri, 22 Nov 2024 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNGAlwUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3B18BC0B
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732317870; cv=none; b=nqwxm/4PIt8Qp+7+eqAmkX/3kl0+0tJIEM6z0eGdwq/VEodIYQvmrwuQ9DjHpaTckITWmjwUF2whsqASE2aiVm8cLaiNOVYEmI4y93UbqrK4RZHeyjPdJIP+GklUWbbLOfvrJyPDU9BV8a3E3DbThGPbKFuSxb5t63VUmZQ7qeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732317870; c=relaxed/simple;
	bh=u0RxDJBthszbybGQk9wFjDGCIn5Najs8610GW0GBdbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k11FHR3K+rIMjmXfO15bNcWoby4GNeefNUOuUgOuI6C+SqFBKQgSBElwebWkSvcHnjLG0bb8kerNDa00yPycni18rZiY+2iJDixCHS0Rj5lTD4lFqx+h4XiiQNexHkJSj/9yYuqMKaqnRP6Z0GW8OC/Awx0t2I8bFAa1u0E7b9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNGAlwUu; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e377e4aea3so21394457b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 15:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732317868; x=1732922668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6f5Cg5ni0UxlK+AJQaxldsRM/7KRVbxPRgVDGJ6GHg=;
        b=bNGAlwUujCixHM1PgkLwcxuUQ7759uzAIUY793BWXZAlpjF+pTWOvp1/jKipHmA9OX
         9FD1b1IqZhfG6MKDX8zS4NmUI1ebwo1D3gZQ4pQPDOUbA8fQOEVKHikcgKWKggpdhkn1
         otyiWgi9P8CsKm0bjUibN51IEqhY0RDPV554vZd7XCMdNAk9ebAc+DXn47KCvZhdWBXS
         Q+NasH2xBIL/jYxFN2n/lVWIAsOpjuwMSi9enI4z8ryVnUA4WKxKhum7JtjcGqdrGzt+
         lTPia18g+j+puVcx/JVQzOZMkEN9eST2Ta9z0wXbxVzHCev8braGJFAWVU89UHrNAXSZ
         oxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732317868; x=1732922668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6f5Cg5ni0UxlK+AJQaxldsRM/7KRVbxPRgVDGJ6GHg=;
        b=YjNj/t7W7UC6ZwDTcFOM6Xe6b+4Jg3i3umciPBGVE3qOJ5D/aqT8bkR0PW2ssptyt0
         FsPuywRoMFDqzhBDhrMBMFB9KOHrL8EAVTohF9Eh2Rh3Zo8fSRYIX2qktWPU4S026Dea
         obj1AwNjbJlFQMVnPCLrTVMIgGLVErsLOIHmizZXHxgkmvMccLB/VEL5is0W9tLy4pOM
         OkjnrLt2Ia9iUVVLV5J/BjYzLedSzFCO9VG16ifjCC1+J1crOF/i9oFQxoiI0mWBW3Yr
         Yr3FeuTFwGZ7cB4bSiRMnVPpKOm82HvajCilucd7NhRlhyv9Knhxq1Jlijbd2aRJkpk1
         Pw2g==
X-Forwarded-Encrypted: i=1; AJvYcCWR6HjHdesSftNe8a4tXcqwcxoPfVA3nc2wl4wqPpZFnKJinAJRA6mPG2i1kn4/oR9qoq6mJWW3Wp9aXBhC@vger.kernel.org
X-Gm-Message-State: AOJu0YyXrOfjk7zalc4JE4Wd2q55Gx7PInCDLwOxZwCD2zjsWJ4GBlGc
	Axpgbverr6T6d9MjxL6Zc+cchXoPNXo/572fFe5+FUIgJiVpL2I7
X-Gm-Gg: ASbGncvQ5Mk+hMepmpFKWcjdURtjYbmc/mbVzIp2aAwy0Ak/5Tjry6AGqdF/l6ofQ9v
	D9jQ6a5KfxSvZ3TxXE/GCkJQzb0iqWCqCYBmmAq/VgmzZWO3UijyT6cBzXqX41vXbzNt4zZrcmK
	zHcJOqZ9A+zS/x6vGJO76kWV4pvBBhwrQoevfdd4s2tCJappbk0rJgAW4caDW6RBUWTKhr36Vxt
	AF0jQ36mIQN/urqznz53MZz89PTUIVjJCLLwkrCLgUb3ZCi5f8erksI2/Ta9FUHYlsjElhfMbYU
	h7RoMxoTvw==
X-Google-Smtp-Source: AGHT+IEnS3FrA3zTT50mBSWxAEndxeY552vJ6l3IoZ28ABUPNtO80E0sf2ZpGC6IcKOhHuSDRBLYgg==
X-Received: by 2002:a05:690c:6807:b0:6e3:323f:d8fb with SMTP id 00721157ae682-6eee08a11f9mr64934617b3.14.1732317868047;
        Fri, 22 Nov 2024 15:24:28 -0800 (PST)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee0094db9sm6794387b3.99.2024.11.22.15.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 15:24:27 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v6 3/5] fs/writeback: in wait_sb_inodes(), skip wait for AS_WRITEBACK_INDETERMINATE mappings
Date: Fri, 22 Nov 2024 15:23:57 -0800
Message-ID: <20241122232359.429647-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241122232359.429647-1-joannelkoong@gmail.com>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For filesystems with the AS_WRITEBACK_INDETERMINATE flag set, writeback
operations may take an indeterminate time to complete. For example, writing
data back to disk in FUSE filesystems depends on the userspace server
successfully completing writeback.

In this commit, wait_sb_inodes() skips waiting on writeback if the
inode's mapping has AS_WRITEBACK_INDETERMINATE set, else sync(2) may take an
indeterminate amount of time to complete.

If the caller wishes to ensure the data for a mapping with the
AS_WRITEBACK_INDETERMINATE flag set has actually been written back to disk,
they should use fsync(2)/fdatasync(2) instead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fs-writeback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index d8bec3c1bb1f..ad192db17ce4 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2659,6 +2659,9 @@ static void wait_sb_inodes(struct super_block *sb)
 		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
 			continue;
 
+		if (mapping_writeback_indeterminate(mapping))
+			continue;
+
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
 
 		spin_lock(&inode->i_lock);
-- 
2.43.5


