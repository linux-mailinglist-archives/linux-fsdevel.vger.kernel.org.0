Return-Path: <linux-fsdevel+bounces-57152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF21B1EFCB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 22:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551FC16FC17
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 20:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F97528A3EF;
	Fri,  8 Aug 2025 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="nfmdhOZO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9826289E3C;
	Fri,  8 Aug 2025 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754685685; cv=none; b=o8Y6sNlQhDakdCu/L96E+wab7RgmVyOx/IRNkNebZSO1K98SOMBGpG2xzzX8iSutFlUccs2Q9aasFbPduXUr1OThIPQLOWIkQN1XAgyHdxw9d9Wt/AaP0bjr4L6hFcvNm3VxiJcWQzUsDVmNEH/1RxFoSPBDyucoxMt4R9jrbdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754685685; c=relaxed/simple;
	bh=kYsKPddX805RzOw4SP5aC06jULGnc9Yib7S66nFHI4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qj5GID6pGIikJLOVg62Urub12QEW1M9JKu6k55MTOnhPZ/Ic7riZDN61A+VsezsaS/fzpQr0Slisp/3XYC6KMGqX99a/m6DW0vyyVTzSZ8vW/xl0AaXw/1e4xJLgWk1dkSBjL5VaUoU+ftsyqyKOQ//OezD/NSVEDJk29ZmRuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=nfmdhOZO; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bzGCM1f4lz9sc4;
	Fri,  8 Aug 2025 22:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754685679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGPumx2Rqm3p1S+Eay5H6awP7U7X//hs66pgfwkfArc=;
	b=nfmdhOZONZIqDdp2LMPb/i11Lmd7BC5zLRjXgy7cdKTk+PfUT+nNdMnwA0DYGSsoUtg4Ng
	EJWmJp7VLE4GetNpIwiS68Xf5E3x8BQAS5/UjpCGsMws+quTJe2nBuIimRRhjqk0fLynYA
	/Uir3/CIU207a2mMOKpVgNZYAoQoEgf6iS6VrEAfajgaD5iGZjVmmXTSvrbjvxpv/bZtrN
	UpLRU/6LWMhxpMAObWDBxUS2ottC22sh5k7BCLpV9zeHQeiNdysLjBcZBPFNbj1iE8eD29
	YEvna1o6ttRk47daFZpxxj7NuWc6lUahSsg7oi1feEodBxAyh+eCDWF8+qhbZA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Sat, 09 Aug 2025 06:39:56 +1000
Subject: [PATCH v3 12/12] man/man2/{fsconfig,mount_setattr}.2: add note
 about attribute-parameter distinction
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-new-mount-api-v3-12-f61405c80f34@cyphar.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2776; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=kYsKPddX805RzOw4SP5aC06jULGnc9Yib7S66nFHI4k=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMS5hxnHdanKCNzTLp9dW6i3QShXrV9rXotXxZE9wZ9
 /jD9RT5jlIWBjEuBlkxRZZtfp6hm+YvvpL8aSUbzBxWJpAhDFycAjCRcgFGhj3v50lNnc4+SW65
 qMPpBaE+K/NOt2X0nXrUaGKwrc3D/BzDf5+ICYGL2Tm+eE6+mL+7/ry5x8frldXMfLs2Nwfefiq
 nxwMA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

This was not particularly well documented in mount(8) nor mount(2), and
since this is a fairly notable aspect of the new mount API, we should
probably add some words about it.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/fsconfig.2      | 11 +++++++++++
 man/man2/mount_setattr.2 | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/man/man2/fsconfig.2 b/man/man2/fsconfig.2
index 97c9aff0e0c195e6028e1c7bd70e40905ba9f994..a7642e1633541bf8f5cd537db22987a4ec70da06 100644
--- a/man/man2/fsconfig.2
+++ b/man/man2/fsconfig.2
@@ -522,6 +522,17 @@ .SS Generic filesystem parameters
 Linux Security Modules (LSMs)
 are also generic with respect to the underlying filesystem.
 See the documentation for the LSM you wish to configure for more details.
+.SS Mount attributes and filesystem parameters
+Some filesystem parameters
+(traditionally associated with
+.BR mount (8)-style
+options)
+are also mount attributes.
+.P
+For a description of the distinction between
+mount attributes and filesystem parameters,
+see the "Mount attributes and filesystem parameters" subsection of
+.BR mount_setattr (2).
 .SH CAVEATS
 .SS Filesystem parameter types
 As a result of
diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
index d98e7d70870c082144dfa47e31ddf091c8545e4f..2927b012eed1569e0d78a2fb91815f364fca124d 100644
--- a/man/man2/mount_setattr.2
+++ b/man/man2/mount_setattr.2
@@ -790,6 +790,43 @@ .SS ID-mapped mounts
 .BR chown (2)
 system call changes the ownership globally and permanently.
 .\"
+.SS Mount attributes and filesystem parameters
+Some mount attributes
+(traditionally associated with
+.BR mount (8)-style
+options)
+are also filesystem parameters.
+For example, the
+.I -o ro
+option to
+.BR mount (8)
+can refer to the
+"read-only" filesystem parameter,
+or the "read-only" mount attribute.
+.P
+The distinction between these two kinds of option is that
+mount object attributes are applied per-mount-object
+(allowing different mount objects
+derived from a given filesystem instance
+to have different attributes),
+while filesystem instance parameters
+("superblock flags" in kernel-developer parlance)
+apply to all mount objects
+derived from the same filesystem instance.
+.P
+When using
+.BR mount (2),
+the line between these two types of mount options was blurred.
+However, with
+.BR mount_setattr ()
+and
+.BR fsconfig (2),
+the distinction is made much clearer.
+Mount attributes are configured with
+.BR mount_setattr (),
+while filesystem parameters can be configured using
+.BR fsconfig (2).
+.\"
 .SS Extensibility
 In order to allow for future extensibility,
 .BR mount_setattr ()

-- 
2.50.1


