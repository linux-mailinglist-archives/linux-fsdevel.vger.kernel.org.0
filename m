Return-Path: <linux-fsdevel+bounces-48645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE49AB1B21
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 19:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F011AA40679
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1930228CB0;
	Fri,  9 May 2025 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvlzyhPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7270428FF;
	Fri,  9 May 2025 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810040; cv=none; b=RRdg6FCIbM1vRGP8vIan8nTNLTPD23Cgr3yGhc6dXKI1UPS1lEzGj+YSj0Xqk7tSahRkdozOz+mKdnw3/GDDIu7aL/buK97Nd2gyHehc8Vd9A2XevbfT7lzX8GzmWjrIGjulsrZEzkWyqN4KOGUH4PZq4r3fAQb3rOegDSzDQCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810040; c=relaxed/simple;
	bh=Iu2irIhK7ig4WBckinRMfMxLhwhfAvp4mPY6BtqvZiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jUqN6Xv3tZ20w3PiSQI8EOgKPPYM/R7bFbRkXpLA6Kk6NVTDDELcCMfZG95bYwee+9WWLYScPjrPIqyCVciX2muStxig8nJjOmTix/teiuOrpyqOzbzhxxp7rliTBAkMn0qwhPufwyVwPJiHUMUKnBJGp6JKP3rld1uLVBYVa38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvlzyhPl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-440685d6afcso24594865e9.0;
        Fri, 09 May 2025 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746810037; x=1747414837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GCQug3eV9rd9VG+U+hL5Tr04WF/PElLsG6h66xPI7UI=;
        b=ZvlzyhPlLztdq9kbWJPsL3CptI1vOBooZYLSBm21/PY7trY8tPwnSI8yokguGmk7lq
         i+VlCZZk85Z4vJfc0nZfDPy1c7Lzu2+fnbsR4sMwxfUP9Mxs0d9sr2PoIkMpVmLSghn0
         PmMuCzzJ7KP0m4+RfrWxAOdK3cNUEOAykEU5yG0zX3j2LDHbJICzv5dQ61e38rPxOaVB
         ksZU6jw8dA/BZJTkprRSh9CT3l8NYnNljMX2tT+4WzvxWcM6swkmuaaGVkCvIUy8/iLs
         Sk5xgOFPya7SFoFuKd5EcPRO+v4qdpRGr8Yo2MEMD1tfhGZMOeg2Bg0WYLtMwrL80JMr
         UAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810037; x=1747414837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCQug3eV9rd9VG+U+hL5Tr04WF/PElLsG6h66xPI7UI=;
        b=BPCmaUqll/sfV2gQgzPB6g9wK3o7qhK8YpDod3Ts0HyoOTZ3GJcvdXwfieXzU0Zia5
         wWiB4oWtQOxNO1qVETS6zZSg+3ui7+wAdH49CeTvpR4I0GgRiaubR+BsFT6+wpIP60BN
         0zoJQvUC3SAjaNEyYMyzLf/JtmB2hYeT1g87IgsqFdXbLhjmD5gGy/MVHCGCifaiuba5
         r2I0wj0kh+dhUbCbA7eLIwe/0ea/oS6elFn3u0MsdQga7jUHTuEHO7qyW9UkrqUMhClp
         7cqyu16pyIFoNQxmp5SsTwrpeI04BCecIVwlu8i/vxzMC2WtcKfJDB/hmuRALtnqHv3b
         puig==
X-Forwarded-Encrypted: i=1; AJvYcCW/X1Q5FpzKjMiwFWqlntRPSWDJFXXs0YFicGySSu2M491D3lGHJkOrN4cRnM2TVVA+0JAJWlhffYf+03yGtQ==@vger.kernel.org, AJvYcCXBaeYVDYTff9Jyw/1avgEHhoipd1suNEgcGmy+e/LGLnTuU1oGFz79/qWj0ls8r4+3YRTdyth3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6uq1vSinV40tecSYjrlmMtJFiKE8sj3BAe3+B8sBX5FKiLki6
	i0APHDIFgtK4mH/H6t5wJgSJVD6cnQJ28YAIldyt0296U/9Obhgu
X-Gm-Gg: ASbGnctp49nkHPGLscAzVgcUl0OfEiekwYUKyxJ2tuQ7leDwEBm8TEUF1JVcfMNShaf
	qbguKpeoM8b/0MJLaj26NJA04KHnIo72YDL4fidMXO20rEPYlaciVZ1+A0UhsaSxLwrbCvF8eZ1
	vWZVvzb1M5Jyee+V9DoTdInybp4QRIAAp0UtqH64wKZZLJZVTJ9yQQY7P/uOE7ShCMSOJ3HhqgX
	RgQ4UOaNm4jQS5XrswGGP/DyPbg7nZa3njxD1bq/BXncFOkl1QEEtBhsMa624Xzzx1Lyzrdj9c3
	EIOn3E9PrOCUbt+H8iBO6/WgjJPPhzmY8h84UoyYKNFGLXUHYgGjKFjy0HgFKv7PJrezJRIfQUZ
	ffacL1LnnGOPRkufuQ8vhSPA579Gajf15rhHaIA==
X-Google-Smtp-Source: AGHT+IHuMjjqYSZwmbNoT5SlwfhJ1CoCPpOibv8jNuC8ux9riL/aQIvUEQSnhFS1wzGqafVe8+52NA==
X-Received: by 2002:a05:600c:384a:b0:43c:ea36:9840 with SMTP id 5b1f17b1804b1-442d6dd24a4mr38312585e9.22.1746810036074;
        Fri, 09 May 2025 10:00:36 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3b7d2bsm78469245e9.36.2025.05.09.10.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 10:00:35 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] Tests for AT_HANDLE_CONNECTABLE
Date: Fri,  9 May 2025 19:00:31 +0200
Message-Id: <20250509170033.538130-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a test for new flag AT_HANDLE_CONNECTABLE from v6.13.
See man page update of this flag here [1].

This v2 fixes the failures that you observed with tmpfs and nfs.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20250330163502.1415011-1-amir73il@gmail.com/

Changes since v1:
- Remove unpredictable test case of open fh after move to new parent
- Add check that open fds are connected

Amir Goldstein (2):
  open_by_handle: add support for testing connectable file handles
  open_by_handle: add a test for connectable file handles

 common/rc             | 16 ++++++++--
 src/open_by_handle.c  | 53 ++++++++++++++++++++++++++------
 tests/generic/777     | 70 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/777.out |  5 ++++
 4 files changed, 132 insertions(+), 12 deletions(-)
 create mode 100755 tests/generic/777
 create mode 100644 tests/generic/777.out

-- 
2.34.1


