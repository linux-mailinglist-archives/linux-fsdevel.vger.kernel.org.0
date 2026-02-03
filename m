Return-Path: <linux-fsdevel+bounces-76206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OxZNvEPgmm9OwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 16:10:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01573DB1B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 16:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A89630CE8F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E882B313E28;
	Tue,  3 Feb 2026 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbaMcQP9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708DB30F923;
	Tue,  3 Feb 2026 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131339; cv=none; b=Ve0RdGo7xNkNVzpDF5TnI59kZgP9GHh1VDfbOSQKD/1lfQOprlVETHRZZk4Stxrk7LnPa7pwsLcb+xUzPs67EEdJk/LBFeIC0hJiDsMnL+0h+WRKoLEq9xjz8p+mqlOG5sodcm5NleDeDj7UcWHPXlhfl2nr1uD3DWWz0zw/uuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131339; c=relaxed/simple;
	bh=tvT/aHsaW9vYUYAFKXFnC5MX19JQl1HRu5b76MJ1e3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUPAmDfXB0kDswbP/veKomiSFgT1OMyC1/i1HQ8tXs7BvRdfOe2Qf5vAvfx6Kd6rkoozjXCYTN/OkwwFIcyaNz4H8nJZmEYa+/0mrk9i99gAEJ5OI4ASvAViTO8GdCnKawTQccf6VFA4epy7lJ3PyXpMd+rAOq7Ba17/V/jv9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbaMcQP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92458C116D0;
	Tue,  3 Feb 2026 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770131339;
	bh=tvT/aHsaW9vYUYAFKXFnC5MX19JQl1HRu5b76MJ1e3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbaMcQP9GmBhRN7Se+bNkv50odBQeJRwEJEG2rei0rFx6jf1OtdIopF2oYUoZgxpX
	 UjlR8LhVU/MuzQBlvYEsuUvo28xUoJeXfUVALkiJCFwasaForVyllvFU/+5MFuLMeO
	 WOUpl/nmtJBrUP+7vEKOvAAYZYSjg+GvNsUkaI3FVM/Aj9wNcqHJSqYkIhDuMZIOHE
	 iCbmuQOC0dLc3XEIGGFo2Hu2xKbZ6883GKr8ddKG7UX40C/leCoc5kV+ITDuLCJ6OT
	 T+Uu+3Asqf65U8D923y2qYbcG3HRiyDVterZZdEbD/TTdIEyK1FIzCYWoYl6XRxhpW
	 7GXr4tYBVhDAQ==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	"Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH] vfs: add FS_USERNS_DELEGATABLE flag and set it for NFS
Date: Tue,  3 Feb 2026 16:08:47 +0100
Message-ID: <20260203-leimen-kundgeben-7be98e9cd156@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129-twmount-v1-1-4874ed2a15c4@kernel.org>
References: <20260129-twmount-v1-1-4874ed2a15c4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=brauner@kernel.org; h=from:subject:message-id; bh=tvT/aHsaW9vYUYAFKXFnC5MX19JQl1HRu5b76MJ1e3U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ28bcWbOF9+uDKJaa0HU+PyLN/DuJxkT59LGtN5sRIP feZey/87yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiILS/DH85Xv2+7e5ZwbN3C aREuEWT3MX/SLG63vbf+eQmUlCVMKmFkuLY3X7+Yv1qc62jT35xrbcbBzQ/XBP1aGq/11u6O5hY 2ZgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76206-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01573DB1B8
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 16:47:43 -0500, Jeff Layton wrote:
> Commit e1c5ae59c0f2 ("fs: don't allow non-init s_user_ns for filesystems
> without FS_USERNS_MOUNT") prevents the mount of any filesystem inside a
> container that doesn't have FS_USERNS_MOUNT set.
> 
> This broke NFS mounts in our containerized environment. We have a daemon
> somewhat like systemd-mountfsd running in the init_ns. A process does a
> fsopen() inside the container and passes it to the daemon via unix
> socket.
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] vfs: add FS_USERNS_DELEGATABLE flag and set it for NFS
      https://git.kernel.org/vfs/vfs/c/269c46e936f3

