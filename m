Return-Path: <linux-fsdevel+bounces-78191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPIDC0jnnGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:48:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A43A417FF92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A82D1315E617
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D171D37FF71;
	Mon, 23 Feb 2026 23:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tk6JA0k8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F62C34CFBA;
	Mon, 23 Feb 2026 23:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890359; cv=none; b=SN9PJeBsCH3oFDaje+tNPJT9G5ORPMsOxOEjb8XHs1lB8ZCH0W7itXFBQYhCXQiw+cuyLrltIUxKq4NTPyREmRr3JwfwGZ/gLcSpfd0yW8xgrq7vizB7gzgtVi1dCFr3TQS0XdRkX94pi/24ySw1esxca/rHgMCHYfsmQrR4pnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890359; c=relaxed/simple;
	bh=znODzU+T4gUNljW+bwtTEYkh7twWz466Py2sWKLByTM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qd3dp5QjJUAsqLfcgOexiR42DJUTDk4KjDM2fAi1AlYFilF8Estx6K2MDQ+EdBfAWKM9gGPo1eoAuOwAsBs+l8kzKqElpv7FxX2gpP7YN0Q7ee9r62ucucEo4XL3U2VgKBft2kmnUVm4uqPqsbtYVspSog7yJyajHcpONj4zgdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tk6JA0k8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3504C19421;
	Mon, 23 Feb 2026 23:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890359;
	bh=znODzU+T4gUNljW+bwtTEYkh7twWz466Py2sWKLByTM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tk6JA0k8PQXj8pHu9G1lS0PGXIoPwicUc/26qLzcOW+4QTn86vmlQA1EbFrAtuwag
	 Kp3JQ0Eb2BAEHCWMuqmMKfBzp3yvtE2Asj+hnArpFChcgk1edfCeCNQoaGb946zbZe
	 vpl7wmMm+YvpmZyqq27fVmAa3RobbO/GEH7i2sPPwtxILvIc0l+XK3pXJK7SEjmDed
	 L+p73uDS+wj51JvRvDx8s31/62Q4RcsAA3TTEodHx4eAorJYlf6mLysG2XFBNh/ZhV
	 z+/lhMNbNxTlhyuygit9uX9kLjyUaTFZmX4TafB8+/sJIebSmeg2HQiGKdLgeC9Ify
	 KisvAugQ0QiPA==
Date: Mon, 23 Feb 2026 15:45:58 -0800
Subject: [PATCH 5/6] fuse2fs: increase inode cache size
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745782.3944626.10807132566808361429.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745668.3944626.16408108516155796668.stgit@frogsfrogsfrogs>
References: <177188745668.3944626.16408108516155796668.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78191-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A43A417FF92
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Increase the internal inode cache size.  Does this improve performance
any?

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |    4 ++++
 misc/fuse2fs.c    |    4 ++++
 2 files changed, 8 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index d91817f362674a..1a4ac0cd9a038f 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1686,6 +1686,10 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff)
 	if (err)
 		return translate_error(ff->fs, 0, err);
 
+	err = ext2fs_create_inode_cache(ff->fs, 1024);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
 	ff->fs->priv_data = ff;
 	ff->blocklog = u_log2(ff->fs->blocksize);
 	ff->blockmask = ff->fs->blocksize - 1;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 3d78a3967f7d9a..4d62b5d44279f9 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1514,6 +1514,10 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff)
 		log_printf(ff, "%s %s.\n", _("mounted filesystem"), uuid);
 	}
 
+	err = ext2fs_create_inode_cache(ff->fs, 1024);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
 	ff->fs->priv_data = ff;
 	ff->blocklog = u_log2(ff->fs->blocksize);
 	ff->blockmask = ff->fs->blocksize - 1;


