Return-Path: <linux-fsdevel+bounces-49181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77177AB902A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 21:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192853A2BB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 19:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F6297114;
	Thu, 15 May 2025 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgZYiH84"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0B22222BB;
	Thu, 15 May 2025 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338675; cv=none; b=I+nWeREz6AvmPayu2UipngsFMuSsZ8/M0VvYzMahfzKQCndBjUEEoQ2iMT581syfP9tKhgtj6MQpOrH1fwkTO+6nhxLxKfxNFjxqcqjgjkrK5YB5aoSWgaKqtLWNQW63UM/jFn36TV5W31v0GhBEjyn3qsEKEesODFLAdN2F2GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338675; c=relaxed/simple;
	bh=XicbMEzMrzL5lLnQTyLnyLh4Xk1XJmeA6Z9zPsbIdQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjAIUwMW72IVo5XQwPWMIm8LCWPJn3hWLOMUaQzihyC2BY3iV2ZtWGlqirZ4dKxZq+RXmVbcQ2VSsk2bpZj/S5uOGZl8ILBzocTcUETfoNJP7G72N5fgIKHpfdWgQgHzrk5jmvDHwNyG62J88wd7Rkd9OmVCfbq238tzbav3IQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgZYiH84; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-afc857702d1so1059320a12.3;
        Thu, 15 May 2025 12:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747338672; x=1747943472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcmxPwjoxhUfjg0HJ44EtbQ1VFKx48WKH2fTBvu8jZg=;
        b=NgZYiH845mZatKapIKyQ435H5x8iLDMdciQ6JSIRQR/KImwa8/ScFpWxFFqmfHUu59
         xOEO+tOD2iHcgCWG8NSvr8ygnsCWHnNQxN1797tDKeAZaqg9/NHxOHS5t5hOKq1HJiy5
         1ES63EU9iprZNpr5W2BXfG0ZW39DGMf1Y7w+qUDlSp01TEHGo8Qw4rCmCevGH1DcWVEH
         j2QPlTQIvH6kB6eQyArl8sFbxUnLmYtF6u3xpnaD2Yig+76sQH4BJVhIRiwZfH0NUmsj
         M+h4/jYU4HsJoJlInhrXC37CsvgAw4yQz8ywUW0SkHyxsej2g45gmIlrW+vjQfmRWr5R
         Vl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747338672; x=1747943472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcmxPwjoxhUfjg0HJ44EtbQ1VFKx48WKH2fTBvu8jZg=;
        b=r+IJtF4sRJ3e/AiFaUoQsRdr1bl5C5z5y8lOsTMu9RuLHhdF7vmrRf7idHNwHYBTpr
         ybZJicW2ZxrnL4FT1gCqkPelOZIgEiRONmkRV64TtmOd3WxbG4wlvPnpdD8E5OtFiU2q
         JpHrn6lHT26PN1bMjQtQ0vlBH+lVld+sKurDLaf+Dnl7QRdMnw73LOotpc3UxiFHwPZx
         zi5EQynrOC5rartQt0ofZGKpTKDSMt28SqwX/V8jpryBy4ZROuui8NNuAaDC16r2vpW9
         GN1CIRrbc1Kun1fT5w2fKIU228T/tb0j+BvWZ9gNIgFKflzoO897Urk5W1nXlbyK0naE
         F06Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVhJZcmtin+Sw4/0EnfE4FjTdinRH+2/aAjbhSAcOjA2WUgTsvsYcdwH2wvN5fEKvCr/gWx06gfS6XUUEO@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtEocomrNJ2Z0r6X13M+Tx2FXRbAzViLhnFKAWbGZRRRVGgA7
	dZNU1+D9aEZ1VG++6/OLwsc6QOguGZKUcsJ0p/OFuix6+lX3zasx1qNzyqzZYA==
X-Gm-Gg: ASbGncv7aDrwMHXxFp8kN3tJKnRpEjpe7He9rV2VehHSlCzNKVTLSYux9S6iBkcfjVr
	bapV05dlEb73Wp1GQudQZi3cqMYZsl6cu8l7axBjhgF+85AELbaGGWdgqxbkcnFFn+fwlbs0Spn
	XcXM1CtMRow2OMrGYsnhdUAVkCk+eN5Ocpp3/vZkbi+KSeY8V0CiozBQbRTQqMvDVihxfQTgbjB
	0XOGdfKoZAwscDa9sslo0TaDf0lHp6reirNvg4t1CJOShmsTlDQ9Nzsh3i+rqukXXyWYiUn70og
	MgUJVRt1Exez99v4LyV61Gni8058QjxP/8PeJDimAHAxIEE=
X-Google-Smtp-Source: AGHT+IG5+rh0wXC/kiJYpPBP5QBAPsi0nS3kEdEoJHx7emXmxH6i9gvLCx737MIPQouz1kplR+orrA==
X-Received: by 2002:a05:6a20:3d12:b0:1f5:59e5:8ada with SMTP id adf61e73a8af0-2162187a945mr1053577637.4.1747338671780;
        Thu, 15 May 2025 12:51:11 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a9893sm280463a12.72.2025.05.15.12.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:51:11 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v5 1/7] ext4: Document an edge case for overwrites
Date: Fri, 16 May 2025 01:20:49 +0530
Message-ID: <fd50ba05440042dff77d555e463a620a79f8d0e9.1747337952.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747337952.git.ritesh.list@gmail.com>
References: <cover.1747337952.git.ritesh.list@gmail.com>
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


