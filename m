Return-Path: <linux-fsdevel+bounces-43237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B4AA4FBDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B1C3AAF83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E562063F0;
	Wed,  5 Mar 2025 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAoILxCG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDDE205E2B;
	Wed,  5 Mar 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170477; cv=none; b=b/baZp2BFikYSheKhal0dlbvwQtBnHhfc1GWs9/V5NzuHV6XhsIWlJydED2BURqdf//f2EF+AXjapkvJV+WBMIVRQlITPwi9VPjuYPpiXhKN3R7QdaPCZ457Uz33vtrYtDIcdqfRXkbTIZqR3YJphJTSrqOvvKtknz+PUaDomzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170477; c=relaxed/simple;
	bh=s1vT9eX3e3yTOI1Nm5+47Y7VYKSR4jH9tAGTZHWI/g4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rHjUMztx2w+p8/XycL5KmWWfwAiPBap7B5kAmizc9zVOoIgMvI17qB4ZlW9bEn8hPx8MauLASvSyRm81FJd8WR2xK5CX7NwxhLBEPnxVtQV4fiINf8uKt8g20CObT36I12lqx8w2vb1mzAJqdXNHqdLLtMcqDkucMsIZKmavV9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAoILxCG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223fd89d036so2651875ad.1;
        Wed, 05 Mar 2025 02:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170475; x=1741775275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYJ99pBbLO9Pg1Rfj7Ibx3+uhoa5MXgVtVx7vKe1AYE=;
        b=KAoILxCGfScwKBcbQtBZtiv2rsFmQgkZXdg8UFMePVSQosi0Fu8Uzu80GQM9dsJTG9
         a6JUh9opcC60uqvQos2DZ6DY88QeaNv/gmd6ZJ7hZsne9GxJIDov8SSlfcBLBPjWHLMv
         +jyObVQSCZjyYiSTG75bD077zre/F5RJGglUakDlZjFmet0M7IaeqB0BKUE3p9dID3vv
         olGqCwWnpnlCOfpRcYdpS6ok8eN9R07Qxs9RbBCupcM2Sv8Q5MIGc2rk35X429zCBK9V
         adC2ekPWhlVvgDI+90VJ33ZTIxa2u5OICt64MHWULmYhy7JbAyBvmj48/e0aHSSUzPgJ
         y0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170475; x=1741775275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYJ99pBbLO9Pg1Rfj7Ibx3+uhoa5MXgVtVx7vKe1AYE=;
        b=huK05xLRJaFOzBHu0TTlZ/1B6bEUzYoXmCkybR5RWBsge2RF4sj/JLdXzZI2ypKcq3
         LNQaatBpzZjj6x9pe8JGE9347mHJvNtkCSQ/Oxpy4rXlDvlEdtIdiHhvhMbdu8RbBi1r
         u4uGAKco6gybv0UVl55qfMN9OFduTJ7ygJ8DUbknjN1ZrYLVgGnh8BS62eb4erSdUd8X
         LIDQGvYTJxlXTL4W2ZenfwfMscuW2nUSIC9cQl2cLQT/J2OA8nmmBRBysgqGcz/QBkQi
         z2mRk6fQwhC90o530OLS91i7vrDXtyOBHvZtZrer47rGiXtMUJYG2d3mN4wtcrhCCQyg
         iycg==
X-Gm-Message-State: AOJu0YyH75NoK7Og/9xj8Eo+wJPPNhRE2qIqbxtpGoCXDflazgojmGej
	XX+mq39QYgxuCLBZwBPBYLNgHtGH44iIZTKdHEY4EOzHB2D5Yc2Feudn+g==
X-Gm-Gg: ASbGncux+jC3v0m7wLNOyA/+LUEhzigRnBHzDE9NT7zkscqPy0mE+wXk0MVsUQIEh63
	4s05+SfIFCVOC2mpC1tg4vJqQaYTf4JwqfmjKIZzGUtaGWNgAvbVJSrZJg5uphLpCOvxmpgcOqx
	4AI3Wm2U+fQR/y4Tju3+K5sokihkn1LVnfh0p/Z/qoitP3LM+CTTqckt0YSMkFWlRrNxJt+vZyA
	XiDEwqpvf1wa579PU89jzU4D+IJbE/YA0UWY3ug2YrI06X4P/ViFQSerX3sKjRU7R94ObXrlml+
	FWstrOGqzoMKTUI+mKpo1InJzuaHEF+s0EGuke7/5W39EgUwKQ4=
X-Google-Smtp-Source: AGHT+IEoTFU/0pFCCABiGDeBKnS+uwYSmSGMapMyk1ZQtqXSSMLndee+juQxLJVlkiTH/oivlnphrA==
X-Received: by 2002:a17:902:e74d:b0:21f:6a36:7bf3 with SMTP id d9443c01a7336-223f1c81961mr45216795ad.12.1741170474390;
        Wed, 05 Mar 2025 02:27:54 -0800 (PST)
Received: from dw-tp.ibmuc.com ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7364ef011c1sm6252768b3a.111.2025.03.05.02.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:27:53 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	"Darrick J . Wong" <djwong@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 0/3] xfsprogs: Add support for preadv2() and RWF_DONTCACHE
Date: Wed,  5 Mar 2025 15:57:45 +0530
Message-ID: <cover.1741170031.git.ritesh.list@gmail.com>
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


