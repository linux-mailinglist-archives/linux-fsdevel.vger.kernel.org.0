Return-Path: <linux-fsdevel+bounces-41101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79942A2AE73
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 18:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB74188B8E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 17:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C146239575;
	Thu,  6 Feb 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNqHFDMx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1689C239560;
	Thu,  6 Feb 2025 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861409; cv=none; b=CStkVBOw8OWQyqtQqsg7g62kqmudfhT/Pv8lCwwICjveZL+/Y9paPbhYD0quX+uquo9OEoeKrHkyfdfup4M5xKkiXReL9+DfWoyA9sDIcGUfMcvsEofftfp/ife/MjICx9zb69/Bn4ZkFdU9cZXQfRHsbISe0cTFgZ2kzoupQoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861409; c=relaxed/simple;
	bh=61udqkcEg9wcSq/halgc8JMmMFwwfrBUY4mtNHZNt8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RicS/Lc8GN43x4cnkq13vgIK56vMDPC9M+xfrEpYgAY5y23tIk+CS5cr7a5DDXgn/L54Lnz27gSxaNDgx3f4OkqtWhZrSUcGlsU9rOhdPApNj5sScQD5J2lkLe6utv46xH+mVcw88QXEQMsFTam1040LHscI9sF1ZVGqJmKq0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNqHFDMx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5de3c29ebaeso522282a12.3;
        Thu, 06 Feb 2025 09:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738861406; x=1739466206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8Wgr0+Th/eZItEiexHX2VH44yFxgC7CrIHewPAPMnk=;
        b=RNqHFDMx/pc2H22eltM0tgYygwJ9gKHs0qst45SGIwzVoyj1vSIczCD2jqy3AK8v9o
         qZakdf/T1+9+IyohtIYqkBgAxFDRmt/NqBKtvGBeyaOzsirBOhSgasVWWsO88DPLqbYN
         s9+hv33Ck4Ymdu81c0N62a5gTSVzXRDdGRxvSQ4BZBCe0N04lGK8KERgDEggM24PBe2/
         V2jrmg76q2ChXotEGIb/GzBbVB48/8JSSF5S8Hx5Bli0modf/anjTkmRVCsqXbzktMNO
         WUPlcaOa0LMkoNQgGilC55AMhDQ+xblQRXhzLteUoGu19SkPb7Vkix2QAddCK8TQmwcC
         PMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738861406; x=1739466206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8Wgr0+Th/eZItEiexHX2VH44yFxgC7CrIHewPAPMnk=;
        b=c4u9SwQNBKHoaVcHP0uhq7gXlZ4hUFMSKnOPJBwFwI0CJUchUFnd6QognLY1c3QCW7
         QqEdb3aJofwnYf+7BG30tL5CnR4d2+8H/OuFq3uEcTaDtgLnt0HretxUHoYiJ1PtwnzE
         wLETqMuc92vawG3Ach7gk2AvPGkEMn/3e1bBZ5iEbR8jIHNYXXtuRJYGySvqe5SWofPP
         c0G/CS7kPuAj9CmPmWivJLDPB4sIEGZmkjGw1ST9Vsxs0JC1RuL38ehC9GMCWAo0c6QZ
         Ef/8+tQM6trb+rTjBwQ75BlXoAcV8aDhlxN+FIEqg15/8Q4ITosQWq051WtidrbBwCOq
         LRsw==
X-Forwarded-Encrypted: i=1; AJvYcCV+4FraEJIas6bB9UX+aw8rXLgnlf5b4MbyhrF0I9CcsHc+8Vx+h9+MdxhBkkIRRk1L4Ye+Gfan2kFPjP4P@vger.kernel.org, AJvYcCX0MHWzQzHLX4sPtNwNqEh9zjwOcKroaVe1mA1y913KzxkEDUm7baGVyDqSm+t9dhUfQkYUe87WB0g12l6T@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6FOjniMaemghtMR8cMClzlHQ0XV7G80q+JUW41VNzc2jQ3mBK
	wM4ehCicu/+uaQsmm9lXBgOontNS2aWjEK8MEN5R7dEsbPcqUA3I4A9aZ6+Q
X-Gm-Gg: ASbGncsJl8SqxtlfL7SOCu6tBnVH7NMJL7vImgHEQWCESwBDdQFuE5vApZW8GjbiiWn
	hlxgReZ3OZA7buXXvStonB8Mg/DSDP3NGK9qyco5X2XAY79mZnJyax4WRS0+0gMDlAXgu8SahLu
	3po8S1N/0Ik2G1RS+1rzK/8y1vaV2qrHrwxOmg3E9OfTINrGVzN0DKzhHAFaZ1mVjHVwmjJ/OMG
	dICbqrJv6oLqnzGf1+NVX6GT4JU6Gk9tgHOrPXueY0bUj6fkPCZKgLMTLDkUfmISr/SYBMYF4iP
	ISVhNHEWSgN2QIThM3ocEjhRL7FBpFE=
X-Google-Smtp-Source: AGHT+IGbVRlMNxB4z8E2WSYpSjY9+Wo24eryKSFABGNz/OIqnnhcM2UhXyn0BhWRWOqb2kyUrH6KXA==
X-Received: by 2002:a05:6402:13c5:b0:5dc:88dd:38b3 with SMTP id 4fb4d7f45d1cf-5de4500570bmr186504a12.12.1738861405932;
        Thu, 06 Feb 2025 09:03:25 -0800 (PST)
Received: from f.. (cst-prg-95-94.cust.vodafone.cz. [46.135.95.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b73995sm1158110a12.7.2025.02.06.09.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:03:25 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 3/3] vfs: use the new debug macros in inode_set_cached_link()
Date: Thu,  6 Feb 2025 18:03:07 +0100
Message-ID: <20250206170307.451403-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206170307.451403-1-mjguzik@gmail.com>
References: <20250206170307.451403-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 034745af9702..e71d58c7f59c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -792,19 +792,8 @@ struct inode {
 
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
-	int testlen;
-
-	/*
-	 * TODO: patch it into a debug-only check if relevant macros show up.
-	 * In the meantime, since we are suffering strlen even on production kernels
-	 * to find the right length, do a fixup if the wrong value got passed.
-	 */
-	testlen = strlen(link);
-	if (testlen != linklen) {
-		WARN_ONCE(1, "bad length passed for symlink [%s] (got %d, expected %d)",
-			  link, linklen, testlen);
-		linklen = testlen;
-	}
+	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
+	VFS_WARN_ON_INODE(inode->i_opflags & IOP_CACHED_LINK, inode);
 	inode->i_link = link;
 	inode->i_linklen = linklen;
 	inode->i_opflags |= IOP_CACHED_LINK;
-- 
2.43.0


