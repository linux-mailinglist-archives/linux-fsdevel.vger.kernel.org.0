Return-Path: <linux-fsdevel+bounces-21419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ECC90397C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 13:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC961F235DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C431817C207;
	Tue, 11 Jun 2024 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Foktfj8Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455F17BB2D;
	Tue, 11 Jun 2024 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103674; cv=none; b=f16xh1h7UVbEkeZdd2/Tp/riBI3Aw1QtSIn+LaE7XNSSsXeyVLt1eeonhnOr2X7xvqCPa4leoMBUgVQeu/Tr6EJBwRWR1Sh1Xb/tHiY6TLjCfr1OzY5Po/ZbxvD3lIbN5PpA0UjBrTNTSTXFm7HIzjFOmRV/7MRPLZjy3x+MNvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103674; c=relaxed/simple;
	bh=vBH/6OYdVjsNNyjp2pikvMXvKQezYlNPmAqHiQSiZF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ui+sVjaOV/Z4dYj2vrSmbDYbkgKcSt/blORZc9ZYbhneqpUEwjUP/Fx/7sFNDcmQxMiaTQ0FfUIJbPjhlvmmtN+ElVVBU5N+VVSx/AIBdLH1PVh/k/dsv6fdhCmZEzx7+JzcWct0yPf5yjFbV2B0xbRkl3Rebaw2rIw4+3FDBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Foktfj8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79B1C4AF1C;
	Tue, 11 Jun 2024 11:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718103674;
	bh=vBH/6OYdVjsNNyjp2pikvMXvKQezYlNPmAqHiQSiZF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Foktfj8QEBkhkirvVOBKEf6XICDJq6ObR9pscnonkImbxnlWTGr+tmP5foto8XmEs
	 JoieWu/Q+B5NF5ppUo3rK96S6DYaVxtt8zdpgPWcXb9MNP8J9Y6/imP934OE7VMnNc
	 Rke55cMw9xbBNa0vw5kM/EP0l+vlE3ax5ezQ+Pg827CfLwaSeWk2qSXGPeiLibAZbe
	 DHyZrsCQOX/GqneNFqoU46MnMxtUEjFcwKNRr09+xmXZMu3GHEcXqTA7vnJ/90mQ+e
	 0aQadq0REIZuepZIkD46DlaV2S/RRDewk1IE9M91fzJQa2ADAjjk2ifEm7ejw2KCA6
	 tH1SJ1l6Wg27w==
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
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 4/7] docs/procfs: call out ioctl()-based PROCMAP_QUERY command existence
Date: Tue, 11 Jun 2024 04:00:52 -0700
Message-ID: <20240611110058.3444968-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611110058.3444968-1-andrii@kernel.org>
References: <20240611110058.3444968-1-andrii@kernel.org>
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
index 7c3a565ffbef..3a86d12c881f 100644
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


