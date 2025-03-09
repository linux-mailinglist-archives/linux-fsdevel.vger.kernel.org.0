Return-Path: <linux-fsdevel+bounces-43541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA51A583DD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 12:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5F23A9476
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 11:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9341CC8AE;
	Sun,  9 Mar 2025 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiKhsgEL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5AA1C3029
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Mar 2025 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741521139; cv=none; b=L6jJJ0V+kn6UyQ916d2rZpXKyVvJ4ndXuRWYak76CX+qbcQIJk6K1951dAMyeZeznxtT0TaLyocfge9nbw7SMvpMGTEFBVRqEjaS/FpZ8/x4RfdZybWC5yJWde5fzpUxuld+qU/73RUcgN7VZwbSBRMNBuMg1UfsGhB74yvQAyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741521139; c=relaxed/simple;
	bh=R92AKFts6szn+vXvsKd8W7CPqSUgOH2MacpbJ5tvcEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aRT6E5gIw8bCcBOOQZluvDtyqCzCaN38FhBLJHClCiGJO6+TFwlkDGYR5gw1/E7POmgyQ4M8dVtPwD2VSaTZAxhh7jmrBt95/ohE1IzySxkvWQn4CHE2Su7gS91rdn4lQGmnwJ8lI5DDCM7p4hsXkujOeELg2wzQDCmocJIi/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiKhsgEL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso396889a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Mar 2025 04:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741521136; x=1742125936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Y4apfXe2FO+cHUICid5tNhF3Qk4mhumfNHttHRLz30=;
        b=TiKhsgELN1nQrEqKt47EpyyGjm4rnrC1Rfg06n9awcUoy9mvos6lm5FSPajKAlJeeY
         Z+SPCSLbaSNFdxwvduxUwjCjuvD+ph9z+8jFhlwYPKDp1Q69g27VZuRgUkGWw54y93/Z
         3IGK9IsITJBnCWhttPNSx/2+slslkODLrTN7hyVGyAFAU5sA1FhsbWBvUUlQ9ma/HZlH
         OsvPP1wHshQFgt+C8WuuPrkfOMcCqZQjoPVGvKIKtHVhKbPmmqtU33wQ/M3R/HEwrt4+
         2CW350CJU93qS81haNXfMkJyHUJSVNo/SwcStq1pXCpEwNCs08pT+8noLQKmUR4Urwlq
         16gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741521136; x=1742125936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Y4apfXe2FO+cHUICid5tNhF3Qk4mhumfNHttHRLz30=;
        b=YiPJtMYIjkhrtHlvN23kiTkjtrTnYP3vTxy9LKm+BZ11JM5tiA3NlodC6bn/+Gs/Qd
         lc0GZ6tRz6LgPNcnAdvKIOBI0m7Hd8giPDep9DQli8I/V/QyI484Wu7/CzgDDivuwv3/
         cxgCoTONwQt051f3j1u0CkX0skSN7hmN/6egbJieJV0+/pfkb5Hj8AVMEm+IQD3RaTxB
         lRkRRm2txsA57wpJQLc5/K1EdCtFO8wFnQp9suNVHIq921sfkYvjpiVns5nZuT6pc7ol
         Xm4uEIltkzYZF+JUzujGnEp6o11MOMW90a5YbHq2+uArav+m+4PApPcT8d5Dvbm+lNX8
         TJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCWu8E3/Fu8ChLRPWnUy2/Ryd7ModWWQy0jTCOl+1lzu0nhlTJWik6/ubd9c2rrjfT8jfD6eq1vmBN9ebpqz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzacp2jLACiPJeMlsGId/9V/FMb+6YLmZmsXLZn9WAiEZGD3HWp
	y5CHjMs28vAcPJPrPo7zvygP+EwtzXm/Rife3hz/lXom0f7y1fFn
X-Gm-Gg: ASbGncs/Ajbs+WZjtSNHGw2yPR+9fy7mYlSaPaEH+GXhAn/UzkTTzmHIkmSzPk5pM1W
	wF0O6JPxLksNTwflQh1gkTPR6gPMfVTeorybtbb8vj7YNpTkXM15fM+1cDwizD39a5MTmWlRzcS
	D6QXCmE7Niax9hNPIOn3tuFjTg/hnCrbAirkP9c3l31r/Mmzk4X9JgDYVCjo8zZ693aa7FsYT1w
	9z1PTZRUBIFo6/gInW8Ydf8378yV7ZM9UaRuhdo/6GDirvm6mVrJ1Rh4Irvc/nYQpyBRvAkZjRk
	ZrHwkJgR9ZAJNQ/3axoOrv0WwDAuNcx9K0jQlJYYl8JL2rUIYBCPyR27vZhlbrPkYtrMq5fF++f
	DTlwgbAY1fHeOq+A7Lsbs7GSK39JdCdtUFrn+J+9ofA==
X-Google-Smtp-Source: AGHT+IHvKlp/DNsAGJ+LK6YqGdyYOQfHJDFI0qe8eUMmeaw/497xaFTLP6+ExFn9ioMViyPXNrAFPg==
X-Received: by 2002:a05:6402:34c7:b0:5e5:bbd5:6766 with SMTP id 4fb4d7f45d1cf-5e5e22a871bmr13269356a12.6.1741521135339;
        Sun, 09 Mar 2025 04:52:15 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74aaff1sm5270273a12.47.2025.03.09.04.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 04:52:14 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fsnotify: avoid pre-content events when faulting in user pages
Date: Sun,  9 Mar 2025 12:52:07 +0100
Message-Id: <20250309115207.908112-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309115207.908112-1-amir73il@gmail.com>
References: <20250309115207.908112-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the use case of buffered write whose input buffer is mmapped file on a
filesystem with a pre-content mark, the prefaulting of the buffer can
happen under the filesystem freeze protection (obtained in vfs_write())
which breaks assumptions of pre-content hook and introduces potential
deadlock of HSM handler in userspace with filesystem freezing.

Disable pagefaults in the context of filesystem freeze protection
if the filesystem has any pre-content marks to avert this potential
deadlock.

Reported-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
Tested-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-fsdevel/7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fs.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2788df98080f8..a8822b44d4967 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3033,13 +3033,27 @@ static inline void file_start_write(struct file *file)
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return;
 	sb_start_write(file_inode(file)->i_sb);
+	/*
+	 * Prevent fault-in pages from user that may call HSM hooks with
+	 * sb_writers held.
+	 */
+	if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
+		pagefault_disable();
 }
 
 static inline bool file_start_write_trylock(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return true;
-	return sb_start_write_trylock(file_inode(file)->i_sb);
+	if (!sb_start_write_trylock(file_inode(file)->i_sb))
+		return false;
+	/*
+	 * Prevent fault-in pages from user that may call HSM hooks with
+	 * sb_writers held.
+	 */
+	if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
+		pagefault_disable();
+	return true;
 }
 
 /**
@@ -3053,6 +3067,8 @@ static inline void file_end_write(struct file *file)
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return;
 	sb_end_write(file_inode(file)->i_sb);
+	if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
+		pagefault_enable();
 }
 
 /**
-- 
2.34.1


