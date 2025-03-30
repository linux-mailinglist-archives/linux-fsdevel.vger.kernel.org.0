Return-Path: <linux-fsdevel+bounces-45302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4056CA75AEC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 18:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5230E1888C79
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372A61D63E2;
	Sun, 30 Mar 2025 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViYHCsKK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB379461;
	Sun, 30 Mar 2025 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743352512; cv=none; b=Ql2mOkNfRun/2UpnXHChHxwkL1G8ztG+aDtmSoZMeWLZq4EyFbCczvng29OlKgJKuYfQ3Ql+iDtwtjYEiXyL0Xmq6jDJoPCqXuRE/6WVtDnOhwV6Oy1IafpspbVGJDTiDKikWxaD1h1ny6FOrNZ4ZTepQij2j/sOhMP6LT47e5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743352512; c=relaxed/simple;
	bh=ehSbMdyy0t5e9YeMRCDuDvLQL24Vk7kk0DG94s5v33Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pa60ld9vSypu2OVOWynwn0QvMxViME3/Z7NjAeR7yApFmhxmroXJ0MQrxpx0TLMtWAAYh8ZhGxkVfYG71KREiXTBJ2IOEcgdeyz7uebZQZfgqZ4k31wXHlXddqSWDQP4xq55GqNvxqXU7+38VvVtnLNpZ95zSowpC5ibGgewQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViYHCsKK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac29af3382dso583297866b.2;
        Sun, 30 Mar 2025 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743352508; x=1743957308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSGrK+eEOvoMOUoRNbGGkHQ0YBTE2+lP2PSjhcU90F8=;
        b=ViYHCsKKGvrE/z7yjoHSwAgr2wEH1EoN4ee2TDAY+Z2F9KPzveJ9yyQoD+ULOQqLs9
         gNiqpIxQmFzYPkbp9Mb29PfNRweBi4VkrP7gJbktDmwBXADvYLSeNnOQkySCLBPmgIFS
         2R19+fffdMGfb6FtyrCfboiXaow1eolPLRLY00TqBFHqnJiNc9uRHhYeaqtapIjs/CbR
         Yvh3NkN3kxuFr5DALda/h1SVHxz/ykLCDj9bPuqh7/MIOlxumtwcNBpJjn+8ihqFjUve
         iHxlX/5Nm0I2BBI7iK6l8J8iK7b6Tn1sX278BSry6fhgtkgxt3RkJ2j8AzAn/GpLpepe
         vL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743352508; x=1743957308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSGrK+eEOvoMOUoRNbGGkHQ0YBTE2+lP2PSjhcU90F8=;
        b=hC5loZfXCyzLC1vHMsy/Pc0PvPWVT8v9iaJ1COL8qj4nEVDF4WlUiVs8AyLFD/WHGA
         OGRXiOD6ImONKdg1Z9KMUJayWzoF3deZxmnUf/znvswkOsj24H+i8TxlQfwISlUFBWd4
         mRiweM5LPYGL0mKElquBdnkTV3cohgtLT1nwGbOwN3nCo3AXlb+xOyVeUmQPMjOis09G
         +2Rf4UJpEVsiQ+8OcwhKvgIfEyrqzwHSfva4cAJCtp5PdMEqIKDapSL317YCg4uaQszi
         WW67q2Mxg3qEEfpusWQ5v3X7WmP+oKYnpr6akVLnZudxPTLkl8ivfGMtaEQRbGpixsSW
         Lxlw==
X-Forwarded-Encrypted: i=1; AJvYcCX15UGOXqaFWM2hhDr/He540WjFt3L6WkWt/IIfDvaCwzvLBiP0rYHqxj43A/Ja08WQ/vzVBxJMRlpi@vger.kernel.org, AJvYcCXOhjnEHFi08Eh/zal0TyYv4X+EVmQSoa49tJR+NA0hIF+erYeKaxklvrCSWQn+QcP1PcLxx6915lfJ6o4o@vger.kernel.org
X-Gm-Message-State: AOJu0YyEMVuFfkU4S5kkbhHBsB0KZfBKZif0K2jvnR8i75H3lasEAnIW
	eWt61blWhOlOVa5CR/ntUSdzL8hut9g47HvJ7prn1mCWJ1Ulddkb
