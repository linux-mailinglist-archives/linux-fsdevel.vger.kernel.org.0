Return-Path: <linux-fsdevel+bounces-20188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ACC8CF615
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 23:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86EE51C20CCD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 21:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775E113A257;
	Sun, 26 May 2024 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="eeZcNRTZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C81304A3
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2024 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716758500; cv=none; b=D44crb+q/giwjUy9hyEmEZpnQN+ZqYLHUBk+ICfxBHxzk84YCrSphB/uV1h1O4FOCuvLe487h5JYiOq/v30aEoy+6WoC0rwlV96MqMdsSe90iNziG1txiXx1aHtzvneMmFIftaODv3LBC3FL7NJ0KCd4FlMXdmnGAjG3BHX1ZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716758500; c=relaxed/simple;
	bh=h07742SfbAhVzUh56nb4wWh/jm6ZTEc0nPN1Utkt790=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJ9Fh6MTj8S+PqBEqrb+kAjhg0YKnM/o6dZs4WdhJ1H9uprYFdNBI70VUOEWUrSK0TMp8mO8lNzAvqaLvlxCTH6wCxk2N5jOmhmkrlb+eCRBZIoRWjxe18Bd3rc/U4YO4jE9+2y99pLf06DJiZPphZWNqI2j0Os5KNeP0/bGELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=eeZcNRTZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421124a04d6so4405695e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2024 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716758497; x=1717363297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrZS6a+2WmF7PbI/Eek9PooMML2FIBwy4rVSyH7zOdU=;
        b=eeZcNRTZMjJO4YnNQC5LsnYWgEIEkaUK7VRrH2kgUN57tFqpRYGi9DVEihP4of3sIX
         XFLo842CUd6TJFClqdCyoxKP0te2StP2BYj3h/ptB/PiBi9jpAkMBsippgKK0J3pqEJH
         R14zp2THbaJYl+KsKidRXo48qgeBJSPBPU2hqy/3bbtB9NsymtlzzatQfU+XMQB80FWK
         fKwxkoD0LmjeF/WNL4zIpQ5zpgY3svmyFyA4Mtz/1t2NmqyXjVHkFc1PTyPBT6rmZxJD
         i4AnJKVe3Y9UYTMYyxOeYGa0jgZvR3PGL+gswoKY26xIXD/VVS5lI4rh73iRdFUK8Wcf
         10yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716758497; x=1717363297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrZS6a+2WmF7PbI/Eek9PooMML2FIBwy4rVSyH7zOdU=;
        b=CMBZDp9ahmntM8VC8qsOJhPscvUY3glHZcYSYFhVOSVcY1UwBao8+UnKv6WaSy7Jde
         f0m2hyuFkO5UnNJZXgC2FOTCFF1GKizSGaQiY+ZgN8kDfKS4jW13ManFxeEyEO2eJdHE
         kRfjl7Jh4wqVpUHOXpop0SoYTOseKiE8jJfvysNiZfoeQ3L0PfKeHkwBvtWeOHF8WjKW
         8eXSMupjcHm9Ei87bgXTucSOSJLsPPpYfT/Cd/pb5Qf0nmUF35j6PgyTgY7mTdrwxpgS
         qw1elhHPP3SdLo5+lk14jnGddkMtGIYIsG+Z4js/erChLWG2c3Rn01OUc7RbxfO8lICl
         ICng==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0Pz4UfkYOOAEgiFR2GjN+LQPmryumUrSY3SMVXXPtap7NToJYdS0L5bfcNkWg+Kfk6rYcUGdiVRv9DheAXLPcuHEEqCDxrW0RlxPEQ==
X-Gm-Message-State: AOJu0YxlYGQx4I8cSrGk1VDeoxAc/NU80hJSUXbL0i994TGc6iuUNeDn
	1iXfpVOdodYF2x40yqtiGA91IM2uj2Xg9BDgIrPEqmdnblHwoqEo2j39Sv5YY1s=
X-Google-Smtp-Source: AGHT+IHW4ae7lxNWn2WaLCNzfX0cTLfvfU9RcG3UisSM/eMD5CFFw81oCKu+GmqWICgbek/bKosQUg==
X-Received: by 2002:a05:600c:6a93:b0:41b:f359:2b53 with SMTP id 5b1f17b1804b1-42108a14eaemr57525155e9.37.1716758497510;
        Sun, 26 May 2024 14:21:37 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ccf32sm87534245e9.48.2024.05.26.14.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 14:21:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: amir73il@gmail.com,
	bhe@redhat.com,
	clm@fb.com,
	dhowells@redhat.com,
	dsterba@suse.com,
	dyoung@redhat.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kexec@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu,
	netfs@lists.linux.dev,
	vgoyal@redhat.com
Subject: [RESEND PATCH 2/4] fscache: Remove duplicate included header
Date: Sun, 26 May 2024 23:21:09 +0200
Message-ID: <20240526212108.1462-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240502212631.110175-2-thorsten.blum@toblux.com>
References: <20240502212631.110175-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/uio.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/netfs/fscache_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 38637e5c9b57..b1722a82c03d 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -9,7 +9,6 @@
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/slab.h>
-#include <linux/uio.h>
 #include "internal.h"
 
 /**
-- 
2.45.1


