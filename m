Return-Path: <linux-fsdevel+bounces-36302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7E09E121B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 04:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64BA282C2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 03:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204651BDA99;
	Tue,  3 Dec 2024 03:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/JoMdXQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7232E17BEB7;
	Tue,  3 Dec 2024 03:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198037; cv=none; b=hedOBEdM5fJTEn/Jacn9KS9blJtrPIz9MYsRaJ8j3mJElIzu5K0DB7zg7LkAU3XIg6vJLb2oPhzkNP5p2+C2Z1/hNtY2l1qS/TUs8Q4gQy72JLwIH5rTktuLs3PcTgTymLxk1WTSvMShASUssUi+735l164gOPyxjwTIYznviVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198037; c=relaxed/simple;
	bh=MdSpb8Nh8lIFO2WMQT06WzxMitSj54UmfgKQ2YobRQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVJkbRx8xENktGLQnEno0qZTFxVfTe3y+5++yUZx9nXiczRZFk98gM0WjdoF054+CKPe828LRY3QvWxKwlP8F7wVz59UYR2Ypib6fseAp99rcWkz+NMUlK9KCsPEsnl1jCgaWNgrO5xK7/omXIdwwhun02Rg9FGkLxhBdHpR+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/JoMdXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8915BC4CEDA;
	Tue,  3 Dec 2024 03:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733198037;
	bh=MdSpb8Nh8lIFO2WMQT06WzxMitSj54UmfgKQ2YobRQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/JoMdXQykTedPN8hEuuVEyL88J4xxZT98mHVHEA2+tEpZaZg5jOFOALAiYzZYznU
	 yEdTZPWS4J5A6X6OnRZAM3eMit8nNJftJWASS1mlryNO7b7TiI/P4My3tv/Tafy2Hx
	 zPXRDUZ28awthWR/XwwsNP7fJ/UONvJr1lB8nH5GZHDCwVitMEyJdwiecDuwD9MXJv
	 iRKphMaCqltI3kBviknatQHCmkT7LXYLVQvd6f656ZDaaRxjw9yw+lOPto5D0+7cH7
	 s+xlXWrNn9bcN8bLk+GDUE/i78SEICnEYmmRrN6dLbUkZ3GNwTUVUnUklDjjgBhSji
	 wO5j0NDcR9huw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/11] tools headers: Sync uapi/linux/fcntl.h with the kernel sources
Date: Mon,  2 Dec 2024 19:53:46 -0800
Message-ID: <20241203035349.1901262-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241203035349.1901262-1-namhyung@kernel.org>
References: <20241203035349.1901262-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in this cset:

  c374196b2b9f4b80 ("fs: name_to_handle_at() support for "explicit connectable" file handles")
  95f567f81e43a1bc ("fs: Simplify getattr interface function checking AT_GETATTR_NOSEC flag")

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h

Please see tools/include/uapi/README for further details.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
index 87e2dec79fea4ef2..6e6907e63bfc2b4d 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
@@ -153,9 +153,6 @@
 					   object identity and may not be
 					   usable with open_by_handle_at(2). */
 #define AT_HANDLE_MNT_ID_UNIQUE	0x001	/* Return the u64 unique mount ID. */
-
-#if defined(__KERNEL__)
-#define AT_GETATTR_NOSEC	0x80000000
-#endif
+#define AT_HANDLE_CONNECTABLE	0x002	/* Request a connectable file handle */
 
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.47.0.338.g60cca15819-goog


