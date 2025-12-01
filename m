Return-Path: <linux-fsdevel+bounces-70338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A874C978E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 14:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D99A7342205
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 13:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C1F3128B9;
	Mon,  1 Dec 2025 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vac9EPW6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD52F39BF
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595244; cv=none; b=jIFrMrLbfKYuRvLiP5Rg9nDUiOqC4SytNgkShYgARXfQlBFbG/7CJZlC6YmE8vNfl2tpiuziOT8uR5qr95Ro5J8pOd6tq/ZitOyLPm1O5dJoOrVPguX4EtKFQRM65PQ+KwWslYigRCrkRGHprrMuYjiHrQPKnxCnXNk6thSdeyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595244; c=relaxed/simple;
	bh=Ba4YHewJsBeFN9HspS3uO86WLlDcBz4A9HSc0LDhyp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DvR0SXz2KD877Fjkat8yyI/gNPpSh1pkiHjRVpagbl0+IISmmIgBdvINBTW75Y0cEZgsusfy+4R3lEsJkngEfFYoCzGdwGow+IfqsUaln+KAf4zK52MXHgCuxP61f9AWyufCZYCIH7l1JIArY3TJJQ64zCJvbUJUKhBUamp07k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vac9EPW6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so6022984a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 05:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764595241; x=1765200041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ggs9rtQy4/FD8+ye9LTzpVHkqY70KYv0vVpjcEq/ojg=;
        b=Vac9EPW6eq2URFJSgI928sVlFkqGSbZ5a3aQHD4hEDHS5co5h9enTq0UdWlipvztP4
         qMqtVZfbEuRXU8cIAi7L4r3HaWoQSXE0vBDHTcOiEobUIDmtBTVxlW4pXVnHYN+ff2qQ
         PlTfSj5gxOQZIBii5LOzBh6gZoA892gdszLLxZz8vaGhP8lgo00Rhe/9E1qMco0I9p6Y
         cH4YKEKTYN51SVmJSh9wemdPKj0mnZsC5M9y2oqd3QVZGRKePjApDqUzFXTeBy3R+aao
         wkwEesIHoXxyuhKfAtrOYkiWT0ixkllXVCR4jmyhmaTGNJwuwU1bErPI+iaWb/UgAMN3
         5F1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764595241; x=1765200041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ggs9rtQy4/FD8+ye9LTzpVHkqY70KYv0vVpjcEq/ojg=;
        b=o8GEe8eySmfrV0Ai+/vsgIAX/OUBA9ACMfc4GVvtjIQPy0oHb0LnGjSRG9Z8xnKF/W
         TdOOXHvvwOGZra5eP3UM3ZwTAKbt+UXKPjTb6sYI7/d2bhjtBMvwhmmzy+87wRa9BZrV
         Dr6edRhAv8Ly0Rv6S9Us4VQZrIQ11gdBvAh7EFhoMkDU4qxD51JCP4lBw8DrT1kK2Yzd
         UR0Eu9UD0xBNLc4clqH+or1fmAhJ7aaCltqpbYMYWlO24SGUHhM+Ye101ZDGfsrOVfAI
         QnOGwwMcOelhcbJnkV8nnFTYxIC3O2pBN7BGOdrWEx200wE5YdZnonlq+I5qGPdTuU9u
         yx5g==
X-Forwarded-Encrypted: i=1; AJvYcCUucqkHRoQz8PDZTQUawJNug1KKOE7G71ecOF9pEbEhrO/KTM7eFuPJTRtYt25r4iLPWw7x9C2Y03a1WD43@vger.kernel.org
X-Gm-Message-State: AOJu0YyiM2QKAnWQhAk2wWZxsDL2a0cBCrP9HxzXOi7dTOzuZ8vHfQbD
	NNjS4pElYmf7W0KHuarjk4B//ltazCQADKHNoY53S3dSKcdsB8ydkgDw
X-Gm-Gg: ASbGncsK9d95inr092/SmI33j9+EfGmWjq/QUMeVLDB/WvO/6ES+HGIHcsvrrIBjV/E
	jZEr6FHhqVHDk1E4RjAJlkoO+e9eAe6bIiQatCozpDHdualQJPfvA7RXm4fdJyLxuh9vhKq5KsS
	jclZts36RwsnXmxUIdWh3O73q+Ll3eMq4hh01crmvQXtxB+OvSW9SmVw8hdGCt/T7TuGj9k5qXJ
	n4xig77IMWCLQqeuluk0RfSZGikjKPov6pFTXVtsB8S9oIL4UHf2cFiU4tqOQUTxDICrFlBPZFi
	ZgM4avHbEpKUbAmjMlLsxIvab4pi/zsniCKrZeDJxhnwkcSdtvFg5HwE3fRJl/86PTvXwFg5l+G
	3ts9pijhlWGnb/w6AJbzdcJodjjxPhAIY2yfM1fUSG8S5kvbd+nmxSrywAjszulXNO+xs7bFPSd
	Km6u+KqHASr+HFEVfNFB7cVFqGQlW5RmRYgzbZl4omZiBXNfRjk73CxqohpKA=
X-Google-Smtp-Source: AGHT+IGY6R1OszJYvwXO/NtamQfh/xgq0/Ghs/ZvXVrgOeyhXTX4FFNjJoz2R5b4i9tvDGn0MAgjEQ==
X-Received: by 2002:a05:6402:2111:b0:640:a9fb:3464 with SMTP id 4fb4d7f45d1cf-645544421efmr33743604a12.7.1764595241256;
        Mon, 01 Dec 2025 05:20:41 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751062261sm13894203a12.33.2025.12.01.05.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 05:20:40 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: assert on I_FREEING not being set in iput() and iput_not_last()
Date: Mon,  1 Dec 2025 14:20:37 +0100
Message-ID: <20251201132037.22835-1-mjguzik@gmail.com>
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
 fs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index cc8265cfe80e..521383223d8a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1968,7 +1968,7 @@ void iput(struct inode *inode)
 
 retry:
 	lockdep_assert_not_held(&inode->i_lock);
-	VFS_BUG_ON_INODE(inode_state_read_once(inode) & I_CLEAR, inode);
+	VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_CLEAR), inode);
 	/*
 	 * Note this assert is technically racy as if the count is bogusly
 	 * equal to one, then two CPUs racing to further drop it can both
@@ -2010,6 +2010,7 @@ EXPORT_SYMBOL(iput);
  */
 void iput_not_last(struct inode *inode)
 {
+	VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_CLEAR), inode);
 	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 2, inode);
 
 	WARN_ON(atomic_sub_return(1, &inode->i_count) == 0);
-- 
2.48.1


