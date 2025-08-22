Return-Path: <linux-fsdevel+bounces-58772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B359B3162E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619AC580FBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 11:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F274B2F656A;
	Fri, 22 Aug 2025 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCYDHOso"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FAD393DE1;
	Fri, 22 Aug 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755861515; cv=none; b=rmbb9VlBVRppXACcS7fJjbHzSuX1UBp6iiMaG8XARxrh8BJr2mr2V9MPwa9WE4uBPcMdi0+8mQOd93qOxFrQCZcdfbUCxkwDacCdYWEvaJ/6CDQlUaL548pggGc3wVBRObTQKIBCB8iZ1ZrpdzZoAgNctCwypbse4AcgVr14vAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755861515; c=relaxed/simple;
	bh=LhqP36IElPtFhrvJR890PX1pgAiMypg72GaWxkdzZr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=S6nrK1duIJ6TP3UXmXYaaK1qGcLiOf1TmN5TlpFUBPUJ27Z1Fax5QXUlwC0/NbM6WBiPx1nYreNSdtnyRjAkWKCCPx3DTK2yhDQHJo7wq701raB6XDt+SHbK0oVByP/SWhxxMoWxY9eYoqxIGP2VmpkB4B3vYad5aXUMrwXb1YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCYDHOso; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-77030079854so57263b3a.2;
        Fri, 22 Aug 2025 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755861513; x=1756466313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UPyo+BQRvjYiG8qClzyl0xKDtaYoJ5/2WSpqoaBh7dM=;
        b=bCYDHOsosV4SQ/horuXVezNDVYzKOg6Bpnq8WirZkH+vEyvsfkaQTzMavJZUd/Qo9H
         YKj4fd4DxM2rzhHur7UlHyc77biaUPz8KhfBEctxvr1YBbMJhJhYByWmfMm6x9+/D0DD
         LJerBa/+Sxig0RQeb8+EDUMc01XLPLc99N+YzwLCPXhv4IjEx+By7AY1FPY5OvjUg1oO
         1CIwVAj3JOak1FVRY6mDXhtc9V9dTko5IYTh+ujxDVvbiltT0e/alVQQWS8XwmmXCU26
         S+yLfKWGrrVr7aqd42TxiwWS7/J+E/e4IK8PPSrH+FZDHund49oA0+yoLVodxUtWeSAJ
         aeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755861513; x=1756466313;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPyo+BQRvjYiG8qClzyl0xKDtaYoJ5/2WSpqoaBh7dM=;
        b=uOE3PTcCIeNYzIdHtj32c0rWUBIvNJ7xADrOxbOLvo6LL8oW6gf3fACnQEaSrIGab4
         XA5PO/a5ahznoeZxY25FkSWV+Mc0O6a3njSVljVB/1xDM47D3m/qPW9vA3U3LcePn97i
         nGDQb6UYN0cDdD0bFWWEagKptM0Dbhuj5yxlQ3E3rXw1Oq1Nfl00BdgiLkfLoQGWwqjO
         2En195u+8g7/jCgF0pfW22Ik40zc08X0bJHD6Zkrs3fwOEcPAXyTTcgvm/xOCZzl5Lh3
         5oC+ATXPmxAOVSrDdkrUj44aHF/H5SU4kKmzZyMXAPHxQuOMkogh5+vG89fnZGUXH3gb
         9bkA==
X-Forwarded-Encrypted: i=1; AJvYcCU1NFuP1KgvyCSJAttzGR1GBzYgAhUu/kG2boP1MMHf7cwKD3pQx/4eKOGw1JgPRzREJKRaGxbz3U9bcw==@vger.kernel.org, AJvYcCUYrtJrelpyLQZQ7Q/1lOyAcqlImXPxYCMYfZ+AfxjTMiclWa71VOe5qwwfkjXvErku4k58GnNU/canzUOrYg==@vger.kernel.org, AJvYcCUgtifC7uY6jQrnuv991CZRmvdOVHn8Lny2KDhiipEtjEhWbCFv+BHmjowBccobskcCWS1AHj7bWM5F@vger.kernel.org, AJvYcCXydjKD//kws1UPH2n0FefEURshFUCgxK7k5MCZmYhPCNC7Le4V42fP4PKbwN6Lfk4VSJgT9g54Tr30wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKLddaAuw7WO18ArwDxA+pDFrDlqm++4w72e7WvCmnYnKrdAcP
	cLpWq8Ykw1l5PmSEaFw8rvQgIGYHkgM9CnZX7zXraX9x7E3NwR858AM4PAv0tagsU/AxGK8P
X-Gm-Gg: ASbGncsB5wqFZHsmFuZCpXs3jmIEEeZqkHT4OG5tlkkg1hgOzx3taVR99wpA86QV7nJ
	rrsv6S0CYFz1eyIOGDuLqiZmOZ7/xBNREDT6gHDC/IVFEe3Ny4NMGYnSxhIIbuFry52rQkoXQ2b
	zqsPezTZiYha/kH/CKpAWaMKIWl6JqYWGjT7dq8Wyap5XBuPqCTmRJ4Vlo8hVVxEfMj84r6GczE
	ek6dJzBkR2x/nUDh4QVWTjmWSIQZBY0V/dvT+0G3WJ4zQruMDYl0P+4flrVJ2gkUJe1VGbmCnzk
	XoUqwES1XtG6BgDbRJzp5UnkossoYQ1DUfdVEV87PYV/B1llY/iQlJsF7g58yttOPA/K0j+Kfjk
	QDmT8QOBy2AqIzYCRX0P+/A1QMp25xJ+k/yzKm59e3UX+320DDcBvI1Y=
