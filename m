Return-Path: <linux-fsdevel+bounces-58487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63816B2E9F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BBA1886510
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B151E102D;
	Thu, 21 Aug 2025 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gONtR3Vg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A01578C9C
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738270; cv=none; b=Krcob1Drim2nQ2+KENcBZtxdJcu6WUEaReykKXkP+1qReTQ27OmoasXz/P6GIGckf/m/XaM1VX5/fvpIBF1oMed2IBjZ3kuvy3gQw0vlq0jP+RPFvdzVgxWXUpm/FkTVzbuWinjaEfsPVpDQ3pT9AoMnGQfCcxFxNrrKQraSTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738270; c=relaxed/simple;
	bh=hSxg/R6707YOvO1ny+1MQpI4QQd7bsO2ApcqIYs+V2E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLv6ZAK4C/qwf8a5QpFTgebiIk7hF4oSL34dhq/CxJKCqUQmhi4LRc5tYt5luSAwNiKPW5X4zDCjvAcAn7ocVHJrnRW73dwrKh/EW6gH4q9tGKWGVzdwr3QfXb8APVBWVgZvr3hTgJ82UFTGoNi/WwyPonXvtKlSqfTfBmk2yMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gONtR3Vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C8CC4CEE7;
	Thu, 21 Aug 2025 01:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738269;
	bh=hSxg/R6707YOvO1ny+1MQpI4QQd7bsO2ApcqIYs+V2E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gONtR3VgLVB8rP72dyZ32gVUCjE/HPhWjOBBO0dgS2z72kG36PT7SkFJ4ABvq7Nt2
	 uDAyyhVoxAz4sdu8Smg89tD4sHDWUfIKz2qTgK1snOTV60cZ14rYAjWLO4h1uk7pJ4
	 9cEGHyH/ziNa1/4mhMOTBIm1m2yIbv/2No/jLACsXzejoRE9QlDlPFnpYozIZRSAGX
	 AwoTUuSd4l3I1/HCjM3fkH8l3ySyjt0hKGEaRLq61gLU7XO9tFJc2lcJLjLmhjmyyu
	 NRVvmatjYgu/tc29HAvsLjTHCv0LZg5B1KK81BRpLCCLvi/Xvk3HuNPVbdDHb1lKjG
	 YN+zhpnuWoj/A==
Date: Wed, 20 Aug 2025 18:04:29 -0700
Subject: [PATCH 12/21] libfuse: support buffered I/O through iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711508.19163.4722575752668860362.stgit@frogsfrogsfrogs>
In-Reply-To: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
References: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Make it so that fuse servers can ask the kernel fuse driver to use iomap
to support buffered IO.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 86c81871ca2b37..eafad773a1fd5f 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -238,7 +238,7 @@
  *
  *  7.99
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
- *    SEEK_{DATA,HOLE}, and direct I/O
+ *    SEEK_{DATA,HOLE}, buffered I/O, and direct I/O
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  */
 
@@ -449,7 +449,7 @@ struct fuse_file_lock {
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
  * FUSE_IOMAP: Client supports iomap for FIEMAP and SEEK_{DATA,HOLE} file
- *	       operations and direct I/O.
+ *	       operations, buffered I/O, and direct I/O.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)