X-Gm-Gg: ASbGnctPud5u5UB6TW1mfH0UzTRJrMKOodQ6sblRNWJT1DLjkE4AspY7igM+1L6aAh5
	9d8v0I0cG27N5Tg3MMzO8+h9DN2GLcai5Pcxomwt3tV1nr7PwlmzhXeEJbiqlaaGldsMDm6XbQK
	cJg8EIGMEmmSVEfvhRkQtai1d8ugkKpIfUcMuTO4SUTqUDSH0Npb9YlrC2WmVRkGgdutpuKkMbe
	xHoRclx9QihdH9hyTxbTb1i6yrgC5RP6g63IDjcgZ48RLuLSlzzASHQCBqZbrrBRVbGXtiYiBaC
	X3x6jBMqvra4Yb53bPlPFWer1qtW/ZMaEQ0wfiJS6e4yN5btRB/Ip5T8HyNTI6KEGaJbe3aJ38N
	YOVux3/+E/Zf5TzR3Ybfvt76A2FIr5WrcHTS12uLCuw==
X-Google-Smtp-Source: AGHT+IHVhEa7NosEtYZC4MV5Cyzszz96XEMrDFOlHllCinbl5NTIMhcvdVaaKhznjJUnnn3kJqMtwQ==
X-Received: by 2002:a17:907:97c9:b0:ac6:e42b:7556 with SMTP id a640c23a62f3a-ac7389e6743mr623677466b.11.1743352507693;
        Sun, 30 Mar 2025 09:35:07 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac719221034sm500020066b.32.2025.03.30.09.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 09:35:07 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Alejandro Colomar <alx.manpages@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@poochiereds.net>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v2] name_to_handle_at.2: Document the AT_HANDLE_CONNECTABLE flag
Date: Sun, 30 Mar 2025 18:35:02 +0200
Message-Id: <20250330163502.1415011-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A flag since v6.13 to indicate that the requested file_handle is
intended to be used for open_by_handle_at(2) to obtain an open file
with a known path.

Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@poochiereds.net>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Alejandro,

Addressed your comments from v1 and added missing documentation for
AT_HANDLE_MNT_ID_UNIQUE from v6.12.

Thanks,
Amir.

 man/man2/open_by_handle_at.2 | 46 +++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/man/man2/open_by_handle_at.2 b/man/man2/open_by_handle_at.2
index 6b9758d42..10af60a76 100644
--- a/man/man2/open_by_handle_at.2
+++ b/man/man2/open_by_handle_at.2
@@ -127,6 +127,7 @@ The
 .I flags
 argument is a bit mask constructed by ORing together zero or more of
 .BR AT_HANDLE_FID ,
+.BR AT_HANDLE_CONNECTABLE,
 .BR AT_EMPTY_PATH ,
 and
 .BR AT_SYMLINK_FOLLOW ,
@@ -147,6 +148,44 @@ with the returned
 .I file_handle
 may fail.
 .P
+When
+.I flags
+contain the
+.BR AT_HANDLE_MNT_ID_UNIQUE " (since Linux 6.12)"
+.\" commit 4356d575ef0f39a3e8e0ce0c40d84ce900ac3b61
+flag, the caller indicates that the size of the
+.I mount_id
+buffer is at least 64bit
+and then the mount id returned in that buffer
+is the unique mount id as the one returned by
+.BR statx (2)
+with the
+.BR STATX_MNT_ID_UNIQUE
+flag.
+.P
+When
+.I flags
+contain the
+.BR AT_HANDLE_CONNECTABLE " (since Linux 6.13)"
+.\" commit a20853ab8296d4a8754482cb5e9adde8ab426a25
+flag, the caller indicates that the returned
+.I file_handle
+is needed to open a file with known path later,
+so it should be expected that a subsequent call to
+.BR open_by_handle_at ()
+with the returned
+.I file_handle
+may fail if the file was moved,
+but otherwise,
+the path of the opened file is expected to be visible
+from the
+.IR /proc/ pid /fd/ *
+magic link.
+This flag can not be used in combination with the flags
+.B AT_HANDLE_FID
+and/or
+.BR AT_EMPTY_PATH .
+.P
 Together, the
 .I pathname
 and
@@ -311,7 +350,7 @@ points outside your accessible address space.
 .TP
 .B EINVAL
 .I flags
-includes an invalid bit value.
+includes an invalid bit value or an invalid bit combination.
 .TP
 .B EINVAL
 .I handle\->handle_bytes
@@ -398,6 +437,11 @@ was acquired using the
 .B AT_HANDLE_FID
 flag and the filesystem does not support
 .BR open_by_handle_at ().
+This error can also occur if the
+.I handle
+was acquired using the
+.B AT_HANDLE_CONNECTABLE
+flag and the file was moved to a different parent.
 .SH VERSIONS
 FreeBSD has a broadly similar pair of system calls in the form of
 .BR getfh ()
-- 
2.34.1


