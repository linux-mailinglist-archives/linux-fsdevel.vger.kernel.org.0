Return-Path: <linux-fsdevel+bounces-19114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C28D8C0320
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 19:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4981C21BE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 17:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B602912BEB4;
	Wed,  8 May 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MACZdoTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846F812AAE8
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189514; cv=none; b=VeDN5rtqeDxHEATpXyf8YmeJovuSLO1Sg01PEBVdIdS166dNF20kBWwy+y9Ku9NswNlqm+aRN1RR3PiOiAOIN9CSO1z0n78Ju04+5+QnZywm/D5d66EFc06xRjQgsM0J4RCPeLbQ5QWTl9Rmxf1bWQsr0ByIRG2PhA0Jr+BTa+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189514; c=relaxed/simple;
	bh=Lh9sl0zFqUcR9HG/AVuIcrH791BNMQBsy4Th3x5GAR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mI13ptR7ZRuuqvUs3t7Vaae/uZsFHnUg0nWTjbqi+tGO1qqmeiJX6dbYGwdgGMlWxtLmEg3I4oXIaTRTN5WoGpQNoUTjyLPVQQO+7zQB3I2d/1/9IL4w35y6IvLQbCfZNCNvGQNnyZ+kv818RkTnPw/OSx/8K611N147XOXD12o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MACZdoTV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so30387b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 10:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715189511; x=1715794311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2nNbu4XucHn8QDJu07t5inyAacTBVLvFhCSSSJI5uA=;
        b=MACZdoTV2HUHmjzFIxVNITkDEIP/reg4vX76Uhvb9lBuevHVple9BEfpKtirjINHfC
         ozLFMsRvQOAwTeoTC7r7kQvLG3E1WmVmFQb7swbvC5hjfus9Ext9ybjvqwYi7HDw3UO9
         LmF4A2l++QQ3D8CU72PDo1PylWW8adWkSEpIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189511; x=1715794311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2nNbu4XucHn8QDJu07t5inyAacTBVLvFhCSSSJI5uA=;
        b=LMqzghoFBXMX3Qy8wIxJqma/15ADaBEJ4GAINCd1xxtNLH4ghC8jCMgJOwXRfOK07T
         WWU8bTqJZCqBKL5pDF6dX9lFSRnWSGZhlEYsdeCmuK3o9Lg1crxnMg3qkBMYyaLv10kg
         YZpQdKLr+F6HH7XwzkrPP6NQMe+gkoMiq17OH7N9/uXeG+VtrzE9YbdYhmi6K8MBatS8
         axlpCYMC0FXcjmD0JPzSmkKx4b4fmFBLLXPab76hbqdbDr18AKiBbE60hcTb0ch/VMay
         t/XnYOQQrZvbHqZPC3xigElNHmRKJBw/UVPcgVZuSV9eK0R4iyrULchOL8BPrzrqK01w
         /PNg==
X-Forwarded-Encrypted: i=1; AJvYcCU68m7HWfNYT2mwY2nY9qKNfc6+Xvsxi6mUI2sD7wIWVefrH0WIQVXye3Us7+9xB6Rs0F1pwPJAjwm7RIrIAMtXw5TLE3DIZ7phOuBcyA==
X-Gm-Message-State: AOJu0YwGSESg4MpbK9KZwsnpe7Qwosh7GGilDRxg/+JmH6H8c7YHBTc2
	Nz3xxA1XOhCQjkVZK8sFtprWUKU6VbbDMB+HsMfns2zRkw/1gRAJL4e4C8g06w==
X-Google-Smtp-Source: AGHT+IHhC2MOnPhfcqxPojENxgcZ8XwUYRxVGdudDH8TMRtD2+Tt4ejx6OP4QShOQ0NN1c/LqX7HRQ==
X-Received: by 2002:a05:6a00:21d0:b0:6ec:f28b:659f with SMTP id d2e1a72fcca58-6f49c207395mr4060894b3a.3.1715189510677;
        Wed, 08 May 2024 10:31:50 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e18-20020a656492000000b006089cf2cde5sm10277706pgv.26.2024.05.08.10.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:31:50 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "H . J . Lu" <hjl.tools@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Chris Kennelly <ckennelly@google.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Fangrui Song <maskray@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Victor Stinner <vstinner@redhat.com>,
	Jan Palus <jpalus@fastmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/3] binfmt_elf: Calculate total_size earlier
