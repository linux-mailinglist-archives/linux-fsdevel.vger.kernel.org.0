Return-Path: <linux-fsdevel+bounces-27837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D41E964682
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5F4285163
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283881B1506;
	Thu, 29 Aug 2024 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8kgqg1/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1451B14EF;
	Thu, 29 Aug 2024 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938020; cv=none; b=k60/qYLGy68g6sq5p8l7NZ1q6XwyhaJItv0JXPoqOtmeQIPIV423s65MknvB5y8Q+9hF7OkS8TaJi3SF+bGsNDlFGvTLt08GPLM4vBiTKFY5QxX/i/cznfbry06zgBMppHQMXBHLeTN6VDKTz1EWw/xMk26BmJql7ACzh0Yc4PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938020; c=relaxed/simple;
	bh=GQfTyF/AcARwsbzaU/KY0v6hOHNiP7v1dRbh+dwXikA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qnjJmvuw47TUziwJFe+xgrAtFKXW6I2QE09A3vN4OYyusK44oDkotfhXHRHnyt3pNKbrHrejZcrCbEjIibqKBONzQ1e4Jb9OJUvIwVVqcQ2egN4kKZaNsTLPBCxz1yIAgPzidb7u7I2izYo3lxwvaWRWo+VM70VQddwosicb2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8kgqg1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CB4C4CEC5;
	Thu, 29 Aug 2024 13:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938020;
	bh=GQfTyF/AcARwsbzaU/KY0v6hOHNiP7v1dRbh+dwXikA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a8kgqg1/tnDu/gVg4Axwb68NgOqMOCgZ0lPQ2cfB9QfW4finULuz7AArTVF69zplu
	 FNKm/vTHJeV9XgdfDzo52xiZiOvg46kJIwTeKKmGFrj+SHRMaZpn8IeLu/gdQuZuiD
	 Hr2FbN9sloZu5WvEEA5M7APSRVPEOb0Uttu7whIsJVpQ845385V0AxDUQhwbYBa0xv
	 wjaLXVzEHPNat8Cs9uKyJBoHVjBhZMFniRIlTICwdkCcMwJVA2IEOEFntAB7PjMtNf
	 lNmNztC7snKpKRNK1DJSogI9ysSLeYJLlW7YlTQNUWVzmTjXAGC8vu1USyHMpNlyhN
	 po2ncTzagvRVg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Aug 2024 09:26:44 -0400
Subject: [PATCH v3 06/13] nfsd: add pragma public to delegated timestamp
 types
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-delstid-v3-6-271c60806c5d@kernel.org>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
In-Reply-To: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
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
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3577; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GQfTyF/AcARwsbzaU/KY0v6hOHNiP7v1dRbh+dwXikA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm0HcX4rCy9GHuSvDRZgq4W6AGu8yb9mN8W0Yz2
 g8UBSXdM0KJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtB3FwAKCRAADmhBGVaC
 FY7yEACvt3wKQELfcV82pU/7XcmpfkMIXpUi8FnJIFedhZGDVOws3OfqupeFuppwe/1yNTj5ccI
 omTmY5o24Ki+yTatvNJ8oaUs9lyy6R5F2Xu+PV1dMNeBW3+/107pPMglaaQ+pFxRAdEvrZAPGLr
 cFqddPmomMljAcQhUOQbYtDUbjmdOUZuaeiCJqxkmsSqcRTPT1zkgwc17OFeh1VqXXbDxl0K+kd
 RAn944dPSfqFO6DC6w0hXK417sx/5pXglf7KsoeN0UK+bThgqT3AEF3nxzEwqEzAyYfIXk+oyTg
 3PnrPJmZUxl8ZhLzx77zsdnAvrbsxJHRNhFlv7fBg7EEPmQQ0/pS/3RcwC57T1BM1uST/HAo/Lu
 GZuqvmycnItH4GJeO+XYf8xGqx6MY2AQA676K7+iPMjKSt798H21Xmb/+U6SjWmHCf82WT6+IsP
 2O3BgrO34mdxziFyswOIVBNqUIRwxS9VNF0wiDH8SccamVaf4VDGjAwzr2lRbSR388P2Yt/A2CW
 y/2kMmCKL+gELnfBPtIIrlwH36ldw36+zNhco++RbQbe4gDxxZ8UkJP+nghKHPSHIfXRWxxDssr
 gvO1fpIExnlzXusGJKUSuG4Yf+and4crW8vuj1wBXU3Nkz0vBjS/xudEtoIQr+Vftx5m+mEOQ3E
 CNRtiY2Z1lDpeGw==
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
index 2503f58f2f47..6833d0ad35a8 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Generated by xdrgen. Manual edits will be lost.
-// XDR specification modification time: Tue Aug 27 12:10:19 2024
+// XDR specification modification time: Wed Aug 28 09:57:28 2024
 
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
index edcc052626de..5465db4fb32b 100644
--- a/fs/nfsd/nfs4xdr_gen.h
+++ b/fs/nfsd/nfs4xdr_gen.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
-/* XDR specification modification time: Tue Aug 27 12:10:19 2024 */
+/* XDR specification modification time: Wed Aug 28 09:57:28 2024 */
 
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


