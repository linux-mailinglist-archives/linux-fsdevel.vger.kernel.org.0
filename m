Return-Path: <linux-fsdevel+bounces-67153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC05BC367B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 16:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59801A27DDB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1B5316903;
	Wed,  5 Nov 2025 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+DRVwMt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F034258CD0
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356990; cv=none; b=MnXN4xRiy5TRDhOeiPnUqAoB7/gl4JUPbDCoXilK19lUFGHh4NVPxQyx/uY1JbAhJIfRddDTPMfNcchHEIA3Asuj//oljSKcWuoA73zbVmJRfTDbR2/hie8GHs0g62ckKSqv9LZihrwASXP5q45Uxcz034db9KAb9IedIa1tjrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356990; c=relaxed/simple;
	bh=DwpdGk8DQrrNe/uKiOzeaIcOB+1qcn0aryuH8E9eSzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IF3J661OD8HBUITUMsKzpZEDq+HNW3vIjQJuqD6xfQZgKkpoTNnaVxBoIiPowXxOK+CtTlm89hdP0+JrwAj6Bb1CJBBpEABbdlHpIe6lGd9TW9W+q++Srmosyw6ZKFCfkzFJHmJM7pKBLmHwCnyzkCkObOUwZ28AzWIfVjl12nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+DRVwMt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4711b95226dso88098095e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 07:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762356988; x=1762961788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SYudu93GVCayz+03i6iP+9i2AlzyUJPPG/ZJivnBUPQ=;
        b=k+DRVwMtSxnqbrAV8aLNRScFb4ZMDhPMiZa5T7/kxle59AFipkhHzl9ywZiSBkIPvE
         /NGUlJxKavrCW00WJhHS77F4gh2evZonywzKfcd7oSjcS1JzryhXld6afNgoImfwIN3H
         tyn5hF5i1x+IWpVRrmFcf2b0oVnbacjPZo7HV2hZLDKF+PMEl9ajBZPRbkNOEsZ8Q9FZ
         Oc5Kmkmp+zLtsSIXqAa/wvKJVnuSK8fBMJuHANG41L1QCTIltc8ImEJH5Bbj11Z5v75w
         vWtJJrKUBXF1xqgjkCgJO1ECBcELWWajD4/Wo11Px1bWP0C5EhnoLHgdtdLCOIAS1sIj
         XtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762356988; x=1762961788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYudu93GVCayz+03i6iP+9i2AlzyUJPPG/ZJivnBUPQ=;
        b=wZv1blYCpIXZivSjp1Y65ft0rxL9KvY7GlWTNLWJJjmlPx8k7Y+PTio8cUOJc4HQ4x
         Vo/k43yAV/ypURKdq3wiI6mzGRzc2tfXn+z1B3zozAW+ur9rd6ykt3Vcw0miEwDv/n3+
         jM7v2tZ03wlhLxi/MusEEn/bMQ9FRXq0ecu1CgDVqEOvZ58H8izg0XqIKIA7Ak3DLD+w
         6n1WN2Lo5UKOGatF5EDZfXNj3hJ6NfrnIJpFKXLxNNuTKR3Xp68Ce3WqvJCtTaPNMZaJ
         YNhLYIKNPuWmlLXYtv2knh4CVA8+mPMpRHMUaNyskKRATcw6rcaJC3OlXbyRzwv22J2t
         WSYA==
X-Forwarded-Encrypted: i=1; AJvYcCWQLF6WeBi3aHw1vdvXTCtaI7BFdBG0PZ7oUSQrbwkFBU9E66wANd42PWAtxn4fN8gsmOZNf8jg6orSzasG@vger.kernel.org
X-Gm-Message-State: AOJu0YxUHVgnl5sE1m+hCZOFNSMRbkbujEOrPdPDInnYefMVidQIdAUa
	V8NwNjlRvj0TI6Hpqeh5SnrevmpnvMEFd0Wr9hFJLp3xw8dtHz4PdKNB
X-Gm-Gg: ASbGnctUUFjA1pdMWTF42ARb35GD7vgXehNij/K+LqodsRdcZ1FkFtz0HaqrZp2GTTi
	c04Lcuprgq2snJ7NRm2kO263Tftu5vDmsg8BdD0GLZLcSkMEhrQcuKanzgwuSBo9iFBY3ldw1kS
	AkIQal4LJyJzVOt4Js00xH8RS3OFdc6NLYdpGKIyRCIrVCQkMXJrFow5uq6PDJD8tpBqkKW6ZGS
	aZnGFXqO0+ZlPOLWKCJ0GPzRZjCtoHrdc96HKLPhNej/4bPfoSwy0a9iYbHDxm8jxd1Qc6YJ+aq
	25qlO5PfeJuCa8vqf6zS2i4/k7FSUNyzRqM/+NggkJt/0bHHQ2SNbKpaYwa0Vr9KX+NjXwmEjeN
	th5wa216Ki0/WOluCuuUKoNrVjZF8pbrvrfDKPA3GIICoQhQuSFlX/qVcZVHTH5MY1fEMYBx1ns
	7br6QU1AVKpbgWRLhtODR9mWJ+V0AtAjBogKJ/kaj/Y6yd/H3W
X-Google-Smtp-Source: AGHT+IENpWtT4ZSL+H5XwM1N45FW+HboaVYJ2ML/odNVsJHMO7wJ+lEx1bxqsvFrTW/4FE6rwMMUOw==
X-Received: by 2002:a05:600c:3b0a:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-4775ce401ebmr46535385e9.34.1762356987470;
        Wed, 05 Nov 2025 07:36:27 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc2007afsm11436499f8f.44.2025.11.05.07.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:36:26 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: hide dentry_cache behind runtime const machinery
Date: Wed,  5 Nov 2025 16:36:22 +0100
Message-ID: <20251105153622.758836-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/dcache.c                       | 6 ++++--
 include/asm-generic/vmlinux.lds.h | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index de3e4e9777ea..531835e8637c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -86,7 +86,8 @@ __cacheline_aligned_in_smp DEFINE_SEQLOCK(rename_lock);
 
 EXPORT_SYMBOL(rename_lock);
 
-static struct kmem_cache *dentry_cache __ro_after_init;
+static struct kmem_cache *__dentry_cache __ro_after_init;
+#define dentry_cache runtime_const_ptr(__dentry_cache)
 
 const struct qstr empty_name = QSTR_INIT("", 0);
 EXPORT_SYMBOL(empty_name);
@@ -3216,9 +3217,10 @@ static void __init dcache_init(void)
 	 * but it is probably not worth it because of the cache nature
 	 * of the dcache.
 	 */
-	dentry_cache = KMEM_CACHE_USERCOPY(dentry,
+	__dentry_cache = KMEM_CACHE_USERCOPY(dentry,
 		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_ACCOUNT,
 		d_shortname.string);
+	runtime_const_init(ptr, __dentry_cache);
 
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e04d56a5332e..caef183a73bc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -955,7 +955,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 
 #define RUNTIME_CONST_VARIABLES						\
 		RUNTIME_CONST(shift, d_hash_shift)			\
-		RUNTIME_CONST(ptr, dentry_hashtable)
+		RUNTIME_CONST(ptr, dentry_hashtable)			\
+		RUNTIME_CONST(ptr, __dentry_cache)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
-- 
2.48.1


