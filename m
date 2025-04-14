Return-Path: <linux-fsdevel+bounces-46375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AB7A883F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C43C67A2741
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BF12798F9;
	Mon, 14 Apr 2025 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ModmNHGZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F04438B;
	Mon, 14 Apr 2025 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637767; cv=none; b=L4yCmWk2DF8X/IJtvoXQS1Au652ICdNucwkpsya6FobV+q9xr7AsUmEO5+KzTn6C/CFDJQ6ulAxPiAmzHOBjI5SQfq4HQ4gLtAkLX6nfCbnhzIUr3leqNt9/4KNqCvFhdq9bPTmwYlEc56ovrTlfj3TXSPG5IGqbyXeuOhN5WTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637767; c=relaxed/simple;
	bh=WJ+JyBh1nHLEgrQ+hkI6yYMG1Nzzmf5jxQP5xAVPess=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxBu0A25CIepnYjya7yfaHlCoSypYE0LqrKBwQK90gf65TJvEMuYGMFbzFslXGijoMAyulJanDfloTaXCdhkjN9SKGvcFH5eeC/pN+6UGtj7VORoRAG0nYJoSA/3W1LPdoRKJFPMQeIqAlVcUV5knlCAXVfu/B3kZG9yrbnK5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ModmNHGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47B5C4CEE2;
	Mon, 14 Apr 2025 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637767;
	bh=WJ+JyBh1nHLEgrQ+hkI6yYMG1Nzzmf5jxQP5xAVPess=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ModmNHGZWVYZSvRJmLj4DYSNL946kAvpy4PvTvWEhTupDlrlWzAXry5I6l7Dx82Ht
	 Y8EsFJugOinR0dZ/0AYs7iNd5CxdB0r/LgJNued2qfFH952bl4pMnBaJVlC36ceek1
	 sv4Lx2V/Pwn7uQlAlnm7pl4+9SrCOU9a7JWSxRiW8ZF8up4a2qeubRxHidUKVMLudJ
	 0lufpOQeh6ZFFR8qoxGgPYDMYnN7YSZaotmEB67n9fqaMOOorUPlfqB2F8P26m3hY3
	 SVELAFEWzvRh0F4kkJWly0/BrwsnUiD6Y2P9FUol7Zfm84HQ47LE1gPPMOVkBbP9wY
	 2/+6V/1fDQ5ig==
From: Christian Brauner <brauner@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: (subset) [PATCH v2 1/2] fs/fs_parse: Delete macro fsparam_u32hex()
Date: Mon, 14 Apr 2025 15:35:54 +0200
Message-ID: <20250414-klemmen-tiefen-026d7343aceb@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411-fix_fs-v2-1-5d3395c102e4@quicinc.com>
References: <20250411-fix_fs-v2-0-5d3395c102e4@quicinc.com> <20250411-fix_fs-v2-1-5d3395c102e4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=brauner@kernel.org; h=from:subject:message-id; bh=WJ+JyBh1nHLEgrQ+hkI6yYMG1Nzzmf5jxQP5xAVPess=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/5XfMPq0zZevHlztfHM5c/qXT6qqZJjtH29GfwZOF5 tyTEGYR7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIphrD//K8NGaZ5+t0zO10 InlZTS6U/fnB7pHOsNjkWaX+jH/LFzL8TxE6xND6iPv/k0+PxR3M7Fds1eecM5np7Gn3hO55X0t OcwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 11 Apr 2025 23:31:40 +0800, Zijun Hu wrote:
> Delete macro fsparam_u32hex() since:
> 
> - it has no caller.
> 
> - it uses as type @fs_param_is_u32_hex which is never defined, so will
>   cause compile error when caller uses it.
> 
> [...]

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/2] fs/fs_parse: Delete macro fsparam_u32hex()
      https://git.kernel.org/vfs/vfs/c/8cc42084abd9

