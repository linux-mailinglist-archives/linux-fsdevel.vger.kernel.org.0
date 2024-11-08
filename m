Return-Path: <linux-fsdevel+bounces-33989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A772C9C1428
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 03:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DC31C220C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 02:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F363EA69;
	Fri,  8 Nov 2024 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdMkq8R+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4D1BD9E5;
	Fri,  8 Nov 2024 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731033449; cv=none; b=OM9OuSf0PENY9Umdkwydn812v/8gMwu/lRdYa6vFAWlMjh/U1oiRXq/lbK/NakNneMW0vE3GK2e6Cz6UVdVb0YhnJ8EH62j9YukD5kj+K1zv+r8w+TtXH2eAwwqGB+UqBCs4s1dbVg54SXhz1bld+fj9U3ADpmegezrz/L96vbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731033449; c=relaxed/simple;
	bh=rWGnNeNkL/86oNC0ZZ0VuxlpvnZcwS6deSS4yJyoV0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcmSnp02QzaU1iN3wQiR2I9h2hUGjnncGHqxCD3awhuNfISguUPeKszKpRR+SQK7iUonM43d4pvgR1DtqRqVWBd/R+RlPyZJuDzV7BOl+tS+4/t8lGMsQynsuCbaHFtLC6aqMoQ3rBv48H1qexHErZnAoDzGY89OWwgAAF2W45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdMkq8R+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-723f37dd76cso1660169b3a.0;
        Thu, 07 Nov 2024 18:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731033446; x=1731638246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3pVCH4FlXu/2T42ItGQed0Iidhr7Qo00IUSLu8dMw4=;
        b=FdMkq8R+B0zgE8grJinZ05LzGxU0YGnARb3/vvkdYcNkEFbY1iT99y1Yr55cOkrgP6
         aedN94bZNlnTAFK2v/u/It3zWk63cOWulOa7x/uLgcYXwGdzVv3Ee5DBZ/UuLLq4PWw6
         xYIs2ISHK/DCstBRjen3pNt7sj8jKx0JLeTycSH3LXKE6TWf6SnANHYcZMyaYqDaDAQx
         Hdjk6OCdhYZ5dfZWBwd5kwPe8FgPHk1fhdgepvbBdDvNYkC+h9nmYGNkBrppPwgSLV5/
         4oSr4lkC7tvcpLun83sIGVfiJzkQtAVCxAsWfwDWpjPaJWq1i1xPu6KVU4/566My6yAx
         OYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731033446; x=1731638246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3pVCH4FlXu/2T42ItGQed0Iidhr7Qo00IUSLu8dMw4=;
        b=m0stvlhnJBfLvo4+DBVBkkJjCqSbb7SDJytHpRUQCb2HnOb7M9EAQxHes8qXnbwhje
         noE9LUZqbudjxG6r+uBQ2J5kqDf+F4itNAznRlN5cZP0G45YbNk052aCxszimu0Sq9gp
         ac9LwMUi30idMA+3QpqHtQ5bKC379CmSRqC4BsVXWlk5SESYmBA35t+HJXMDm3FWw9d3
         LkvjgA9b8ofhDvTOliPgdrsmml0CgcbaprHsUtDGTftQQQj8XE1Rb5oZsbv1mpstzmWu
         oesi2EU48pXdjrljze52XlUGw1+nr7we5WPrubIWQ3GoXo8M2elRnPW5uds644bCQcax
         c+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUa3T/LLkCUd0u46PbPE2WMp0EpcCbdx3yIIzLhiN2ECoSXgYjNa3TwdwDc2jvcqnZob16rvWaappDkVsPh@vger.kernel.org, AJvYcCXagGKSt5om394oqSItCW9e7mIGve2AKICiFfrnid4Y5z9bpJrD5iGhaioH0+ir+DV4H29C6DDNun66IheE@vger.kernel.org
X-Gm-Message-State: AOJu0YyHe5iT6B7v11N9qYv2ejcJ93Ttb7rweUtnu0aMi03jIeVJ044Q
	tai1FDMFfvVMzn+sUdSMqChxJJncd99yXWR90TickYX7i+bsmyCu
X-Google-Smtp-Source: AGHT+IEu6yK6kjxMKQHtvBJc0wf/sd6iU10fLqMoX/HyUe2GBWPYNSuGIM7I9RwtvwJcp44Wq7sgbw==
X-Received: by 2002:a05:6a00:80f:b0:71e:8049:474e with SMTP id d2e1a72fcca58-724133ab461mr1400676b3a.26.1731033445604;
        Thu, 07 Nov 2024 18:37:25 -0800 (PST)
Received: from sarvesh-ROG-Zephyrus-M15.. ([49.206.113.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240799bb02sm2532370b3a.101.2024.11.07.18.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 18:37:25 -0800 (PST)
From: Saru2003 <sarvesh20123@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saru2003 <sarvesh20123@gmail.com>
Subject: [PATCH] Fixed null-ptr-deref Read in drop_buffers
Date: Fri,  8 Nov 2024 08:07:17 +0530
Message-ID: <20241108023717.8613-1-sarvesh20123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Saru2003 <sarvesh20123@gmail.com>
---
 fs/buffer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1fc9a50def0b..e32420d8b9e3 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2888,14 +2888,23 @@ drop_buffers(struct folio *folio, struct buffer_head **buffers_to_free)
 	struct buffer_head *head = folio_buffers(folio);
 	struct buffer_head *bh;
 
+	if (!head) {
+		goto failed;
+	}
+
 	bh = head;
 	do {
+		if (!bh)
+			goto failed;
 		if (buffer_busy(bh))
 			goto failed;
 		bh = bh->b_this_page;
 	} while (bh != head);
 
 	do {
+		if (!bh)
+			goto failed;
+
 		struct buffer_head *next = bh->b_this_page;
 
 		if (bh->b_assoc_map)
-- 
2.43.0


