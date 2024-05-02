Return-Path: <linux-fsdevel+bounces-18522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9948BA247
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 23:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2678B1F21847
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 21:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74516181BAA;
	Thu,  2 May 2024 21:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="o9OoYScd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE5B181318
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685218; cv=none; b=JzUXrL4DIiBxHeVG6JseZNkMIe0SQ9WUpBswGOl216DqDeh/cr2GFmTHadRWlpGJMEUiRUV3f8+G4p5Zw1hRVSjrADWjmo3FSpzFuCo2Ch7Z7YjdjHdXfqe90Gn62yUrFv2BQeUpmvUKKmC7bzadHDuOxZNDGsYmGpatmcqPcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685218; c=relaxed/simple;
	bh=tVWXNCzdMWLdqo6Ilri79iJRAhyTbQmQeAhLhhvAFyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sb89HdoSE/bcpI/vPAtF5fvgiejqinKpKfPfzCes40ZCum7kHP8ZYlgswjnkUCPwTR8jDlxl+rLFCXZZk7ycUii92BckdVyCIITfKvmSTdCYcoZyR1bpNrgbdZtlK0+uttGHvoaDLUgM8jb2dqssdVfzUfmCM228HK2sAaZ4+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=o9OoYScd; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f0f6b613dso1705734e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 14:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714685215; x=1715290015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wU/XAKZMmUOs49TIIxrQWM7SSMi6Vt7hgebFMdmZZhA=;
        b=o9OoYScdHYuuenDc9CZlLY0tcO3eE4/qY+YyFolo9ynupcjYg5OyyaT2EOyyjV9jwD
         7kM9zFW19qAphPxyyl1kIJ6IVg2n4XBuR72MnhzhHGy5OCp6wP4ytOxPMGLXotIZY6+4
         BK7m/oHubHYiuEvwsXz25i31yabAPIMoI1bhOKihuJruGQ/FH83chFz/OSfKOXxlbUHj
         w35MF6vQFHzgdGyqILv6WxhgkS5tkIUr8wO1ZMXB+aeeJtqYKHjFvxhLo8V4dCKskzLD
         v8y57s+lrQgcUGBUcNMDf4lJEVaZIK0v6xUuF2DR12X6816mKotial+odtuoACnrDGgX
         p+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685215; x=1715290015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wU/XAKZMmUOs49TIIxrQWM7SSMi6Vt7hgebFMdmZZhA=;
        b=WQ7+/G+Hieg48mJMa9MvWow/Ad3nuZT+wExxvWY0Bgj3D3nwpCmazJgeTlX3kG6aWT
         AtNTbjqXAqNhAHMVBXydwfwbccGv3B4WVoil0Tl4AezWxHSY/GtJ0p6qvPr86iU4ICHX
         I/deIOG8Q7dhRHpbIrMNoSUhzhnVjEzyr2GampjynDwoTo9u9Ca5lc1KuRJISdV5M+v0
         J5OrDp5cwnLzM5lUSeKq/+4KZWtOrRD4PCo/d47G51+3D4Sj9VtCTIfKF6Qm+idOzCg4
         IUafajnOXKmd4WaxJzRtKEgtNafLxFhY49XE6UmXbRs6F9X8Slzw8Ngd/5i0dTPIeIB4
         NXXw==
X-Forwarded-Encrypted: i=1; AJvYcCWBvyOPmU/wZb6hT/kbbVg47EHkzh0GbE4f4l4QMsX0+qQkuPc1h59cRbXOeUtbETszL69YdPJMhi6aiQ9W9sRAbvgSeZ9tkU7unTDsJQ==
X-Gm-Message-State: AOJu0YyyxLytF8elCa3HQW9ey88Duve2Ixy3+hyArCSRFW71Av4nANSi
	SUMwkyv8b+lVSz1orn+mOM8YmlSXMEcjQa+op3OhlWN4XUIS/ztYU4MlU9+JuV0=
X-Google-Smtp-Source: AGHT+IFdU+CNhHsbaoct4Qy+KcY+OUDNYVYuy7Zm5gtsIUrtGa9LNDfgRLHazZskYH9L85fevDVJpg==
X-Received: by 2002:a05:6512:3144:b0:51b:e42c:2ec4 with SMTP id s4-20020a056512314400b0051be42c2ec4mr584685lfi.24.1714685214745;
        Thu, 02 May 2024 14:26:54 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a5981fbcb31sm354886ejc.6.2024.05.02.14.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:26:54 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	kexec@lists.infradead.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH 1/4] btrfs: Remove duplicate included header
Date: Thu,  2 May 2024 23:26:28 +0200
Message-ID: <20240502212631.110175-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/blkdev.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/btrfs/fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 93f5c57ea4e3..5f7ad90fd682 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -9,7 +9,6 @@
 #include <linux/compiler.h>
 #include <linux/math.h>
 #include <linux/atomic.h>
-#include <linux/blkdev.h>
 #include <linux/percpu_counter.h>
 #include <linux/completion.h>
 #include <linux/lockdep.h>
-- 
2.44.0


