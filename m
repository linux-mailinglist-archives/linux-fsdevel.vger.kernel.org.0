Return-Path: <linux-fsdevel+bounces-27164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CF495F1DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5CBE1C227AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ED5194A68;
	Mon, 26 Aug 2024 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grpfIMos"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8521946A9;
	Mon, 26 Aug 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676399; cv=none; b=OcRZ/RXMa/K91kVsDDneUuM43NnBOKyICF4WPTjtY890+Q3wVpnJeAhQS4I6WTnGLJu5fXwd3TBy5QQGPDPHAvX8Jh/2rIqeEUYjflLhzlPug6yZp/OvCJ4ga1dSyWZq9s0NNgUcniBh2A/2HsU7nCBkw3+UfJ7PBBDt3qTIOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676399; c=relaxed/simple;
	bh=7jlrRj4kXPzN3gZjrQ6Cust2gbuDWKwrYdd0gLjRSjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ezh/xsI4jJNr8CWCoC7WpvgXNeVedVYg0NZd6OKOm7PE7pUiky+tYl8Ac7FKvR6ZB3L3TX7i8Q7X2ePpiLQv9CMgbe0jX9olumS55m8pPzc0DktiQQ6D903ptBO2O+xcIrX/Iq//vhgRLQujIGHpJ2710jVZf26m0ptKn4tfzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grpfIMos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A621C581B7;
	Mon, 26 Aug 2024 12:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724676398;
	bh=7jlrRj4kXPzN3gZjrQ6Cust2gbuDWKwrYdd0gLjRSjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=grpfIMost5Zj4NU3cY1DoXAukCIX5s4aDblfEEmcMo2gV+D0unW5/Hfr+OuWTXVAM
	 GlWVEjO8p5qjXljy58qBRrKrj0ZVNmAUt7uwOj9EARdv2WTwdLwVLnGtWRgkOF1V7I
	 IZf+ggsLs3+SBftDeLbHvo6fPHUOl/BleVsqg+XUS5kQ6F0pqvX0l2tJwaJPXTceXX
	 73kd3GBTscl+cyj2vDKYCMPBdE5QviCeD8sNe46PL9BM3sPYTg9hOh0dIrB6w6QZqo
	 J2qQwiLrBpAKba2J9UQeSkFrKINfPphedLF1uFmiIrO5vXVOUdrPE1IA2AcFURWSM7
	 foM/9Cu5yEgfw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 26 Aug 2024 08:46:11 -0400
Subject: [PATCH v2 1/7] nfsd: add pragma public to delegated timestamp
 types
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-delstid-v2-1-e8ab5c0e39cc@kernel.org>
References: <20240826-delstid-v2-0-e8ab5c0e39cc@kernel.org>
In-Reply-To: <20240826-delstid-v2-0-e8ab5c0e39cc@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3577; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7jlrRj4kXPzN3gZjrQ6Cust2gbuDWKwrYdd0gLjRSjQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmzHkq5SiPS5mfhgWmxd7cOMuuf1SQbfCc16Lo0
 mpJSYVeTKGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsx5KgAKCRAADmhBGVaC
 FbFOD/9uagwI3lUrGKeYqJcGSp6ls/zpL4e/z5sWK9vOe9+O43vv81HwrtnS1ho6sIXWn1VMVMi
 kMN6PAylkYhkuxb8o2UvMqNmSGtNkAuqthJIKb0K4X3kN8TZ452xeZktlFnEH3171jyz7VAqW5T
 iV9l1/FO95U9wGbuAgRuCFmiZVIhgrmsRV3u7V7fPQMfPDsx+geZZHTzVdqIS8oVqrVL30oDwLl
 z5Q8uFC4t/dCPrkY3IQwmYLxtkcb90hJ4JgqOzau1A/dE5PZh+PAGi6yxWrjxMA9gZlpgHr+8FE
 4kAE+Jlx8bWRA3l2D1XEm3R0JuplGwcagcodFUWJRWxpF1BjZ4nkm3bwrwclm9WzE4d8auqHWHj
 P5UGOyTF+6Vl/ziU9cO/odqrv4PUXCwVzZkyeEu/hUWU2uaB1cw5vjqaGyqIqTdDZE9GH38hdA+
 8e9dfzI+uQZGzKWvy4ZRxAnlPG023JTTDRpoed4LklrCGcWXgXFDMqWs9cWIF4Ajs+FeQFXYomI
 jUSmBYDsqzRXBSHoCr4CUKEdEOp1ZTTa46S2IfKYHI4Z/eEBNf0UIXERAjnpISTQA6MsTicSSl6
 aIW2zh4OB8UxGJqH7ycm0gd5MgJxBuFNYSD4Bf4pPWjEXllzS5IXSvxNOWYbbF0gJVYFc9EAqfm
 S9Oktj2Z4bLm+Eg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In a later patch we're going to need the ability to decode the delegated
