Return-Path: <linux-fsdevel+bounces-43254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42DCA4FEBD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 13:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9306B1890C37
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564E5248863;
	Wed,  5 Mar 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByhDDAU0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5502459C0;
	Wed,  5 Mar 2025 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178218; cv=none; b=RFytVDQsMK3QURWzjhuLU7l4bVMwe1DSrJRAkUjJAuR/afm2W+DwrWFkDLNs9AbjfHcX1AGEs662F6Y4AltkY4rSaggnn2xnjxKeIDW9WhDnvx4L7qtSXrn1n3ozjffS0qQz6CYnB7DFipF1vpc/9d2c5XqY9Kn3dK6Gqrc22WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178218; c=relaxed/simple;
	bh=2ZK91i9XsyeViiZuUTFKex2pNwvDjGUQw0C7bW1KLVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pF0sL0ILa6c8SCgzmqQ23LqolXJ6y/ZiuDbIJFje/0eDpfWsFKO30/zG+xD09CYxuHpn2C1888noVIWyEAYuAisLuR/4eZ6NnJQ+LG9uM1JsZyJL7Jdwpa6lS8mWLpxclrfJVido/243edpCqmZkwEQ9IPcnvkMOA9VxFa124pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByhDDAU0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e535d16180so4942004a12.1;
        Wed, 05 Mar 2025 04:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741178215; x=1741783015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nxGNdfaQRrtpdKySkoLLtxRlIKFtjBBmUFqnTGFSs4=;
        b=ByhDDAU0E/3BRhUXLNbuLiD/NBqZvmYYZhschdCNzkAG/VxF8jMH9Qhg+zN/wQG0V4
         Y6D+5wxec7NM/WPwdr8U5zJJolz9Q+I2Hx7fS76RiHtB416ddFji8RDW0IstnOqobWen
         260qRkyX0XTn88YUaAfYs5E8X2gecccoiubCMtgmBAEOhL4z/SwFS/YYTM4yMMZa/gT/
         teDlTO5j78CIH/94CeGjhAovhMAMeoTYTQ58fCUkRIDTKBCAxdHU/paOCphbB18gx4nf
         uF0G0v8MClTc3orF5s9VgWeYHAJj3PtJJIuC/GR7zy36VbtXDz/JGXB7rzQ8Osbni+25
         y7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178215; x=1741783015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nxGNdfaQRrtpdKySkoLLtxRlIKFtjBBmUFqnTGFSs4=;
        b=N+0lGVF5fca3Z1OVZ4b4BlFOo7fdI221T14Oc4jFiSAuIBgbRtJDrglKDXS8VjIco6
         nrs5ZTzhi5HQUtPI/2ZfaUbOAL0gel9b6OUDmAajQhgXGcl9jNf168XCGqdjR1lB9bfM
         X7pKcCtbDIBfn84wopxua7WR/Iloks0XZd3LqOgn0/V/Z+1DPpjdmTDatBr3T629nmnt
         qgGkJ64pNLphy2MmNwZVJ5Ka92wqeFJfbv5o51WlBtqrjzMxruU1sNVwtRd9sV1h0lWV
         KVLxnfmnSdfxRqkrphtzdbKcM7ZxgQAxi7SkI5m2UC1TkbH82ZQVGPrb+K73YSFril49
         9Q3g==
X-Forwarded-Encrypted: i=1; AJvYcCUJNkv2UO0ZnZH8gZF9OR9bvbQsq9nw0x7Mq885BRQ/YCD6nOuPoi4lQVt3VEnAvzxjZC93XWnJT01BCbIv@vger.kernel.org, AJvYcCXvDEnfsX2tCq2+Wu9pXpwc7+V7pzCMRrXm6S9HasOTw+Bv5+lD0u/pZ4Yksmrh0STp/u2loPczQt1sIhJJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9Yt7pzzvjlHjoznk3LX4tO98IHe4vJKvdK9X1ATPuQZvcHEb
	ZMpNi0RAvDL4D4DKrhL7NTyaqzLHJLucu0sJYQnkAy9JTV040YzVuYJ/xQ==
X-Gm-Gg: ASbGncseOM8w4OQrjYJp5QZ+48kKfqfFoaXBTXcPM1Bry4ZP0amxBhegV5dVyGGk4Y3
	jtIFSHto9a9wBiok/mCeg2FSq3TWOD8EvOhGSt4sex0YayPu+/ufYM8rtG7cl6TMXLQkzc/WZa+
	ZUQGKmwW06KryPWo9Nh+tB/icasE8uaGPu1Ke3xKLqtaXLfIgT7k7wZHWjqXe4IuXo3XhRuTtmI
	Ub0FRXlDM/9FdglQbnk1THyQAhIIelhwaBUv4a5oO9c4S7vB5Gq/tukWKqw6AICaz6cOE8FEa4U
	2XbqjDnbrw74AUHGRLqw3tBp4p+NWBbPywpGCWgiue9meYyxnHk+DHoqQN4C
X-Google-Smtp-Source: AGHT+IGvc1WN8cHlOuGOsa9/SGrkXBK3KqfDZQHhVsp4eqeXT+14uDIetFVJ0CuW0AOyU/rLRl1b5g==
X-Received: by 2002:a05:6402:40d3:b0:5df:6a:54ea with SMTP id 4fb4d7f45d1cf-5e59f3d49bemr7455657a12.11.1741178215173;
        Wed, 05 Mar 2025 04:36:55 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6cfc4sm9632068a12.18.2025.03.05.04.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 04:36:54 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 2/4] fs: use fput_close_sync() in close()
Date: Wed,  5 Mar 2025 13:36:42 +0100
Message-ID: <20250305123644.554845-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305123644.554845-1-mjguzik@gmail.com>
References: <20250305123644.554845-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bumps open+close rate by 1% on Sapphire Rapids by eliding one
atomic.

It would be higher if it was not for several other slowdowns of the same
nature.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/open.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index a5def5611b2f..f2fcfaeb2232 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1577,7 +1577,7 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
 	 * We're returning to user space. Don't bother
 	 * with any delayed fput() cases.
 	 */
-	__fput_sync(file);
+	fput_close_sync(file);
 
 	if (likely(retval == 0))
 		return 0;
-- 
2.43.0


