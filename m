Return-Path: <linux-fsdevel+bounces-31323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E4D9948C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 14:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0AE8B22093
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FFC1DED60;
	Tue,  8 Oct 2024 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARnOfYI7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F8F165F08;
	Tue,  8 Oct 2024 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389779; cv=none; b=CaTdvMRiYlF82FNHbrKDpsp35dGzFHvrd5Z9qkUgfTTQGudQaXjUDTkC8fRiPnTQ0Wnn/IC5NK5jhSrjYia/idx6VlGQD+V6Bh3j48BSrHBDs6yjBaP/wn6VrAI+shOqt8SEs/9C3biRBmPQ3iYhT+qV6/tEjUZ0SeC9MOA2Hm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389779; c=relaxed/simple;
	bh=482txqLeNk4mvFzvk4g/P2lAkRhMgkWocQURd6tD8n0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lh0aldQ7vlWGbnjUsxVQCjp4vVtcrIx+PiEgGpd6NQuHAerUFmv69vCL0Ky/CtQxc1UE9vslvpMk6d7lr+Lsdm0axgVCSA2jucojAMM9u7CPeOOwY2VZyGPvuP6hY3TJOjtahMzxs2c6XqHAjrjOeb5Et7trebwNULzv0c6HDxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARnOfYI7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4305724c12eso1362195e9.1;
        Tue, 08 Oct 2024 05:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728389776; x=1728994576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujHJys7fYYHhgOPFU3KJvztMDKT72417+uhQQSgyc0A=;
        b=ARnOfYI714JRqzfr9Z16lUtFLiptybvIVejkbAHaw0PBLUAiz+oi4al3i6skQ1QEH/
         9sNWuxItiPfsfE0IaFCZtfyUCnK9feB8aCfQe5Td4fTQDDLBdsQQu5ynDduo9klWY+64
         OHO5YlolzdpMc3gErv0Gxsvzg5x9fGECXGEdo3wN/YRzdVAGBDRtr1+wxQS/0OOdZtwI
         B4odusEU8DHSilSQuWEAH78H3glB6iGAkb0Y1OkXFZMJWVe25jJKM5jDsh4bwA7n/V0U
         al1h3w20bT6B5FxR7RDrU7XhQBFLqA06b6ZTkficR87RqmuC4FKN+Lrk/yR2SDVDOof1
         9ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728389776; x=1728994576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujHJys7fYYHhgOPFU3KJvztMDKT72417+uhQQSgyc0A=;
        b=PQsEQ8KJ1Hd938GUnZWaun1YLSJ/OCeCMqi6QpRjBnAFppllrKfkxqLcZK/UFwX21O
         oIYfL7kEIX6hYLaLVPiB1AiNFUdRWoONoikTyR3kI5u6nKrux+RyQnD+WTk0sdWLq1FH
         Zk+qjNw/TvRpS57lvbGPUUy8oyjA1WAFDXZEG/EraQ/HIMgogzpOlSG2JhbLLxF9xc5G
         tTXZm0P+aWmQi2gsxGYQ4BlccRG/6t9PgSQIlx8rIlSYbJmwH8CZGrmi42TdVKvY2zTS
         f7nVnN54K99wNaHWp2vFRleCUucTbN4cNABw7iMZTB7EBqeTK95ZQEMKnwF0PQvG18yZ
         MIWw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ968XGJt0eCy7Nbfzii10CcR0rGakutF0ScXql/ciFNKbOkMXVSW/Ep4jdCJBxvSt5xJ/Qp/vx//PjMob@vger.kernel.org, AJvYcCVOXOgSpYZRc1SsHw3SzdSdjjt8yJpEuP9MOs7Q9d5Cnteo4XTLIo44MvpIt5zvjT+PjurmqDIaRuJaa5KZ9l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTw9ynXfUJz3o9tSUq5ga7qE9KxytKk/FnCj1iSu1F/P5Rc5pe
	esedNp4vS9SzP0ft/TqntQUEOYmb/hQmL6MLCcn7KHzzWs6ON4cd
X-Google-Smtp-Source: AGHT+IEv+ImaEr/7cVbGXKPVcQrSmyebPdbvDU8yXA6EccSbt6HXdkbJ5FGHhqxWKDPTk19+eVnqxw==
X-Received: by 2002:a05:600c:4e4f:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-42f85ab3aa4mr99520195e9.13.1728389775550;
        Tue, 08 Oct 2024 05:16:15 -0700 (PDT)
Received: from void.void ([141.226.169.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920be2sm8009851f8f.60.2024.10.08.05.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:16:15 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] fs/inode: Fix a typo
Date: Tue,  8 Oct 2024 15:16:02 +0300
Message-Id: <20241008121602.16778-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments: wether v-> whether.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 3bd8eba6c51b..d37fe8ddb646 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2878,7 +2878,7 @@ EXPORT_SYMBOL(inode_set_ctime_current);
  * @inode:	inode to check
  * @vfsgid:	the new/current vfsgid of @inode
  *
- * Check wether @vfsgid is in the caller's group list or if the caller is
+ * Check whether @vfsgid is in the caller's group list or if the caller is
  * privileged with CAP_FSETID over @inode. This can be used to determine
  * whether the setgid bit can be kept or must be dropped.
  *
-- 
2.39.5


