Return-Path: <linux-fsdevel+bounces-69626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D36C7F033
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 07:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED4E63446BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 06:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA932C1586;
	Mon, 24 Nov 2025 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qx9Oav8k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6092B221F39
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 06:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763964304; cv=none; b=bCKS84dr49FrdB/W0RYa22IsbwTb4I8FgXzGHfQliCvQrCkDI20gTJaoiqQUpIan2p80kDqHtljAEyb/c2Z/eCKhu5amAay6X/gKrh2Ggi69avVt5T597LnZbEXcB72PiSECzHf6MRE/JDrMTrnBKYgFTZjPACZv4tN7pvHWEjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763964304; c=relaxed/simple;
	bh=uwW5/7qGULapL1sVMLPb1Xc+6mdWxww9p7V7V1LV88Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EcF72KLY/0BlS4xjQOgj54r+Z+vBJ9HGuqOm0zCpRBfl9FjQW1xyGJp18OlZaMemfTzyOrp2wWa7mzLoGjwvhQVn9WBrhtb+QI/UUlXWkdHmb0dFaBYTl7lU0w6RSe7ubCoNq0mIU6L6L0ODYvIZ4l0h7osRmjNlnNdCWGT24H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qx9Oav8k; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a1c28778so43123755e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 22:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763964301; x=1764569101; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uH1o7GeIwYc1DYoErssPphWFX52WlisMeq9xtONgZz8=;
        b=qx9Oav8kq/eUyg4PMAyVbAa9TYkOJfPG4CLU41YDrLYNTTZrseRzKIOrjCWVHsooYj
         xENKfb1e8hKuWxpQmiipL1jeehc9rqnWL9prnV2IHHbyyIuByKyEmQZ8rqqzqcHs32mj
         47/OBWOk5QONOwVeLgnnx6lSCme3Y5OhQOYlLjPC3/ROwUfloPLPSua9FhnNSAU0MIKL
         2dcdWC72e1eEsrFc4iMtuAjM53rxbp3f/G126AE8RO9nq96S8ZYgg4w+uYYvmARlD0Gi
         tCoF7sl2WZmKrkBSZZcx8/dVY3mzT0ih6L/1MnV+6DB9Qc+CFI7E1Q7g3NbaqBFvDVta
         LzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763964301; x=1764569101;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uH1o7GeIwYc1DYoErssPphWFX52WlisMeq9xtONgZz8=;
        b=BXc2Z6AzolRrNB/zgaA72cCx53ZobQM3Ak/23kNVg75EvNlhn+e9QqGxhqPEob7cce
         dSgfZSWdulIPdJaqNUAEDKiKs3ntBYm6n95f8DnmGFatOEUjuwhYYXVP2xZZNRjOytnA
         MX6XhPBFyOD51FcfvTaqddo2o9mZhZKDBercAXOyhxIhSXexn4XSesj/gfJOfacHQeeh
         2QZxXK6dvzMkUdre8wGrghmKpm+LfJq6IOtUDnYGW4HH7nUFvDMq70/MUkwAG7G2OMgi
         unCVNtl3oTYLmVkKBDomgKwHjwwa5cGdC0wLKktp4ZN52Uqn8+h3Eg5UDkO/03YsEmRn
         gZdg==
X-Forwarded-Encrypted: i=1; AJvYcCVJz2nGuM+ReTNgMx5EQfoLkUMCoAoe5xMQ4fPr82fD0x3ioQ2rxYFY/V2QCOaXOkA7WkLhW4msw2BRxawZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw35pD6qQncLo46haKq8FJFGuyBGsYqFmi2o9Fp74z5/mrgzCem
	9prK/H8rm20yfk2atdmBxqp5QU773L9jMFmum5v1QaaPiBJLbO2EAT2uweXD1kl3Tr8=
X-Gm-Gg: ASbGncszICv62esB52pG0GmmeJi++Z57D9dmDckgmJz99sWLzmSfqjXLeavBC49LSv7
	620fY3JQKIimcGLNQwggL4+rNvM7LblMM0MPnOeUKcTguQvEwQxhFCqaUoUqW/GInaeHpcn6/Xo
	o2oadS/LhgbOsB47bUPxnF/BmQIZUb8iFqeninzKd/d5kAZovrkwJcXu9dmEMifah352KKN9TPv
	+Tr6Vg4M52l3qPldeoFZ4xSy3pZQ/q/IgedA2PldRI9fRhzu/7D9bJPEqg7F/yEzfxlD7yu0jTN
	wKTXU77a0nCAth7jCMBoDqT4Pzc6dli75dtgN5wy32DXkYSYjpVyh3jFmhTE6R0evCenyMyL07z
	gUnjqRB+g0fpYDy9bLIhBD4WIGHu1eUl98DsnihQF0enxsCK048G4bLLhQR73ibNAdGcHGChFvl
	kmNiwz/LkzO0ApmG14cz4zjR7GPZU=
X-Google-Smtp-Source: AGHT+IE/1JX/nps0nusBrJi7ArbL72409Zg8vYjuZAApbr5lk5tocgbNd/CCB5XgbxxXSuP2QUkiXg==
X-Received: by 2002:a05:600c:1c98:b0:477:6e02:54a5 with SMTP id 5b1f17b1804b1-477c01bcf3cmr104847785e9.18.1763964300525;
        Sun, 23 Nov 2025 22:05:00 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42cb7ec454csm25365196f8f.0.2025.11.23.22.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 22:05:00 -0800 (PST)
Date: Mon, 24 Nov 2025 09:04:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] fuse: Uninitialized variable in fuse_epoch_work()
Message-ID: <aSP1iMPil7wTnboD@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The fuse_ilookup() function only sets *fm on the success path so this
"if (fm) {" NULL check doesn't work.  The "fm" pointer is either
uninitialized or valid.  Check the "inode" pointer instead.

Also, while it's not necessary, it is cleaner to move the iput(inode)
under the NULL check as well.

Fixes: 64becd224ff9 ("fuse: new work queue to invalidate dentries from old epochs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Luis Henriques <luis@igalia.com>
---
v2: Move the iput(inode) and re-word the commit message

 fs/fuse/dir.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 761f4a14dc95..73a46b0be09d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -199,9 +199,8 @@ void fuse_epoch_work(struct work_struct *work)
 	down_read(&fc->killsb);
 
 	inode = fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
-	iput(inode);
-
-	if (fm) {
+	if (inode) {
+		iput(inode);
 		/* Remove all possible active references to cached inodes */
 		shrink_dcache_sb(fm->sb);
 	} else
-- 
2.51.0


