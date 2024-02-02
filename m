Return-Path: <linux-fsdevel+bounces-9997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CC0846E8A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FE02830ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D62713BEA9;
	Fri,  2 Feb 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeL6hCmb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F316A1AAD0;
	Fri,  2 Feb 2024 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871702; cv=none; b=WcGFwxU5tFZ16s+m4oeRWFxTeZ13zupWPvGRMhEaaLfI8PtWqYcAqveTJJkuOUuPGoFnhyndouJFMxapqyGfm788OfI42toNTu+oc779qpsQgck7FzbRlB169HiYA5BDRgqkK/3XsKZ5GEV+InpJHd/C8hOAjDcMHdVckS6lm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871702; c=relaxed/simple;
	bh=hkpeaV8u9rmcrplO8sPRlu+Yw3e2erGl5bp7bG2DOfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TFTbWElt7asO8f66GfFvAc8CJTSBfTg9eVy7g4u9kOCOT+M8G5gQIp8Sx73LnYX7Qav3v035vSYaqprlmwCAPxgIYobo87+kOHEpIAx6N+NePncVGmjTu9wGfLykPrxNZLI+qGFZifw+wB9bYhao9r4MKJy7kZyeV1JmTuERYRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeL6hCmb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b1b95df3bso624581f8f.0;
        Fri, 02 Feb 2024 03:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706871699; x=1707476499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzmNNtzVgqF5REdEifiI9TBBkr8i4rasQbivXnMhC5s=;
        b=FeL6hCmb3/6na+gdBYOsw+A2lgrlWL9nH5/whv9CwM3Q9bopJyrVsiBvwYTv2sCqWT
         FtbSeq3uzf5hf9CtllcRt1kkGuIoAqzK7Nt8q3fsaFxiLG4D7BnOHB3x6YEi1nloOqrU
         lR1a4uXaiic5AsaOXEkNw9ZVtPj1mZE8eRRCmMIH2lFs6VsUhSevVUMjKEqWr+0JG9uS
         oPmD1ojABWYnZ2UzcYGhnAoF5f2fg5+0EmIVqeoqRfFLk2lVpHSpkLu11s1JGRlEmoRS
         4z4kqgUf/zBERszZTq+aFODyJUA73l01HDbXuTLSW4CTWqXac90VIyTnN2fTqH/4CWPM
         Bbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871699; x=1707476499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzmNNtzVgqF5REdEifiI9TBBkr8i4rasQbivXnMhC5s=;
        b=LIdw4U+1Wuv95tIWC1dkf75iyi53av/LMedGttPRAT54ufOgubsxBLa/ix42pQraxC
         3UKtnHVWVjMGrYrvJlJJ/Q3tTycNKzmL9iPktAONvHpxUHs4HcFxHoUpcPv6uw/r2xrP
         WuvlB9h1Ni4eFM9u5pmf1WWyNG1p+KHHr5KFXPVYY+9USbCxjpQ8ky1cgnCkkaPMY90S
         YJ8DtHf0DB2ynFXe8w2u/1Quep3uJFrJQ3JWgsfiv7Hk8HC/K719p9VaNkXkiErX8nwq
         wCdjQePKr9k2He62U4J0UeMqzUNh4nIn9pb2kbg2IOfGaumXCPQYSdHAUwzOpiVa8oOm
         qb2g==
X-Gm-Message-State: AOJu0YyvJO2dWeUDKnbJXV7H/+1Kf3jfTNktI8ZP9RC1iXPSN7W+zlIv
	+LKnKr2R9vSOjsIOCYAGH6M1sQeAOn2M/9xbZZcMFXspoY/i1JaGHOy/Ostr
X-Google-Smtp-Source: AGHT+IGQp/TFEs6vLHnvcpQ9wYgdEEgTUtqawicb5Y+dLtAyDjU6To3cL+VhE5Zuzz5cC/lNV8zKBg==
X-Received: by 2002:a5d:4211:0:b0:33b:1a6b:eeea with SMTP id n17-20020a5d4211000000b0033b1a6beeeamr2515307wrq.51.1706871699076;
        Fri, 02 Feb 2024 03:01:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU1njgsFsNu3ozm6VYL92LQ5nas6y8HlqyjAI0+IO01MSu0lp61gFEqpgprJwU3hyCVOSHczUtPTDrN3Gdo2ROG9t0wswdF6/ww6XHdWzuyelHzmUk7g3dinqRwykPqhsUtat5p6TRkjyXiuzamooobLXhBDmFAWtegjLG6Bf7+jJBWr4snAstJ6YHlauZkXoq6EzE818Ip5ri0MMvjQrneVyMdtCAK/hA9z3AJgvuJm17xT0CChHEec316qVxdCPufruO/4bTTJngRsDqG
Received: from amir-ThinkPad-T480.lan (46-117-242-41.bb.netvision.net.il. [46.117.242.41])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d4d4d000000b0033b0924543asm1654180wru.108.2024.02.02.03.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:01:38 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-unionfs@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fs: make file_dentry() a simple accessor
Date: Fri,  2 Feb 2024 13:01:31 +0200
Message-Id: <20240202110132.1584111-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202110132.1584111-1-amir73il@gmail.com>
References: <20240202110132.1584111-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

file_dentry() is a relic from the days that overlayfs was using files with
a "fake" path, meaning, f_path on overlayfs and f_inode on underlying fs.

In those days, file_dentry() was needed to get the underlying fs dentry
that matches f_inode.

Files with "fake" path should not exist nowadays, so make file_dentry() a
simple accessor and use an assertion to make sure that file_dentry() was
not papering over filesystem bugs.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fs.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 023f37c60709..de9aa86d2624 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1078,9 +1078,20 @@ static inline struct inode *file_inode(const struct file *f)
 	return f->f_inode;
 }
 
+/*
+ * file_dentry() is a relic from the days that overlayfs was using files with a
+ * "fake" path, meaning, f_path on overlayfs and f_inode on underlying fs.
+ * In those days, file_dentry() was needed to get the underlying fs dentry that
+ * matches f_inode.
+ * Files with "fake" path should not exist nowadays, so use an assertion to make
+ * sure that file_dentry() was not papering over filesystem bugs.
+ */
 static inline struct dentry *file_dentry(const struct file *file)
 {
-	return d_real(file->f_path.dentry, file_inode(file));
+	struct dentry *dentry = file->f_path.dentry;
+
+	WARN_ON_ONCE(d_inode(dentry) != file_inode(file));
+	return dentry;
 }
 
 struct fasync_struct {
-- 
2.34.1


