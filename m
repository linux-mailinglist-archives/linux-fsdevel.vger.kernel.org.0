Return-Path: <linux-fsdevel+bounces-70546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2BCC9E9AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 10:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B07C14E11E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378032E0B5C;
	Wed,  3 Dec 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhL+tY39"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17F12E11C5
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764755716; cv=none; b=LMWywh94iE7tG2nGtZF2QH/uf6yVkhOYaE8iGfCNwNcddj+CWPh0uT4go+JXXZjLQJ4tOIEoEd9qbIq8lvzip7sS42El7Jtr9TSer8CEWgWM0ByMFOW9smKZjjsIis9dTZ+OqHJDF0F2bGoUl4K3R2XG6pLh3XWXYYtydq1D+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764755716; c=relaxed/simple;
	bh=Z0/PnTFWvNvryQbg/+p8fk0WkhD780wpan5KSSoHjLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ooXmujFUeo2mYvVJJ27Fo0RHu7Nr9gX4sAmKoxra+LY3BwkUDCgraePszJf2bprP/xc2d5YJ9AlROXaa4zK2+UK1F0mfj3IvXygux4aZrLd9QBJxBl5Wexq2N1KCa41mFpWAIc79ESMH+1U3BkyIm2bWu0K3VCwyQ6/ZwlDJ+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhL+tY39; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so4776995a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 01:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764755713; x=1765360513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bN9lxn/GJA5BYLYCQOMY7Em1q1VfUhkZaHoREN9oMY8=;
        b=dhL+tY39KhVsIiA7yuRLGmSmkA0TnjhtfrBzvrIGAXwGP/t3HRAwKqtyrr1+fAYO+D
         cHOSIp/lmdGbd71F1sUJHa8TW4EZXmRD7ALxmDHfw6Ov+JTeFyWJ6PmoYhpHMc9hXnEL
         d1KmWmYDfg10NTJxHWLiUaOOPvgRVUaTkGhfY1ZdFxKcfjCszKTTqWKGKHuxjt7pmsLJ
         bFPMX1e9CWF9Ni4QKMEpe/uTjyzoHVeVUP397EeekPd6gq4gfLcpsszVP/4k8AfFExPy
         5ylh7mzEstnBSun6L27GOyFNeIeRd9nrKnplfdOBHUKskcOqNwBs63AfznEQHlKzaV/L
         +UzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764755713; x=1765360513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bN9lxn/GJA5BYLYCQOMY7Em1q1VfUhkZaHoREN9oMY8=;
        b=V38R2vzBobBFjzx/7vHujziiiVd4epPrg3f4dOAf4aUYWWpYirkGAVVHM4CzlShGPV
         pDcOVCc/j1YmxETpfGoMKBFs0R/I+ps0maV2cUFqlAmeIzh8S1wbScuWvTVDgdba7Pct
         tZNBSkqYFnEHEOSjggsd9PWU3rk24aSaWS+OagGxGXauqREaArugD34ZY4Hh6U8qJ3uP
         sqftBlVWbVrLYqcKK6YB30mAtoB0wNaG51Y7YONrcPb57YfcYnu5O755HkHT9KSNpbeh
         ECTI0ud7UOqD272WLu7G7VbKiykSOpPSNw/2Kj8GSMKHOrLkWkKQpLDF1NS1R/jLz85m
         uyfw==
X-Forwarded-Encrypted: i=1; AJvYcCUChWWvA1LQfQjSzCge5x3eRyegUwkEUYE1VHQT7HKO+BQvUegJHVM4ozPqTgSJ77BzSZaXOSTt6oHKn1V3@vger.kernel.org
X-Gm-Message-State: AOJu0YxBLVFBkR2mYUqqxhOVRxilWCOc09585jwRuGtDTgeCiWjqrm1C
	XRuPhMaS319j6q72+8X+Ui/895iAQOnziBtbjUAqN8Rn6l54lWllHCXU
X-Gm-Gg: ASbGnctYwfktaG1lhZRkCMb0za4E+kbI+GlvuLYd4Bbn8hdACl6+bxvaXSfHnd220un
	AJSvJmYthyvmld9HAvcRMRkdgaIWj9b4i0h208RgVMqzpfWQTHohIAQTNuNYj+N+6nIBCzcokSt
	XsU5nlsYFe63xyYSqHKgTT8FhDsSPoX1V4aQVDLwJ0zP4nAyIofHsF1Qep5rBiEOnX5TonveCl7
	C5kBfZY9ExSE05aVnlKInVmpCXk/O/KyFkhw9mBIXwJF1WxZjUKja2UG5qF3AY+juHJx9waukAY
	Yxf3B0OwHV8AsN5+/0BG3xoJoClVrTSBUS/4B2HMl7Uosu8Vx/GTjfBjJ85RoPQ0MJgbxEgmRTU
	ILWI8Ll2ebzun/2bmLiAgLrJ0Bxl5gxT4ZChP90VhBLC2fHll5IEuEPYIlDcjkUMTCgOX4ku6Sx
	djezjM2EioJ5LIBlTmBWkweTs9dkHnKEXCrOG9lshyj7kBdanhbm4/RyR5w3ReYXY8nvIo3A==
X-Google-Smtp-Source: AGHT+IGJqX0JgUpiWAap7Hu4VouoGauAJ1MNNcTQQp1s0wjBG2lGhUhmp4lhVVByAg2u1M0ssiBKvg==
X-Received: by 2002:a17:906:c110:b0:b76:e89f:98a9 with SMTP id a640c23a62f3a-b79dc77b38dmr167319266b.61.1764755713007;
        Wed, 03 Dec 2025 01:55:13 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162d26sm1746352666b.3.2025.12.03.01.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 01:55:12 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: annotate cdev_lock with __cacheline_aligned_in_smp
Date: Wed,  3 Dec 2025 10:55:08 +0100
Message-ID: <20251203095508.291073-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need for the crapper to be susceptible to false-sharing.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/char_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index c2ddb998f3c9..84a5a0699373 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -343,7 +343,7 @@ void __unregister_chrdev(unsigned int major, unsigned int baseminor,
 	kfree(cd);
 }
 
-static DEFINE_SPINLOCK(cdev_lock);
+static __cacheline_aligned_in_smp DEFINE_SPINLOCK(cdev_lock);
 
 static struct kobject *cdev_get(struct cdev *p)
 {
-- 
2.48.1


