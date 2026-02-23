Return-Path: <linux-fsdevel+bounces-78134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKp8BLjjnGn4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:33:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B24A217F8E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41FB530A02E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3550637F8C6;
	Mon, 23 Feb 2026 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJlOSQn0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B798037F74F;
	Mon, 23 Feb 2026 23:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889481; cv=none; b=XKO7s4OF0Mko2q9cEiEJzPJA+8T8UTstGqJ6hZRMxKL0zeGZMI9EMgL7i1I1/DX8HOUGpz+8AECvNfLB6KQIIfA9oi8dByaOLuIiMHcitSMiNZam8rwtMfoIaIqViRiB2olrjrVDOiXL2jdo1y/VR7YGlh5GOCJlWISh4xsiIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889481; c=relaxed/simple;
	bh=sSiXobMCnGGwfJrDuncCwpBE+8M8zwrABfSKWQv4gWU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3+hBXpOJo9h57wt4vWduUtoYTWoe0ydAPChTUIafyZE0EBtWLuO8CSqSi3X5vHO4IuNJ83o2yW2Yx8VOu/2XkpRPWx0Cw0hTGfhrdGKR2OaD3lmVpQ9AaGgSqiPkBxefPu1tAZ0wOONoOATiNZbpW8Y9KeSj+MvIc+PdwZAhB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJlOSQn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C61C116C6;
	Mon, 23 Feb 2026 23:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889481;
	bh=sSiXobMCnGGwfJrDuncCwpBE+8M8zwrABfSKWQv4gWU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SJlOSQn0lyOzjtNPSwCkmUxVeZNQvg/+dD6SCAQvdYGGjEeCn64SYmPC6LY2OrjHB
	 hQG3y+eVSSqSEqcrxpS87oLPSibst4x7x09L0zlQ47Nv0ojxZEtMO5EqWPKCGbKsLS
	 xoYk1vMjsTD+WJtDGshpYtVJSeTNB/MG2yEAV5pV1HbdRwj/reSYFjtsyNwf32Cixr
	 LgUELOVnTtny7iFwk0utFf2mpB9zgcGx3VudO0jaxTuikjsX3j8hk/1tjabzX/YwAt
	 IKvlWRnR5LHVhk156+gxKTqMGcGT1x3+rX60xkZAEhu3CMfRUWVLkN2QAe4ksSaxVB
	 nW039kh1l94IQ==
Date: Mon, 23 Feb 2026 15:31:21 -0800
Subject: [PATCH 23/25] libfuse: add swapfile support for iomap files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740345.3940670.10536037421305895187.stgit@frogsfrogsfrogs>
In-Reply-To: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
References: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78134-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B24A217F8E3
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add flags for swapfile activation and deactivation.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    5 +++++
 1 file changed, 5 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index a42d70f79d57e1..a8aec81ec123a2 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1190,6 +1190,9 @@ int fuse_convert_to_conn_want_ext(struct fuse_conn_info *conn);
 #define FUSE_IOMAP_OP_ATOMIC		(1U << 9)
 #define FUSE_IOMAP_OP_DONTCACHE		(1U << 10)
 
+/* swapfile config operation */
+#define FUSE_IOMAP_OP_SWAPFILE		(1U << 30)
+
 /* pagecache writeback operation */
 #define FUSE_IOMAP_OP_WRITEBACK		(1U << 31)
 
@@ -1229,6 +1232,8 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 #define FUSE_IOMAP_IOEND_APPEND		(1U << 4)
 /* is pagecache writeback */
 #define FUSE_IOMAP_IOEND_WRITEBACK	(1U << 5)
+/* swapfile deactivation */
+#define FUSE_IOMAP_IOEND_SWAPOFF	(1U << 6)
 
 /* enable fsdax */
 #define FUSE_IFLAG_DAX			(1U << 0)


