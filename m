Return-Path: <linux-fsdevel+bounces-46074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E26A82401
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 13:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F333BE983
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 11:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA5C25E456;
	Wed,  9 Apr 2025 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXYFNs/C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63025D1ED;
	Wed,  9 Apr 2025 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199550; cv=none; b=DmVujrCtTUKC0+S5/aUDeP0tKsblXqAgCLcal3QOlCAWeS8oHnlO2aUPhGr/W/kuGsZgZIARBnhpwg054ZsgEZ96/3hPjDPBoHG2scKH57ATvkhcWgzrpsktDt1udrNc45hGQurbQtZ+M7C9QU7i6Cbh2jvLLtq15LbCmXaT+i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199550; c=relaxed/simple;
	bh=8i6W2NOBKBye+iUdjeGX9so/WQUawCrPnsTv1t26ShM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nyj4iA91s/5Yg7rjuBpYabcAVgZXnnUOgcMGiAacvEaJgvSirDIDaFrMIbMB4URmBD/pNoksK3NMRpPwbsHp99QRFbpMNcWwWIG+XOLpW8oJ7ly977wBMjWNVv0vu2JuH4K7jk7oMUHnlQ3D86FsCLm28tcW0tx9+QJ8nBaakd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXYFNs/C; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so46927715e9.1;
        Wed, 09 Apr 2025 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744199547; x=1744804347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4jhLZrqk3vr32c/8xm38WO72gDBvOfap1yATJtkGTg=;
        b=AXYFNs/CtAwNhfi944+MNW4xj9qgjuz1YDIo3Qk6Qak3CIk8DROUwIO/aMDROY5lHG
         jUAXYH2GYuH6vWy0JRdHpZcR28qvR9+DBx8t10SgHjtZgZYf926ARI59VCWoovjf+9IC
         mHciMX4Dbzjj+G61ekdEj7qJLHLtBUjHli8wTptz1MxFjaic0dcUCsPiPSmXQsCTCOv4
         dXgpLB5NaPq7ycoNhjEyuxdzycx6x8gMvbEBxBa93XaT285IlCmLdXbG7WMygNVHZlDF
         ugfrPsn8jyf2EuR/RTLSFNV2UiJ8NldPzy7CBYhjrqMSkOq+LSf6DKx6iTKKO/eya0y3
         8JiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744199547; x=1744804347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4jhLZrqk3vr32c/8xm38WO72gDBvOfap1yATJtkGTg=;
        b=CERsNDz18MyDRH5h3xbU8SN3CXbYe4OBJkVdUEGcqM2IZJ1Pwaoc8PQdlWwF0joOiX
         gV1WepaWbxlGM0dnN9gVSchjQE+4zdd6RG9JX4yRUuoBPAZsTpVjWGZ7WdB3OBo07ETI
         uw/OA5hnEEUbQqRHpea7XbE5mwBiYLJbzeDETBgGLq83QIV2bJYTuSE1wA7NqPIQ5QOH
         ETG9qspFbjEwNx/OtKjI+rPUZsSVlCHDltF4QHnRLoqmP93JYaObof+3AfazF5ZLVi05
         J9ohzddUVuFzMyW+/ByBe45LzfeqWQvQ5GBd1qXPu0fHx1++2UKzpX4iMx56y2r0/PP4
         yE3g==
X-Forwarded-Encrypted: i=1; AJvYcCXXGwx9ZqRzXxC8IpDJxGVCdcJ5cMDpN53bqpUOIQdm3gJZ3pNhqChOcbYxDIE/2/CF/Fy2+MyZ@vger.kernel.org, AJvYcCXnh8takiaCzHDaKIhBRlDfD7X57beSb11f3wob+j9/oQYDLwCZKoWEujqg/UdKP/Vp8dwZCY92msRTu0GH7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfOLu7THRxAcu839WE0TMb9HfV0iP5c+8HGp2m1P6EYiiufCN1
	6LaAGdU9N3BCWFvljcIFuT4z3fJPQYslyvHTbvbFjuDjRDxccZFj
X-Gm-Gg: ASbGncuZ4gyPsjnpd+JqoZ1QSpLunKdIiKBw2a66poqdxAZrZq6KuQziidh/luP1oWv
	jqKcMZ+NmOEbBb6lLj2QxnGSwpNW8IFyK/5RbM8dJAnTxpjwE761byNWsTKvOFP5UWy8Xf2/rKw
	4yn4K0ztu3aatW5cnYWzCeW4NEOrDmPFG6uU9WqtiYCBq8A/SQuIQ+NfvLPxiLiMyea7nirUFvi
	ziAyy32NCnUrHe8gokA1R0xtvQlpz7hYFbw5noI+gdtisJRWbg3jpk5sDp6nohp58R1oEvPtuML
	DGJew3MYqr8tLEk/srpj5dz0pchm6KJmunoNv1hL19R0D6wsNaCydhzYGlr8dHvczy54yvWNQHc
	zVb7d9nzYxbDNXZ8nNAsFz7Hp6bVDVP62AmH6Fw==
X-Google-Smtp-Source: AGHT+IEi7PGyuS4sM84LLpIoWErz/ip0QGHDG4AOBK+bSPl2iXWxuo/6d1PGPXJ36+2fGpYFBXICzQ==
X-Received: by 2002:a05:600c:1992:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-43f1ed4b5e0mr20869005e9.25.1744199546828;
        Wed, 09 Apr 2025 04:52:26 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d069sm17786815e9.17.2025.04.09.04.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 04:52:23 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Tests for AT_HANDLE_CONNECTABLE
Date: Wed,  9 Apr 2025 13:52:18 +0200
Message-Id: <20250409115220.1911467-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Zorro,

This is a test for new flag AT_HANDLE_CONNECTABLE from v6.13.
I've had this test for a while, but apparently I forgot to post it.
See man page update of this flag here [1].

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20250330163502.1415011-1-amir73il@gmail.com/

Amir Goldstein (2):
  open_by_handle: add support for testing connectable file handles
  open_by_handle: add a test for connectable file handles

 common/rc             | 16 +++++++--
 src/open_by_handle.c  | 44 +++++++++++++++++++-----
 tests/generic/777     | 79 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/777.out | 15 ++++++++
 4 files changed, 142 insertions(+), 12 deletions(-)
 create mode 100755 tests/generic/777
 create mode 100644 tests/generic/777.out

-- 
2.34.1


