Return-Path: <linux-fsdevel+bounces-23639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAEB9306E8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 20:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E4028189B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 18:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8A813D601;
	Sat, 13 Jul 2024 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs806t9d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3311F225D6;
	Sat, 13 Jul 2024 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720894559; cv=none; b=rbuhiJHBx9DKnvwOt9Fio3u0o2WnakmKwxA4YTAP67ekeoZv+mKw7kqmWWNhJzbpVSoHd6vy5ZRUmdTFdMEhJ3+IkRQPXfyt7tBW/NqBprlmZ9ViG4wVW+BzhCTkndNs/IlPvAZ0gJ8Mkv69yVF7r+iGNl65sOwZ/BAJPmXdAiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720894559; c=relaxed/simple;
	bh=mFtpr0dY9Cb2O+EY7ksWwDDqCjYXeDMbFuFEwfTXW3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjJrMkezcwVe/b2iLY+LcpON8lnedHaWQTmROx013lL4A9y/MrvHcGwvSgIHr8dZZErtuPrjb6GWRjeSzPg3t4nSHHozfT+kpf5JnduxJ07U2rIKdJ8wbJjcVZCwWHYzYJlrkGdjjAE0ED9tfWUv7YIg9kTQTw9CRgIGnU87EZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs806t9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40922C32781;
	Sat, 13 Jul 2024 18:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720894558;
	bh=mFtpr0dY9Cb2O+EY7ksWwDDqCjYXeDMbFuFEwfTXW3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cs806t9dZGGTP1v0MHuRtE9KB/Wx+N70EHU3FCTpMSoImkOa+BIKlXopGaCJEb8mq
	 KRecXYbL89Jr/SCvk042h32Nxup4dEby1PZ/74vZZS5Rwz7kPXXzh6opGqmhzPoGF/
	 x4bS9fJurVnlyt9H7yv3JM8uVsMdNzlG7+Oq+ExP0A3wW62zgSvGE/m98ikbXEBpqs
	 UtFUr85koOc6Pp954Qeam+bjaRkt1QYV3TC2cC1Q3lcJOWNRUrSiWUbybmVdKpdar6
	 QYx4KGCyqrS2AROURuZMTFX8qMfDjR1ZuyvXF+Rp2n7z2SUvNaR4V6S4+vBuKNIg1F
	 C+b0WhggJ7IIQ==
From: cel@kernel.org
To: alx@kernel.org
Cc: linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 1/3] fanotify_mark(2): Support for FA_ flags has been backported to LTS kernels
Date: Sat, 13 Jul 2024 14:15:46 -0400
Message-ID: <20240713181548.38002-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240713181548.38002-1-cel@kernel.org>
References: <20240713181548.38002-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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


