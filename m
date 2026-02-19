Return-Path: <linux-fsdevel+bounces-77708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IExkIOARl2n7uAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 14:36:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAB615F213
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 14:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DD8A304A167
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 13:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E64733342E;
	Thu, 19 Feb 2026 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIf6SuXO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9AD2FD1B1
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771508157; cv=none; b=lDrH2EMfzL/annkltn5OW0mmAXMP2sjUjDbNtOTxfZ7ixOv23ngocGAjGvtCoEVm3SReq0qWK6IA8kj8/2DZN8w7LFAMWyQofkSiqEO/Em33wtNP7+8g0efmkSDYqnR0pjol/07N9DvsZncnQ4RBz2iPXFwHDECOcrWLdFH9xOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771508157; c=relaxed/simple;
	bh=fkjAjQ/KOUAuw0wMHw8c4rTyw1xCKLyn4m6UtAoHBG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAwTp2b18b6ZeRtGqdEyZ/u24o52DSYH3CSPj//hI4GH81r6h9eAJrYvWlnOFkQxTo9hnlkrGstthgX2zzcsQdYvu4Cjt4HQotzyKD9aZa+RppqVJBR158nvRz9owTtvCidCctYVuPVcAwhYpt+Xp4krRfG4ZSYL23uOauLOM94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIf6SuXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C463EC4CEF7;
	Thu, 19 Feb 2026 13:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771508156;
	bh=fkjAjQ/KOUAuw0wMHw8c4rTyw1xCKLyn4m6UtAoHBG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIf6SuXO548x1dRQ32H729ZeUCSXfPnIPsMr0FlGcVZu6G8Fy3MOT3YrMo+yylOJl
	 +/TgRpAW6H4uWkm3mw36hCOXXlKvOkfVWbjbKaq+NiJmYAUIZjYWdfYNR4l7NFB6yc
	 BAkJ6GvQ1XRL9+SvEbJbO8jJKSpEGG2p1cZIrAtBB1SMAG3v8ijEoe6RVmq6muDeyS
	 KZOuwxgwXOixQIwTqhyL6ijG5cWR07govx4T/UmJ5sM7gZsqTnUVURE6cBpOjwx2Nx
	 2dVLBkGZqJhdGWvmBFIbNvLjiWM8narFaqtlB2HXBgGmn4QN18/vx3oM00CyWUqD3g
	 SUiXFUCa4IlwA==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: remove or unexport unused fs_conext infrastructure
Date: Thu, 19 Feb 2026 14:35:44 +0100
Message-ID: <20260219-hausgemacht-korrosion-6696eb330974@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219065014.3550402-1-hch@lst.de>
References: <20260219065014.3550402-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; i=brauner@kernel.org; h=from:subject:message-id; bh=fkjAjQ/KOUAuw0wMHw8c4rTyw1xCKLyn4m6UtAoHBG4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROF9zWd1rrw5G2nLBdKqb9Upfm9d+JOjdjN0fEr7lbD T9v+B92sKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAixlcY/umvYZy/yXeh6pZ5 Zn+7d+1ge7T5kk74m627Q3yO+/v6zI9h+MN5p2nSyxnHz3/OuV5eIrB54s4f7yun8Rmt5V8ww/a v6w9eAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77708-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBAB615F213
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 07:50:00 +0100, Christoph Hellwig wrote:
> now that the fs_context conversion is finished, remove all the bits
> that did not end up having users, or unexport them if the users are
> always built in.
> 
> Diffstat:
>  Documentation/filesystems/mount_api.rst |    4 ----
>  fs/fs_context.c                         |    1 -
>  fs/fs_parser.c                          |   19 +------------------
>  include/linux/fs_parser.h               |    8 ++------
>  4 files changed, 3 insertions(+), 29 deletions(-)
> 
> [...]

Applied to the vfs-7.1.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.misc

[1/4] fs: mark bool_names static
      https://git.kernel.org/vfs/vfs/c/0d799df5b147
[2/4] fs: remove fsparam_blob / fs_param_is_blob
      https://git.kernel.org/vfs/vfs/c/8823db29744f
[3/4] fs: remove fsparam_path / fs_param_is_path
      https://git.kernel.org/vfs/vfs/c/d2f2f7cf8e89
[4/4] fs: unexport fs_context_for_reconfigure
      https://git.kernel.org/vfs/vfs/c/bc014937bc11

