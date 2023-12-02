Return-Path: <linux-fsdevel+bounces-4690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A25801F05
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 23:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97411C2042B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289C419BAB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="elr09MWO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59230129
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Dec 2023 13:22:20 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfcc9b3b5cso16206505ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Dec 2023 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552140; x=1702156940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dZKi9NMCd2PNGrGsX8s5UPrOfKzB/ri42Q6YHImLKk=;
        b=elr09MWOGl290voBUBoq7u39jrDe/xO30ixZh0QZYZAORAFEjs89UMRw2WMEGRbvFa
         /98vrGb1rWz/B/I6YM2/FuEfvvidMrgNoP4f2KPMTvvENFaKwQMrorysQEYSvoY0b//W
         QpTvfB8ega9RBGbfdj4sdCZ1fQ/Pc6afycvvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552140; x=1702156940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dZKi9NMCd2PNGrGsX8s5UPrOfKzB/ri42Q6YHImLKk=;
        b=iXA04mMRNr/MvXbVx/f/wDJlc0uWTlcHX5YOj723Y1fFkHVdFnFZJUP6+/sMbLJsdv
         1ct/nGq2ss6dHsNnGw2EnM78PRyO+pYKI+J1Hxuwy/fR3P5NIUp0HD7IMSc0a3Y2IISD
         eA+VackFZgkDhteNlOjsAjm6xXL+WOlRQsywcj1+AefRbrnxyWWbNaB68xWnswPOlEPk
         MvkGggo957i7QbZxdEOmoRDg00Tv9KDakSe4Gb3UZVKWVYZjIfiktzkYhb8pMGEiCRdF
         +ht7AnJxKqIpYYd4+Mm3v0HE6o+opuo2/s0pdG3WRoss38avO9P4wzb6LMoZ5MyoYw/y
         DD+w==
X-Gm-Message-State: AOJu0YzNtZ7A8ytC8b4BJV1fAvy/3oAjtk3oiXR3iCtWSC9lv+YKSPwU
	Z4NeAJXOm7+1vWJpqi1GCzvFiw==
X-Google-Smtp-Source: AGHT+IHQYZH3IlFcYH3VAbROSWfHbY4Lp+ss4pOueqIveJc3aQKHWsO1MW/WUU32lw84L7HJ6zBcSw==
X-Received: by 2002:a17:902:e844:b0:1cf:c3fb:a982 with SMTP id t4-20020a170902e84400b001cfc3fba982mr1644556plg.63.1701552139834;
        Sat, 02 Dec 2023 13:22:19 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001b9e9edbf43sm261943plb.171.2023.12.02.13.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:22:18 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-hardening@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] pstore: inode: Use __free(iput) for inode allocations
Date: Sat,  2 Dec 2023 13:22:14 -0800
Message-Id: <20231202212217.243710-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202211535.work.571-kees@kernel.org>
References: <20231202211535.work.571-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577; i=keescook@chromium.org;
 h=from:subject; bh=LrFJJwbwaP3diV7F4yBd+rDDPSuUzm8XAAzIy+IkY44=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBla6AGPooNcpMsUpMnk7AZ7HA4049QAKPudX3SC
 5es+XxUF3uJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWugBgAKCRCJcvTf3G3A
 Jq24D/0dySbOgDPtHzuco4GLjV8/iYcSa9kl2NxlYzcrytw4fgSpsF8oNM8CLBO/GXJ5Daol0AC
 Bt8jiWEvGaGCBkZQNHWCIGJGMAtRJyDYsJZSo5rR3SBjHlROGmwejZSlN2jXViiCOqlVt5YpuWR
 eHbR+BGWN+kRXzxEcpstmju+PVhbOto4kr1BCnJiVPxQA6zonvrcinQGGOXfW4FQrX2/+F0bQLc
 53nLZwcp0uDrnn8GDTUT7qZtSGqmQeUZwEtg4evOEM00CZXSJC6DCqntTn2k7+hCKznMz5IiJtE
 hrTtOUNTs2+FivyzNehv/RqK29xEV9jqkmeo9TLdLQ7N4mTEAb+uV4yKv21mg501odxycBHoamE
 e0BCS6k6HsaMHaIDM6SrTWfFPgi6o2ns4Uf3FUsQ3/6OTUEnqH+dtWaCnqjZMmJEBMlrg0HtjmQ
 trCoUfAwQWB9c+MtiAHDLQGqn4uw4bmmTaR1tTY+raBeV5lT60xOjJxBrNpM7zQ5SLLC+FQuOEd
 zQkKLeHJij3Bufk0646mwUGtWowKcPno5w9lNbO0WEv1cVhI3EoEew402Iu8IJQwWujM/0iBI1v
 J0eRgwkEoAE8Ed/6YEelW+hrgLvz3ABThVaktG2XO7jnh2Pki7SBtdv7e/MojC5x3QYA33h3xzw or4Uvecyt9Mh/aA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Simplify error path for failures where "inode" needs to be freed.

Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 0d89e0014b6f..20a88e34ea7c 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -337,7 +337,7 @@ int pstore_put_backend_records(struct pstore_info *psi)
 int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 {
 	struct dentry		*dentry;
-	struct inode		*inode;
+	struct inode		*inode __free(iput) = NULL;
 	int			rc = 0;
 	char			name[PSTORE_NAMELEN];
 	struct pstore_private	*private, *pos;
@@ -369,7 +369,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 
 	private = kzalloc(sizeof(*private), GFP_KERNEL);
 	if (!private)
-		goto fail_inode;
+		return -ENOMEM;
 
 	dentry = d_alloc_name(root, name);
 	if (!dentry)
@@ -384,7 +384,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 		inode_set_mtime_to_ts(inode,
 				      inode_set_ctime_to_ts(inode, record->time));
 
-	d_add(dentry, inode);
+	d_add(dentry, no_free_ptr(inode));
 
 	list_add(&private->list, &records_list);
 
@@ -392,8 +392,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 
 fail_private:
 	free_pstore_private(private);
-fail_inode:
-	iput(inode);
 	return rc;
 }
 
-- 
2.34.1


