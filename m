Return-Path: <linux-fsdevel+bounces-30955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBBF9900E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AE91C2161F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 10:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C021553B7;
	Fri,  4 Oct 2024 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMEqnz4m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E733155342;
	Fri,  4 Oct 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037431; cv=none; b=E5NlbB3mpl34BhyYLwJB0jwjkUeLPSEZ5ujdEicTa5G6bjvC3C+zvB+YXh59zsUPuhEQUBYolu5qLuOJNsQ/fx/7UX1ybJ4p8fqeibKYuPN9N2jlyFEAIXb6VGhw4KdLH7I4i02DGLPOdMhddi3ERq+w9DIQpzFc68mf5uZlqw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037431; c=relaxed/simple;
	bh=TcNfKrdPqFXwPsjHjY6qHNaDVmBBoqwOiV/iY/JcQ+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nC6TL8yHQAn90rcExi5OXZo2O3U7NvWug7EGlTBwyrecRCLY0DTMER0GaJFNnhQkPLASnZUJConOXTsfSQhZS85HaEwu5A3x6AYAUQpet4XjwxcdJISxaeGDvuVa7WwxBBMPdjbq0pARgFJzMhdD58b8WmRNaOiD6GP2yiDY0wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMEqnz4m; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398b589032so3176998e87.1;
        Fri, 04 Oct 2024 03:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728037427; x=1728642227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l40jdEEvhbgdYhgzNetRpuzwF5wi18ln2Cfcvfzr+lU=;
        b=JMEqnz4mmj4i4/051K9j+g3KXChZ0TApEc81GctjePBlUyJcr9AD82SvvHUKqkjbb6
         xhNXKL8C1nOtwzSaAyX+YLKTKDabO7WldyyQ5vdVXbLtOjUDMPiC+BSsgsjHOGMMoAFR
         FDfV3ep183SzW/FHc1rqTUYQUHGu5crcNZD9/pSogQuBumAlbsfcCUAGW7ly3zSHl/4h
         2mf2Wex6vchJz3TY7OPFoBAkRqjA+VnZ7V8KwYpxgpZi4oMGeaQQwdLsYb/TCY/m1BPn
         /S31clTBHY+QPi/+M3nSxIN/y/mIoDh4I0w7SPghRpAeT0ICly/TiO9O9C4QvzkRrKOV
         gMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728037427; x=1728642227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l40jdEEvhbgdYhgzNetRpuzwF5wi18ln2Cfcvfzr+lU=;
        b=DoE6TDHp3at8QN6fQkDDYMC3raWLfzVyBHbigh4ynhw0OJ+Oeot/Qd6kwEGoVza32U
         yZXYIM8hHZudkFbt1ET4xFd0EshqBETONLmYKu7cYI8IZkrj8hDEQWeEmfC2OD/ns+28
         7j8QDbvZF3F+UStwZmQZcjUPWWyGzoXxaeBc+b6yHYoDy3iJ/gbF6aKsEb3IWCFAqjCY
         mPeeAZn2PoTbsBgjNdPqX+kDCwJeMVVz02dA6RGsakbncmCjQmzuyN7i+c4x6VY/1Fkg
         oGGf9vfll8tA7CWfO2ntjgErfVSrA7nQXjNngni7LFBiRDN0pSXCcn4ha3D0m6XohpuO
         d13Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvvR9zEFuQsXrTM9ttEoabdmpoWP31Vg9S+5o+LF29UVtpE1DnjbaWIe+sVlPh/jEj8MQGiSI2WOLrdBYV@vger.kernel.org, AJvYcCWyc/wFLrWazs3smTQuBhzHjsI6Ek/wMngaxtXkrSQnOdSnsXxlga44JOWcqYId4hj1/IuVYu0vwGNwLJQVcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw39INQ+FhXQ5yfgyxaZTkP7X4OaplSQXwQRYmVxOLEaQb+wKzO
	lFjr0+QIvUe5q+M0a4Vlqo9ErQM1KdXC+TjoeiXXlNRaxp203N3J
X-Google-Smtp-Source: AGHT+IHPSYFEOYp0L/8lai/SrQvHB1cR2jSj0zB/qZ8RZMg1q8kWtmyrE+NWgASfsj3tmXGk40hj+g==
X-Received: by 2002:a05:6512:1094:b0:539:9720:99dc with SMTP id 2adb3069b0e04-539ab9cf404mr1990287e87.46.1728037426876;
        Fri, 04 Oct 2024 03:23:46 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99100a37cdsm207335066b.3.2024.10.04.03.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 03:23:46 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 1/4] ovl: do not open non-data lower file for fsync
Date: Fri,  4 Oct 2024 12:23:39 +0200
Message-Id: <20241004102342.179434-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004102342.179434-1-amir73il@gmail.com>
References: <20241004102342.179434-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovl_fsync() with !datasync opens a backing file from the top most dentry
in the stack, checks if this dentry is non-upper and skips the fsync.

In case of an overlay dentry stack with lower data and lower metadata
above it, but without an upper metadata above it, the backing file is
opened from the top most lower metadata dentry and never used.

Fix the helper ovl_real_fdget_meta() to return an empty struct fd in
that case to avoid the unneeded backing file open.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 4504493b20be..3d64d00ef981 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -90,17 +90,19 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 }
 
 static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
-			       bool allow_meta)
+			       bool upper_meta)
 {
 	struct dentry *dentry = file_dentry(file);
 	struct file *realfile = file->private_data;
 	struct path realpath;
 	int err;
 
-	real->word = (unsigned long)realfile;
+	real->word = 0;
 
-	if (allow_meta) {
-		ovl_path_real(dentry, &realpath);
+	if (upper_meta) {
+		ovl_path_upper(dentry, &realpath);
+		if (!realpath.dentry)
+			return 0;
 	} else {
 		/* lazy lookup and verify of lowerdata */
 		err = ovl_verify_lowerdata(dentry);
@@ -395,7 +397,7 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		return ret;
 
 	ret = ovl_real_fdget_meta(file, &real, !datasync);
-	if (ret)
+	if (ret || fd_empty(real))
 		return ret;
 
 	/* Don't sync lower file for fear of receiving EROFS error */
-- 
2.34.1


