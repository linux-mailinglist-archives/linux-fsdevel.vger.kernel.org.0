Return-Path: <linux-fsdevel+bounces-48935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058DBAB62DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 08:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389AE19E2E2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 06:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0481F4C98;
	Wed, 14 May 2025 06:17:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF50513D539;
	Wed, 14 May 2025 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747203459; cv=none; b=b5eT+uZawmT2yuuTAh3o2kZbysf2u/CXYnOFu92GlFocGUMBBnQOMOsh4aZ8vWWXxaAyhB+1cHu+mQfQDpJa3/DdJiSe0muNkXFgPtGxdjNKprrUTQopihqH7eyUIZNIbwL5vadKPqBBk1vt6a3LvaRmz5xC5AOD6QnrQwzUdgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747203459; c=relaxed/simple;
	bh=CWHORAXG2oiiaHYAWxfkNRLv9y4YW0URPt7RpnYjehg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kj8wQIQI5wkmGYSbxXcFnAhDjY9MPuZfOH+vpyDwfyauY7peHI18hb+AH1skNGOQQGM0hqRm4xKbXd9R250yO9r105qIYdvWo/iBMavqtsubhUbXgCkmmOyurwvO8RyH07bKqOX+7MM7fF+ONwpTXC/NMMvGEE9Ce9KlozS4IfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7cd0a7b672bso305311785a.2;
        Tue, 13 May 2025 23:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747203456; x=1747808256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ckf4J7K6nhKzDsTt0cIUCHXIZuk9xFjMGBfmOU3gBK0=;
        b=G35C11uL6IchaVz5AgxrfSy+4cM1yE84Y2j+Fgmbp8zFkg5sOj+Qdr+daaEPxrEasI
         +procYuEDZ6keZ7DDrUI6m43R+sXer0j0cflNT2LpIxxajUiqoi4Atr01QsUd3ctw5qf
         q5VvzjurwDVj2MgQpVdKHt7AwOCsY2sfxp00kUiEJCjC2cElYTyYAYUVWvK88N23XQuX
         LZj2VqZ922akkOgUAvtsFm2zqTlzsm7t3io0gidvgZbEzzR4GVAP2IiO9fXFBXQk1cnp
         DlW9a01/4j1qtlwuqJdw3CNFVJRoZJhXZvidipVT+hURG1DUtIZdpbRM6ZyWr//b39dk
         bmKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCab+8oYAJO1HTNkNMz75DFROAK0Z+fM7H+ZQkuUf98fSMUH8M/O8fs0m+ugKdpLiTUQD84ekuC8sXYo0H+Q==@vger.kernel.org, AJvYcCXk6QKcIdRgjzSCoEpJf9BHmjwRCX/8NTbsirHe3lb8ESxwlRCIvniPkumS+6828n6mgybNB8p0DEo=@vger.kernel.org, AJvYcCXw5biE2bMra6xPXJS/jNNvFMg6h5YIpYCN1YpQrDw57c7J78De1ISEoh10pqcHVi9EUek+dc4LDxFZZM6I@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5UAkIPpHJbMjgTp/7iaIvpR+/7+4cR5Mdvf1TmFjZxL0noGt
	DBU981/0xHcnXoOt/MMPXoJk3RxIHAEvJJ382gxsKKI/aktpE3z4jg8lsAVLYGU=
X-Gm-Gg: ASbGncv60gLM1DJt9gf75pz44vN8vFTijnTC2N3I8bpLKxjOM1o+21+GmFAkOz9DQ0Q
	za8+KiQ3s7mOKKDWuTiu3k//jJNmj+3E1Q7u8LsJ3b9PCb1bReIzvIt0twT1SMSH/jAt+QICur5
	rNrXB+ONYBE9waHz+b8sp+ntCjhAqsSpDTEJlw/A83ZN+GjIs5HEKx6hzlo6ZKAgF6wD4L8oqNt
	I+v3hFG8F2GkQIVdRfobBjhGEB5Lc6WBfmLgc94OLEjfBDd5t3RKk/BgXobycDFFfq4eVWJwlYR
	S/EVfuqaAPjbfKVGhS9UpC1gj805U7CLpBAIIWLAisLVdTlOnf1Xi8Aq+xC/XzxWDNU0He4/kI9
	Vs5YF0LQUCljTK9fJrHTqCg==
X-Google-Smtp-Source: AGHT+IFQ60TWyhSc7sQ4amWJetvm+Kt1H/in4TeBBB4ppBeiWIkLKv3Ija3+K6/Fnd8UfI6vwl9dPQ==
X-Received: by 2002:a05:620a:2596:b0:7c5:e226:9da2 with SMTP id af79cd13be357-7cd2888e3b3mr365807085a.47.1747203456454;
        Tue, 13 May 2025 23:17:36 -0700 (PDT)
Received: from localhost.localdomain (ip170.ip-51-81-44.us. [51.81.44.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00f9b24esm807118985a.62.2025.05.13.23.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 23:17:36 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Jonathan Corbet <corbet@lwn.net>
Cc: zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	wentao@uniontech.com,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] doc: fuse: Add max_background and congestion_threshold
Date: Wed, 14 May 2025 14:17:04 +0800
Message-ID: <20250514061703.483505-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As I preparing patches adding selftests for fusectl,
I notice that documentation of max_background and congestion_threshold
is missing.

This patch add some descriptions about these two files.

Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 Documentation/filesystems/fuse.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/filesystems/fuse.rst b/Documentation/filesystems/fuse.rst
index 1e31e87aee68c..c589316c8bb35 100644
--- a/Documentation/filesystems/fuse.rst
+++ b/Documentation/filesystems/fuse.rst
@@ -129,6 +129,20 @@ For each connection the following files exist within this directory:
 	  connection.  This means that all waiting requests will be aborted an
 	  error returned for all aborted and new requests.
 
+        max_background
+          The maximum number of background requests that can be outstanding
+          at a time. When the number of background requests reaches this limit,
+          further requests will be blocked until some are completed, potentially
+          causing I/O operations to stall.
+
+        congestion_threshold
+          The threshold of background requests at which the kernel considers
+          the filesystem to be congested. When the number of background requests
+          exceeds this value, the kernel will skip asynchronous readahead
+          operations, reducing read-ahead optimizations but preserving essential
+          I/O, as well as suspending non-synchronous writeback operations
+          (WB_SYNC_NONE), delaying page cache flushing to the filesystem.
+
 Only the owner of the mount may read or write these files.
 
 Interrupting filesystem operations
-- 
2.43.0