X-Google-Smtp-Source: AGHT+IH9mjr26UJ3g0LmaRv/b0ZvoFG+9xOWGwrJkUAX2nsn0RpxVR7Fe/yi0mFpPp+Mg7DWG+ghOg==
X-Received: by 2002:a05:6a20:729a:b0:235:5818:66a3 with SMTP id adf61e73a8af0-24340dbe60emr2267284637.8.1755861512983;
        Fri, 22 Aug 2025 04:18:32 -0700 (PDT)
Received: from saltykitkat.localnet ([154.31.112.144])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-325213788ffsm1803655a91.19.2025.08.22.04.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:18:32 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: josef@toxicpanda.com
Cc: brauner@kernel.org, kernel-team@fb.com, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 02/50] fs: make the i_state flags an enum
Date: Fri, 22 Aug 2025 19:18:26 +0800
Message-ID: <3307530.5fSG56mABF@saltykitkat>
In-Reply-To:
 <02211105388c53dc68b7f4332f9b5649d5b66b71.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart6088876.MhkbZ0Pkbq"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart6088876.MhkbZ0Pkbq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Josef,

Sorry for the bothering, and I hope this isn't too far off-topic for the 
current patch series discussion.

I recently learned about the x-macro trick and was wondering if it might be 
suitable for use in this context since we are rewriting this. I'd appreciate 
any thoughts or feedback on whether this approach could be applied here.

Thanks in advance for your insights!

