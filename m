Return-Path: <linux-fsdevel+bounces-74916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KWlEBw83cWn2fQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:29:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C325D3AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7138B8CA7C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F403DA7C3;
	Wed, 21 Jan 2026 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="K1vsSmZj";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="ZoF2WDNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859A3D2FF2
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026438; cv=none; b=EPid98JQNm/XK0qnZAKeNwy0qifI1YLmPZr1+XSBA8bVvYi56VJBj1trRX10KblpGwAoP9vaUeyKVlP+5iLMtnMQFDSEyG8HyU/+lq8ZXM9o6l2DOmYdAi36wKOueixmfR5OMIwwR9EG+NDWX1S8DVSdZPZlnIG3zFKarqRF5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026438; c=relaxed/simple;
	bh=MI2BmTqtZrNSQrlrrLbu/L5u8kVcj0qImD2nnPGSwwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBFZbKcTJd7Cw3YvNaS/z3QW617oDrcGIAfBJTMQ8Hyf6gzKfPWoEB+fE9n2muCXhwwW8Yr6HNmpVXqs09O7fZ8x9oTohtyXiDmTuU7smDCJykb1gT8my/B5RV6bJ4n3X9bUN9FPX6As/UQa1H0yTAtN3OxzNKcfPwO9AQePEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=K1vsSmZj reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=ZoF2WDNT; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769027336; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=T3TZwnO8y1oxOvrH2YQS/n2Bl9vhGxNTqyNbInimA3Q=; b=K1vsSmZjfCq7ZQuiCG+7cP9AxD
	hz8ePPBAFK8c+E3j8hl69X9vSKjOFMP6LEUlrmHf6PVJoowouOGDZ26+cCQyp5l/Z19ruvGvU2IiI
	6nprUzJmYzHuJczzCekYY+ys+rTMnCnoz6BwXMDzDtTTcCJEcKDz4hiFP1bKI/Qp4r01aKe4FDuc2
	ji3r07/czo5GWWzlcREnZd0RwCicRVHL9ZLDZtUTUSyXYLXXRuobmi+ZoU3pIopTt396fq0hlBr6l
	WsvV5KSOlALzU1cmbxibebsJOzUevJ8l9kNp8izpwaGOvSdotXcHAZp2WBwo2Fa1sut+/VVcCrMWV
	JYHd2u/g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769026436; h=from : subject
 : to : message-id : date;
 bh=T3TZwnO8y1oxOvrH2YQS/n2Bl9vhGxNTqyNbInimA3Q=;
 b=ZoF2WDNTzSZmstFOHMZNi6959UTtyUo4irLiWVoKTIU+jd+YTyJ0Y2Y/enN7JDKs4k3Lr
 wYAjXhhsQU9r16GzO1vZn7/SlKWq1LKyXOTELbKBEulocC5MltYRKKDmJhSypuQ96CdP3BS
 FakJk8KT8tVIFJQkFgtqC4DFmu5+Af/KrcpFIFxy/NsOoOpUq770N3vLPQqbwu9SjEXXoH7
 NJzPi7C/yWWWOWQthQfP6ceaiROYubwrxOMBPD8+eaxG894PLVArf6QS5RBtHBairnxVNEV
 RVroHJp3Y2pZ93vj9PDu8pAoUgVAKWI68T1Umv3Uvm7WQEbOuypslmgvLAmw==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vieaL-TRk28y-OL; Wed, 21 Jan 2026 20:13:49 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vieaL-4o5NDgrlA5K-l5yO; Wed, 21 Jan 2026 20:13:49 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 2/3] 9p: Introduce option for negative dentry cache
 retention time
Date: Wed, 21 Jan 2026 20:56:09 +0100
Message-ID: <7e38e7bd31674208ab2b0de909c0744feda2c03f.1769013622.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769013622.git.repk@triplefau.lt>
References: <cover.1769013622.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: SZVTXOyD9Efi.FsrBAOhWS51W.jVDplwpu3b4
Feedback-ID: 510616m:510616apGKSTK:510616szNUyQSrVu
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74916-lists,linux-fsdevel=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[triplefau.lt,quarantine];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,triplefau.lt:email,triplefau.lt:dkim,triplefau.lt:mid]
X-Rspamd-Queue-Id: 79C325D3AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for a new mount option in v9fs that allows users to specify
the duration for which negative dentries are retained in the cache. The
retention time can be set in milliseconds using the ndentrytmo option.

For the same consistency reasons, this option should only be used in
exclusive or read-only mount scenarios, aligning with the cache=loose
usage.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/v9fs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 1da7ab186478..f58a2718e412 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -39,7 +39,7 @@ enum {
 	 * source if we rejected it as EINVAL */
 	Opt_source,
 	/* Options that take integer arguments */
-	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
+	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid, Opt_ndentrytmo,
 	/* String options */
 	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
 	/* Options that take no arguments */
@@ -93,6 +93,7 @@ const struct fs_parameter_spec v9fs_param_spec[] = {
 	fsparam_string	("access",	Opt_access),
 	fsparam_flag	("posixacl",	Opt_posixacl),
 	fsparam_u32	("locktimeout",	Opt_locktimeout),
+	fsparam_s32	("ndentrytmo",	Opt_ndentrytmo),
 
 	/* client options */
 	fsparam_u32	("msize",	Opt_msize),
@@ -159,6 +160,8 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 			   from_kgid_munged(&init_user_ns, v9ses->dfltgid));
 	if (v9ses->afid != ~0)
 		seq_printf(m, ",afid=%u", v9ses->afid);
+	if (v9ses->ndentry_timeout != 0)
+		seq_printf(m, ",ndentrytmo=%d", v9ses->ndentry_timeout);
 	if (strcmp(v9ses->uname, V9FS_DEFUSER) != 0)
 		seq_printf(m, ",uname=%s", v9ses->uname);
 	if (strcmp(v9ses->aname, V9FS_DEFANAME) != 0)
@@ -337,6 +340,10 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		session_opts->session_lock_timeout = (long)result.uint_32 * HZ;
 		break;
 
+	case Opt_ndentrytmo:
+		session_opts->ndentry_timeout = result.int_32;
+		break;
+
 	/* Options for client */
 	case Opt_msize:
 		if (result.uint_32 < 4096) {
-- 
2.50.1


