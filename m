Return-Path: <linux-fsdevel+bounces-20092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AFB8CE044
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 06:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82372817C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 04:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BF24F1F1;
	Fri, 24 May 2024 04:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0X12B5Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172963A1CD;
	Fri, 24 May 2024 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523858; cv=none; b=YFVmSDdi3bpRrjLAurCC93y1zhKyd5VPNXQhJNGIMKUO4PU49P5ze5kdrwhqAxwvyI+Y+vvEMgRCwN5QvXvjHvcjY7zZ9gyl5SsDGMdgKht4AQgs5urO+QYmBry9LMyIZuzwbSULfJ//LkoWrm1/3BY1+wkb2ygqIqQm1J8nBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523858; c=relaxed/simple;
	bh=ZB4t6JlnJmyNfXJGfSg5ESgmhwAqw9FNf1Hmazm6kO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWjAzbkBRqKD6qD77U+gOVxN3tewBOHtl0YibBdCBpxOis+y0lz4jhOiRBF5ivAIatr4eJoCElOnYUCXuoRkoc8/l4X9LlWq37RPFpKINgiDFLGYuxNoUzjs7odVTa/Ikjon1eAvxxvlWAXFpLbdVEi9i07RgO4p0dWTglpxCx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0X12B5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDF9C32786;
	Fri, 24 May 2024 04:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716523857;
	bh=ZB4t6JlnJmyNfXJGfSg5ESgmhwAqw9FNf1Hmazm6kO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X0X12B5ZJO7+/PmdMn4HdgAZbKU1NH+gvRopfoxD3GC/v/a1MKLtcxCgm4Fxl6zGU
	 qiUBA/ew+RLkhKXqCxfCoAtsqhZfug5eG/NEIJzm6Sfw5g/TB2YS7fi8zcPdA+H6yR
	 8aUMuRwLuaddhdyOI3zU3vqdBvUXESYGPsbc4SLxHsg6g/RIWLXqlkrv6CgVPLuBtP
	 LMaN16sNkRBz0sg5eqjHZk0ktrW+4MXpk3AE9CY7C7W95zL+Jyq4tz7yLQNHRPYNMd
	 qsWmQUdn70zaWixVwAf8AOsxjk9TE8dZemBTjpQx6cRp+oA7vXVeYIIkCz7X74raUB
	 8GpR/4E/3s9qA==
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
Subject: [PATCH v2 6/9] docs/procfs: call out ioctl()-based PROCMAP_QUERY command existence
Date: Thu, 23 May 2024 21:10:28 -0700
Message-ID: <20240524041032.1048094-7-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240524041032.1048094-1-andrii@kernel.org>
References: <20240524041032.1048094-1-andrii@kernel.org>
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
 Documentation/filesystems/proc.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 7c3a565ffbef..f2bbd1e86204 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -443,6 +443,14 @@ is not associated with a file:
 
  or if empty, the mapping is anonymous.
 
+Starting with 6.11 kernel, /proc/PID/maps provides an alternative
+ioctl()-based API that gives ability to flexibly and efficiently query and
+filter individual VMAs.  This interface is binary and is meant for more
+efficient programmatic use. `struct procmap_query`, defined in linux/fs.h UAPI
+header, serves as an input/output argument to the `PROCMAP_QUERY` ioctl()
+command. See comments in linus/fs.h UAPI header for details on query
+semantics, supported flags, data returned, and general API usage information.
+
 The /proc/PID/smaps is an extension based on maps, showing the memory
 consumption for each of the process's mappings. For each mapping (aka Virtual
 Memory Area, or VMA) there is a series of lines such as the following::
-- 
2.43.0


