Return-Path: <linux-fsdevel+bounces-62796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2345BA10D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 20:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A567B6AC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 18:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0331531A561;
	Thu, 25 Sep 2025 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9TwYj63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E03A944
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825656; cv=none; b=VeXjH51FN1ohZj5VUvkeaSd4Z1IjHUKjjTwAXLJAcP9MjRiw0CGXYLXXAKgdM//FxRCTjJbpVUQiHOdg5oS2FDh6i0ONETWzT0Ybycq2GmLAkrJcWAHLaM02JLRaIFaShQld+Uj7Fn8ZLU0dM6gPlGiXagoKH4iFlaEJWlv1j1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825656; c=relaxed/simple;
	bh=iPMsCDmAZ1/9Rgvwln1uAxNNc6ZneIPOQTm4AjlYO0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOqVzYGSnb+RG3BhILKg9Mo0EZIksuaidomaj4AEP8gJDQzbWLWNYLa9HqM1QqzGtI/4NEsG3Edgi1DLAFw59f+exXy4nBTDd/VweCNDO52VluviLZQu5OBTnZERTvjpYkrR4KClLApX44rPNCRXKwWTRORtpLtTOWJ9Zak/Yw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9TwYj63; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so1557870a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 11:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825654; x=1759430454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T7+VqYarq32/zzn8AF8MiqcEn4oLnej22V5bgZfeTGQ=;
        b=f9TwYj63yfzmnW0r/w44Goz83yTT52O4gvZosmzowdM9hlI/n2HZPApCorfyOSsRH8
         HcZqRUBsoD85PbPWTo5FKTfY0rn9MljOSdzz0wTP8b21l0RqdFp4JAKZwmi87wg0D2oq
         8MrI/JH6tStcZTDMPq+LHGEdi5sVkSVX6mZWQKW8eWoTd8nFF+9l4paz0/cKgCPdiDXD
         M2E+emML0aOdUFTkmObaOukC/wccGv0xwrezxRc7hfpnGuS5XwohyPE+vRWI02uMJ6F8
         NxjczEaX1KmpiQSoHUw97woZMsekBz4frPz9aEphW3lag7J/rSAzvYhPDPJ4a2NkKaFx
         aE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825654; x=1759430454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7+VqYarq32/zzn8AF8MiqcEn4oLnej22V5bgZfeTGQ=;
        b=rlpirem92j5ulwDQ0lse0sF+yJyXdosQBlhf0J6oIiT61dkPnvmKOXwwBjI96I6YER
         iZZpk8KlYukvOHqEXZm1PBmEbuoGZ3/4MGZv0QcSmqFbm120/ioCbRmnnVza9Z15clDn
         cHwoLhmn89Ba61LoHxVjtsTfC0mw85X2AWMh1AG30I1MCC24KkQjjQG9Cip+Kn57KJH0
         kWRZxG7BZVN7RVVzeWBZPwGreQ2Rtro23+6pHbJHyulRAHoO+vLiryggJsR/ObIHf8py
         XPr89ClqpIxwy4zYt2QLAmXCDgQA++YCB5vP/hm2khqVN6zgP9tu0znv6UpQaFLnogw5
         fMeQ==
X-Gm-Message-State: AOJu0YwG9wSJ8iuGmQDWJvNG7N6XD+6r9rSpjdG3dfBCn+vD3Jwi3p4N
	Eomg103R+M/GDn30VpsGQIjavqrnSgxLvqn9+cVTwn9+jdbBgTekeRmV
X-Gm-Gg: ASbGncv7Q0/WydAV49cyd4RTPFnOoPMB4Un3qb1RzOFNdxc063tTFI4jfidkEoqPxyr
	lsmxJEpZoJ5IXhp5c0a/vWbE2/Gh9JCAGDvckG8veFIzu/dDBP9h+00erAaVJ2V83MTqPynvzyx
	wBhkNPuS4+YKVqonLeBNy0XTsR69nhIlTniKkV4j/E4YP/POfHUazR6yjqFIpWxeZmTh4hWvTnu
	uvyQ4+J9btn129AYdGBR1xPhUokb+TnLNc7hpl0z2ok/jhjafojAtsqEvtlxs12/Qf3EijTIFQa
	UqwvoU9Q7PtaIEAO7xzsyCw5C4Ac2iBw9L/7rNts34sEpMLJXabYFHzZphb/1V7QBa1nkDkaopI
	EFzTljh63MnRTgVtk
X-Google-Smtp-Source: AGHT+IHEjxtw1OTBoRCUierBIu5xU2NdTakmEBegZX7OlNKgnyULrixN3QAWIEuCSzDsEZXQjGt/Ug==
X-Received: by 2002:a17:90b:3ecc:b0:32e:7c34:70cf with SMTP id 98e67ed59e1d1-3342a300aafmr4570860a91.36.1758825654205;
        Thu, 25 Sep 2025 11:40:54 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33474c157d4sm3068727a91.25.2025.09.25.11.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:40:53 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
Subject: [PATCH] exfat: move utf8 mount option setup to exfat_parse_param()
Date: Fri, 26 Sep 2025 03:40:40 +0900
Message-ID: <20250925184040.692919-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, exfat utf8 mount option depends on the iocharset option
value. After exfat remount, utf8 option may become inconsistent with
iocharset option.

If the options are inconsistent; (specifically, iocharset=utf8 but
utf8=0) readdir may reference uninitalized NLS, leading to a null
pointer dereference.

Move utf8 option setup logic from exfat_fill_super() to
exfat_parse_param() to prevent utf8/iocharset option inconsistency
after remount.

Reported-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3e9cb93e3c5f90d28e19
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Fixes: acab02ffcd6b ("exfat: support modifying mount options via remount")
Tested-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
---
Instead of moving `utf8` mount option (also, can resolve this problem)
setup to exfat_parse_param(), we can re-setup `utf8` mount option on
exfat_reconfigure(). IMHO, it's better to move setup logic to parse
section in terms of consistency.

If my analysis is wrong or If there is better approach, please let me
know. Thanks for your consideration.
---
 fs/exfat/super.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index e1cffa46eb73..3b07b2a5502d 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -293,6 +293,12 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_charset:
 		exfat_free_iocharset(sbi);
 		opts->iocharset = param->string;
+
+		if (!strcmp(opts->iocharset, "utf8"))
+			opts->utf8 = 1;
+		else
+			opts->utf8 = 0;
+
 		param->string = NULL;
 		break;
 	case Opt_errors:
@@ -664,8 +670,8 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* set up enough so that it can read an inode */
 	exfat_hash_init(sb);
 
-	if (!strcmp(sbi->options.iocharset, "utf8"))
-		opts->utf8 = 1;
+	if (sbi->options.utf8)
+		set_default_d_op(sb, &exfat_utf8_dentry_ops);
 	else {
 		sbi->nls_io = load_nls(sbi->options.iocharset);
 		if (!sbi->nls_io) {
@@ -674,12 +680,8 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 			err = -EINVAL;
 			goto free_table;
 		}
-	}
-
-	if (sbi->options.utf8)
-		set_default_d_op(sb, &exfat_utf8_dentry_ops);
-	else
 		set_default_d_op(sb, &exfat_dentry_ops);
+	}
 
 	root_inode = new_inode(sb);
 	if (!root_inode) {
-- 
2.43.0


