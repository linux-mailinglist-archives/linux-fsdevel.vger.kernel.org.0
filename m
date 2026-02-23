Return-Path: <linux-fsdevel+bounces-78040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xRsuIwjenGm4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:08:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C6217EE02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 272FA3094154
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD98A37E2ED;
	Mon, 23 Feb 2026 23:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sp55KZOr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570183783BB;
	Mon, 23 Feb 2026 23:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888011; cv=none; b=tu1azofdUZU3aea3iamQ2imQ1wQVOUzUyisNd6y51wHgdOkx3o2/LRRHANeA198cPQ3q2EQSXTNdoO8YvF84z3Ptn02DgKoQ/Rd9XtJN4PZEBgtrwzFJOHX57PTgb6FsheRa+lJlIft3PC9UChJiy7rw6lmec452B4kWKHaro18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888011; c=relaxed/simple;
	bh=u6JnsKUda8GUWSdVhmWn4CwU4D4A5ozj9w7tOM+yUMY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKd9pu6NQP9Ab7iXTZEpn9OgUSB6PUNtoOOoquzVuKY7AifRjtztUQNz0DCMRrxB6ilWymlN+OLOzjcCJdbPoQeBNyNYYm7oF2lSXrK2t6bqSuv/IqmUWaX5a4NjksOtxwZ3MXCfUSn+9tppy5URg5zLQvn1wptymQSdFDOASN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sp55KZOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C52C116C6;
	Mon, 23 Feb 2026 23:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888011;
	bh=u6JnsKUda8GUWSdVhmWn4CwU4D4A5ozj9w7tOM+yUMY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=sp55KZOrL9Xu99RZuCpWmqQo+wS5GhKAKdD/HsqBv/SYbZG7XeZvjDwVK0Wft+jMi
	 OPt7V7Uhf3IIvdZHLQzfuTQIiMjxJhlCUqsnXAaYNbzAjPX+F99lwkO4HoELCFGE7+
	 BxpTDTrFmoiBhGyqmCmlgYPgwtexh9x79aYh5gG3xFW8X5ZvhEGQO/HuMjxzaPaaN6
	 vdixXFIDpdfgdm0ll7ZEjNS9nWwoKtMyf+p1Vm+tH61zCxyFEyxtAaCZhfXw2kE9Di
	 Bw2ReMMCfzU+/2QTJbnyFfRYhxvTD67ZeY3j47qwRXdlflghvKeP/Ltc/J3d4qPyNJ
	 d9c1EqOfT4V1Q==
Date: Mon, 23 Feb 2026 15:06:50 -0800
Subject: [PATCH 2/5] fuse: quiet down complaints in fuse_conn_limit_write
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: stable@vger.kernel.org, joannelkoong@gmail.com, bpf@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs>
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78040-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 45C6217EE02
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

gcc 15 complains about an uninitialized variable val that is passed by
reference into fuse_conn_limit_write:

 control.c: In function ‘fuse_conn_congestion_threshold_write’:
 include/asm-generic/rwonce.h:55:37: warning: ‘val’ may be used uninitialized [-Wmaybe-uninitialized]
    55 |         *(volatile typeof(x) *)&(x) = (val);                            \
       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
 include/asm-generic/rwonce.h:61:9: note: in expansion of macro ‘__WRITE_ONCE’
    61 |         __WRITE_ONCE(x, val);                                           \
       |         ^~~~~~~~~~~~
 control.c:178:9: note: in expansion of macro ‘WRITE_ONCE’
   178 |         WRITE_ONCE(fc->congestion_threshold, val);
       |         ^~~~~~~~~~
 control.c:166:18: note: ‘val’ was declared here
   166 |         unsigned val;
       |                  ^~~

Unfortunately there's enough macro spew involved in kstrtoul_from_user
that I think gcc gives up on its analysis and sprays the above warning.
AFAICT it's not actually a bug, but we could just zero-initialize the
variable to enable using -Wmaybe-uninitialized to find real problems.

Previously we would use some weird uninitialized_var annotation to quiet
down the warnings, so clearly this code has been like this for quite
some time.

Cc: <stable@vger.kernel.org> # v5.9
Fixes: 3f649ab728cda8 ("treewide: Remove uninitialized_var() usage")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/control.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 140bd5730d9984..073c2d8e4dfc7c 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -121,7 +121,7 @@ static ssize_t fuse_conn_max_background_write(struct file *file,
 					      const char __user *buf,
 					      size_t count, loff_t *ppos)
 {
-	unsigned val;
+	unsigned val = 0;
 	ssize_t ret;
 
 	ret = fuse_conn_limit_write(file, buf, count, ppos, &val,
@@ -163,7 +163,7 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
 						    const char __user *buf,
 						    size_t count, loff_t *ppos)
 {
-	unsigned val;
+	unsigned val = 0;
 	struct fuse_conn *fc;
 	ssize_t ret;
 


