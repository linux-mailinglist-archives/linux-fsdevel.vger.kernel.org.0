Return-Path: <linux-fsdevel+bounces-51627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63797AD97B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8176A1BC17CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD7C28DB71;
	Fri, 13 Jun 2025 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHTc734f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163EA26B75E;
	Fri, 13 Jun 2025 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851460; cv=none; b=ouh9LY1hociIKYP8pm/NhOX10gX/urwp/ehh6+PnBQySS4Novg9bPJfA/r9uqFRErLxPSFrQ9QWF+Caa1W+5ACB3BAZZvIT5AYbNjZ0xrBQDP7Pz51Ku9q7c4fsSS78fAXgfdtmEb5A8Dh6jG7Tnvy8Yyap98gtkGba3gP+yJag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851460; c=relaxed/simple;
	bh=Dw4ui0FnrjiiWGAw9mflG6X7uUD1tteMaNY52BI6fpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjiNmE+Rtfa5wuyEAErVsy0G9hXDaH/oTQhrlXZ6rCyisbECOrUuikKZigIY3Aq6LfhoUwCmfvx4L0XpJkGbX47TToSJz/xO0E5zJXQNnWVfDYWQlofUg6koipQSQ/RAX69288Nx+QxcnIlj17FeVv6OrWCWarmuGwFTrHx6dFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHTc734f; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235a3dd4f0dso17926685ad.0;
        Fri, 13 Jun 2025 14:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851458; x=1750456258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nADVB/FvIVF3hWdDyO9TCtHSdvoVh1t9uVKY6Ize6zw=;
        b=kHTc734fPE5nD4CP6BYA2KudkfVx4/tSSGFtdz2W/0NoUxqPzzs8LSVX1skZAjpd4T
         PrFd+uaOaxfa33HPSQpSwFQf+7EcnfhykXvFponfCPSDUVYi/uZpNDXcAXcB4C4ZeKIE
         iZyr3/S4a6tyq82OXDM27N87uSr91C2y6sLTKOe+SjU5JLp52OQM36cwqEkP8iiYdXKV
         Uw+1p4Z2dgZn9UHg3jWmqqLmorzQdUbTmOj8SptcCY3HT0MEgnn1fF7qRPv0GlpbUbZN
         nzYiWf6P9Yo4I02x8jmRFqwnes0JqNnEDjh0bPrBJLok1eLLuqlZK9Her9jPEqJhJaTl
         SIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851458; x=1750456258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nADVB/FvIVF3hWdDyO9TCtHSdvoVh1t9uVKY6Ize6zw=;
        b=QlbQ9hJt0OXXnY2AsC+hLgfz+1qNt1z+Keg06vyncRyWm7lLOoXkH2Tem662Vqw8Tf
         F4NUZmOTYJJWF8FCMoXWM4WLkrkZYVoafFY2SqSXp5jZrqZdnQWvjoKT9LfLXDaYFE+H
         UEbKHJTZXCrVg1z8BdTgIHC1QWjHl756FR5ZWUOmkjN+XA0jIfe2NwQssC5sIXD8K0ey
         qPrfNVwOWXF3omi4yflSpBgXAO5dcqCB6qh1uP6LXBUvM2wBd8QC2Yz1dRrEjr2gFpXi
         xj0WXbwPpCKT3fT44q06tkck2Mun4/3H/5bfRvQ8ODM4/rzfooqP+JJrxeGd7C28lxKK
         W1cA==
X-Forwarded-Encrypted: i=1; AJvYcCUh2df88VsX6xQjP7yKTY3w7BvWsO7x1Q5w3btPIAlYQGvuJvuoUkB1NeTMSy8EcAYnwuQBH9lPGL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl5MVrMvuHeJ9QX3s2Q8yIMub6CdGUQH8xfNt4R3wWMeJPN6yx
	perSyxkWXyiPv7lxGHtoVkMeAxss3Zv8TSpVDz82yIVvuNo5m/j43eywlqCoEQ==
X-Gm-Gg: ASbGncuSwG4YtWxovB4BL+5BR5Sk5GnfNLYlof8Dr980AeLDTWUp9jyPbJGKo1EAL9i
	2PWpj/dJwewWoI4l0V0UFOtvM3ERBvI91gxeyb0BmkRzN1wj+xHeTaw5Yo3SIjR3RWv/2r4eXV0
	FUxOe3N6y1jcb6Uzp1Vr4O7XBVLO7pdFOZ0zhtiQ2Bt8i6wdXcqzJKOHlBFFPiMXZVP97gF6HFg
	yB3fFmVoYznxPCumSJb7iWNMOuoyScf/lS6ZwEY5ft6fAPXvxemg6Rhaa4cnO+vrDisMOs+nOCY
	bZGXT/iutH8aMqxqt/fvFzmZEO58P5KaJOb4qo7Z0l6QJk8ufSW92DddnVjKZYg1MmOh
X-Google-Smtp-Source: AGHT+IF+YRqtI6iJugOzXyqz7i+//DwP/sVpLZni1uQiSCMMKUwgxbRkBY91nXpSrkSKG7a35+OkXA==
X-Received: by 2002:a17:902:d2c9:b0:235:c973:ba20 with SMTP id d9443c01a7336-2366b14d1a3mr15709735ad.49.1749851458199;
        Fri, 13 Jun 2025 14:50:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365e0d0b12sm19497465ad.253.2025.06.13.14.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:50:57 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 07/16] iomap: decouple buffered-io.o from CONFIG_BLOCK
Date: Fri, 13 Jun 2025 14:46:32 -0700
Message-ID: <20250613214642.2903225-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613214642.2903225-1-joannelkoong@gmail.com>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that buffered-io.o is not dependent on CONFIG_BLOCK, decouple it
from CONFIG_BLOCK in the Makefile so that filesystems that do not have
CONFIG_BLOCK dependencies may still use iomap for buffered io.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index fb7e8a7a3da4..477d78c58807 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -9,9 +9,9 @@ ccflags-y += -I $(src)		# needed for trace events
 obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 
 iomap-y				+= trace.o \
-				   iter.o
-iomap-$(CONFIG_BLOCK)		+= buffered-io.o \
-				   buffered-io-bio.o \
+				   iter.o \
+				   buffered-io.o
+iomap-$(CONFIG_BLOCK)		+= buffered-io-bio.o \
 				   direct-io.o \
 				   ioend.o \
 				   fiemap.o \
-- 
2.47.1


