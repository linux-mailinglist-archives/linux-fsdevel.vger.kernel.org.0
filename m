Return-Path: <linux-fsdevel+bounces-59722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7FAB3D4D5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 21:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B60517158A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 19:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB732741CB;
	Sun, 31 Aug 2025 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="cwYN70ab";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="bPesyFpu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e2i440.smtp2go.com (e2i440.smtp2go.com [103.2.141.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA261624C5
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Aug 2025 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756667888; cv=none; b=DtLbh5tRqYzHcIiEYbCpM/TQmbTLy4RTvv+5bP6eyYMFgZGGHcL1MhbBH5GkN8aQhXrs3Vx6CMWTkQsqF/r51e1A2uDp0bIDOqqY4HIRW0uKIeqTS6t5sS3TT0TkV5wLHz+Md4rmrMAZdkSifcLpv4z+ZdNyyM2tk/MixKSTxPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756667888; c=relaxed/simple;
	bh=DRcLIFuIOSuESQ2ofaXfG+0PDFNlbm73jo++sagk/94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2VC3Nb0bzjoiZ6Sxxgfgc3UMF1lrWigll4xNpD0WNIbiFvS5/22qebY8EzMzMyGQtxm9VE+fVtYILnUuWnOD+H6CprQwoQkoFEDN0nnAW4FtxmPtWKrSvFq0dDGdf1tKG6PXFnuuaNHfRC318bzZlmTXQ2g3tJdLJO4M4asMOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=cwYN70ab reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=bPesyFpu; arc=none smtp.client-ip=103.2.141.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1756668786; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=yB6pbMXYcls8l8+6f9uwrMKHsQgjD3KAY1Ts8L0/mj4=; b=cwYN70abbZlzKNH4mr5wJVZivC
	XEbIMKgX9fTFh83SCpo2ylLZ20t+9z8k3LFAepAx5x+MicFrxNpFXmwbov9G2dSIer+eMiDsq8YXa
	k5o+p59424jBa2tOQJTKsNH2fFy5puiAmyeMbSj84NLdBbasJhYsxCBUApgX8qq4TF2rVMFDXaTYa
	9JtyxDtDa0Jt64btzC2Uc2dGke94I4iVzg1yJ5mJJ+yl7Xor3HwFhSO8mt1QnnR5wChPP64J0a4ya
	9Zgq69JMRX3pKQDEE2soJNZ3bLbm12xNut1D0d8DeB+/KWsqsbHMGsUWGaB6HJtt+TKI+pqIUtA4m
	vBORKaZQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1756667886; h=from : subject
 : to : message-id : date;
 bh=yB6pbMXYcls8l8+6f9uwrMKHsQgjD3KAY1Ts8L0/mj4=;
 b=bPesyFpu9h+l8oEDBvFJsqhgjhc8rX1IM91f64kOKX6RWoo17cNn+VsWrArOQtTNupnzK
 yCRXfN7snybfqUw/byX68+dpVUncoIKon/x26pp/fhSwR1r48lHTVALq4fGN8yLexQlWuQo
 cFbseDdhK2S584rNpSLKj5jAXbfDLWVJmadJ4Kpzq8GjfLCo0g9xx1if5YX+RMQR95HC0C1
 BUcDbM+iIFKw/EXuGOPqgdkDNGiXxa4h9cwvPK5R1XLSqdMa2cY2fijzLVzRVeDywZUYwF4
 bVhQ4zGr2ENdAkvPjCvkGKtI2jE4ujRvEP7eu0ZmBfdYVeG6B5oFV25n9/7w==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYr-TRk4Kv-5d; Sun, 31 Aug 2025 19:17:57 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYq-AIkwcC8vNym-KDcR; Sun, 31 Aug 2025 19:17:56 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 2/5] 9p: Introduce option for negative dentry cache
 retention time
Date: Sun, 31 Aug 2025 21:03:40 +0200
Message-ID: <18f109c2d62d0529511957f3c2a492374d01e63d.1756635044.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756635044.git.repk@triplefau.lt>
References: <cover.1756635044.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: SBH53Bl8n7Sj.v8kk_TWuzQV8.6AnyTgG6GeS
Feedback-ID: 510616m:510616apGKSTK:510616sJVlOeeiTz
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Add support for a new mount option in v9fs that allows users to specify
the duration for which negative dentries are retained in the cache. The
retention time can be set in milliseconds using the ndentrytmo option.

For the same consistency reasons, this option should only be used in
exclusive or read-only mount scenarios, aligning with the cache=loose
usage.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/v9fs.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 422bd720d165..7c0c2201b151 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -34,7 +34,7 @@ struct kmem_cache *v9fs_inode_cache;
 
 enum {
 	/* Options that take integer arguments */
-	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
+	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid, Opt_ndentrytmo,
 	/* String options */
 	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
 	/* Options that take no arguments */
@@ -52,6 +52,7 @@ static const match_table_t tokens = {
 	{Opt_dfltuid, "dfltuid=%u"},
 	{Opt_dfltgid, "dfltgid=%u"},
 	{Opt_afid, "afid=%u"},
+	{Opt_ndentrytmo, "ndentrytmo=%d"},
 	{Opt_uname, "uname=%s"},
 	{Opt_remotename, "aname=%s"},
 	{Opt_nodevmap, "nodevmap"},
@@ -110,6 +111,8 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 			   from_kgid_munged(&init_user_ns, v9ses->dfltgid));
 	if (v9ses->afid != ~0)
 		seq_printf(m, ",afid=%u", v9ses->afid);
+	if (v9ses->ndentry_timeout != 0)
+		seq_printf(m, ",ndentrytmo=%d", v9ses->ndentry_timeout);
 	if (strcmp(v9ses->uname, V9FS_DEFUSER) != 0)
 		seq_printf(m, ",uname=%s", v9ses->uname);
 	if (strcmp(v9ses->aname, V9FS_DEFANAME) != 0)
@@ -251,6 +254,16 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 				v9ses->afid = option;
 			}
 			break;
+		case Opt_ndentrytmo:
+			r = match_int(&args[0], &option);
+			if (r < 0) {
+				p9_debug(P9_DEBUG_ERROR,
+					 "integer field, but no integer?\n");
+				ret = r;
+			} else {
+				v9ses->ndentry_timeout = option;
+			}
+			break;
 		case Opt_uname:
 			kfree(v9ses->uname);
 			v9ses->uname = match_strdup(&args[0]);
-- 
2.50.1


