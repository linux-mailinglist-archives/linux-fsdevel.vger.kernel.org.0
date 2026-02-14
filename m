Return-Path: <linux-fsdevel+bounces-77204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH3CKbhpkGllZQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:25:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AA513BD88
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D8FA301E6E8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 12:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DA7285050;
	Sat, 14 Feb 2026 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJalEmtv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500E630B532
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771071909; cv=none; b=JDeIR92Jrz9J/YmP8LHCk3CSenePQa07S1JUycgXGZPmertCXJVnyjv4S18IUwSHNWJEB5oNulfEulNbaLMTSxeqTZ32lG5xMU+RBV0Nj1HBPb7YFrKh8W3GAr3yBOgvsg/WiuOzIbQtfsbHX/Z4EIbHxeLDXqoyue6+2bl1fS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771071909; c=relaxed/simple;
	bh=LkE1CKh8iPNh9pHSWAdz9nOWAEf/rcSnw2ErnGpB2b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNsonIPnZ8KjZMua7W2u/tbAI3JCMJj2niyfVTWb8KRmZyTTJKxlHWtML8SVJTp3/z4IZNkgyNGfVjDlP9TyHNi746m91YrhTTahyJsBwN2MU1aMP8xV23LZ3gw+SAz0Pxx9735yCtg0fGvdg7nrpD00xEsCwtrfLcHdW4V71TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJalEmtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616FDC16AAE;
	Sat, 14 Feb 2026 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771071909;
	bh=LkE1CKh8iPNh9pHSWAdz9nOWAEf/rcSnw2ErnGpB2b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJalEmtvrg7gYbDge6a3rF9cW9vlTBpxyb+BYMite5jN3QBwNlMUr9Is9NpH9/Fw2
	 hWpyetwoHin8BNLcgWP+pqLoNQPMNAeyZTc6HwMssETPmTIMXGKMpPTgo5SSlk30WV
	 5B76esXwt69f8kF/KWj/JtvfV2q0K8S9mbW3pXgCl8MoinXg/pKECiuHePEA+k5Yk4
	 TbFy/thCPz4f7qNFRBtqJQySDKRCdMieDyaSw8GxcjyN05050Jg1wsAFsfWZ9p5kKi
	 q9o4KSm8BRvkAXkzs+CfnZkktrUOE+xKMNVAWy0vHhVzlVLrjhQ6qn0pLr0ApEkkJt
	 K/Mh3SwtCH7mA==
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH v2] iomap: Describle @private in iomap_readahead()
Date: Sat, 14 Feb 2026 13:25:03 +0100
Message-ID: <20260214-mineral-bauindustrie-d5b3c88b77d1@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213022812.766187-1-lihongbo22@huawei.com>
References: <20260213022812.766187-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010; i=brauner@kernel.org; h=from:subject:message-id; bh=LkE1CKh8iPNh9pHSWAdz9nOWAEf/rcSnw2ErnGpB2b8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROyFzAsChpcb7xBqUpy2Y/P6HyYSP7uq0T9nx13W9fK CV4z++eYkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmcCGcHEKwEQu32H4zXber7l4xu6Tczao HGxcIZK+P17IcNe2J2JfY/4Zfmbqq2Rk+PGo4veJKXLhzQH6P1YUVnB1rb/1L3Dh8Ue6EhEfdkX 5MQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77204-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29AA513BD88
X-Rspamd-Action: no action

On Fri, 13 Feb 2026 02:28:12 +0000, Hongbo Li wrote:
> The kernel test rebot reports the kernel-doc warning:
> 
> ```
> Warning: fs/iomap/buffered-io.c:624 function parameter 'private'
>  not described in 'iomap_readahead'
> ```
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] iomap: Describle @private in iomap_readahead()
      https://git.kernel.org/vfs/vfs/c/ac8389617279

