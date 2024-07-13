Return-Path: <linux-fsdevel+bounces-23640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E759306EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 20:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A351C21B29
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 18:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7AD13CF98;
	Sat, 13 Jul 2024 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRIafl81"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76EE38DE9;
	Sat, 13 Jul 2024 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720894563; cv=none; b=a6P4GrUYcl0R4cZQPLhcQWKyHEIHe2Jkxla3SrsYOsiIOkzKJE2REK7ihuBOncEKZIsAxGatM6t+wmpUwwkaEkqJwQ2BnpSWHsJ5i1VAneBIqxsEiQbGf8CEdMugwovSbdrxseKE8ISt4ojAB57Q0T0raC6ipk/niKKbpqVXV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720894563; c=relaxed/simple;
	bh=+qTLGq03NqhUfWuqMDQ4NcOhN6T1QhHQ8lm52omYFzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a71iF28CWuAIWBHcUv1xl8kdhK/Bx740RjJx8JTY8hLYofabmdJDw9HkMDucqHdlMr89+YAOqjZjsgXg/8c8DIH4+/Xb5ELrLTqsjT950ClkInYCqY8HYWVLjpN4/HrTk0k3/sgYUYhgE4/tRiCWYQLASTKwqw3yZLMF3IRL89U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRIafl81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7262C32781;
	Sat, 13 Jul 2024 18:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720894563;
	bh=+qTLGq03NqhUfWuqMDQ4NcOhN6T1QhHQ8lm52omYFzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRIafl81T+UTCIk7Gl+8ahE4raeQLpSAvACRno93farIwTs7pbH/UInNlIEdfei8g
	 jRj3GXlu9QGeKEgti5qUEn7EZ+tUbBrAFBOWxlY/gFGzSIvDT2b61Pq3/K78cOCQ+K
	 B3eEo/SMTDMDteuC6lP35ImBEj1hae8i8shn+b7h72pKeT+G+A6zVs9gu0f3eenBBD
	 f46B6UqXc0G1IOBaLzH/Jl5Cg/J/Kxn2LRTaBdSZIyTxo7GRcuR3GQMR2gweXbawVE
	 C+TY+5hqV14ap7zhHXcfChBFyg0iSkaI3d+BcfO1kN4DjhPFk7MiziPEJjqGzsx961
	 fj6ooQXVzwHbg==
From: cel@kernel.org
To: alx@kernel.org
Cc: linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/3] fanotify_init(2): Support for FA_ flags has been backported to LTS kernels
Date: Sat, 13 Jul 2024 14:15:47 -0400
Message-ID: <20240713181548.38002-3-cel@kernel.org>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 man/man2/fanotify_init.2 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
index e5f9cbf298ee..12378ac05255 100644
--- a/man/man2/fanotify_init.2
+++ b/man/man2/fanotify_init.2
@@ -295,7 +295,7 @@ for additional details.
 This is a synonym for
 .RB ( FAN_REPORT_DIR_FID | FAN_REPORT_NAME ).
 .TP
-.BR FAN_REPORT_TARGET_FID " (since Linux 5.17)"
+.BR FAN_REPORT_TARGET_FID " (since Linux 5.17, 5.15.154, and 5.10.220)"
 .\" commit d61fd650e9d206a71fda789f02a1ced4b19944c4
 Events for fanotify groups initialized with this flag
 will contain additional information about the child
@@ -330,7 +330,7 @@ that the directory entry is referring to.
 This is a synonym for
 .RB ( FAN_REPORT_DFID_NAME | FAN_REPORT_FID | FAN_REPORT_TARGET_FID ).
 .TP
-.BR FAN_REPORT_PIDFD " (since Linux 5.15)"
+.BR FAN_REPORT_PIDFD " (since Linux 5.15 and 5.10.220)"
 .\" commit af579beb666aefb17e9a335c12c788c92932baf1
 Events for fanotify groups initialized with this flag will contain
 an additional information record alongside the generic
@@ -460,14 +460,14 @@ The fanotify API is available only if the kernel was configured with
 .B EPERM
 The operation is not permitted because the caller lacks a required capability.
 .SH VERSIONS
-Prior to Linux 5.13,
+Prior to Linux 5.13 (and 5.10.220),
 .\" commit 7cea2a3c505e87a9d6afc78be4a7f7be636a73a7
 calling
 .BR fanotify_init ()
 required the
 .B CAP_SYS_ADMIN
 capability.
-Since Linux 5.13,
+Since Linux 5.13 (and 5.10.220),
 .\" commit 7cea2a3c505e87a9d6afc78be4a7f7be636a73a7
 users may call
 .BR fanotify_init ()
-- 
2.45.1


