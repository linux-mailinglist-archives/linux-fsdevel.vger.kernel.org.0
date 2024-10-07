Return-Path: <linux-fsdevel+bounces-31225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F43993490
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A8B1C220F3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E51DD55E;
	Mon,  7 Oct 2024 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kvVV1kR0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E79D1DD534;
	Mon,  7 Oct 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321298; cv=none; b=Kr24yHc7IYxEg0l4YiZ5GMHWVPDvqoTY+CQq+Fdy4x0bOksG5npyEBy2w3PN7isi9ULM4spOPbchoz6KX/RqGBSE/pWj7Kjb7QX9nHsjaPd6j6rAi2RZvB3r0GQ5Pr+wx5RcQR6hFvBmVfilGm6c2+lYkVQou3NleaiQdNp5GHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321298; c=relaxed/simple;
	bh=UKymu+mzuZLEK69UaQG2sYNhML4Ojs7J1jeASLinB+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cAescQhNhNy+KzFFgCVOzR+33QZFMWJYu6jSw9ijO7kcrt7O/t12GS2WqeRgchTfc/YUMxW75Nw1T2KITJkVTLkk+yFQ2MUBdPzkFN5VmOUCyRTS/+4s2j+UmKxn5pXAulws28v3IksB/rcFuFrnVsAKG4ah6SoJzyPKaVI4BhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kvVV1kR0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3B61A42B38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728320698; bh=HfbsOkmGxKTMn8UUu6s8L07CkPvNg5PaKCyqCkClrFI=;
	h=From:To:Cc:Subject:Date:From;
	b=kvVV1kR0NUD2LHQ9PlPj2IROekdRvtzVJL2kVZzltv6QZGUYvv5lQoW9srUUpv8fY
	 stRCRzThSe8zH5Sfu0pE5ESnmF+lzmjPTDWZd0PzH5aQEJkfPLLBFjmd8aFxRYQGet
	 oA35kKX+o2MibQJuOmwunrPHWqkSe+gKtlA8oBedlF1a5kK78Eh8ST6HY3pWKCSK4d
	 sXdTJAH5CKLYo/DmJkYXFhHAQabevtC7BabQsuarZOW9B+M628ETL89+Ql3f9te37y
	 otv5VgP0n4lqZYyl22TjKjx1vcdB144iSH9ot2bQuSG0VIj3Kfym+lJ2xfPSyuRUO/
	 W8C+ODd6dj+Jg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3B61A42B38;
	Mon,  7 Oct 2024 17:04:58 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: [PATCH] netfs: fix documentation build error
Date: Mon, 07 Oct 2024 11:04:57 -0600
Message-ID: <874j5nlu86.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Commit 86b374d061ee ("netfs: Remove fs/netfs/io.c") did what it said on the
tin, but failed to remove the reference to fs/netfs/io.c from the
documentation, leading to this docs build error:

  WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -sphinx-version 7.3.7 ./fs/netfs/io.c' failed with return code 1

Remove the offending kernel-doc line, making the docs build process a
little happier.

Fixes: 86b374d061ee ("netfs: Remove fs/netfs/io.c")
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/filesystems/netfs_library.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index f0d2cb257bb8..73f0bfd7e903 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -592,4 +592,3 @@ API Function Reference
 
 .. kernel-doc:: include/linux/netfs.h
 .. kernel-doc:: fs/netfs/buffered_read.c
-.. kernel-doc:: fs/netfs/io.c
-- 
2.46.2


