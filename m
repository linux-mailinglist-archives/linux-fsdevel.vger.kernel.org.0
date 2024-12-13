Return-Path: <linux-fsdevel+bounces-37387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F9F9F190F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26475161718
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC891F03CA;
	Fri, 13 Dec 2024 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7rAwFrO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138491F03CE
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128601; cv=none; b=PQ5uHo0l9MtT51dNiZAR2ixWJv6rSpZ1Jx+4YjaFGZd2lN2UhrdBBvzgcqL2K6MdkdWAgyFRMZZ4ULXQkBU4UQPl1hp6NMx/sG/h+2jeA9bBPo9u2SYAdxVRQezB+kifvzaem57s9fqnGswHaeRyH//QML/FAmS1GHruFBHmsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128601; c=relaxed/simple;
	bh=6ZrRjb/e8440rM5YaPrAJpfXe1s8MA1WaHYrkuIGN3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsJQfHnrlaVIzljQ1f/Yt2Z0v6DEe+Uxb70b+C1jitL4sDw38bGmMJOBdz878D14ooWq66wr7XFrQpp5lb6lHDsH4toblX5zryn9BuF/VZwXeFO7QroB5bSfR8Rxyp6tGlTSKPww0Zxerds0qPplExC/JJ6gGrFvYnsELGzC+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7rAwFrO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6eff5f99de4so24537037b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128597; x=1734733397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0tiYQZ2Nk5Me6EurDZ8+B71ViyLwJM5cmZFljbkfGE=;
        b=C7rAwFrOwNM70vdFS1yW9Y89EyZewrfdxlN6WnO4ZifwZ0xgQOrWQ2n4yoBfvp501Y
         TT+rPLw+V/M4AmPWLNhSAah2mI2hoXkSiNIVGAXR7bqZ4bgvahsWYtuDisvEWxtZWYnZ
         e0/RRKDkYOfSrircku0i06XUUXJ4khBauvGTueyM0eWeViuF5OUeOPi4JfkTnygXGjdl
         qgFXQA2YDMxtxjS+8gNzUhlG5U95xWh1GDxneGtFfgEspqPbsJUEipXA3P/H4X5iUy+q
         hFgFKpBFhkmZ1wfMA8JNgijABrUYugpEjmYO4gV3IhT0DdMY+wiLiJ0q93XYmqlTSf2w
         ms0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128597; x=1734733397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0tiYQZ2Nk5Me6EurDZ8+B71ViyLwJM5cmZFljbkfGE=;
        b=AkW/R/KNimdnxdK7qgnlDeVnHj/3pwTvsG7CV9amLBGrUnI8X9Tej5EPKgxEhG2nK4
         w2Vgi6xF2KqzzjZqa4ZAexh8XGbKhfyRyUN3crgLubgeMe8R6FpjbU5oZPH3WiJl/xh7
         TDRRmydH1k/KVmfKsOSU04thSx/GxGFSzuKtY1Jtdm4vA//9sd+isHyhQBtT0kj4C3Wz
         TxIhzIl3cca3WME48c19UpHa9w2x0y3ssik+jLuVTfzSfipTYHZ4eK4p2Az/g5/YTP7F
         8teQAdDqz5C1qVV1+53w8MJhxI0RTwZhH31XwRpzpiJ33wuITsFt6QQx2umOS9rFVWmg
         VYxw==
X-Forwarded-Encrypted: i=1; AJvYcCVnhTHz6BfZtqCwu74YVRCNmJ1A9U76TDdBDnHyqG0KmlQKPhfVUfoQ6+3ZALzA9ClffwhQD+dDcmz3ECyL@vger.kernel.org
X-Gm-Message-State: AOJu0YwVbHSetdN3vyDQ+0tjGN90soNYaUePkTjcd82jGo3Piw1ecp3W
	97TBKP5MHS1a84ugINNOhtlUot/jMPwIG5pX9vR9gw0T5jDnJOT6drKrvw==
X-Gm-Gg: ASbGncubfrcz4D9HFMi4q5DhimOjCdUBOiwJGtBcgX4GhOVoxEllp74CaEzzQduCuST
	zr+DrmFLdVCeY+dTgeYJEr/yPym3G8wPE7tapW/fTt8tHS1Lzffv7u5MNBVsidfWluxAReKOzTA
	34PYdmuoi86s7EdvPIg6lWCmX4h9rAak7g+GhdG7P6ysS7IgYWnsxnKcYBQO8bKf/P43IsF+Cv9
	RceGx4T5vDN2GXK8OVegti8x7VlCLUvkEuUTBhjqUxTA+he/U4IGrhWPefVbh7MrxHN5yNRnUkn
	Yk2jJKp6DxoyJgw=
X-Google-Smtp-Source: AGHT+IGrd9/GvUJfQmkURD6JT59C9dXxYVNSsg4s8vcWL4A9fiYlg7K5JDQ7/WJR6xgH4UjotEgfDA==
X-Received: by 2002:a05:690c:d8c:b0:6ee:6e71:e6d6 with SMTP id 00721157ae682-6f279b16651mr43741477b3.23.1734128597129;
        Fri, 13 Dec 2024 14:23:17 -0800 (PST)
Received: from localhost (fwdproxy-nha-010.fbsv.net. [2a03:2880:25ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f288fc55e8sm1242067b3.19.2024.12.13.14.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:23:16 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 08/12] fuse: support large folios for queued writes
Date: Fri, 13 Dec 2024 14:18:14 -0800
Message-ID: <20241213221818.322371-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213221818.322371-1-joannelkoong@gmail.com>
References: <20241213221818.322371-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for queued writes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2f704f522b00..94e304a63f9d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1798,11 +1798,14 @@ __releases(fi->lock)
 __acquires(fi->lock)
 {
 	struct fuse_inode *fi = get_fuse_inode(wpa->inode);
+	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct fuse_write_in *inarg = &wpa->ia.write.in;
-	struct fuse_args *args = &wpa->ia.ap.args;
-	/* Currently, all folios in FUSE are one page */
-	__u64 data_size = wpa->ia.ap.num_folios * PAGE_SIZE;
-	int err;
+	struct fuse_args *args = &ap->args;
+	__u64 data_size = 0;
+	int err, i;
+
+	for (i = 0; i < ap->num_folios; i++)
+		data_size += ap->descs[i].length;
 
 	fi->writectr++;
 	if (inarg->offset + data_size <= size) {
-- 
2.43.5


