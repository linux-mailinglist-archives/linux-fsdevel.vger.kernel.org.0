Return-Path: <linux-fsdevel+bounces-66698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 203BFC29991
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 00:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C5A188DB61
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 23:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E80148850;
	Sun,  2 Nov 2025 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns7zzXTu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3CAFBF0;
	Sun,  2 Nov 2025 23:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762125177; cv=none; b=VfBdfxKqK8lAFhqg1OjtqzAL1ghEX9V2u6EjJvtHwZCBD2L9hPhjyXBmhoSsG9DwTA6w/Q/HmN6OaRTvwvoWwXE/NSEZ7vsPyPx4N/3z20nh+M0IO0zNzzif4bADRI/PXxadfUHCo8mCG79RX+j7+F4Nlxznwqhhziy94KL2Br4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762125177; c=relaxed/simple;
	bh=BiiT3s/H8+pZ/AAoKoA6lZOhNS8mGTmCvgDQ/hf4FXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XrwVkhyQtH1KP4dwBqvYXwEG+JDo6sMOUS2gHCdbyGiVBvOAG5By0OhDw7n73righ5GEqEpab/qt+eAE7kBZrjSexIZ0Ed2nkSmZS/WXKhf1TSCZak9+gSdxBgRfPkR6LBTohnoNu4Qe+5Qu635rc6F5TksTvoAkVOusxMRUOXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns7zzXTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0B1C4CEF7;
	Sun,  2 Nov 2025 23:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762125177;
	bh=BiiT3s/H8+pZ/AAoKoA6lZOhNS8mGTmCvgDQ/hf4FXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ns7zzXTukiWqW0YhAqipHRjU9O1i6F2GI7Rza7kUB9iJxbR4HJlbDACyQ6zIasf9D
	 djWyBdDfbDvePevSj9vEvM80mEqDyjmPsNwcjHut6X8GYdpwcxZBSyT8Kqb5ivNBdC
	 nnLYl/t6bge6ung3hhmGzhT5QZgqZnWeXs+ZvX86n9LB4UiTPxiW3IyUfsdbnOC+s2
	 Z403I0V2VbNVmyUHVsr3IGgRP8s9W5leH5YO9QOT3EPzLYRDI4TQ0h3LUsFHe7YRbf
	 f8kHaCNoHCTQCttDbQldjCd7yADVAD6S+EKKBpv3Gxe1uglK2uMZEzysxvQRoiA32g
	 NvBFjVUF7n3Nw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 00:12:40 +0100
Subject: [PATCH 1/8] cleanup: fix scoped_class()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-init_cred-v1-1-cb3ec8711a6a@kernel.org>
References: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
In-Reply-To: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BiiT3s/H8+pZ/AAoKoA6lZOhNS8mGTmCvgDQ/hf4FXM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyPy1VO1/FdLZYdCWvzIYfW+z/tvSqPQzrfu2z4sUhI
 50PmkJBHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP52MTwV7ZlsnifBF/Ytd1n
 n6QFVsxzuPFY73dW4+8N95h4j69LP8DwV+CRhukRA1vF+9z+h9hbbgfU/jXuZGDnUFz92KWaJUq
 LFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This is a class, not a guard so why on earth is it checking for guard
pointers or conditional lock acquisition? None of it makes any sense at
all.

I'm not sure what happened back then. Maybe I had a brief psychedelic
period that I completely forgot about and spaced out into a zone where
that initial macro implementation made any sense at all.

Fixes: 5c21c5f22d07 ("cleanup: add a scoped version of CLASS()")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cleanup.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 2573585b7f06..19c7e475d3a4 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -290,15 +290,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
 		class_##_name##_constructor
 
-#define scoped_class(_name, var, args)                          \
-	for (CLASS(_name, var)(args);                           \
-	     __guard_ptr(_name)(&var) || !__is_cond_ptr(_name); \
-	     ({ goto _label; }))                                \
-		if (0) {                                        \
-_label:                                                         \
-			break;                                  \
+#define __scoped_class(_name, var, _label, args...)        \
+	for (CLASS(_name, var)(args); ; ({ goto _label; })) \
+		if (0) {                                   \
+_label:                                                    \
+			break;                             \
 		} else
 
+#define scoped_class(_name, var, args...) \
+	__scoped_class(_name, var, __UNIQUE_ID(label), args)
+
 /*
  * DEFINE_GUARD(name, type, lock, unlock):
  *	trivial wrapper around DEFINE_CLASS() above specifically

-- 
2.47.3


