Return-Path: <linux-fsdevel+bounces-58674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADBBB306FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3214117D124
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3661374268;
	Thu, 21 Aug 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="3a2hxYO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459F3743EF
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807675; cv=none; b=pYkKT6j0rjjanc5K/36+UJ7klnZnL2bLd+ePexvm3IDPL1BroffWUR67DBSCtIH2O0wK6abI+swoQ1v4jLFLXwVm1Fy0Ckwa1Anprs+8RuIOu32i8i4lSbWwDrcA1Vb66v9NuESOiNxwiqC2clM73ATtac2ovcMDzgs4eqMP3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807675; c=relaxed/simple;
	bh=GaKmvGab+0a2RrIuxhv8XqHzko9SenWylGMpW6UIOW4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKT6Z3TGSwNv2ODkKdL9kjSFCMWkIABhYoVRGj22TDXcWnKsxuS7xPzyDweJ3cR+dGpyAcnUcsxO8cLWkNTSLD14g5SFoFvmNsGjsg5DWIx0H061Q6TxCbeo6LX1o+c/SLoOhGevqGJkUvhZrIhCGPMz4e7dKkITJXK9sRJI71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=3a2hxYO8; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d603a9cfaso11270597b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807672; x=1756412472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTOjoTpV6m7hLv/F0NHjQx0Ply5AcqoXgmnK8+LDP5A=;
        b=3a2hxYO836tfYyAVGnW2blIN319c+qyOm7QlScVs2dhASeE6ZvyGrxPDmVBKRoC6qE
         QpkTSKqg8J26CU9WfvFxJ70pIZ0XCbvcuw1cb/rYJ2Py2VKfxnlLyUDj5k54VpgQMB7I
         D4H3EZY0f2UnpxdoJN4FAxMCfi7ZVc6QajhNg4u8PrPFa6jOAaIYfoPQs/ef3alEfGwc
         jbdNtGvRTYzolRxjlcNTad9E3z+CjSFwtiL0J9XrRdL0EUPGovsRklQptL7mIDBgjbpF
         lE5T2t4tH/9uaoc7uWQt7NExagl/cwsl+VKq69S1Yxjv1Y3o6a+5aud9ylZuC4vmLAY9
         +XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807672; x=1756412472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTOjoTpV6m7hLv/F0NHjQx0Ply5AcqoXgmnK8+LDP5A=;
        b=uLs6jAQikkYfYbhgAJGuWXjmYsLvIG64xAsxOLedm+iqYExEz+hHZW8a/xxdKdHT+S
         5iMsZh/Ht/IZRiUxSOs7XU1msFRVcoGG2RzWSZwIhWQBfGU3FB+tIQEQxaNxwgW4qvVD
         Gz/K5MrnPV2SEDYnZhU8IhRb9ppHmgQR+BkKa6O+Owuq7eVWD0ADuIm7Qyqn2DO2LZYE
         i8SHwNsjAjdPMwuTU71j1c8Z9WFonwe+Gk8hF5LM8xiLhivLQ39U8RdAqTlzQwIPVFLE
         D8zmppmw19cd9NBP5mUO4OWr1aB6vWNg0sQaK11mZ56gb0Sfpf7mcUyGL2DT0uCJ7R+s
         zGaw==
X-Gm-Message-State: AOJu0Yz9lsH4ZgtYxgYg9zJcGB/emvEcQg0lDBwfroUg4eARz52UwOUL
	sbfRkK08t3DxTsFjzVlO4h+z+FTni0ZC4ulNd2tR4PG4PMRQDTfFu0OE6c0TkXJnQ0i0XHwoueG
	YfOqdebFfAA==
X-Gm-Gg: ASbGncuHgcq51Xsl0Cdy1xfQY3teu6pAr5dEettZoMhvI+VeynXHY4YGRSXxTr5XUQt
	JrTXMzpqiHXSLjq4TeTymSVLdj2APh/ojMjphAfAc4YmbcC+Qdc5sHIAYFetfkvvWXvN1HDFpLF
	1sV6RK8wFPt8txAd8dPOiF7zsnWghhMWOHKcknNWEQVcWoiHV6RfvG8JM21MC0CWDvhx3JgeUUh
	/3dF/qRAXYNpDIiM7QACnzS99/C/jFeMMbQxVYoxUnTXVXIgU8V/6iceBgHKXps541qDFgbwItp
	zzTnC5pefc+wQra9zh8GU8w3P+9+tWLU+RpugibGLLUZu9SLZKveIzcas4TtAjkHz0IH5Ogx+T2
	KFD38Ho/z6LKpqglDU7HlaItmJuQiHXGoQS3BDgaMvwhwVwHgl+qkF2T5XTEKjp4bXIGd2A==
X-Google-Smtp-Source: AGHT+IHgWhO0XZL2d+T13fQCGNTnfEWS9ecA9Ina0HETuoa+JmM/sUYXK320kf/CPFEnDhrEBPT2MA==
X-Received: by 2002:a05:690c:6d13:b0:71e:8165:990f with SMTP id 00721157ae682-71fdc316064mr7520287b3.24.1755807672210;
        Thu, 21 Aug 2025 13:21:12 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fae034dc0sm17871437b3.74.2025.08.21.13.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:11 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 37/50] fs: remove I_WILL_FREE|I_FREEING check from dquot.c
Date: Thu, 21 Aug 2025 16:18:48 -0400
Message-ID: <109daa67d809b78526099377be7f9fef59608010.1755806649.git.josef@toxicpanda.com>
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

We can use the reference count to see if the inode is live.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/quota/dquot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index df4a9b348769..90e69653c261 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1030,14 +1030,16 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode->i_state & I_NEW) ||
 		    !atomic_read(&inode->i_writecount) ||
 		    !dqinit_needed(inode, type)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 #ifdef CONFIG_QUOTA_DEBUG
-- 
2.49.0


