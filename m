Return-Path: <linux-fsdevel+bounces-34131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21CE9C2926
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 02:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B611F22E7C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B4D8121F;
	Sat,  9 Nov 2024 01:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="uWa5rgwV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A5558A5
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731115741; cv=none; b=pE2mpny7xaVon6OEaEHVv1CWk/+86ws3O1zNtJQU6XHlqdSfbDEteRH4fpMp5D20D9RsvVti/Qx2TwmM8Lxen5vnhV1lfNj8HrqCMXxTgVSbQTKFZ05XGQI+mm9hXkaxQVieiZy7SVJu0yhoHJpkhLp4oOgdOvLg9vypl9JiVKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731115741; c=relaxed/simple;
	bh=uZOIUaRs+7H+jn62BpsP+uX28ASu2b/m0Dd0veYqTPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAxSZZJrRwdA4UMaoH7fz3uCHL5mNbi10DcilgsFdtw3xVNinOFOsq7LNV3nDa232bTKh5ZkuN5Ay2hl0Cf7M2n11vB7EBQq+cSPuvHdNWibzJFT8I6YNkIVQsUllV4W5UJVHOjlWko78XZ9L0U743y3qhitXc5ngv+RrHpVKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=uWa5rgwV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c7b9087c4so6395ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 17:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1731115739; x=1731720539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4yNjGAg8qf3fKwWurXSx/s8j5dgkc97k/3nCeXjiZI=;
        b=uWa5rgwV4reeQFAdaDLk35MfwdFUPJ+wVO6Da+WNWAYyb5XPToSp87v5GfTcvvf+Iw
         YFNI/j6fwJbqa/71fHRWmClD5tPNynamdv5tsaHarZ0XVm/3hAReAFLb+pmxJgwDH4Nr
         dhHT6U/ex2MYmEiI7rpFj5u51hD3Eh0HAmk0iTB9bToJpH/KHfo80EW/YX/GEa90LTmE
         LbFZr9j6kSl4aF0y0ztLQ29KXgVP0wI1FabeW4z3P/5H+ILw1bqFD7Fuqdi4fma8WfcV
         +TeTaxTHhC3PmAWqA95HbMzaX/LPjfsUFpXzvt1KEq0z/F4JSjKUydICAKw/PssWD9qN
         eqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731115739; x=1731720539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4yNjGAg8qf3fKwWurXSx/s8j5dgkc97k/3nCeXjiZI=;
        b=dYAmqnpXKF1jv37P+VRf0/YgODk6z/iltpN99PmYYawEWDgmI7R6qSDrtbpbikLB6e
         saDwTvwNlOOHm9rdCaYRjyrqUvmZz3Ds2qQYoBgeUOy6FcmkfNFe5rvPq7qsU9eSCPId
         7tf+fsswZwAByWfEyeIDbHyze6fbuicHweCUyOPkswBzIqRRqKMH+HgHT29YOB/IsvpQ
         DWMXg4FJQrheOg9m6bucZJbTFgDav7bs0MZTEaBfhJV42XpsyHR3JioIzxn/Cn0rPj2a
         Ku9Zn2zZa/OH74/epO618QNW2oY5VW2n+cVPA8DYZGVzFkVnoBHeJRnFt/MSlbvpX+FF
         fKBQ==
X-Gm-Message-State: AOJu0YwrHydmfnVF/HF3wcwbO+NxSjKCH0O1qMnTMqPmsK4QD5g7t1Ld
	kluueh5mdwzW378Lfc6FhGeksN1MJ6+0+b5wDUPhjmQ4TkCV0vkJ6tdntoIuyQliyL2GUebTDwL
	l
X-Google-Smtp-Source: AGHT+IGxDPbGoufHSHqpkSKM+XO+452K3765m0FRuWx/5mfOxgW3YLlOJkt1wHWgGfUa1caBsRR/ng==
X-Received: by 2002:a17:902:dac9:b0:20b:80e6:bce6 with SMTP id d9443c01a7336-211834f8c81mr28605025ad.4.1731115738993;
        Fri, 08 Nov 2024 17:28:58 -0800 (PST)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::5633])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c96fsm37493355ad.255.2024.11.08.17.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 17:28:58 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: kernel-team@fb.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] MAINTAINERS: add me as /proc/kcore maintainer
Date: Fri,  8 Nov 2024 17:28:42 -0800
Message-ID: <fb71665d1d10a8b3faf7930e4ad9d93143a61cef.1731115587.git.osandov@fb.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731115587.git.osandov@fb.com>
References: <cover.1731115587.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

Christian volunteered me for this a while back given that drgn is the
main user of /proc/kcore and I've touched it several times over the
years.

Link: https://lore.kernel.org/all/20231125-kurhotel-zuwege-10cce62a50fd@brauner/
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bdae0faf000c..89645de6faba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12242,6 +12242,13 @@ F:	Documentation/kbuild/kconfig*
 F:	scripts/Kconfig.include
 F:	scripts/kconfig/
 
+KCORE
+M:	Omar Sandoval <osandov@osandov.com>
+L:	linux-debuggers@vger.kernel.org
+S:	Maintained
+F:	fs/proc/kcore.c
+F:	include/linux/kcore.h
+
 KCOV
 R:	Dmitry Vyukov <dvyukov@google.com>
 R:	Andrey Konovalov <andreyknvl@gmail.com>
-- 
2.47.0


