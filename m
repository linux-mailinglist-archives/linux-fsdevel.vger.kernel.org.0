Return-Path: <linux-fsdevel+bounces-44108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE7CA628F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 09:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D95177842
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3D21DDC2E;
	Sat, 15 Mar 2025 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlWEkDiw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE418E023;
	Sat, 15 Mar 2025 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742026828; cv=none; b=oatNtQr5LbLOwqqPDo4RM1dnfmPZO4jBPvTFOPBuX7hqIT5PHdhy4DiY6A3UnFxCE5lxab30J1io6zeot8HPft/vERT9799I9Ct+DdvH+rhpZxqCznzxL/aO3NFruZpsbhmaWBGWhrBUfHRd478j5GPsbRqgSDHLspK5JkHU9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742026828; c=relaxed/simple;
	bh=0jkRdgernz7i++UYipak/SXnnIEg7hNuL76BZ3XqfjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lqhUTWSvl4NMpNophbq+5VG187xBc3/rbSpPx4KAIIOe6Q1WwPb0mxHOraC6G9PNBxPF7nJg2JfzDpNsDEeIZN2MBAHO9uiIx9EzwX1KpE8RqoZpWrQHr1gU4Pk9rwAvs46RINbL2F5UA6W1FbC4Cg+hzl5yXWjR/XYB+vsfxec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlWEkDiw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2243803b776so78330985ad.0;
        Sat, 15 Mar 2025 01:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742026825; x=1742631625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PNuUqB/N5exhUTR5etjgn8RyVGXTehpbQ4LU7oTnmWU=;
        b=KlWEkDiwaOnaeFmPpF2TcHNabNVW76GtOmL/UzAwvRE+wFlcIaQJWJZR9H8EC5GUv7
         7XSlfjKztHn7h2hXlD3aBbYGWQokVfl8EEHAnanItavL6zW3lpxBbH9zWqfYARz9Dj39
         pX6Dpoq0Kpu8tEqCUE/KLGp2kWnWT3PNi3noPuDpguU6FFFpdgQ400TiA+UtULzSAbAA
         0j9CO8634ONmKG4iTGcnwy+cSmhM9MLLF8hLiTmIp+xDdJajoyLCP8rOLBSUVUG1MWCS
         +JlVykl62JZ2jn8AFBODXk6qZhMaUgJkJ6YGv5z8kcCHRTRwlQ/lh3pQS+0buNDNYT8u
         nwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742026825; x=1742631625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNuUqB/N5exhUTR5etjgn8RyVGXTehpbQ4LU7oTnmWU=;
        b=MOLHKHZ61P+wKUe1M0V+l5n1JUI4KIrq6WA3mkqTR5gI3ODBPZ1oXE/0DF2fsEqofB
         g0rxiJJaGftSu3fzHrMx3WN/r1CzOJKAy+JQoEiKh8NxViUA4zpMsC4zGWGVLlAEsJU0
         dfTOxcFnncXYfETGYnQNbO5fiUvse6pqPSu54qzyv/Obipq2xSsoGE24LKzOirgMdgis
         vJJkW86e0m0dhNhoxpHFDvLe6F9beX+14ttuRuGX4PzH7ITFnGf2+2W2HFIeGcgHFdUl
         jfG8aU8j0qNOeKSFE2zbUGnzNiBcym5J+uKCUEaKXT5FyIHRtLfcLp7jy5wt8nOO/deZ
         3Vag==
X-Forwarded-Encrypted: i=1; AJvYcCXGKNxWt1rjXz67pcUxWCZpwGhQ1z+LUVCH1wMx493WtLNamN6g7Vbi/7Wsnxf4Xc0pYjSk03U7luBuB6dB@vger.kernel.org
X-Gm-Message-State: AOJu0YxCmNND8zS33UAyrcBxvqZZdbY7rGgFAJkoP1/5PUpXwXgQ97or
	FIQ+eUI064j17Ao2fp5dHKgc7rWzr8FAUlM9Ks6BrzVW3Oa5OyqLlRsq5A==
X-Gm-Gg: ASbGncs76ExHZe5Ugn1taZEMRf5XdCdn/gvXHWtF/6OqipbULWJlVmck+txtN8QTJpD
	WCcvNHXd+lVF9uNL1nfxlmb02aghQGEC8jozR7ax0bNbBy/NnUQThC6CVTT6XzVzOP6IqCc0k+Z
	AZvSURcSK12T543aeAgY9VdIEwqiaBb+zzl71YeyGh1gtPmv3zeVeKN82xlUd9wYXIRz/MJIE/Q
	I+Cm6JmQ/OJnlIMe+saZt/vun3W5EGl/Iu3/TKs1uH32iksHptTaETK3iJjJMaBq//7dK+BwWcy
	05lRQEpetJouyYn8KzCu0+WPWd4zDelKVq4oNWR2g8auP1F/+w==
X-Google-Smtp-Source: AGHT+IFXoB3ePL4u5TDU8isX8y9tPqVWV/3ndH5sjamTUf5onzuc4D+52t8NeOJ87X9g4xJ5NIPZHw==
X-Received: by 2002:a17:902:dac3:b0:216:644f:bc0e with SMTP id d9443c01a7336-225e0a799e6mr76323235ad.24.1742026825138;
        Sat, 15 Mar 2025 01:20:25 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.87.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe7e4sm40071405ad.189.2025.03.15.01.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 01:20:24 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 0/3] xfsprogs: Add support for preadv2() and RWF_DONTCACHE
Date: Sat, 15 Mar 2025 13:50:10 +0530
Message-ID: <cover.1741340857.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds following support to xfs_io:
- Support for preadv2()
- Support for uncached buffered I/O (RWF_DONTCACHE) for preadv2() and pwritev2()

v2 -> v3:
==========
1. Minor update for -U option description.
2. Added reviewed-bys of Darrick.
[v2]: https://lore.kernel.org/linux-xfs/cover.1741170031.git.ritesh.list@gmail.com

v1 -> v2:
========
1. Based on pwritev2 autoconf support enable HAVE_PREADV2 support.
2. Check if preadv2/pwritev2 flags are passed w/o -V argument
3. Fixed space before tabs issue.
[v1]: https://lore.kernel.org/linux-xfs/cover.1741087191.git.ritesh.list@gmail.com/#t

Ritesh Harjani (IBM) (3):
  xfs_io: Add support for preadv2
  xfs_io: Add RWF_DONTCACHE support to pwritev2
  xfs_io: Add RWF_DONTCACHE support to preadv2

 include/linux.h   |  5 ++++
 io/Makefile       |  2 +-
 io/pread.c        | 62 ++++++++++++++++++++++++++++++++++-------------
 io/pwrite.c       | 14 +++++++++--
 man/man8/xfs_io.8 | 16 ++++++++++--
 5 files changed, 77 insertions(+), 22 deletions(-)

--
2.48.1


