Return-Path: <linux-fsdevel+bounces-49442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE2FABC704
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 20:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBBA1B60C77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDD0286434;
	Mon, 19 May 2025 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICH0u7vG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB3D171D2;
	Mon, 19 May 2025 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678805; cv=none; b=kEm67ecCqUhk5/q9Z3N5eXgNHxG0EiM7MDQ4oGjapg+cPIT5btKcQtssMH/YsrjRoC9sJvWz/48Hk2flFVeTV/tVuNXqvGS3eCyY3pkefs+nExkIz4wuHeYWPAo0aiLcMTJw/XVQoIAZmH7zR+8K+gDLxZe0hgPoD9npj628H/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678805; c=relaxed/simple;
	bh=o12prAGhAwyVzCJiZM0bFYqqvIDRh76xWJU4XD0Dj+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qANx5i48C84GQtz/Dy0pIqp/hOtKqM5OsNgbApneMTKcdr3MTs5qBNEh0J7Rv2SO2Rag9FgyDfvm0X2f3r4BttemG53AXXLIZLevf4TgaDFCPatdlPCuFPuIt6SoU5PETurRlQCjmrpZbm6BZzBfah0og9uHdyLknGgnTtZqUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICH0u7vG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2322bace4ceso14138785ad.2;
        Mon, 19 May 2025 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747678803; x=1748283603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p6N/dweR0Vtl86wrOcYIVeSn2AIIfc9yuokVrZ10vko=;
        b=ICH0u7vGkSuWSBtVB7V+nnhA3De7FGmfgIrK3C03B3I51P52WXzZ6u488T3KfvvChI
         uffASp/zemawvir0ss82Y0vx1qzCvQeJNwcv6ws+RSlVvfR+2/fvuHGIPA3aNuE3kkRu
         +nq5rX6BeHGTDZLzildjxi8SZA5SkRcadn0HmaEkWnW8D2wwNkgrIkiDRUOkXdWdIM5H
         tH3ajoCOr6Qj/QwhBqodq49SiYoRBoZKHGbeF8pQWAC70NM50pbpyTxgVnEUwOwVNQVV
         VUgfRcQlr0Koh0XpMdRR67FTyxNFIEsooqTIWdxasmlbiIuT3KBByKSzQdvMn20xOnre
         ytAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747678803; x=1748283603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6N/dweR0Vtl86wrOcYIVeSn2AIIfc9yuokVrZ10vko=;
        b=BdJ7/jIQl+ZyVWr59Xv6GrY4zMBvp+PjRWlnzMQLoOPhnztco6/wFBmXGApxFo6lgh
         WDZG/SHAEywOApcnmTiVyoHYLjMhGYcyarl8DAOjNXM5L++FUUXR8Ku3zl2wOkiEP7Ss
         WlKtqnPWIIy2U9/VDKP1wFVeEvZOJ4VRBo1+zcnFJQLWfLpAAoyO+v25o4OhquK9MNoe
         /NmIVA0SYbn7kVK0J0FCl3Nn0e3Wd5LZiyb9/uobsDTqZC7rXzXmht4cpOrOON7hAYma
         XLQ/NuIx4uSN7VOMquxdNaDPCU5ky0VOh1eMejAcw68dnl9VfCrTqMa9qyjvtYYebmAB
         2y7g==
X-Forwarded-Encrypted: i=1; AJvYcCU6YLxHJ9vN9R1lIWDH3+AVSSUA2FcI6VizQzRgDZXmeTziYmgF+8/r7m9C5762LzVYiCEO+eiJPPG+JoSS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0BpjqbWUe8NHGJ8fsPq8LYicRtIVpxiVLyLx/3kACjtUhVgZl
	3WxzKp3MJXs9NbhnqbAmq8YQDnalMXUrvUDngI60JCkQZwFFXG8zSX+LqUkcrg==
X-Gm-Gg: ASbGncu75RXawb7X/kWKKw4L+N2lZhkwtRkB42K2oS0/s2WMSr2S5rWKgUkyD6ckSn1
	YeOp/Pk2fwEdnxqk8qLeVuJxAvOGCDRh7rep2cUFJVnY/spy6oXSuiQYUrR0TdmkYA6l7CKbyB7
	4p2t7m7otNz7pZNgQ8ISoP00CXMP1eqVvjgnhdF+lMAzCxxBmqBgTGbypqHRFm9rbzuOS+uqIPv
	4nTT+uuITFtbP9d2HHySGaM8frScDU1UlM8upK6GmICns37Ytug+qFp5KLHrpm8NMk7lxieW3Pl
	Mo34P6M49GE0Oq+bkp7rf0rfCTfbphbQSHwM8UtbR26BIaLAjs2iHQ4m
X-Google-Smtp-Source: AGHT+IGIGeVKJfNf3Tscpau2iBHhy6IS15Wl5tnqhI04PA0Y42Trrkl44aZmrYShwLw6GPydwFSnOA==
X-Received: by 2002:a17:902:ea01:b0:223:5c77:7ef1 with SMTP id d9443c01a7336-231d43bb574mr199988555ad.21.1747678802755;
        Mon, 19 May 2025 11:20:02 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.82.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed4ec3sm63156245ad.233.2025.05.19.11.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 11:20:02 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v1 0/5] ext4: Minor fixes and improvements for atomic write series
Date: Mon, 19 May 2025 23:49:25 +0530
Message-ID: <cover.1747677758.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some minor fixes and improvements on top of ext4's dev branch [1] for atomic
write patch series.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/log/?h=dev

Patch-1: Is the fix needed after rebase on top of extent status cleanup.
Patch-2: warning fix for cocci
Patch-{3..5}: Minor improvements / simplifications.

Ritesh Harjani (IBM) (5):
  ext4: Unwritten to written conversion requires EXT4_EX_NOCACHE
  ext4: Simplify last in leaf check in ext4_map_query_blocks
  ext4: Rename and document EXT4_EX_FILTER to EXT4_EX_QUERY_FILTER
  ext4: Simplify flags in ext4_map_query_blocks()
  ext4: Add a WARN_ON_ONCE for querying LAST_IN_LEAF instead

 fs/ext4/ext4.h    | 8 +++++++-
 fs/ext4/extents.c | 6 ++++--
 fs/ext4/inode.c   | 9 +++------
 3 files changed, 14 insertions(+), 9 deletions(-)

--
2.49.0


