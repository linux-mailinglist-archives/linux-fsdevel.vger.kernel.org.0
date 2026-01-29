Return-Path: <linux-fsdevel+bounces-75868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D0ZO192e2mMEgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:01:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D9FB1419
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F459300AB1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A073C238D52;
	Thu, 29 Jan 2026 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0kZRNMf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F77B8462;
	Thu, 29 Jan 2026 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769698895; cv=none; b=NiEWtuzBSnmLYKQNyxtv8VLCUgOOxyw4BilqR79fp3xBROKTv1EIyAsUrjy/QLjP4ODCLRmro+Zikm32QH/q9NmxFt3x4NsFtdBY6QteNCJIuslwZyDcWkW0lL5HFG6n/noIRPY2xKIE53ta3xt3SZmkfjL5Cyz6oee8R+z4dJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769698895; c=relaxed/simple;
	bh=zoRMlhgqaDvcPEwMvPATnYjEC5iG1KLGfWHXZQJfNeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HT4MdmvYo3C82XWh5oyEGYKVZwiPtmX4qN6c2fRSwVUyoZgLnJamhiG+TX25VlfYdisLyeGFEdioPzXhYujrSyD+TmudFiwikqutpEjjXtHQwwK1ene3jDLdhchtM1wzpzrJHPD4+mK2WVgyxfJE3Eag9OmiSvMYXKuXIjWhARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0kZRNMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BBAC4CEF7;
	Thu, 29 Jan 2026 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769698894;
	bh=zoRMlhgqaDvcPEwMvPATnYjEC5iG1KLGfWHXZQJfNeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u0kZRNMfUOVXGxuI8qOkVx606SiaAKMWSIRorS0JuyX5QgN697knVrwyshmnyeBXC
	 87GTzkPpwG0Ka66yqVrUSYc6MphOcw5ip4xIMkmWM4jvMotu4YF/1+Gpa8tmVXrfMo
	 oMvw9XJRWcBufIHJVUo0IUoCFO4a9+Klcr411X0N05PAo/nPYQ6pEa/JxouJWcBiFO
	 kx/y3w150vKVt3KJU6uQkc/IEvmG6ZHsZcVfklOyEsRwU0Db9BSr+dI7wTh04XtnVE
	 RbjHEl6UqzpxSP8e0CwsHNMvj7uRO+UQTlcS9X2CCisXTl8qNmXz2mFCt4u8c2+lZH
	 1ZMcZ+A25wdkg==
From: Christian Brauner <brauner@kernel.org>
To: fsverity@lists.linux.dev,
	ebiggers@kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 0/2] Add traces and file attributes for fs-verity
Date: Thu, 29 Jan 2026 16:01:29 +0100
Message-ID: <20260129-beieinander-klein-bcbb23eb6c7b@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126115658.27656-1-aalbersh@kernel.org>
References: <20260126115658.27656-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547; i=brauner@kernel.org; h=from:subject:message-id; bh=zoRMlhgqaDvcPEwMvPATnYjEC5iG1KLGfWHXZQJfNeo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRWl3mxtjTJqSbNa6phUOS6c/LnuSnnSgK/NEWc0Z27w 7pfa9rEjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInkajL8D3mQ0rF1D4OA9c3K VwmiAsvsbGf1ZuoETGTf+82Q1bXyCiPDz403vJydlor9Mhf6P3sPt80sg9vvb4fuPvXh7R1T+Z8 CPAA=
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
	TAGGED_FROM(0.00)[bounces-75868-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76D9FB1419
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 12:56:56 +0100, Andrey Albershteyn wrote:
> This two small patches grew from fs-verity XFS patchset. I think they're
> self-contained improvements which could go without XFS implementation.
> 
> Cc: linux-fsdevel@vger.kernel.org
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> 
> v3:
> - Make tracepoints arguments more consistent
> - Make tracepoint messages more consistent
> v2:
> - Update kernel version in the docs to v7.0
> - Move trace point before merkle tree block hash check
> - Update commit message in patch 2
> - Add VERITY to FS_COMMON_FL and FS_XFLAG_COMMON constants
> - Fix block index argument in the tree block hash trace point
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

[1/2] fs: add FS_XFLAG_VERITY for fs-verity files
      https://git.kernel.org/vfs/vfs/c/0e6b7eae1fde
[2/2] fsverity: add tracepoints
      https://git.kernel.org/vfs/vfs/c/fa19d42cc791

