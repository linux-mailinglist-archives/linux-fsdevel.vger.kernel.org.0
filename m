Return-Path: <linux-fsdevel+bounces-33279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A51B9B6B88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 19:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE3A1C233C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 18:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1C71C3308;
	Wed, 30 Oct 2024 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM5KzxN9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF691BD9F6;
	Wed, 30 Oct 2024 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730311306; cv=none; b=UPgAiPPfgnCAEkP0Qx8Z7w4j7c3Ze1bQVsfDxSaSbpI8IGWYPC/eFfQeLWK1NuFxI8OYQNuckXGuwl6LB0rZe3HDEkwZOi7ciaBhmiLLS5vHADU44dAM/7YAvZI1Jv4Sl7JH3kCTAbaItNw9djAKZPBzI0nt+Os2pF/Q7Epcv3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730311306; c=relaxed/simple;
	bh=kxBRWNXk7mGC+D4h2OF9By5VWchwSuVSqHGRRyqZP/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XRpD545ZABGtJGlXft6I5XN3A7bZiaIjL2qY8YAeknptuT3cp9YKQD6B30DmLmIhJ7oWWlQoJC6ws+jvwVEXSvYV6zbvLll2GSn0DvUoiviz8aMUXHmWr0A0F4aM3YxTst8weCOWv0r/Iulnf6kUxhJ4hIpRlUmrl8QltF51voA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lM5KzxN9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so983025e9.2;
        Wed, 30 Oct 2024 11:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730311302; x=1730916102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ctpxKm9XupWsXHDupGH1kukdh82QDivGh8V/94jYHw4=;
        b=lM5KzxN9c+EzgAhRTc3N+FF6tJnxJM7raem9+wBvsA6oxUT30Xfjsh8YJDnhWmZowl
         GTY2l0JBBmweg2fm3dwp/wvdZgpUdDbfuThDJHLqLeOT9z4Y3lB4MjBT0W/EEtAX477T
         /HkfWli81GzPPEzsMi4ObgcsyAhaeAMxtKrw3++ysF1vgAtDiOdaA+aPbZGlI9RaIxqP
         xT7DxGVGhH8rTebRQ+uKHaoZF1vV0mn/lqiqvh20C8XW0j9e3oqnse1iWjaANc5rmoRl
         eOu8X8ULgDx30a3pGDDA7gRKz1WoyzUQgNLKLPwyUwGPHDOSogZGw5qgi8RRkPrlt8N7
         97BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730311302; x=1730916102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctpxKm9XupWsXHDupGH1kukdh82QDivGh8V/94jYHw4=;
        b=xF019qPo/ApOuGwiuw348APdA27A21fnhyTNrvSurVX3KpWbPLPh6cbgcs9RZT187b
         xdM6Y5Pt3azhmwLuWN4Uz9mrl5be29NgrDUUg0Xv9Q8myLHM/lH8ayKRwiySNZyckREr
         Pay3cJo9cbyj2Xsel/DryztKTYi82Fw1i7OfG8FWQw/yrEoXrMxM+gBYcIJaq/sOEyLJ
         wKR0dk7I3I+mqISN7lonZQkwB1gp8khfa1cNQk7zDjg2CSLONL6KPngJHaDvzC26bswp
         B3e7+hUFRXB6Op5irtx8ZUzaR9+hMtbr1D3U9ASFjiYPltpOcidwcwIdaHeW9zMyCjh/
         eL/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU91/wZ92Zxe1lUxMxjcizwTZLaOVzsiPUMWda7athiS9EJcoxqJDnCeQQLxIhOTbr47jo1G+OG4uLjUOzX@vger.kernel.org, AJvYcCWVX+iICMRuiNIx9N9rLvj9p9/Q6T8MQmYEXYh5JGqdbbDS3wa4dRAZvxpigveti658E09xNOQJSRV2EFAC@vger.kernel.org
X-Gm-Message-State: AOJu0YwQPkXpa7Fnn2s/CAuDk+UOSJ3/Xreo/K+9/rgCHkfvw1vjtmjG
	y4RHxdW3TVrJhNYgf0uX6TgR1FWHJ0JsdhbMUTHY1czKqrgBnFw4
X-Google-Smtp-Source: AGHT+IE4jn3TceKdWKChgM/nwc8RySj1R7ssBKlNau7JGawbEV3E4XIRbvEl10/byvoEDM0T9SB2bw==
X-Received: by 2002:a05:600c:4fce:b0:431:4f29:9539 with SMTP id 5b1f17b1804b1-4319ad29f7cmr184731685e9.32.1730311301965;
        Wed, 30 Oct 2024 11:01:41 -0700 (PDT)
Received: from localhost ([194.120.133.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e7d23sm28049075e9.7.2024.10.30.11.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 11:01:41 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] xattr: remove redundant check on variable err
Date: Wed, 30 Oct 2024 18:01:40 +0000
Message-Id: <20241030180140.3103156-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Curretly in function generic_listxattr the for_each_xattr_handler loop
checks err and will return out of the function if err is non-zero.
It's impossible for err to be non-zero at the end of the function where
err is checked again for a non-zero value. The final non-zero check is
therefore redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 05ec7e7d9e87..21beb82ab5dc 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1015,7 +1015,7 @@ generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 			return err;
 	}
 
-	return err ? err : buffer_size - remaining_size;
+	return buffer_size - remaining_size;
 }
 EXPORT_SYMBOL(generic_listxattr);
 
-- 
2.39.5


