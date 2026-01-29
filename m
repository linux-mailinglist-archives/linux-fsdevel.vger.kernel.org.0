Return-Path: <linux-fsdevel+bounces-75854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UITpD8lVe2k0EAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 13:42:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0239B01F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 13:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C1A83017276
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 12:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC28338757E;
	Thu, 29 Jan 2026 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okEIVB26"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5F0239E7D
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769690546; cv=none; b=HwbEPEqcm5uklpxnoNdQyyst+JJZ5g71gzOG/Rw3J8nbQgBjn1ulDZKViNWZ/6luri1HOsrj+RYxJmsDs6p2V7t0AFtAKADOKtN7PmgBa/Sg5E9toZxvH5QspfRESXX+/0Bsq88SWzkPqcWV+DAAca8QEXYi69oWQZAn9Ww0F00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769690546; c=relaxed/simple;
	bh=00PupbBxcWGQQpS4OQ4Rhyl+7b8A8wZYZDrw3zSwHx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtxIS9hHTLBIOziMRyDSfViqOqNKx2F5Ci8smWmRxGrRktIIdvi4LbV5JcXGkycepQUOsVcfJRhv2Sf9dZD/1Cob42L8VmTh2D5F7QirgNXvJSUStejJmeEqlOjIvlpoOlbIqbFt09bvG7/eNsZXipwYqvYBoIyw4eI01EqreMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okEIVB26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12689C4CEF7;
	Thu, 29 Jan 2026 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769690545;
	bh=00PupbBxcWGQQpS4OQ4Rhyl+7b8A8wZYZDrw3zSwHx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=okEIVB26/c6PkZCWWxcNIPa03RzsrcXJvVJRZd9lSMk1ga2uy2zDlnczK5OHi4Hve
	 SKmRQ6mOnIosvOlwUboJQuR4dGqc2rR1QuxA2V9u9rLt8/37loMgarAeMwYjtyvA+Y
	 3P54zUPmUcCKCnld8xsd76Q1GiAtyshPGWw5NnRZgD+xZ/nQtNyfcTSLXlaUexwCLn
	 xrLpg5O5xzqUulYdWKCSmkhUs7t1HGVinz18DgoUMYF8dO7dNnc+Nh+A3Qv8y5TvA4
	 YV+Oluw5bVrhijeVis2LSIYvZ07BSEd4Ut1y7yOtnYurndgcKOy9rK3i+vJUc9DpWD
	 t1457GnvtTdXw==
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	willy@infradead.org,
	hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 0/1] iomap: fix invalid folio access after folio_end_read()
Date: Thu, 29 Jan 2026 13:42:19 +0100
Message-ID: <20260129-radrennen-begruben-ed0059653cf4@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126224107.2182262-1-joannelkoong@gmail.com>
References: <20260126224107.2182262-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=brauner@kernel.org; h=from:subject:message-id; bh=00PupbBxcWGQQpS4OQ4Rhyl+7b8A8wZYZDrw3zSwHx4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRWh65tyjNeezT/nco31+ONAe++p7Y/3VHUofclI92EM SZ02myTjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMc2NkuMK0bXW+Qs2L7pNL v79eJ219riRpq9mGg6uDpq/MWjxxpzIjw7YzVx9t/htucTylZF6ExsbpPhs2pK11YPdSOF7mzXI ygR0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-75854-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: A0239B01F4
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 14:41:06 -0800, Joanne Koong wrote:
> This patch is on top of Christian's vfs.fixes tree.
> 
> Changelog
> ---------
> v4: https://lore.kernel.org/linux-fsdevel/20260123235617.1026939-1-joannelkoong@gmail.com/
> * Drop new iomap_read_submit_and_end() helper (Christoph and Matthew)
> 
> [...]

Applied to the vfs-7.0.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.iomap

[1/1] iomap: fix invalid folio access after folio_end_read()
      https://git.kernel.org/vfs/vfs/c/aa35dd5cbc06

