Return-Path: <linux-fsdevel+bounces-28139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EE7967441
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 05:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27DB1F21EC3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 03:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14F62A8FE;
	Sun,  1 Sep 2024 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEt0tcHc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BEC2901;
	Sun,  1 Sep 2024 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725159717; cv=none; b=iM044L8fPBaN28lvq0/fIiufrmmfy9jGhLdbwyzNRQqFJViv+brMFvdYk7A0zr3iXeNWeevKcAXfLqPZEjov8Jic8ASAX2DyxberjVUPr9vD6ZqWxe5NFdv/hUIHXXSgFUybiz3/t2jM1aRifNksA29GMrr6CLtIaAmmkttn2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725159717; c=relaxed/simple;
	bh=UBiYJK+p+DohB4gZdvhbm4yFi8h1WeTfzTbREh5PF+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sF6NLq7ouRZu2cjmYwUovRvuSQjR458Wj8YU27TBLNK1e5IoV886a/6U45LM6pM2Y3SzikdrNVQXJV3CfJfC5ZdLl5MUV3kdbHnlp5C+oGzuKN3F1IucOyV1KBvBjHqMHQjngRreHzTSuL3S1Gwr5k8//SiZVOHW0CzCt7/57EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEt0tcHc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a8116a4233so127541885a.2;
        Sat, 31 Aug 2024 20:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725159715; x=1725764515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=djadNJyuJ2wPfNb4yapWyOvESM2uf5bfPTkIbuzgGKE=;
        b=YEt0tcHcaCNpPc8z3lPVB2yPX15mylIGg0M43C6SC3x1Enup2jpcD+HoxFb8q8YJSE
         8aCKAWU+oUAopAAvhXQU9tFiValcKZZdDrrTbadF1xbbIjUqP8hD5GxoXuZsA756Fy4J
         hyJpfBC8+wq4TY/ripAq373+8s2uaBrT16/eOqJkctYkQtgvQ/2ySlgSGJpprQoVGD/m
         5j4aJMeaSlvqfFnVseVERiE2aJ4FZiI9wekUOT0p2XA29Wpl0qjkOismFQRtHY/MGHxL
         KG4kuVdZI0b0qkqsQd75N3/IXB+kI50zteJQmey4A80JzEVSlTHhKxvh/NbGptUtA5uZ
         FyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725159715; x=1725764515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djadNJyuJ2wPfNb4yapWyOvESM2uf5bfPTkIbuzgGKE=;
        b=IzJkvwLZFYsny63LaA7wZ6+jK4Sxnj5s3DZsgG5NqE+RH6cGkNno9ej79dBsijbUR4
         6+dgk6NQuNmniFbJBsu7qNIYjM0/WMG1oQiBl+chEi3BPA1rWrKtpIXdX6bsUkvEb+VX
         3iUgiRxB4O8BlZ1nLcD+cKl/w6w6GcEENt39/6i+JuNl+PRcfJ+vcit3UB4VI5rtQyMO
         b760u9tcQMITAQQYDtZm1LlubZXbScaMEyHpqv+Am0Cq/gdi2p2nc6yVAeCS8hmk4AbO
         Fg+KfLSWd5mJ+LVoeaw05FT7huGMXXjhtuGYLvfDoTPd6wErRxEOKpDNpAE6rRXfgHdZ
         fHuw==
X-Forwarded-Encrypted: i=1; AJvYcCWicYTmIZvl40qhzQzfLmTZjnFJlE7wg7hZOvw8tXdQewwJumOHXhBZDjcn618tf3wJOWbMh/W+niTyG8ah@vger.kernel.org, AJvYcCWyJ1RBkSf+8CGIvjN37hnIAdfAjABD9VC+9me74dNiCjISfgWBrCl1qV+r+Riu46mSo9a3B9hxQJQT8l/H@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqlQAsXefjz/80IDqcyC0Z3vnMjQXTeBRkIS/O02oLmALyQNb
	nW6jEmFTZbw9dXGHwQElXOwAewL6ARQM0VZ26hALPLlZuqmWJoHvJlSFwsDV
X-Google-Smtp-Source: AGHT+IGBbQogDmDi77Qb2ex7TwsHpEzTvhrqviTZ2HakZEqNWIR5roPSL3VQxWhMqCGX4JFan5lByw==
X-Received: by 2002:a05:620a:3941:b0:7a6:56f7:7b2a with SMTP id af79cd13be357-7a8041b5ea0mr1312131485a.26.1725159714596;
        Sat, 31 Aug 2024 20:01:54 -0700 (PDT)
Received: from localhost.localdomain (pat-199-212-65-137.resnet.yorku.ca. [199.212.65.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c241b4sm292886485a.42.2024.08.31.20.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 20:01:54 -0700 (PDT)
From: imandevel@gmail.com
X-Google-Original-From: ImanDevel@gmail.com
To: jack@suse.cz
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Iman Seyed <ImanDevel@gmail.com>
Subject: [PATCH] inotify: set ret in inotify_read() to -EAGAIN only when O_NONBLOCK is set
Date: Sat, 31 Aug 2024 23:01:50 -0400
Message-ID: <20240901030150.76054-1-ImanDevel@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Iman Seyed <ImanDevel@gmail.com>

Avoid setting ret to -EAGAIN unnecessarily. Only set
it when O_NONBLOCK is specified; otherwise, leave ret
unchanged and proceed to set it to -ERESTARTSYS.

Signed-off-by: Iman Seyed <ImanDevel@gmail.com>
---
 fs/notify/inotify/inotify_user.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 4ffc30606e0b..d5d4b306a33d 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -279,9 +279,11 @@ static ssize_t inotify_read(struct file *file, char __user *buf,
 			continue;
 		}
 
-		ret = -EAGAIN;
-		if (file->f_flags & O_NONBLOCK)
+		if (file->f_flags & O_NONBLOCK) {
+			ret = -EAGAIN;
 			break;
+		}
+
 		ret = -ERESTARTSYS;
 		if (signal_pending(current))
 			break;
-- 
2.46.0