timestamp fields.  Make the decoders available for the delgated
timestamp types, and regenerate the source and header files.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4_1.x      |  2 ++
 fs/nfsd/nfs4xdr_gen.c | 10 +++++-----
 fs/nfsd/nfs4xdr_gen.h |  8 +++++++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4_1.x b/fs/nfsd/nfs4_1.x
index d2fde450de5e..fc37d1ecba0f 100644
--- a/fs/nfsd/nfs4_1.x
+++ b/fs/nfsd/nfs4_1.x
@@ -150,6 +150,8 @@ const OPEN4_RESULT_NO_OPEN_STATEID = 0x00000010;
  */
 typedef nfstime4        fattr4_time_deleg_access;
 typedef nfstime4        fattr4_time_deleg_modify;
+pragma public 		fattr4_time_deleg_access;
+pragma public		fattr4_time_deleg_modify;
 
 
 %/*
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
index c22372144a57..0816cfa530e0 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Generated by xdrgen. Manual edits will be lost.
-// XDR specification modification time: Fri Aug 23 17:28:09 2024
+// XDR specification modification time: Fri Aug 23 18:57:46 2024
 
 #include "nfs4xdr_gen.h"
 
@@ -120,13 +120,13 @@ xdrgen_decode_fattr4_open_arguments(struct xdr_stream *xdr, fattr4_open_argument
 	return xdrgen_decode_open_arguments4(xdr, ptr);
 };
 
-static bool __maybe_unused
+bool
 xdrgen_decode_fattr4_time_deleg_access(struct xdr_stream *xdr, fattr4_time_deleg_access *ptr)
 {
 	return xdrgen_decode_nfstime4(xdr, ptr);
 };
 
-static bool __maybe_unused
+bool
 xdrgen_decode_fattr4_time_deleg_modify(struct xdr_stream *xdr, fattr4_time_deleg_modify *ptr)
 {
 	return xdrgen_decode_nfstime4(xdr, ptr);
@@ -223,13 +223,13 @@ xdrgen_encode_fattr4_open_arguments(struct xdr_stream *xdr, const fattr4_open_ar
 	return xdrgen_encode_open_arguments4(xdr, value);
 };
 
-static bool __maybe_unused
+bool
 xdrgen_encode_fattr4_time_deleg_access(struct xdr_stream *xdr, const fattr4_time_deleg_access *value)
 {
 	return xdrgen_encode_nfstime4(xdr, value);
 };
 
-static bool __maybe_unused
+bool
 xdrgen_encode_fattr4_time_deleg_modify(struct xdr_stream *xdr, const fattr4_time_deleg_modify *value)
 {
 	return xdrgen_encode_nfstime4(xdr, value);
diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
index 48da108a2427..e79935f973ff 100644
--- a/fs/nfsd/nfs4xdr_gen.h
+++ b/fs/nfsd/nfs4xdr_gen.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
-/* XDR specification modification time: Fri Aug 23 17:28:09 2024 */
+/* XDR specification modification time: Fri Aug 23 18:57:46 2024 */
 
 #ifndef _LINUX_NFS4_XDRGEN_H
 #define _LINUX_NFS4_XDRGEN_H
@@ -88,8 +88,14 @@ enum { OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 0x200000 };
 enum { OPEN4_RESULT_NO_OPEN_STATEID = 0x00000010 };
 
 typedef struct nfstime4 fattr4_time_deleg_access;
+bool xdrgen_decode_fattr4_time_deleg_access(struct xdr_stream *xdr, fattr4_time_deleg_access *ptr);
+bool xdrgen_encode_fattr4_time_deleg_access(struct xdr_stream *xdr, const fattr4_time_deleg_access *value);
+
 
 typedef struct nfstime4 fattr4_time_deleg_modify;
+bool xdrgen_decode_fattr4_time_deleg_modify(struct xdr_stream *xdr, fattr4_time_deleg_modify *ptr);
+bool xdrgen_encode_fattr4_time_deleg_modify(struct xdr_stream *xdr, const fattr4_time_deleg_modify *value);
+
 
 enum { FATTR4_TIME_DELEG_ACCESS = 84 };
 

-- 
2.46.0


