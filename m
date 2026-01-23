Return-Path: <linux-fsdevel+bounces-75295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I9SAd+Hc2krxAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:38:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7034B772A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A56FA302294E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 14:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911B52EE5F5;
	Fri, 23 Jan 2026 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kgp/kPKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F12228FFFB;
	Fri, 23 Jan 2026 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179095; cv=none; b=Y5DLbCtqQSmgliph71CmjoX/tqDDHCO2FzXqHXtjE4bZPkS3Nz6D/23Qgm0XE9YS6RtrKIfeeiAKQ6/XsNo6e0n3iXHN+fEA2u6VIwy7lJHqj6BQkfCbnOKy+4StaJC/WlSVfVxdm7GH3jsgLH/P2PFKyy2zQk/rFZeC0pBT+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179095; c=relaxed/simple;
	bh=V9fc0Dik4NTRdfyjN7NV755Y08CSkCbILtvaAGdGrsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3ODC9qDfR7+6jmPfTQDUF+d34XBqHmbfRqgZJAAHB3K2G6k+wE+InW6UVCaSrZUeuXymszV6WBC8Jm2Lg+3XEiQO9nbX+VUN4pJKfquC+9LJOozCY+1PCOUtnnWqyqpIypa5jS5E+1rL1h2ltHp3hSi4bUp/HNYEeXozAYaD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kgp/kPKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E718AC19421;
	Fri, 23 Jan 2026 14:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769179094;
	bh=V9fc0Dik4NTRdfyjN7NV755Y08CSkCbILtvaAGdGrsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kgp/kPKuHpxNesrAZjsT76x3xEFrySK8wNQjU9fYo5B4y+9ylRthYek5EvO5rSKAw
	 kBYK7+HGYHNq/kdZZ8MxxMaq8WVuJTNlKUH0WYhmuFX7VBqWgtDWpx1GEEHmVntxd0
	 28f98cGfndFGs+vqRm9/9T8bBajs/qCVEFb5IsOpfL89pab4pwMzyxme+gvIrenxIs
	 DSRFsV/L8RH+bdFtlqjuCeTVuTfrt75XIZ2/oiI2qPy3A0SKtC+adoSuE3hpW0xnzy
	 Yoy69pVssUa4qg7XGYcHrUzhnwInKW1/3SVMUrx9pkBQO/oV3YhtRaXOHYHJtf+JpL
	 2Z2uY7iVXpN+w==
From: Christian Brauner <brauner@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuanql9@chinatelecom.cn,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs/file: optimize close_range() complexity from O(N) to O(Sparse)
Date: Fri, 23 Jan 2026 15:38:03 +0100
Message-ID: <20260123-wollust-vagabunden-af9d9bff4c4a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123081221.659125-1-realwujing@gmail.com>
References: <20260123081221.659125-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417; i=brauner@kernel.org; h=from:subject:message-id; bh=V9fc0Dik4NTRdfyjN7NV755Y08CSkCbILtvaAGdGrsg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQWt1+cXH7sMRfT5Jv3jdZs/rttF5+ydRm3n6ab559HP OKi26NFOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS4sjI0JK1z/3enpPBWVfM 55Xv427+dSNa86qXptccC2aDlLVZjAz/Qze+kTrKtzVOp/rPA+Yp4s0ys6LUTk1bPCWl+fHFVWV WLAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-75295-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7034B772A2
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 03:12:21 -0500, Qiliang Yuan wrote:
> In close_range(), the kernel traditionally performs a linear scan over the
> [fd, max_fd] range, resulting in O(N) complexity where N is the range size.
> For processes with sparse FD tables, this is inefficient as it checks many
> unallocated slots.
> 
> This patch optimizes __range_close() by using find_next_bit() on the
> open_fds bitmap to skip holes. This shifts the algorithmic complexity from
> O(Range Size) to O(Active FDs), providing a significant performance boost
> for large-range close operations on sparse file descriptor tables.
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

[1/1] fs/file: optimize close_range() complexity from O(N) to O(Sparse)
      https://git.kernel.org/vfs/vfs/c/fc94368bcee5

