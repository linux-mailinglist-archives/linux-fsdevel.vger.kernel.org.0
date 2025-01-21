Return-Path: <linux-fsdevel+bounces-39792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D11A181F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 17:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6715D1673DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBAA1F4E2F;
	Tue, 21 Jan 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2dSAEPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9055028C;
	Tue, 21 Jan 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737476836; cv=none; b=qxsbxgo6UpJV1IaSjYiskkSBp64fjnwtAx6LYA9oa/j633XWyMvwul6SPtSrzyR2VLdCbr/izeII1leuEWZLUWSL3fculvczWjA+S08edGCUIncNm71Lk+c+1AOE5E24UdDsy3aKNGEeoN8OVrojSlzK4FdZ5xuY8ijS9ooaxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737476836; c=relaxed/simple;
	bh=eM0YU/Kb0i9BFxQef4LJbBnTrJtx+NtvXfH9LxEQY+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pR55PqeTlep9/6G/YU+Bt6ptI4JBeha0R6Aaz3oVYegFxyGMriKTvMpwLWTfyVgxAgNZilEqR5LpDYMrzSlXL4YEf82NR7ZiunAiP5caX0x6BvfdyY/WQSC+RKHhhECFIEDYszOj3DoUYy3kTyA28Z4i8t6KGlvjccPlu5htDqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2dSAEPL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385d7f19f20so2906808f8f.1;
        Tue, 21 Jan 2025 08:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737476832; x=1738081632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fh4lC6uJS329b8WMsY/Vj1WBjtMTnjsqucrjY/Jtlds=;
        b=d2dSAEPLW2QeAwyUo7H338gwv026wxaa45iMCIqf4utWoSTyOwbKVfZ7fv2Bo4t3hD
         WsTmjSf75x4Uqt1dEITyZW+JFrfguVGgGRIvhTnpHTlwfkyGmKAnA8oPPOzjrGf2PiuJ
         VFFY8niIlDphy67xi5pwXRJt2T+Su3ArtSWUfplS5ZrfiZ1d3S+chsa4i0MUkLgq4cPo
         Z8pot37cozQeVR9+lvMdwIKa/v2pCkE+FtiHZ1wHPq4581wIqIeDgwWXfiWyHx0tj92P
         TRTMWPhFGji5T3+eEQf+yMK7XL0mSXxUhIZhvjJsKiGGnMkCE6wlvM/8S3/ZfCE5jeAd
         ikGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737476832; x=1738081632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fh4lC6uJS329b8WMsY/Vj1WBjtMTnjsqucrjY/Jtlds=;
        b=pbab6ajvY7jiAfT4+vB5qFxCKsj4YCSACU3STNrRMMRj4B13d87h+HDd20ZOsA7PUE
         Tco176h8IdZAdCNBbzTd40jDCOMlK3d6jy87BXNDbaB6k6MB8Ncti9WoJrVmVBOx6+bl
         m+ufg40z2FjbQrZOCdLCAN3fJFRFYuyNgA1PaWqL4A5r/jDUCcaJpVgGe5SA7CdyyQm9
         JntVGqZbwtZfCE2l8VFvZaokEQ3njVBhQD5y9zU+XRT1G7KKlv3R340AE1wSfWwuChyc
         vW2ZEo92yz+/jXuRXvjy6v24Njpt4/0pSfgHE8zVJvqK/ED3Gl2p0pCAMulPUyEoLmtZ
         BqqA==
X-Forwarded-Encrypted: i=1; AJvYcCVehe7EyFpPJar+BW8USljuYIXyFJ/J8v1C4SqtkV1buuu4XZZLS2CCvFw84RabHOHu6yc5H7+YRQZ6TFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB5VGMPtvL3f9xqvHaki6BEX4P38UDEsvVwp9AWjRzFFxiTSQH
	o7KYerVjRqvHC5RNMiFPaftyweFp1iPR5iQ7ZmJBCzc4dK/B5JGNPA2GqJ/4
X-Gm-Gg: ASbGncu0oluO4DxEgWaQ4LkAAUR2Mfqm+xbce7te5tUEhrPSXUlOXb6TcQ38NQqZSct
	t8rIAuktvTfJnfZPQGRCAQj68mdbJ8rvomIuScX8Th5GZ2K8vSpGe/Zl8ciTOyi7xDaViSs2Fl1
	8jHiA73R1lwCDvA4hjfQ4FyFSgSlD/frKrZT3xi+knNrTCYyiKhKtMBmm9hW93oh4y3FR2aMP4p
	FZB136nxKi4htfg5vE+YYQCUq3gNe+bfOCstH6KmgRtTVfcIRVgNVvQRJVs3E3RwVIJx9muIS4p
	uWsNnQ==
X-Google-Smtp-Source: AGHT+IHxhQzNQlSJBcwW+4cTFV41LEt9i77ZfngoSs+LaSGceRy1fNqwNroJzoyBAkgxsJ9M5DRmAg==
X-Received: by 2002:a5d:4207:0:b0:38b:ebcd:305c with SMTP id ffacd0b85a97d-38bf5675826mr13590957f8f.29.1737476832294;
        Tue, 21 Jan 2025 08:27:12 -0800 (PST)
Received: from azathoth.suse.cz ([45.250.247.107])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38bf327e024sm13536335f8f.88.2025.01.21.08.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 08:27:12 -0800 (PST)
From: Brahmajit Das <brahmajit.xyz@gmail.com>
To: hdegoede@redhat.com,
	viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] vboxsf: fix building with GCC 15
Date: Tue, 21 Jan 2025 21:56:48 +0530
Message-ID: <20250121162648.1408743-1-brahmajit.xyz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Building with GCC 15 results in build error
fs/vboxsf/super.c:24:54: error: initializer-string for array of ‘unsigned char’ is too long [-Werror=unterminated-string-initialization]
   24 | static const unsigned char VBSF_MOUNT_SIGNATURE[4] = "\000\377\376\375";
      |                                                      ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Due to GCC having enabled -Werror=unterminated-string-initialization[0]
by default. Separately initializing each array element of
VBSF_MOUNT_SIGNATURE to ensure NUL termination, thus satisfying GCC 15
and fixing the build error.

[0]: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-unterminated-string-initialization

Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
---
 fs/vboxsf/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index e95b8a48d8a0..1d94bb784108 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -21,7 +21,8 @@
 
 #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
 
-static const unsigned char VBSF_MOUNT_SIGNATURE[4] = "\000\377\376\375";
+static const unsigned char VBSF_MOUNT_SIGNATURE[4] = { '\000', '\377', '\376',
+						       '\375' };
 
 static int follow_symlinks;
 module_param(follow_symlinks, int, 0444);
-- 
2.48.1


