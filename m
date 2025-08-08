Return-Path: <linux-fsdevel+bounces-57141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BCEB1EF99
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 22:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7883F7AC548
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 20:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95535242D8C;
	Fri,  8 Aug 2025 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="rGb9F0ex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AEF2248B3;
	Fri,  8 Aug 2025 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754685614; cv=none; b=TyzrSIGxrMpb3TsmeXu8IMkDJ5nsszCox4MeNNfYranfs4ZF58gI7KVtvmfDJRmc6nUk272NqdT7XJ2lF8ht/FszWIUiHIBiIKrcn+kHUiQGOMQu1WXj4u7TG4EmcTKhBR0DSDagcjfC0HSf3V0vS+7EFk8Zzjms3kzick/1wnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754685614; c=relaxed/simple;
	bh=9x2GIlcD3cYf08YHgjOqsR+ppGR5Qw6j8BsDOjGrJJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xzm7TEwjBvH1B4v3eS+PBWFbHJFe4UxmEmX4sQDn76Oo5N017oUFTJfz7qtKARBjDuB+LqJi0QTNSs8WRpoTY4mMQD0PVknCKG4FHo94cuZkyQfKowhIyRjbpmE+WxUhEB+nz2Dwj65DEIWNIbUPyfs36KqQP5IQvke02l4h6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=rGb9F0ex; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bzGB042N4z9t7d;
	Fri,  8 Aug 2025 22:40:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754685608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1l48VI8o0GNZeOO2k04rV2PeunW2FfL5oSOr2P+jRHY=;
	b=rGb9F0exbTVvk7CQW80/2LPTRslfMH6YeOohp6+2RaD9tVa0OvEsHm9zBeq31A7FDRQqvM
	Txb5w5k2qfX8YLAnwCgFmOT8NOiORcQM5FWKxiNxInRQGBYaIEbCJ6pqOGLMlkIfXGDfcz
	iMyoehpVC2OGfhzMYTZTOJzdY1BTdFrwpuwnwSIrIf9rx/phGC51wyiYYOk8veX5n1nCmu
	fyok+DIrG+C88hzHWmU2onYOWNP+5eJ3UmLqx0vx5IQK4N7Kju4pCZRpMUrahyst4JBB6w
	XG53mhpbs3Ajc5BUXAGpXn0+F4wF9LnaIHf6nRV2yppm7qOpE6YeJRgq3OZf2w==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Sat, 09 Aug 2025 06:39:45 +1000
Subject: [PATCH v3 01/12] man/man2/statx.2: correctly document
 AT_NO_AUTOMOUNT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-new-mount-api-v3-1-f61405c80f34@cyphar.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=9x2GIlcD3cYf08YHgjOqsR+ppGR5Qw6j8BsDOjGrJJU=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMS5jmyKdgM+eU7FyvzAtdvKXP9mffzNnMK/R3ecvC3
 zsrjaQ9OkpZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBEzgczMqzXkuEvdmq+bHl3
 bU3wXNP9PnL2ctOu/t5hMuMAf4F7qzbDP4vwL98yym5klVU+05rbs8SxX/bcu7PnnGsyHxSd6tK
 ZxAUA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

AT_NO_AUTOMOUNT un-sets FOLLOW_AUTOMOUNT, which blocks the automounting
of all automount points encountered during lookup, not just the terminal
component.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/statx.2 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/man/man2/statx.2 b/man/man2/statx.2
index 07ac60b3c5d61d919fa790fe2d5c2ba33a771f75..0b4175e994f42c7aab6b0bfd50739971d4d55a4f 100644
--- a/man/man2/statx.2
+++ b/man/man2/statx.2
@@ -184,9 +184,9 @@ .SS Invoking statx():
 the call operates on the current working directory.
 .TP
 .B AT_NO_AUTOMOUNT
-Don't automount the terminal ("basename") component of
-.I path
-if it is a directory that is an automount point.
+Don't automount any automount points encountered
+while resolving
+.IR path .
 This allows the caller to gather attributes of an automount point
 (rather than the location it would mount).
 This flag has no effect if the mount point has already been mounted over.

-- 
2.50.1


