Return-Path: <linux-fsdevel+bounces-78207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IneLYTonGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:53:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BD418012D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAAA231C1A89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224F43803C9;
	Mon, 23 Feb 2026 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFMC7/j8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3EA37D132;
	Mon, 23 Feb 2026 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890609; cv=none; b=iTguyZsts2yAXwxOYX2WqoACiYOk3d4L8mNrWZkVp8FD5OEN3R5A9mq3HmcqjR1PZKNe/iinWnu+9aJZv3vOZUx6S84RyzATVw3uqne038NiRUml2xnbTQWJoujVuwKdpyqB9cJm7a1EP9osNrq9yCgjXnjl5xoQmCm9i9tNEK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890609; c=relaxed/simple;
	bh=YwXRuo+JbzU+DmUOFRwkAESDTtzoc7fPWFdKp6OyAC8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbSoN24zXgRoxsRGBZNPUEtn5Blp4ZeIUYvhkL+0HYQBjwjTjrtxkkD3msDakmVQNHeeTZHMtOvAhJ4s25kNULo+dOpEiZVSxVrhuptXwBePzLe+vFYaWql+Ahoh923yQO0/eBSqfUb2Q4H8ig/zAbboREY+L7vmLDVrxHxlBm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFMC7/j8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A86C2BCAF;
	Mon, 23 Feb 2026 23:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890609;
	bh=YwXRuo+JbzU+DmUOFRwkAESDTtzoc7fPWFdKp6OyAC8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=uFMC7/j8ZLOjWIYGfpsDwAlKr978EZpYAhS8cmwI3XkfX+JWOWcQuCzVDtfGhyr9A
	 tUWr5faYWIgjtQsuD5WnpdIXFPA4ip5nSdYRs982QlpaaTmsaWG1WuvR9kDP/ccpi9
	 7b1+eozTxK4uvvz7eaodjy2MyJdLUSbGcawZxOJGhSStlljHES4rAAB7Dt3Y7pipe0
	 XUhyz3GEg00anguEMlZyF63YbNz8Zrj+aXBUSI6083Jd/wl8JZqhtivonxHBVKf1EO
	 TsHdYADzms8KaHsa0XxLj+bom39/j5w+JlZNnd5kXUzdt95EBFfEq8CaFv+7HRwtTF
	 IC8gFjOO0kUmA==
Date: Mon, 23 Feb 2026 15:50:08 -0800
Subject: [PATCH 3/3] fuse4fs: adjust test bpf program to deal with opaque
 inodes
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev, john@groves.net
Message-ID: <177188746525.3945469.7811087808723395803.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev,groves.net];
	TAGGED_FROM(0.00)[bounces-78207-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29BD418012D
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Adjust the test program to deal with fuse_bpf_inode.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index b3c5d571d52448..09ffd93c72724e 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -7832,7 +7832,7 @@ FUSE_IOMAP_BEGIN_BPF_FUNC(bogus_iomap_begin_bpf)\n\
 	const uint32_t blocksize = %u;\n\
 \n\
 	bpf_printk(\"ino %%llu pos %%llu\\n\",\n\
-		   fi->nodeid,  pos);\n\
+		   fuse_bpf_inode_nodeid(fbi),  pos);\n\
 \n\
 	/*\n\
 	 * Create an alternating pattern of written and unwritten mappings\n\
@@ -7852,8 +7852,8 @@ FUSE_IOMAP_BEGIN_BPF_FUNC(bogus_iomap_begin_bpf)\n\
 		outarg->read.addr = (99 * blocksize) + pos;\n\
 \n\
 		fuse_iomap_begin_pure_overwrite(outarg);\n\
-		fuse_bpf_iomap_inval_mappings(fi, &fubar, NULL);\n\
-		fuse_bpf_iomap_upsert_mappings(fi, &outarg->read, NULL);\n\
+		fuse_bpf_iomap_inval_mappings(fbi, &fubar, NULL);\n\
+		fuse_bpf_iomap_upsert_mappings(fbi, &outarg->read, NULL);\n\
 		return FIB_HANDLED;\n\
 	}\n\
 \n\


