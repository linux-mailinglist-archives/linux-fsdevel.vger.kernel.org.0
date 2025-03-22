Return-Path: <linux-fsdevel+bounces-44753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FABBA6C71A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 03:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C827A9855
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 02:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34AC335BA;
	Sat, 22 Mar 2025 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQiGb15C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B329A9;
	Sat, 22 Mar 2025 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742609839; cv=none; b=J1Y0snrXhWU9/adb3oVIAscsWwqC4AK86zQlo6YzQOyCTqtZ7VXM1ADff69a//XX+A+p7Yij0H6Nc9sYJMTV5kcU4YpsNe9yTWtCRHWRavfmoZQKwkehAYGuBECN+M6xV0YU6RPAcH/RyEaLMLBNErvTqp+dDFgY1yrAMQRnG5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742609839; c=relaxed/simple;
	bh=85nL1QROQTDm5SB7AA38fgrDMclZnntWyyRomYbyOb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AtZ7NZZemyq6ucHOlGeo45YemwEPkMuQU5KBgJiDz7v6+vDN/E/Fwo54/BuI8xKmrUtKFgPiT7we5/DuUHKyvC1abeLC++MUOJjja3PRyv27e8aP8TMsIr/5q/deJ62XpQIMrJZOsuFkTT58bRgs2+PitJ4Blm6P95XZ3L4K86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQiGb15C; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4767e969b94so48659561cf.2;
        Fri, 21 Mar 2025 19:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742609835; x=1743214635; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5F/pLJt3JZA19sCPSEyxqNC6dnLnvJyR1Rh8BramFHU=;
        b=bQiGb15CnDHn28Z74h4tuE3zxivHAdRHCeWd+W7U20A4Yp4hwN1K1OUAcGOpKbflH0
         FVV7MCL6cDEaoGLPGd8aQ9cK22JlaJ4IV3wMmzPlxiNKZSF2bQe7ShL1z7uabt49MFkL
         slfIM19ube2x+myid7pvhdjvuMkLyw/U3m0OlhoPNwp8AhjwFHN/767b550JYn4716NH
         WVcncLZWMZS/rIf15lbGMEc5rcWKcMiJoySeJngZLUqP81aYy4GtZtUmGBPWYiG5yJfG
         9JdP9JD+J/ceoGJuDlo8brh8gIHtmhrcF8I99QFSdNwfKPPZgi3eXTfPrybBAlR4rqkS
         ofFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742609835; x=1743214635;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5F/pLJt3JZA19sCPSEyxqNC6dnLnvJyR1Rh8BramFHU=;
        b=dLmixuOpD+RjI8s+jCYV1gS2mtz90IBYQbAsmHVD4zdfQ0YJDzAHZJxKQmnRLDEkk2
         w5YAPAQxsZEKBObNP7Lfs/y8kklipjx2/xV3GKg9H+ob/5ySV1W2swB32Pr8K5vS89y6
         Vtlp45QZrFexFL7+EziC9WGlaGvm/KOWoek37T7j7Z3kZafahlwJEbdNzJ/x+BJd713w
         k7+eWkChX5f21WTJ/kIocIiRPz5obEB+Bld7NcjXBs12LewJZSHrmp4NLAfANc+TGPWh
         M+08vCOqi2a6U++QhbaksDGL5a//kAMNKvsZlOfKXBocTILnsecZLKyb2y0ldED+kc8w
         DKYw==
X-Forwarded-Encrypted: i=1; AJvYcCVigHdnj4eCNjH+MsoxME3auGbzzq4TVAwaQLDIdB9k4mT0QrSZNJOoQroGjJNgjKki0Ng6zHsurUSia/oQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzsRgOTrQgn/LDPblaWZO9hkdJaD0mefbpmxBRvsBgmL53cb5Ze
	hmYg6y9u4AnppP8gDZyg+pUNV+pfg8wUXJJxFQ1FXbJNzf/zeOwu3SAppAJUSrs=
X-Gm-Gg: ASbGnctZE9mEhuMXrmUMxMxL6F5+FlO2iHN1hiUJ2Lsnd1nw+HS6CMadZ2aCR0IA5z9
	mUlYvdGW9qrdSRvAVjdYwCZuoOblqWMctXlzX2naDf8eQTvjs56dwHh748x/EjowrONuat4cc1f
	0Les1OtO+YUkNUrycv7o0sNJ6X3pCsgcS7dEkFuSfA11LrjAfVonbspOuj/Y6Y+En9h7DOOx0rf
	LYPhTgckg8IjfO/WhfVXAihL+ig3zuux50fF12g3fE9JPWR9QNgtliBN4CVzA6KT44+Pij2AhQ4
	3N+tr8b3nWfoe4KVPpIXi40DFnbdc3r6/Kucj+3wEgX84PuKIzQiLorp+s/Mz7NJD237c9V3/NP
	Af6R7i10=
