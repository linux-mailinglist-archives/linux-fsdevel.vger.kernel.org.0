Return-Path: <linux-fsdevel+bounces-49148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 607DCAB89B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 16:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184241BC2FA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0B41FAC54;
	Thu, 15 May 2025 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxwt7A6N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8E12CD8B;
	Thu, 15 May 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320360; cv=none; b=cNmo6axdPPVI8Ltp+z4Q42OHzZhtBsPH4Pm4JSc7eGOpWP/KZLlW0v/aqtMPJKOcgWlp+mwgXQNUYXlT0QkUPynQOy+Or3vT0yELM0FXlFO9y1dzKetW0tNg74pu198INIq2WdusFP4H4cPynaIhdwwQS8ZeiLs0fed8k/dFrmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320360; c=relaxed/simple;
	bh=XicbMEzMrzL5lLnQTyLnyLh4Xk1XJmeA6Z9zPsbIdQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFqjU1M5av0rahAZBtN/4G/D68mvZ38+VvfQk3Bm2KRI2VKZTZwBbze0XkbPLqOFGPogrTVp+J2i0zFwBhJVmC1Z9lK4UKdMJr52A5Wwp1SSlvsLOtzwmJYrYMUJY/KE1IK1atLPJHsXkM6oAoYjo/anwC+HDGRWwQRnKXxN+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxwt7A6N; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742596d8b95so1443774b3a.1;
        Thu, 15 May 2025 07:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747320357; x=1747925157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcmxPwjoxhUfjg0HJ44EtbQ1VFKx48WKH2fTBvu8jZg=;
        b=kxwt7A6Nw7MDkLmKmWji+k9h/27ToSTcX7zsY9Vn8KAeYOvlV6OkRlY/RAN68gHwfm
         fre2VP/Znrv8dDAeVdVI7pl6FVLGHBhT7zEV2wUtWx9N06PD34ex+cpE/crg+CneVrOo
         lGfJRnfn+5/6Hl/ymoQSfncZXMvC1+vKemThQruMH45x/oHGZZU4CbNozibA7htNq5wy
         WUmcr9ywxu/jc7bJqxhPNbR7tXISX5KrTM1EneIBQzgstd4a43HfZuHGQcTwVPB8RfZj
         AiqPI7BbCRU77gwLUrNK/xVIVZR0LF5SmGZTBJZMbpIRl9JcXB/dCEmZ55a1Hkje6Fe4
         pYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747320357; x=1747925157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcmxPwjoxhUfjg0HJ44EtbQ1VFKx48WKH2fTBvu8jZg=;
        b=kWiZIF2F93YYdZ6Hlky0/HTZaxkDlWJUoN1KdWXpDHEidiR37vajohYckyZJ3/NEKH
         5b1GLk6jfgKbd9SGtSGQ81wNT0tuubT8FZUfKXgday+XHsXSeQ9Z9o3VrqCJRMi5qPAD
         PXBH5p14HsOBKE4f82WVoljB/QltSPjbBB6GA5IX17HjWdEYuV84X68Czn8a9TahvaOK
         xLYTm5gN7efJS9PnRR9lqRYRQkOD8aGDE6eVYR6s2ONqF8xZSvVCx7NNpNLI083nDk9d
         PVUgwC1c5cMpqjragJPDc7y+t/O0nMOAzMCBRpn62ecAkt0BUnr7gFHV5VVHR0+U+jbI
         dhkA==
X-Forwarded-Encrypted: i=1; AJvYcCUuUM3InG2DD+bBiydMySSwS1svYvVJMjaBrXqtw75YpGQOIPWMdfP3XIFpon8k93Oj+1vu0Va/GgxgR2o9@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMAgymgrl3qemw3onijBQV9/8Rl5ZRES4B/EDEYBoGLnBb1Hz
	c7kpA9ooSSTcNeMEL4Rbzrl6H/2zVjullXohzZeRXsxRiusvvmBIMGz8yA==
X-Gm-Gg: ASbGncu1b6ToIBbi/Ws7F/FclBkWlpv5CQ1Z3/01S0OQ9UGLWyK3MIaUgCFxqcmxfs5
	0mPk8DrXSs1T1T/wQuyoTpU56QkY9E+lmqvmbBeczqHSQI12R1H1EKCbHDhc4CGNQXtQLsjHYIK
	ERWOJB9zZuyMW97ttp6PBJKQcPxmzsA79PCMf2PBEQENWOB2LF7KKZFgsOkMeYya+hEucNOPBjf
	HaVOkk+31kiRuPNmLyeRfAu85SWlE+mY/cSQVtc3oHQoi/qfOf4WIqvSyI2OA+2K6h3KiB4qKjp
	FEcQjRg4HwgY9quREiwQjjKONka33zOqLs4CMld9BAUBrNw1t9F1V26Y
X-Google-Smtp-Source: AGHT+IErz+EcF3OTqsTj2wkukrSjgdKQ0BJOYWRRVsAFHkWo3TDj3x/W+0aMl4X+v1D10DVZw2rhcg==
X-Received: by 2002:a05:6a20:bd1d:b0:216:1ea0:a51e with SMTP id adf61e73a8af0-2161ea0a623mr630851637.41.1747320357186;
        Thu, 15 May 2025 07:45:57 -0700 (PDT)
Received: from dw-tp.in.ibm.com ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6e6a5sm3451a12.17.2025.05.15.07.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:45:56 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 1/7] ext4: Document an edge case for overwrites
Date: Thu, 15 May 2025 20:15:33 +0530
Message-ID: <fd50ba05440042dff77d555e463a620a79f8d0e9.1747289779.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747289779.git.ritesh.list@gmail.com>
References: <cover.1747289779.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext4_iomap_overwrite_begin() clears the flag for IOMAP_WRITE before
calling ext4_iomap_begin(). Document this above ext4_map_blocks() call
as it is easy to miss it when focusing on write paths alone.

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..b10e5cd5bb5c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3436,6 +3436,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		}
 		ret = ext4_iomap_alloc(inode, &map, flags);
 	} else {
+		/*
+		 * This can be called for overwrites path from
+		 * ext4_iomap_overwrite_begin().
+		 */
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
 	}
 
-- 
2.49.0


