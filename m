Return-Path: <linux-fsdevel+bounces-23622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60737930023
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 19:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFD11C21BAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 17:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC00F178386;
	Fri, 12 Jul 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi1R+K/H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675C172777;
	Fri, 12 Jul 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807022; cv=none; b=SGTqS5gyYRVHEEusB9rscUMPI8Dghs80dmgkqqJ9yocdl55gbZWYcIv8Yy2WqfrTkuHyK/v8GgutI0pGQ93DIApcDpB/9BvPGysfS4dk74MirezWQ7mhFflw13BqrVXZzyYIf1W5Zmvkc/XZ0aEUBDRNWTZSixJvFWjGLGWWgoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807022; c=relaxed/simple;
	bh=QZOyrPULHwZGMDwiE9qJEry9Fhp//3CwkfjE+W8ccFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6Qd/D2v9dOs2mpaJb5ITYbXUYZlMuxjkHoGe3Og+Nvh21CS30xQgGdJn9zVNGQWlItgk1olPIhStcPdFfCnUF5PqLWQayEAG/S23m/5W/oPk4pwdLXCf/hrImJEPQRIJ/WpI3F8mo00htRPjrEQJ0glCqQLBHL2v1Rfp9zGIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi1R+K/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BCFC32782;
	Fri, 12 Jul 2024 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720807021;
	bh=QZOyrPULHwZGMDwiE9qJEry9Fhp//3CwkfjE+W8ccFE=;
	h=From:To:Cc:Subject:Date:From;
	b=oi1R+K/HgdrxsVbfUUyVMfkWHF2gc1sqdyyeLMYwXwJz2RWg1FAMHrjGJ/0Zvdfu4
	 31CSA0Qs/o9Xq8fB6cAwgBZjj8dq+1s6oxOxYLQ0V44REdH/9G/9RsDaLm2HH9BSyT
	 jz7UJgnShlfEyL96/4vwRqsMALHRt5kiG92Lir76wVvuUpdIwXHK5y10yWwv8LnqgQ
	 u3CBxy59VLGyEeZyJaZqnFeMk+hY+poeryEYo9HQKMFhmM1gqdb0OUXCxnLhYMSayp
	 t1akXbQspNBUr6fBJ9n5o2Q1auFYFttrQh+a4zDCYz4cQYJFXwU38VMUxDFpgljL7j
	 +P6VbcTmlvwZw==
From: cel@kernel.org
To: alx@kernel.org
Cc: linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 1/2] fa_notify_mark(2): Support for FA_ flags has been backported to LTS kernels
Date: Fri, 12 Jul 2024 13:56:48 -0400
Message-ID: <20240712175649.33057-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 man/man2/fanotify_mark.2 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
index f3fce0c4e4c4..edeadc883029 100644
--- a/man/man2/fanotify_mark.2
+++ b/man/man2/fanotify_mark.2
@@ -176,7 +176,7 @@ the update fails with
 .B EEXIST
 error.
 .TP
-.BR FAN_MARK_IGNORE " (since Linux 6.0)"
+.BR FAN_MARK_IGNORE " (since Linux 6.0, 5.15.154, and 5.10.220)"
 .\" commit e252f2ed1c8c6c3884ab5dd34e003ed21f1fe6e0
 This flag has a similar effect as setting the
 .B FAN_MARK_IGNORED_MASK
@@ -271,7 +271,7 @@ error.
 This is a synonym for
 .RB ( FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY ).
 .TP
-.BR FAN_MARK_EVICTABLE " (since Linux 5.19)"
+.BR FAN_MARK_EVICTABLE " (since Linux 5.19, 5.15.154, and 5.10.220)"
 .\" commit 5f9d3bd520261fd7a850818c71809fd580e0f30c
 When an inode mark is created with this flag,
 the inode object will not be pinned to the inode cache,
@@ -362,7 +362,7 @@ Create an event when a marked file or directory itself is deleted.
 An fanotify group that identifies filesystem objects by file handles
 is required.
 .TP
-.BR FAN_FS_ERROR " (since Linux 5.16)"
+.BR FAN_FS_ERROR " (since Linux 5.16, 5.15.154, and 5.10.220)"
 .\" commit 9709bd548f11a092d124698118013f66e1740f9b
 Create an event when a filesystem error
 leading to inconsistent filesystem metadata is detected.
@@ -399,7 +399,7 @@ directory.
 An fanotify group that identifies filesystem objects by file handles
 is required.
 .TP
-.BR FAN_RENAME " (since Linux 5.17)"
+.BR FAN_RENAME " (since Linux 5.17, 5.15.154, and 5.10.220)"
 .\" commit 8cc3b1ccd930fe6971e1527f0c4f1bdc8cb56026
 This event contains the same information provided by events
 .B FAN_MOVED_FROM
-- 
2.45.1