X-Google-Smtp-Source: AGHT+IFytUdCmElhe+7B2ZUaP/mpqLWoB6dC5TkFuyYHraKooqK1huwn1jqfYfHLtiEZIiqFCjuAnA==
X-Received: by 2002:a05:622a:5e13:b0:476:add4:d2cf with SMTP id d75a77b69052e-4771dd89822mr88321391cf.16.1742609835298;
        Fri, 21 Mar 2025 19:17:15 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:5ff:9758:a8dd:1917])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d192090sm19395131cf.46.2025.03.21.19.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 19:17:14 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Mar 2025 22:17:08 -0400
Subject: [PATCH] XArray: revert (unintentional?) behavior change
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-xarray-fix-destroy-v1-1-7154bed93e84@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKQd3mcC/x2MQQ5AMBAAvyJ7tklbpPiKOCwWeynZihDxd43jZ
 DLzQGQVjtBmDyifEmULCWyewbhSWBhlSgzOuMoUzuJFqnTjLBdOHA/dbnS+NI0hT7YeIIW7ctL
 /tOvf9wNL5UPMZAAAAA==
X-Change-ID: 20250321-xarray-fix-destroy-274090a7a18b
To: Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Partially revert commit 6684aba0780d ("XArray: Add extra debugging check
to xas_lock and friends"), fixing test failures in check_xa_alloc.

Fixes: 6684aba0780d ("XArray: Add extra debugging check to xas_lock and friends")
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Before this change:

  BUG at xa_alloc_index:57
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc7-next-20250321-00001-gf45bb5d4b2e8 #854 NONE
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   show_stack+0x18/0x24 (C)
   dump_stack_lvl+0x40/0x84
   dump_stack+0x18/0x24
   xa_alloc_index+0x118/0x15c
   check_xa_alloc_1+0x114/0x6e8
   check_xa_alloc+0x24/0x78
   xarray_checks+0x58/0xd4
   do_one_initcall+0x74/0x168
   do_initcall_level+0x8c/0xac
   do_initcalls+0x54/0x94
   do_basic_setup+0x18/0x24
   kernel_init_freeable+0xb8/0x120
   kernel_init+0x20/0x198
   ret_from_fork+0x10/0x20
  BUG at xa_alloc_index:57
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc7-next-20250321-00001-gf45bb5d4b2e8 #854 NONE
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   show_stack+0x18/0x24 (C)
   dump_stack_lvl+0x40/0x84
   dump_stack+0x18/0x24
   xa_alloc_index+0x118/0x15c
   check_xa_alloc_1+0x120/0x6e8
   check_xa_alloc+0x24/0x78
   xarray_checks+0x58/0xd4
   do_one_initcall+0x74/0x168
   do_initcall_level+0x8c/0xac
   do_initcalls+0x54/0x94
   do_basic_setup+0x18/0x24
   kernel_init_freeable+0xb8/0x120
   kernel_init+0x20/0x198
   ret_from_fork+0x10/0x20
  BUG at xa_erase_index:62
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc7-next-20250321-00001-gf45bb5d4b2e8 #854 NONE
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   show_stack+0x18/0x24 (C)
   dump_stack_lvl+0x40/0x84
   dump_stack+0x18/0x24
   xa_erase_index+0xb0/0xd8
   check_xa_alloc_1+0x12c/0x6e8
   check_xa_alloc+0x24/0x78
   xarray_checks+0x58/0xd4
   do_one_initcall+0x74/0x168
   do_initcall_level+0x8c/0xac
   do_initcalls+0x54/0x94
   do_basic_setup+0x18/0x24
   kernel_init_freeable+0xb8/0x120
   kernel_init+0x20/0x198
   ret_from_fork+0x10/0x20
  BUG at xa_erase_index:62
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc7-next-20250321-00001-gf45bb5d4b2e8 #854 NONE
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   show_stack+0x18/0x24 (C)
   dump_stack_lvl+0x40/0x84
   dump_stack+0x18/0x24
   xa_erase_index+0xb0/0xd8
   check_xa_alloc_1+0x160/0x6e8
   check_xa_alloc+0x24/0x78
   xarray_checks+0x58/0xd4
   do_one_initcall+0x74/0x168
   do_initcall_level+0x8c/0xac
   do_initcalls+0x54/0x94
   do_basic_setup+0x18/0x24
   kernel_init_freeable+0xb8/0x120
   kernel_init+0x20/0x198
   ret_from_fork+0x10/0x20
  XArray: 6782365 of 6782369 tests passed
---
 lib/xarray.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/xarray.c b/lib/xarray.c
index 261814d170d8..638c4c90e5b2 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -2380,6 +2380,7 @@ void xa_destroy(struct xarray *xa)
 	unsigned long flags;
 	void *entry;
 
+	xas.xa_node = NULL;
 	xas_lock_irqsave(&xas, flags);
 	entry = xa_head_locked(xa);
 	RCU_INIT_POINTER(xa->xa_head, NULL);

---
base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
change-id: 20250321-xarray-fix-destroy-274090a7a18b

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


