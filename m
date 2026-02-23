Return-Path: <linux-fsdevel+bounces-78065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPSDHUvfnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:14:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEBD17F0C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70BF430774E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375B137E316;
	Mon, 23 Feb 2026 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An0eUF0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A4437AA81;
	Mon, 23 Feb 2026 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888403; cv=none; b=rheX65glK2JYNP1KvOEm8ca0PQtRrXdAGlpETX3ygF4Jp7GUwGRRvX69sYbk2WaCDnaxHqXf9bq3H8rG7YW8HhAQTVArPB0KCpp2BFrVMkt1i/JE/GuSEbrtk+oLQa1gGqLdp/VXr3ShpX1RDcYueAmc8ZeyQH0uU40pF8sfFk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888403; c=relaxed/simple;
	bh=1OQrNc99OIAJ/y7zD6f+nLVZJ93UhPz9lCQwGOWaYSM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMLxUw/LJjVkKuCbeEK0Xf0oNziFqUp6l1bwLi2RuOySmGUyfABghJU4ewWUi7WquuOgU8ew601+vGYWncwBs7awqcZS5Le5tjKgIw/Q/HVbfGhxiUFdiT4Oo2tJGiB4fzrrePZEdgnsRbaGRaAoeg1gRqYDIK5JVoNxkTyXbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An0eUF0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B63C116C6;
	Mon, 23 Feb 2026 23:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888403;
	bh=1OQrNc99OIAJ/y7zD6f+nLVZJ93UhPz9lCQwGOWaYSM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=An0eUF0jt50MNFfSJ/eigzKun4SFU+yZOBu9OzDSPRjQpgtB/XGdfLHaQUn1ICTzD
	 eiQYSKacRn75xTRHn0dGPmBAGwlD71t8U/S9qTBfpsMW/DKxQRVxm/enH+bNqolEdv
	 RUySY6g71Ssc+wyXyu0EEaTVmZVk2W62pc94os/WgXYQ+zFD1vcZdtO4W5TWSdWkEk
	 4X72iNv+Mp0xqtm9TAYKVT2q8YJw6Pw4RbCg4JF/QhbEhZticsmAL+edhVZAYhp1tt
	 KbcsLEtI+2Kjlg8B9LCTQzCVFxlhSPKYlkgFkHTxL+db5FBS0IhYBT2h3UOCOwZYvH
	 qtFr+c+p4Ywzg==
Date: Mon, 23 Feb 2026 15:13:22 -0800
Subject: [PATCH 18/33] fuse: use an unrestricted backing device with iomap
 pagecache io
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734631.3935739.15389478225545145527.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78065-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECEBD17F0C1
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

With iomap support turned on for the pagecache, the kernel issues
writeback to directly to block devices and we no longer have to push all
those pages through the fuse device to userspace.  Therefore, we don't
need the tight dirty limits (~1M) that are used for regular fuse.  This
dramatically increases the performance of fuse's pagecache IO.

A reviewer of this patch asked why we reset s_bdi to the noop bdi and
call super_setup_bdi_name a second time, instead of simply clearing
STRICTLIMIT and resetting the bdi max ratio.

That's sufficient to undo the effects of fuse_bdi_init, yes.  However
the BDI gets created with the name "$major:$minor{-fuseblk}" and there
are "management" scripts that try to tweak fuse BDIs for better
performance.

I don't want some dumb script to mismanage a fuse-iomap filesystem
because it can't tell the difference, so I create a new bdi with the
name "$major:$minor.iomap" to make it obvious.  But super_setup_bdi_name
gets cranky if s_bdi isn't set to noop and we don't want to fail a mount
here due to ENOMEM so ... I implemented this weird switcheroo code.

Also, userspace scripts such as udev rules can modify the bdi as soon as
it appears in sysfs, so we can't run the fuse_bdi_init code in reverse
and expect that will undo everything.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)


diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index b7c459acd0c93b..5690e5d079807b 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -721,6 +721,27 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
 void fuse_iomap_mount(struct fuse_mount *fm)
 {
 	struct fuse_conn *fc = fm->fc;
+	struct super_block *sb = fm->sb;
+	struct backing_dev_info *old_bdi = sb->s_bdi;
+	char *suffix = sb->s_bdev ? "-fuseblk" : "-fuse";
+	int res;
+
+	/*
+	 * sb->s_bdi points to the initial private bdi.  However, we want to
+	 * redirect it to a new private bdi with default dirty and readahead
+	 * settings because iomap writeback won't be pushing a ton of dirty
+	 * data through the fuse device.  If this fails we fall back to the
+	 * initial fuse bdi.
+	 */
+	sb->s_bdi = &noop_backing_dev_info;
+	res = super_setup_bdi_name(sb, "%u:%u%s.iomap", MAJOR(fc->dev),
+				   MINOR(fc->dev), suffix);
+	if (res) {
+		sb->s_bdi = old_bdi;
+	} else {
+		bdi_unregister(old_bdi);
+		bdi_put(old_bdi);
+	}
 
 	/*
 	 * Enable syncfs for iomap fuse servers so that we can send a final


