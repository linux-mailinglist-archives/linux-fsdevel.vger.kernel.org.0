Return-Path: <linux-fsdevel+bounces-67359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFDEC3D029
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 19:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD013BE38B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7B1332904;
	Thu,  6 Nov 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXEtAkGs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606134FF4C
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452078; cv=none; b=CqdJVbkkOkOau59Rz0vzzpnzkpKVqQ290K/frk0vk3eVmNqfclmjZNTAlfsL/kA79dBQ4ubavYTK1/VqbwV/XshInMAD7YxWadq7pfCm0oYJFuzAGOwFhTBjfSapyXNUjMpBOqWmzW5Z5h4Kmk79qeebMJgfr6O6lStaC0gpI2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452078; c=relaxed/simple;
	bh=ecKx94Uloyw5Ypg7LHJi/wxlymzsTKHjuBzKSBg9xEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/ajW5ZAUAJ/yRyRgKgpI6Ku5vDFTG3qOGmj224YOApIDgkVVYSBAsnQ3NxGhUFd+S0cnPIl0jVf3aadNdiLnnjPl7+Volm+ryv5LPom3dA8QUc565OBK4ETUKeDvUmIeIPQHLpAd/pu3yJgZK+ceBz0RlQjaaqxaI0qIiqz+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXEtAkGs; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b72bf7e703fso19372666b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 10:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762452075; x=1763056875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM5YuHXRVa3PD4FJFdTxSM6sbhjSzqRHVaQqfGflXZM=;
        b=cXEtAkGsAMSpPV0eqxFPKAklkaT1xQOUfrnbecZluVxpVDLgHWVdA1yDX3GNSP6TyG
         /wU8aLnLQFrxKZF0fucd+VCCFsgdxQSBjkAKdiHBwUDTUcDg/YDWDrRO6740rEs7tBrl
         opNnuGdHVHdWvEIMR0P8kkzDU7gW2XebRcOgD3KN93ZphfxVFJIh2Kiox+/ZwRJriXiG
         IGNG8Druwc3ypXVQ8eOqbXxH8K1cE2U+NLHvnmC0jxtO65zIo8Zjd3sxobpnprzRU3ed
         pLZykLeM4eMzVqZBYVoX0Af6FTsb91Btk0dNfafWy17bJssZCom6V8M3XWMbdkfBuCP1
         uYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762452075; x=1763056875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rM5YuHXRVa3PD4FJFdTxSM6sbhjSzqRHVaQqfGflXZM=;
        b=Z4UZYqJpnoSOvxlPVQ+etC8OdWztCjLBL+NX2uou6BvwP0fSAF/riTxSpzBeATJ44k
         h/2Gf7OOwvEYf438WNa+j3Zvj4BK7TWspkpc7sEhH2bDWAmjWUISLv4UjgWw6wzM1n0o
         spYV6O7/GCR5xeuZRTsYa4OsxQMMW0ApuypfmWHMopjRHrsmTp7e/7bcQXvocgo5C37M
         duDom4teICLro24my/ZtLFouvYxi3NpU3wPvn/ku4ME/EdBg6nXRnWmaQ2xkcUM+IVZE
         3ZvdW/jQhkO6nVPl3Av1oZ+i2LQzDMXp/9nfuEsGWsB22DnixVOs2yZ2UdQTtNdZ8O+M
         dJpA==
X-Forwarded-Encrypted: i=1; AJvYcCUdDKRIs8ZyJLl68ewu84O59uMLZJovLuSUyeX3qrysQtVTAwOyQ8oVw9jFrTdPs2nGxwDQHByYnwwf4TRu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8evCDF3JEOOdvEP3dUDaDHzq4iUqthOc3vnECE8qOloYagxtV
	1Fr93tfNToDz9RuMXERADtiyfHgqBVrBn5cz6T46Ux9xTTlbCWAqGg/4
X-Gm-Gg: ASbGnctJbqsmlBsm4WCtEuunncwgYbQg/ZY4X5VQeCESuqLQhDvrj1U41oSVi5kcooW
	yC5zqpULFVTAaWTmLE0QmyvGlC33H9BsRYbAdeaJ4U8A9+59GtnmF8lVG9o6oVIJwTKzCNmpsbZ
	Nk9M24jGOnRM2UfFUf4N3i3eUED10VmsgGZm0CTHakKX4ULwA4fmMnvmn9DcGtQuFrdgtPzUzfb
	EH9ubjZLQFVXOdqkgsXTZFRYL0UlkfgDYORkTzvNZqO2F10ErTD6BLC4/Eck6w0PiB5I4InjLzY
	xVK06CHkvReSMUeMzLmJ0xEpuUE22rr4rDi9v5dOX5ojVAEpxbYdpcpOngPNeN7G9YO5y0GDlgJ
	ZfFSqiMtUkb9YdZZLPEhT7Y+O5iXjJiOhNBrwMN+hTzT6P1CluPqE3fYjKu7ycStkssA0PN1iji
	WwVV3qm/rsW4pjZj15fDwAE31hsMQoZdkc0mql+XP1MoA9gHae
X-Google-Smtp-Source: AGHT+IGe8qAFLbn4/vX5i0Ow1/iT5EGUdVcCOuyeIG6eX5kopi8FhtvrktlTKE/4N10OlP9KFFo2Ww==
X-Received: by 2002:a17:907:9627:b0:b72:56ad:c9c0 with SMTP id a640c23a62f3a-b72c078d329mr10605466b.17.1762452074675;
        Thu, 06 Nov 2025 10:01:14 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f1bbsm15430466b.65.2025.11.06.10.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:01:14 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 2/4] ext4: opt-in for IOP_MAY_FAST_EXEC
Date: Thu,  6 Nov 2025 19:01:00 +0100
Message-ID: <20251106180103.923856-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106180103.923856-1-mjguzik@gmail.com>
References: <20251106180103.923856-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/ext4/inode.c | 2 ++
 fs/ext4/namei.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index eaf776cd4175..7d5369f66686 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5522,6 +5522,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_file_acl)
 		cache_no_acl(inode);
 
+	inode_enable_fast_may_exec(inode);
+
 	unlock_new_inode(inode);
 	return inode;
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 2cd36f59c9e3..870bee252e54 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3038,6 +3038,7 @@ static struct dentry *ext4_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	err = ext4_mark_inode_dirty(handle, dir);
 	if (err)
 		goto out_clear_inode;
+	inode_enable_fast_may_exec(inode);
 	d_instantiate_new(dentry, inode);
 	ext4_fc_track_create(handle, dentry);
 	if (IS_DIRSYNC(dir))
-- 
2.48.1