Date: Wed,  8 May 2024 10:31:47 -0700
Message-Id: <20240508173149.677910-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508172848.work.131-kees@kernel.org>
References: <20240508172848.work.131-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3041; i=keescook@chromium.org;
 h=from:subject; bh=Lh9sl0zFqUcR9HG/AVuIcrH791BNMQBsy4Th3x5GAR4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmO7cEHn0buAr/C675Nd09yTzC5UND2JGNtAzn6
 7fAhDpYVyGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZju3BAAKCRCJcvTf3G3A
 JpCtD/9LYmlihZG7ywOzTinHJzY1kGMdJPl8aorBC0w8BZYWZG2L5735ch2DLxaqLeucHcOdIzd
 j2P5KQxKEFi3VSlTEJgG/CHFTE/LdNWf8K4HNiSgIPRvftdZy0yfsLhEg6c1Bc5+jOOGN7Yw1Oz
 6PcT0O2RfYEkFZSrUDCPgVVNxk1+jVVG6NCQXKg/g1beIDLLZRXDt/CujNa4YHVUpd/PYIZvsBI
 tyyKrW1A2QVx0+ktTAviklFaU/7UJYQBntwA7dredHuOtT/fqjgzVNTigROk/o3oX6LwbM3R/nS
 rpbycTLj73Gn4W97wBLGOx8O9yk/tSZARqYHaJgCzAFLUSp6KzKoPZby1r7csVaek1B3X8fP+8+
 BkY4XLEZdalGU8cLbxI+PY/Qr9tF2wa2MjCxf53MHCqPc76J9sF8E993yLTDuBhej9jyYD3tQ8f
 szKoB0M+V2j30jykwU46I56obv/BNssOUb7HZuY3opJ8Mjr05I2VVwIQkqlyrX5+S5i6mvqRIui
 +CwG4y1jlqtzUR5IZywuhfiJ1adpU8sxNVbg6dRC8xSQ5BOBZyf262o/4gaFHzFjKf5iPULmnZ1
 SvfgCjHzQ3eQ8HeL0WrvMnveAWiwczVNHiEsljH0SLouDc9W4fSSSyePhi6mu7GKCpxPtjxXxWH YPVMgoHtsFF9p3A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation to support PT_LOAD with large p_align values on
non-PT_INTERP ET_DYN executables (i.e. "static pie"), we'll need to use
the total_size details earlier. Move this separately now to make the
next patch more readable. As total_size and load_bias are currently
calculated separately, this has no behavioral impact.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c | 52 +++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5397b552fbeb..56432e019d4e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1061,7 +1061,34 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * Header for ET_DYN binaries to calculate the
 			 * randomization (load_bias) for all the LOAD
 			 * Program Headers.
+			 */
+
+			/*
+			 * Calculate the entire size of the ELF mapping
+			 * (total_size), used for the initial mapping,
+			 * due to load_addr_set which is set to true later
+			 * once the initial mapping is performed.
+			 *
+			 * Note that this is only sensible when the LOAD
+			 * segments are contiguous (or overlapping). If
+			 * used for LOADs that are far apart, this would
+			 * cause the holes between LOADs to be mapped,
+			 * running the risk of having the mapping fail,
+			 * as it would be larger than the ELF file itself.
 			 *
+			 * As a result, only ET_DYN does this, since
+			 * some ET_EXEC (e.g. ia64) may have large virtual
+			 * memory holes between LOADs.
+			 *
+			 */
+			total_size = total_mapping_size(elf_phdata,
+							elf_ex->e_phnum);
+			if (!total_size) {
+				retval = -EINVAL;
+				goto out_free_dentry;
+			}
+
+			/*
 			 * There are effectively two types of ET_DYN
 			 * binaries: programs (i.e. PIE: ET_DYN with INTERP)
 			 * and loaders (ET_DYN without INTERP, since they
@@ -1102,31 +1129,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * is then page aligned.
 			 */
 			load_bias = ELF_PAGESTART(load_bias - vaddr);
-
-			/*
-			 * Calculate the entire size of the ELF mapping
-			 * (total_size), used for the initial mapping,
-			 * due to load_addr_set which is set to true later
-			 * once the initial mapping is performed.
-			 *
-			 * Note that this is only sensible when the LOAD
-			 * segments are contiguous (or overlapping). If
-			 * used for LOADs that are far apart, this would
-			 * cause the holes between LOADs to be mapped,
-			 * running the risk of having the mapping fail,
-			 * as it would be larger than the ELF file itself.
-			 *
-			 * As a result, only ET_DYN does this, since
-			 * some ET_EXEC (e.g. ia64) may have large virtual
-			 * memory holes between LOADs.
-			 *
-			 */
-			total_size = total_mapping_size(elf_phdata,
-							elf_ex->e_phnum);
-			if (!total_size) {
-				retval = -EINVAL;
-				goto out_free_dentry;
-			}
 		}
 
 		error = elf_load(bprm->file, load_bias + vaddr, elf_ppnt,
-- 
2.34.1


