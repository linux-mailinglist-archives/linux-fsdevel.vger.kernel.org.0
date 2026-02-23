Return-Path: <linux-fsdevel+bounces-78077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLh4HungnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:21:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1350C17F338
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8017A312220D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C81437F72F;
	Mon, 23 Feb 2026 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vM8ze56z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8222749CF;
	Mon, 23 Feb 2026 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888591; cv=none; b=hpqRB8c59z/rFRz+OcpwItB3+CUB12tZeoLDYlw9u+cbHs2X8UwTTKN3YyzyTBpIZXuc4oEIF2zI9pa8LMo7tr2qJrlgcGWxYRM6iJuhnO8xSBOIeQM/OFXUBF9SVMEI1VCcO80lfzg2538xBF3sR8HY4mNH37b3w4Mb+l9qDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888591; c=relaxed/simple;
	bh=2HH6h4ijPSQ/x5iG/HFfKe3y5yxOjG3M+U3Mk0T4Pic=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5y0UYU2vQufRyQFi3v4WKg87dqtxFKMJJQcHzwvNsvXUHjyKSMysQKF7iskEk5Pv8I2vOWMY95ZEgWEP3j4HcNvDQsQAcVyowZaLb2qZNZs71fO9jzjGdkXOEomat/VUDavz0IRVkTbRHOAVMi84ht1gWKIPHeVMDpLQeTHKAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vM8ze56z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78ACC116C6;
	Mon, 23 Feb 2026 23:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888590;
	bh=2HH6h4ijPSQ/x5iG/HFfKe3y5yxOjG3M+U3Mk0T4Pic=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=vM8ze56z/a71aaMHlqxIUoDYTBXK8S+bA0sZ0dZ2fcnS3RNb+4Fum2whF7AYm4qyA
	 72rm+8lH6SD4+M8iCcdnKXdVqtYFXq0AWjqYAzFd/VPG1fIhfkYtE3qL0DBrqylhfZ
	 Hx4SYYm/7PeWL3jvm9AfL6hfgcRfpo9F8VMdMJLjHBnAZlh48F7PKvYMx527ORpZcZ
	 ZMgTBp9N2RujZ/vjsFqjf9ss/VK/rYE5dRVlJQdJbVg3tdZceGuv9gOdkCBKlJSobF
	 Rps0XrxLuXBXSsagIcM8AEWmNd6YW2OetJH4W0p0N9bdhDKmar/JjFfYUHDYhEoev0
	 9D4LBqQALfu+g==
Date: Mon, 23 Feb 2026 15:16:30 -0800
Subject: [PATCH 30/33] fuse_trace: support atomic writes with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734887.3935739.16330595827877111632.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78077-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1350C17F338
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index d3352e75fa6bdf..de7d483d4b0f34 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -330,6 +330,7 @@ TRACE_DEFINE_ENUM(FUSE_I_BTIME);
 TRACE_DEFINE_ENUM(FUSE_I_CACHE_IO_MODE);
 TRACE_DEFINE_ENUM(FUSE_I_EXCLUSIVE);
 TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
+TRACE_DEFINE_ENUM(FUSE_I_ATOMIC);
 
 #define FUSE_IFLAG_STRINGS \
 	{ 1 << FUSE_I_ADVISE_RDPLUS,		"advise_rdplus" }, \
@@ -339,7 +340,8 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
 	{ 1 << FUSE_I_BTIME,			"btime" }, \
 	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
 	{ 1 << FUSE_I_EXCLUSIVE,		"excl" }, \
-	{ 1 << FUSE_I_IOMAP,			"iomap" }
+	{ 1 << FUSE_I_IOMAP,			"iomap" }, \
+	{ 1 << FUSE_I_ATOMIC,			"atomic" }
 
 #define IOMAP_IOEND_STRINGS \
 	{ IOMAP_IOEND_SHARED,			"shared" }, \


