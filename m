Return-Path: <linux-fsdevel+bounces-22652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7DD91AD8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E2E1F21775
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 17:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB5819D066;
	Thu, 27 Jun 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWxwaAm6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8DE19B5BB;
	Thu, 27 Jun 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508157; cv=none; b=Lj5LFoAFEKHZ/agvaEkEJHKaaNAs3TNg3JH3cjCtDiRmjGY/UG6yod9MzBtXiI5pj8ior17ArYgC++pICbKqpCOCFN0ULTB5yZeZYj8Lf611PWfMHl+SrNkYa35pQDNaU+2K+WJF3aTHRwEmhzoGxbwb7D4C6WX3q2I50o7jXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508157; c=relaxed/simple;
	bh=OCMwDvtwnM9ll0Ws/wHw8cfOMgOXkr3TtaYN7UcD3wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRBcpVZHvSgYzlJVEeJRvDP7sObBbGhna3QzZDw/5mI6Q+gSnPRmSoXQLoSsDF9Sm+AAtBTmiS7+KUdZX8eB/q2iLMrLD1/GhXBpUJ5J8NNdvIc8cMk5f+KY1QETXct0IaiEXAr+HcZvTrIr32r+7RP1G9ALJG1DJZXQ5jEF0xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWxwaAm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A915BC2BBFC;
	Thu, 27 Jun 2024 17:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719508156;
	bh=OCMwDvtwnM9ll0Ws/wHw8cfOMgOXkr3TtaYN7UcD3wM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iWxwaAm6HiI2s6p8C7OPJUQawedJzfpX3Qtv6R/A3MQznMfbZJjniPkVsJ6xd0kf+
	 FanSaA7+wP2JrEJsSSupGUVVfHV8nS8GQOg/o37+oky22AN3kGvCRezK8rbrTKyyxc
	 TDAtr9dlBHBQzf2+BDakPYQ4IZ+SiUzUpDX8adHYcU0SjHUMfkqKcSN/lNd8LAEBxa
	 JOT1dqf1/FQNuopBQcbInp1Ctny9qlB9k5ehdwSstT1gn218L89kg7JeHWfyJbEFkb
	 6lPe01BN5tapSMV5+FQQvExwXYOvAx+QC1vzjwpVqP4vl1LHhlDvcKcj6LkFO+9gWf
	 CAcElJq4S2Mxw==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	liam.howlett@oracle.com,
	surenb@google.com,
	rppt@kernel.org,
	adobriyan@gmail.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v6 4/6] docs/procfs: call out ioctl()-based PROCMAP_QUERY command existence
Date: Thu, 27 Jun 2024 10:08:56 -0700
Message-ID: <20240627170900.1672542-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627170900.1672542-1-andrii@kernel.org>
References: <20240627170900.1672542-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call out PROCMAP_QUERY ioctl() existence in the section describing
/proc/PID/maps file in documentation. We refer user to UAPI header for
low-level details of this programmatic interface.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 Documentation/filesystems/proc.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 82d142de3461..e834779d9611 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -443,6 +443,15 @@ is not associated with a file:
 
  or if empty, the mapping is anonymous.
 
+Starting with 6.11 kernel, /proc/PID/maps provides an alternative
+ioctl()-based API that gives ability to flexibly and efficiently query and
+filter individual VMAs. This interface is binary and is meant for more
+efficient and easy programmatic use. `struct procmap_query`, defined in
+linux/fs.h UAPI header, serves as an input/output argument to the
+`PROCMAP_QUERY` ioctl() command. See comments in linus/fs.h UAPI header for
+details on query semantics, supported flags, data returned, and general API
+usage information.
+
 The /proc/PID/smaps is an extension based on maps, showing the memory
 consumption for each of the process's mappings. For each mapping (aka Virtual
 Memory Area, or VMA) there is a series of lines such as the following::
-- 
2.43.0


