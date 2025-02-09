Return-Path: <linux-fsdevel+bounces-41311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B72A2DCB0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 11:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4D27A28CF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 10:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B70218132A;
	Sun,  9 Feb 2025 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUFUvehQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A201465AE;
	Sun,  9 Feb 2025 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739098574; cv=none; b=u2wltQDOm/b7zB+S26qrYFLTFRygwJNYV1P0DchOhPn+W+v9adMn9Qpac3g98l07pDotVn7STaaU5rizM/RJageH6MeLUBrK5xm4rXhLpRYJH9SEFm2VtWe2J8Y8CfwlXiwbQMwUfwrVCdBhlE5gsd1Ehn/X4kyNET2X7Sz92vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739098574; c=relaxed/simple;
	bh=zXJ0D7PziOBKrP2hrvvEml9ZnFbLXIj93i2bZJy/ZXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fr/oChGXPlaYLqHf2b7qqB+eTimCSoo7svYR58ObCw8ouKd8Pp4E2hpbPuzy6DG+PTLxFjl0H/DBPwheYz/Td1CopwinRLf2o/p0ztPGzo6zLVs99hdRF4dMGGTUFm/mrzhhKShKlN0OeNpCINl4PlkULfJSA6GkbFNOw0R/B4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUFUvehQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38ddc36b81dso111387f8f.1;
        Sun, 09 Feb 2025 02:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739098571; x=1739703371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jSypBlJXNqvlbMoetMO4zkcr5rYigOWyW1fPKRBLIEc=;
        b=JUFUvehQ3HGGEF5EOvuNeVTPZnRsmD6sxKXExpiOamO82Ufd4Ve10kGYgf5UyOb/Tf
         +yWtZA4csdAvdtZJnB4daRkLihWiIpF3TTUDgtVlrLMS1U5crXwZlYknVGnWPEk/eFqd
         inzSE/ymTEdjnay8YOtbX9zP7iRXkPqLovb9h3L/kSWNrxywa7tolWEpYtwc9JOFZBBb
         Yg4yqxJmtQ9WnYGYboaX1nFCb1GFmVpnfUvR+MTOG9Uecg7cBQ+kogjmKDGST2qF3VAf
         s/w0S9xM52sA6v5wsaZGrPLvvaD8Ysy1FZlYoDmkll2DEYDluDPw3GAnvKgA3G9W6wpG
         g8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739098571; x=1739703371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSypBlJXNqvlbMoetMO4zkcr5rYigOWyW1fPKRBLIEc=;
        b=KVycuIbZJgJ14F/ieYdwkLWhOQQWRS9ERdvdMtb7HMm2g0qcixzpFQOIYn0vpT7IeP
         s6UtSW6fgFeF3CHr0F/lKxw0D2gzzS3jm8o8PSowoaGmz4N5kdagvDYHAtg0myHXdMbZ
         RgINqnwG1xfX5LDi31nuHy+K5o8QziE5lAiR39yUiIwcmwTyDSjxeNhGpzzryeK6T8Vl
         DrfP9D/4XuqO4F3pP50HYetKdelPfdC7q5h4tk9m+qAkgRKHyxv44jFxqvD1z8ePgrxw
         p5ftemdT5P7bWkSc6g87dw6tMAWF0EajBzLoklCdLLoGWwGpMxbtSFIULN5bv15C6A2R
         n/iA==
X-Forwarded-Encrypted: i=1; AJvYcCW5wv7AdjdCFDj2lovSOu6KEuvhJrb6evPZ+Vpsmlvhh/swjU0surUBzDY07ZPwk9E8NfU3Qfol6GEHkLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG42CXqvn+FKPpCMK22cpy7NBSV8vkHaiHSmgynUsB4EGad+dm
	vI/yUc0Zp5QXLPGmEnbULFk9CmnYzK+AHBgHCALjkBKqb63iIfsxliu4CQ==
X-Gm-Gg: ASbGncsPD6caDCwT4k4BFphkEkJjAiK5SC4bzFixQNvvf0AGMz96y74PYJ+i1oV4AfL
	ZBTNfy0oleMr3rV2c2PYxNmQK7lkPsrcTYv9VRxN45XaKpdlFwY+eF8/LVUe+1ugjKryM/8zsvQ
	TMGmCxDuUYirQ3sCmclpwQpTve0kuk6aMGs11nxujVk/ILhDi7QlSEXc63nMlzQiSiQOJOKJSRb
	3CRDCB1TZ7qwSOgzB4/WABh57Jh/f1KzIBn1/kH/v567FjtI9ilLw3ZMMc2IENl99Ty6ihdtlhJ
	HkP6v1PreeF0sgrNHkK+dwXN+ZPQoD1lpFtohMdcxTWiuoE/fWHkS4kAdX1WdwM1XMMpviA5
X-Google-Smtp-Source: AGHT+IF5xa+53zCng2CppHkoAfjxRVHhX0G/G6505Wt1YgyW+HAb9GqKomdhkXt9QdGu6hvffScE9Q==
X-Received: by 2002:a5d:5f48:0:b0:386:37f8:451c with SMTP id ffacd0b85a97d-38dbb20b159mr10713880f8f.1.1739098571068;
        Sun, 09 Feb 2025 02:56:11 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcb781bdcsm6325791f8f.23.2025.02.09.02.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 02:56:10 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 0/2] uaccess: Add masked_user_read_access_begin
Date: Sun,  9 Feb 2025 10:55:58 +0000
Message-Id: <20250209105600.3388-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code pattern for masked user access is unwieldy.
Add a new wrapper masked_user_read_access_begin() to simplify it.
Add the equivalent write wrapper.

Change fs/select.c to use the new wrappers when reading the
sigset_argpack and when writing out the result of poll.

The futex code could also be changed.

Note that this might conflict with the patch to change
get_sigset_argpack to __always_inline.

David Laight (2):
  uaccess: Simplify code pattern for masked user copies
  fs: Use masked_user_read_access_begin()

 fs/select.c             |  8 +++-----
 include/linux/uaccess.h | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.39.5


