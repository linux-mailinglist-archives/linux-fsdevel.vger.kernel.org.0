Return-Path: <linux-fsdevel+bounces-18257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7348B68BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9471C21E01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378E110979;
	Tue, 30 Apr 2024 03:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpH9qhw9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1A10A0C;
	Tue, 30 Apr 2024 03:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447869; cv=none; b=OcHfOafOLqdV0hQbiMTo+/jLNkN0tvsQhLoq7vXRIgri48Lf9AtrJdFFhhgMlhTf4RI8uwHmqxIkjGuoNUi3h9PtZQ5W3FZcWjgbct1QqaLrAYcXI0w0BvdBbk/dhhUd75QWe6XnhRx6REFzs5p+2NS37tcpU2kvxE1bG3IGIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447869; c=relaxed/simple;
	bh=eoOuwQplEfTtqp6x6BmwFhj00mBNeG6r5IEbVognfrg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEkqN2wrFAdRz6wWg6fCmqRt6ttC3m4I7lyOLxDGOMY7qewB48SqT0xGwRkPHqatLzeD0puOOYgMonXbR8bnCZSrhW8fQtQbpOOFsxv6RMnlgeez35ubfhTeXyiRFGyfn+oPqkWIgpf8diss/7E7rFzmuZLNS+oQwe46kk+ZHU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpH9qhw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECDAC116B1;
	Tue, 30 Apr 2024 03:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447869;
	bh=eoOuwQplEfTtqp6x6BmwFhj00mBNeG6r5IEbVognfrg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dpH9qhw9Tp5dIaiXPGzoOzXfNRvUzjOZv7xI8KB592USjkWlX9zkewGLB5Nw1cCXb
	 FORxUvIxjcOyfbeXGQT2hxYzmOs3veTzQ98DidhZ6+C90iYE6b4gy3CwUxRSRRvIzm
	 MU/ED0ANlpGggihGER8mjki90ZJ5wgzYlkAHwcEwmCRHIvkgrkWpVKfVczl9O/eA8h
	 gt34pTH/KsJpa/Nv1HTmNyBfXM4Qy5TTwwmSHxbTSr+cwJY1/KL07uSp0bItf9ZPnp
	 GLcz0BgTBImv72ovYilMO76zmxz47vZsNJIh0iNLPAIV/82rVFZR4Og3AX1/46cj21
	 tDCgBj4XZX/4g==
Date: Mon, 29 Apr 2024 20:31:08 -0700
Subject: [PATCH 01/38] fs: add FS_XFLAG_VERITY for verity files
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683126.960383.14706856644618362588.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

Add extended attribute FS_XFLAG_VERITY for inodes with fs-verity
enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
[djwong: fix broken verity flag checks]
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 include/linux.h |    4 ++++
 1 file changed, 4 insertions(+)


diff --git a/include/linux.h b/include/linux.h
index 95a0deee2594..d98d387e88b0 100644
--- a/include/linux.h
+++ b/include/linux.h
@@ -249,6 +249,10 @@ struct fsxattr {
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
 #endif
 
+#ifndef FS_XFLAG_VERITY
+#define FS_XFLAG_VERITY		0x00020000	/* fs-verity enabled */
+#endif
+
 /*
  * Reminder: anything added to this file will be compiled into downstream
  * userspace projects!


