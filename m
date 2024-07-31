Return-Path: <linux-fsdevel+bounces-24693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C478E943232
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 16:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622471F26703
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6C91BBBD5;
	Wed, 31 Jul 2024 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amDNhx/D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A61DDC9;
	Wed, 31 Jul 2024 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436861; cv=none; b=hakB3NgFo5TCizcfMfdrTuKvWgqKivO+JGYpO3AanSannn27+rqIgzhUMADZnk9FNUz7KBkANSoB5PkbNK+yKQLmyZ0XWuPGE8znoI0TDZvNuMa93ddcsR0zTPgY+XD1t+nO2QXkxejh5jzm/epY8UC+4igjucKn8WmCM7nPSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436861; c=relaxed/simple;
	bh=bnW6xuwZRXMhJrERIAI3wU1Z7HMnXzuTTSgYcobJcNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okTHcMOMiRNG37p08piEEM+WxyDARTuNZgAz38qXqyWOnR/oAEKS3YWHqSXvC8y2LIlY+/UinPMunBfcbUQYwhLfBV1Q+jN8MN7ALT8hibB6bj8Xbo4Y6MGIcJCFWV6SWfoc7JgM6gxV84gODmTBEbGPRle242y9k83TWVL/Vhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amDNhx/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE70BC4AF0B;
	Wed, 31 Jul 2024 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722436861;
	bh=bnW6xuwZRXMhJrERIAI3wU1Z7HMnXzuTTSgYcobJcNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=amDNhx/D9q3Te2VaVhD7jTIzAn6vhUMsTpFFXj/sbot7JZIo24T3EyYxqVD2450a9
	 rOk9dmf4/Viw/ibNSVrYZqjNIQrcndTSe8H1Nat3tkBXW9iIAxr6upd9Dn4JM63lD+
	 3O1Le2Wvn02sLYrmGGfVlU59ykSFdSMRvpXyazO7pjoixeX3BO7vr939kNIe49OTiL
	 7n8Hbwut99cxMna36XlGHd6Z6flRLHbix3cfZTNh+bzl9fEsPygXCQXnY9rfgykH81
	 p3yqWzLNhNjwRg3GkaJ8LKcOnBVCaAf7d9j/b+YHVgtWcyUpdZgmKc7CAKjijCON1G
	 d+zd0DDFltTeg==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] netfs: clean up after renaming FSCACHE_DEBUG config
Date: Wed, 31 Jul 2024 16:40:50 +0200
Message-ID: <20240731-denken-marzipan-d7c2a89e8375@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731073902.69262-1-lukas.bulwahn@redhat.com>
References: <20240731073902.69262-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=brauner@kernel.org; h=from:subject:message-id; bh=bnW6xuwZRXMhJrERIAI3wU1Z7HMnXzuTTSgYcobJcNA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSt8vkmc/DXYsfL6x+HRv66+uG/Ie+c8LgGz/LnJ4od+ SMmM7EGdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEVIiR4dqk3i47bxmlZ6eO 8nyQYE6Zu3Kv3NbD5vybr7S+enY0/CsjwzTWe/qpWZM3lyz52uB43dB+1w3OXQvOz7Q8bHGT10P sChsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 31 Jul 2024 09:39:02 +0200, Lukas Bulwahn wrote:
> Commit fcad93360df4 ("netfs: Rename CONFIG_FSCACHE_DEBUG to
> CONFIG_NETFS_DEBUG") renames the config, but introduces two issues: First,
> NETFS_DEBUG mistakenly depends on the non-existing config NETFS, whereas
> the actual intended config is called NETFS_SUPPORT. Second, the config
> renaming misses to adjust the documentation of the functionality of this
> config.
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

[1/1] netfs: clean up after renaming FSCACHE_DEBUG config
      https://git.kernel.org/vfs/vfs/c/c9bffce5f3f5

