Return-Path: <linux-fsdevel+bounces-21003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EC58FC0B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 02:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9295FB26249
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 00:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3110713C676;
	Wed,  5 Jun 2024 00:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjIONyKY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D77AEAF0;
	Wed,  5 Jun 2024 00:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547138; cv=none; b=AcS3bvxB81QBIJAwLHs5JypDHcaIsrkGNkDR9dl7xW86KOP94zQRczNUbc9Zi4Aez2B4SvsNrTieEaRy0PtxRl2iNiTjTaO5kM950hBSVGKUUiTpSFlUL1xb8MUXxf675JeQHaK+/+/85Xgj2wYR7IkjwZXyL64gzG7fJrXm2pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547138; c=relaxed/simple;
	bh=ZB4t6JlnJmyNfXJGfSg5ESgmhwAqw9FNf1Hmazm6kO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSP27qhTxNc7bFFjgyGN6ELh8ikgaidTHD64j4EaxadDeLx0XnnRPZ+2SeQmiaQg7x2ROHgMbdXg2TJr+d6sS6F0ituOdx0jk7sJeHRjkJw3tt0IgIpnKIUeq6pK7ZWLsiKo/FxkYegWe5Qhpbmg40l4hmsHF7o4KqsQ7osDzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjIONyKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9BAC2BBFC;
	Wed,  5 Jun 2024 00:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717547138;
	bh=ZB4t6JlnJmyNfXJGfSg5ESgmhwAqw9FNf1Hmazm6kO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OjIONyKYr0+xpTgXOjcVF6bOu02uR2+txTrRdm4Ixq+QkB+2eXEz0kuSKxOnhbNv+
	 n4Mw3XADEz/zMDgWgsnoCtNCX+wDYNP/uoyMk2FDPgaQ1IfIloSv/lZSECMlFyarar
	 DpohbGRGcfJaJ4hdzHB3Tratzz77+u8gEQDjOEuiJw3aBaKwuO1bJZ8X0E/seeHgHX
	 q2cx7mBYyK8gJ5dFXkXh8Y9Bxu99EhogGZY1NuRAP/ayKfGAuOcbZy1dmBkpKT9YW0
	 wz7tZsETraSeriNv1SZHfrH06MX7u9Gc8yZ7/mlxd/jNwiW4Z3R2XTqq4QIB08cT4I
	 kLfEN+PJfbx9Q==
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
Subject: [PATCH v3 6/9] docs/procfs: call out ioctl()-based PROCMAP_QUERY command existence
Date: Tue,  4 Jun 2024 17:24:51 -0700
Message-ID: <20240605002459.4091285-7-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605002459.4091285-1-andrii@kernel.org>
References: <20240605002459.4091285-1-andrii@kernel.org>
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


