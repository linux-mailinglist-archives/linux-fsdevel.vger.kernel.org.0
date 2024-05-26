Return-Path: <linux-fsdevel+bounces-20189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B45FA8CF618
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 23:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484671F21626
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 21:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DA913A25C;
	Sun, 26 May 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="XmjO/I9h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304631304A3
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2024 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716758621; cv=none; b=O+RtvpIjZyHHOUHBy0rzmKLX0kMp4csOCcC/+n5bmirgpXlglOfiyP99CY55Gn6uwG2w/1UM9ip3AeUN3LeONHevcQfwPOsVwWRo2zTVxhiabL7RYUbffiU4y1WBAKp5naLu+znrhvtMHgH2w4MOZWQjolAdwO4TJN9aqy3/m90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716758621; c=relaxed/simple;
	bh=4br1+bsqarhpsUSUDMHnPY9ItAu5sQzF64WsQKB/4Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAkMWAoYnt6ZqBFWb7eU7kEP4J1JXbZLCzkBdidGqYafAiFelhckk3t2ZFCVtX08UiwbrzPTjBmxoAq6JDC71QAJXyeZIIa+KoHHZwZfRG8WycO6YwgbmRzX7vo6VolcflEx2bqsqafsIWyGERBls5w7GPLzb4dd0z1nYyfek1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=XmjO/I9h; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-354de97586cso5789787f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2024 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716758618; x=1717363418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qbk0UNvpsQrSUqN6RzC4hENS9R3C9NfeLNOx5djjey0=;
        b=XmjO/I9haUhiyklbPuZ9WpTglsUZdxk9OmWkuSxY6sNAUOyzp/IR/oUhSthm6XcE3L
         wJmuerQQprftAOKfkl9baTQLYH6T36DkBMkmyNLzzcVNizzheJu/zoe/hqGeLvGM4xFJ
         +cFcNtMMWq1Kj2gQpoXAFFWhodzuiJHLp4gFEOJ35YagajD7/2Ky23oABy5shch5Hkm9
         RxcXrW93bZepY62gWQnbwK4z89bXIhXdoRgtHoM8OICVbw4qnEX+D06h9U6TwFC+OLbD
         fxE7V63w6kBqOWvtS1En49gwNijuIOJEWyzOK8Jbn4eDETFSKXIwNYRkjgPlpgSrCJNd
         ff7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716758618; x=1717363418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qbk0UNvpsQrSUqN6RzC4hENS9R3C9NfeLNOx5djjey0=;
        b=T7rFPFN16Fi9buTMiJnDa4s4CLQ36QWiLSvszYlrCrcqGLfMMBQJgOTrkrbFWLrbSV
         tjnrnei/ZwIuOrWwKd/18ytoDtqvo0tSZ7LCrrnDlnGl7bxOgDakY/KvIgeWGWGKaw+3
         31DBw53wJ7Q2WywfGuYjhRmsdmRmcJ7zCoDFr4cfmnFCZlIGAHorv+3fazbAbspzjmAB
         KtoUseNitG/G0Jq04EuNbXduocYiYtadiWr93mpDg25Pmr4ghplkT6qOejicwS+7/LUU
         bMqD5eReu0ZJa4wpn89E0OZi3lgc+YlLXTYez9q47Mo5J5I5GyCkfuNUuqgiE78w9huV
         t9FA==
X-Forwarded-Encrypted: i=1; AJvYcCWMSY+5PKtnSu3E79Vx8pgYg4Xh4TGr/htDpuAwI1H/ZLxkO116zbIFAOixz3wUW39zn65k2P5OY4LMcwaIV8wtla56lFCQtVUY3NxOFw==
X-Gm-Message-State: AOJu0Yx+p6sKV0TBS+S5xqYGTyyX9afdxm6xgFeshI9BYZ9QLFNAMDcn
	FC0lH52KQizgC0aYb7/bzVY9uURyjEekmhIuM6cj4A2PSzGMSVBhMAqMNcgSvvc=
X-Google-Smtp-Source: AGHT+IFy5L/fF6HnmYmy15FzQ2I5Aj94AJhD6S8HOgJeCGnH2efGYlzLjxrfvdfR5wJ4GRUcUbR/8g==
X-Received: by 2002:a5d:4e01:0:b0:354:f1de:33eb with SMTP id ffacd0b85a97d-3552f4fd249mr5166115f8f.26.1716758618179;
        Sun, 26 May 2024 14:23:38 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7de1bsm7224197f8f.13.2024.05.26.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 14:23:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: bhe@redhat.com
Cc: amir73il@gmail.com,
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
	thorsten.blum@toblux.com,
	vgoyal@redhat.com
Subject: [RESEND PATCH 4/4] crash: Remove duplicate included header
Date: Sun, 26 May 2024 23:23:10 +0200
Message-ID: <20240526212309.1586-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <ZjcvKd+n74MFCJtj@MiWiFi-R3L-srv>
References: <ZjcvKd+n74MFCJtj@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/kexec.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_reserve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..d3b4cd12bdd1 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.45.1


