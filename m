Return-Path: <linux-fsdevel+bounces-78206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP4VOrTnnGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:50:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99993180044
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E3AF301B17C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3C63803DF;
	Mon, 23 Feb 2026 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWhH4GH5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182C537FF7F;
	Mon, 23 Feb 2026 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890594; cv=none; b=FvFH7Lb/fUia2+7ZReZJmH9sRozUYf5dmgbxF4SqfxBBku49CzwM97zdW4/MwUW5rYRT3LG1MW9ppaefPQHEtPY4oXy+JKSke3IjonLnS0aldvggWLjb2hdlG3LioKSVUwrRUsiuADc3yllc6yVwJ3Zw59/iuElHax6wjRYuSK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890594; c=relaxed/simple;
	bh=6oBPg90qRJmR05SVdf2hKZj/+CiaMI8l9PPxvKRrrFE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLhGCRB4LqECAP/L0D2j64CuEsP8kSvOYt4VB4yluanO2pyCeH0ZtWf09p4boGCzxxtLGWFLH8I3AuBU+AtqcHhnFHKWGmHe2CvyxtjTe/KzDwrr/4NKOuaA4bgAQ0rFIEhZp6rltqt5gisSqjIdchHOPSoyuVGVFRFaamoN0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWhH4GH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9159FC116C6;
	Mon, 23 Feb 2026 23:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890593;
	bh=6oBPg90qRJmR05SVdf2hKZj/+CiaMI8l9PPxvKRrrFE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tWhH4GH5ZVbL5tJn0qzxwaUKOLKXB1M9YVBdYlP8rBLnYsPJKG2Sn4TJZF0ZKo5SU
	 tyhYm/lFbTM3zTE0UHcoTsvtWusvVGmqkfvqw5Nh4L3HWz5w9Cakjm+WXp8+8H7ALU
	 1bRXGLuJW/7iDwanV6Ayt6H3DA6y7ihTJ/R18N6uovqKbzM69Ep+nd87MwVaVgOum0
	 njq+fAIfVa2XcaFwf+zArqVoEXng1rvW9hpOMgnbFhU1gZN7A8nBZ/nNr+61MWgu80
	 Z51LU2SEb3NflycfVo5aw5x5x8H5GjDGYL8vqA+zVB9TcXLGyPtCAu+72bgxJW4SnO
	 EN0+CcIVubIqQ==
Date: Mon, 23 Feb 2026 15:49:53 -0800
Subject: [PATCH 2/3] fuse4fs: wire up caching examples to fuse iomap bpf
 program
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev, john@groves.net
Message-ID: <177188746507.3945469.2523498079754039193.stgit@frogsfrogsfrogs>
In-Reply-To: <177188746460.3945469.14760426500960341844.stgit@frogsfrogsfrogs>
References: <177188746460.3945469.14760426500960341844.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev,groves.net];
	TAGGED_FROM(0.00)[bounces-78206-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 99993180044
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Continue our demonstration of fuse iomap bpf by enabling the test
program to update the iomap cache.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   10 ++++++++++
 1 file changed, 10 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index b5deed0ef767e9..b3c5d571d52448 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -7830,6 +7830,9 @@ FUSE_IOMAP_BEGIN_BPF_FUNC(bogus_iomap_begin_bpf)\n\
 {\n\
 	const uint32_t dev = %u;\n\
 	const uint32_t blocksize = %u;\n\
+\n\
+	bpf_printk(\"ino %%llu pos %%llu\\n\",\n\
+		   fi->nodeid,  pos);\n\
 \n\
 	/*\n\
 	 * Create an alternating pattern of written and unwritten mappings\n\
@@ -7837,6 +7840,11 @@ FUSE_IOMAP_BEGIN_BPF_FUNC(bogus_iomap_begin_bpf)\n\
 	 * run this in production!\n\
 	 */\n\
 	if ((opflags & FUSE_IOMAP_OP_REPORT) && pos <= (16 * blocksize)) {\n\
+		struct fuse_range fubar = {\n\
+			.offset = 325 * blocksize,\n\
+			.length = 37 * blocksize,\n\
+		};\n\
+\n\
 		outarg->read.offset = pos;\n\
 		outarg->read.length = blocksize;\n\
 		outarg->read.type = ((pos / blocksize) %% 2) + FUSE_IOMAP_TYPE_MAPPED;\n\
@@ -7844,6 +7852,8 @@ FUSE_IOMAP_BEGIN_BPF_FUNC(bogus_iomap_begin_bpf)\n\
 		outarg->read.addr = (99 * blocksize) + pos;\n\
 \n\
 		fuse_iomap_begin_pure_overwrite(outarg);\n\
+		fuse_bpf_iomap_inval_mappings(fi, &fubar, NULL);\n\
+		fuse_bpf_iomap_upsert_mappings(fi, &outarg->read, NULL);\n\
 		return FIB_HANDLED;\n\
 	}\n\
 \n\


