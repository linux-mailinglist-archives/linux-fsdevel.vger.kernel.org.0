Return-Path: <linux-fsdevel+bounces-57150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8180CB1EFBE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 22:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7D716C735
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 20:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121A6289E1B;
	Fri,  8 Aug 2025 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="s6YutWte"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1150289E01;
	Fri,  8 Aug 2025 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754685671; cv=none; b=TPg/oO4p0XtB/qR8lUvqBJ2o6bmfmMUDSDY94NSPS/AOKrAzE2GhDJCnLKh0j3zYxY6zQ43lZo6jyw/0MuSBItTZ2xViAFc6q64KnQ8J081L262JswQhGKc96YVe41AWTc3y3b2O8pDwsoEsDVkc/RB47H0YkGAX8b2cTn4zYes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754685671; c=relaxed/simple;
	bh=k4I6IhzIuLAKznoxjZO8roLMK+pWpHy5eTqdzRZCCxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lwqJvSd4hTsq+zuacAy+l168Jjjk40pamXBbdxKE+eQmnekdQwDDMMAvzYWIpOufycMy13FH20pBPCaj6R8RyukRwJLvdbPUEt8ywk5aLPX5nrHIhRY9sjk7nPZ9Hti1h2TXVRQxTybDeCb3xzkZJYaxhiA2Kr15J8cTRwLYCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=s6YutWte; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bzGC62rkPz9srN;
	Fri,  8 Aug 2025 22:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754685666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fAn2b5Wd7l80nCN6IMuQRQe4awmsDAnQOQK6EkhBSw=;
	b=s6YutWtelvDML72HGJxcXKAmsyaRjdZ4VsBfc/PD4V03+FKtXgk3VoXeoob+cXBahbkt3y
	TKZWFhuY3RQSAKhGhJKyoLM48rqnTF+evlARKjyU2rBzKrL5AEqB0U9+cODCsd6u/WYMvU
	wpDQ7tj8+BInBEPTlx03EzxJ+tVi7WcGzgrDIIZn/XYHdMAStfMICX7ewu3/J+W0p4HqUu
	xPGRVfuAgXqbYDC8acyUBX8+Xa82jFgWrCAucrG/iNKIeoHmboo1fgWmu+kRubQh9PwXFG
	EZk2EMw13ekbYyvijDLJK3ShRXbV7uGvc003n8+YAi61BaL84LbD3swmzACL8g==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Sat, 09 Aug 2025 06:39:54 +1000
Subject: [PATCH v3 10/12] man/man2/mount_setattr.2: mirror opening sentence
 from fsopen(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-new-mount-api-v3-10-f61405c80f34@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
In-Reply-To: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=k4I6IhzIuLAKznoxjZO8roLMK+pWpHy5eTqdzRZCCxg=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMS5iRlnqIq3urGbfO/9orsqf7fZ7cmVggzimr32Wly
 SAcUzGlo5SFQYyLQVZMkWWbn2fopvmLryR/WskGM4eVCWQIAxenAEwk4RbDH76pa/4uSVwZdenc
 lgn9nXpZR5SlM/OcH3z5nGX7S3fzuakM/2w5irbN9MhuE5hxjEP+XLfY2SMTrV88v+K5SpX3tsY
 KCV4A
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

All of the other new mount API docs have this lead-in sentence in order
to make this set of APIs feel a little bit more cohesive.  Despite being
a bit of a latecomer, mount_setattr(2) is definitely part of this family
of APIs and so deserves the same treatment.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/mount_setattr.2 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
index 46fcba927dd8c0959c898b9ba790ae298f514398..d98e7d70870c082144dfa47e31ddf091c8545e4f 100644
--- a/man/man2/mount_setattr.2
+++ b/man/man2/mount_setattr.2
@@ -19,7 +19,11 @@ .SH SYNOPSIS
 .SH DESCRIPTION
 The
 .BR mount_setattr ()
-system call changes the mount properties of a mount or an entire mount tree.
+system call is part of
+the suite of file descriptor based mount facilities in Linux.
+.P
+.BR mount_setattr ()
+changes the mount properties of a mount or an entire mount tree.
 If
 .I path
 is relative,

-- 
2.50.1