Below is the patch for reference:

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..6a766aaa457e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2576,28 +2576,36 @@ static inline void kiocb_clone(struct kiocb *kiocb, 
struct kiocb *kiocb_src,
  * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
  * upon. There's one free address left.
  */
-#define __I_NEW			0
-#define I_NEW			(1 << __I_NEW)
-#define __I_SYNC		1
-#define I_SYNC			(1 << __I_SYNC)
-#define __I_LRU_ISOLATING	2
-#define I_LRU_ISOLATING		(1 << __I_LRU_ISOLATING)
-
-#define I_DIRTY_SYNC		(1 << 3)
-#define I_DIRTY_DATASYNC	(1 << 4)
-#define I_DIRTY_PAGES		(1 << 5)
-#define I_WILL_FREE		(1 << 6)
-#define I_FREEING		(1 << 7)
-#define I_CLEAR			(1 << 8)
-#define I_REFERENCED		(1 << 9)
-#define I_LINKABLE		(1 << 10)
-#define I_DIRTY_TIME		(1 << 11)
-#define I_WB_SWITCH		(1 << 12)
-#define I_OVL_INUSE		(1 << 13)
-#define I_CREATING		(1 << 14)
-#define I_DONTCACHE		(1 << 15)
-#define I_SYNC_QUEUED		(1 << 16)
-#define I_PINNING_NETFS_WB	(1 << 17)
+#define INODE_STATE(X)		\
+	X(I_NEW),		\
+	X(I_SYNC),		\
+	X(I_LRU_ISOLATING),	\
+	X(I_DIRTY_SYNC),	\
+	X(I_DIRTY_DATASYNC),	\
+	X(I_DIRTY_PAGES),	\
+	X(I_WILL_FREE),		\
+	X(I_FREEING),		\
+	X(I_CLEAR),		\
+	X(I_REFERENCED),	\
+	X(I_LINKABLE),		\
+	X(I_DIRTY_TIME),	\
+	X(I_WB_SWITCH),		\
+	X(I_OVL_INUSE),		\
+	X(I_CREATING),		\
+	X(I_DONTCACHE),		\
+	X(I_SYNC_QUEUED),	\
+	X(I_PINNING_NETFS_WB)
+
+enum __inode_state_bits {
+	#define X(state) __##state
+	INODE_STATE(X)
+	#undef X
+};
+enum inode_state_bits {
+	#define X(state) state = (1 << __##state)
+	INODE_STATE(X)
+	#undef X
+};
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
diff --git a/include/trace/events/writeback.h b/include/trace/events/
writeback.h
index 1e23919c0da9..4c545c72c40a 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -9,26 +9,10 @@
 #include <linux/backing-dev.h>
 #include <linux/writeback.h>
 
-#define show_inode_state(state)					\
-	__print_flags(state, "|",				\
-		{I_DIRTY_SYNC,		"I_DIRTY_SYNC"},	\
-		{I_DIRTY_DATASYNC,	"I_DIRTY_DATASYNC"},	\
-		{I_DIRTY_PAGES,		"I_DIRTY_PAGES"},	\
-		{I_NEW,			"I_NEW"},		\
-		{I_WILL_FREE,		"I_WILL_FREE"},		\
-		{I_FREEING,		"I_FREEING"},		\
-		{I_CLEAR,		"I_CLEAR"},		\
-		{I_SYNC,		"I_SYNC"},		\
-		{I_DIRTY_TIME,		"I_DIRTY_TIME"},	\
-		{I_REFERENCED,		"I_REFERENCED"},	\
-		{I_LINKABLE,		"I_LINKABLE"},		\
-		{I_WB_SWITCH,		"I_WB_SWITCH"},		\
-		{I_OVL_INUSE,		"I_OVL_INUSE"},		\
-		{I_CREATING,		"I_CREATING"},		\
-		{I_DONTCACHE,		"I_DONTCACHE"},		\
-		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
-		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
-		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"}	\
+#define inode_state_name(s) { s, #s }
+#define show_inode_state(state)		\
+	__print_flags(state, "|",	\
+		INODE_STATE(inode_state_name)	\
 	)
 
 /* enums need to be exported to user space */

Best regards,
Sun YangKai

--nextPart6088876.MhkbZ0Pkbq
Content-Disposition: attachment; filename="x-macro.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="x-macro.patch"

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..6a766aaa457e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2576,28 +2576,36 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
  * upon. There's one free address left.
  */
-#define __I_NEW			0
-#define I_NEW			(1 << __I_NEW)
-#define __I_SYNC		1
-#define I_SYNC			(1 << __I_SYNC)
-#define __I_LRU_ISOLATING	2
-#define I_LRU_ISOLATING		(1 << __I_LRU_ISOLATING)
-
-#define I_DIRTY_SYNC		(1 << 3)
-#define I_DIRTY_DATASYNC	(1 << 4)
-#define I_DIRTY_PAGES		(1 << 5)
-#define I_WILL_FREE		(1 << 6)
-#define I_FREEING		(1 << 7)
-#define I_CLEAR			(1 << 8)
-#define I_REFERENCED		(1 << 9)
-#define I_LINKABLE		(1 << 10)
-#define I_DIRTY_TIME		(1 << 11)
-#define I_WB_SWITCH		(1 << 12)
-#define I_OVL_INUSE		(1 << 13)
-#define I_CREATING		(1 << 14)
-#define I_DONTCACHE		(1 << 15)
-#define I_SYNC_QUEUED		(1 << 16)
-#define I_PINNING_NETFS_WB	(1 << 17)
+#define INODE_STATE(X)		\
+	X(I_NEW),		\
+	X(I_SYNC),		\
+	X(I_LRU_ISOLATING),	\
+	X(I_DIRTY_SYNC),	\
+	X(I_DIRTY_DATASYNC),	\
+	X(I_DIRTY_PAGES),	\
+	X(I_WILL_FREE),		\
+	X(I_FREEING),		\
+	X(I_CLEAR),		\
+	X(I_REFERENCED),	\
+	X(I_LINKABLE),		\
+	X(I_DIRTY_TIME),	\
+	X(I_WB_SWITCH),		\
+	X(I_OVL_INUSE),		\
+	X(I_CREATING),		\
+	X(I_DONTCACHE),		\
+	X(I_SYNC_QUEUED),	\
+	X(I_PINNING_NETFS_WB)
+
+enum __inode_state_bits {
+	#define X(state) __##state
+	INODE_STATE(X)
+	#undef X
+};
+enum inode_state_bits {
+	#define X(state) state = (1 << __##state)
+	INODE_STATE(X)
+	#undef X
+};
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 1e23919c0da9..4c545c72c40a 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -9,26 +9,10 @@
 #include <linux/backing-dev.h>
 #include <linux/writeback.h>
 
-#define show_inode_state(state)					\
-	__print_flags(state, "|",				\
-		{I_DIRTY_SYNC,		"I_DIRTY_SYNC"},	\
-		{I_DIRTY_DATASYNC,	"I_DIRTY_DATASYNC"},	\
-		{I_DIRTY_PAGES,		"I_DIRTY_PAGES"},	\
-		{I_NEW,			"I_NEW"},		\
-		{I_WILL_FREE,		"I_WILL_FREE"},		\
-		{I_FREEING,		"I_FREEING"},		\
-		{I_CLEAR,		"I_CLEAR"},		\
-		{I_SYNC,		"I_SYNC"},		\
-		{I_DIRTY_TIME,		"I_DIRTY_TIME"},	\
-		{I_REFERENCED,		"I_REFERENCED"},	\
-		{I_LINKABLE,		"I_LINKABLE"},		\
-		{I_WB_SWITCH,		"I_WB_SWITCH"},		\
-		{I_OVL_INUSE,		"I_OVL_INUSE"},		\
-		{I_CREATING,		"I_CREATING"},		\
-		{I_DONTCACHE,		"I_DONTCACHE"},		\
-		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
-		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
-		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"}	\
+#define inode_state_name(s) { s, #s }
+#define show_inode_state(state)		\
+	__print_flags(state, "|",	\
+		INODE_STATE(inode_state_name)	\
 	)
 
 /* enums need to be exported to user space */

--nextPart6088876.MhkbZ0Pkbq--




