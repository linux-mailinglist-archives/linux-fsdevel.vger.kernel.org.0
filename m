Return-Path: <linux-fsdevel+bounces-33735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3DC9BE430
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 11:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00436283B26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1041DE2DB;
	Wed,  6 Nov 2024 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bglYgFtl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD721DDC3A;
	Wed,  6 Nov 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730888611; cv=none; b=ulckLOhwWyJk/8TxfyjUhrtS9zJuTJVc50c9t5OqkpwPSgdZNRoJTCjTbiL+mxqMFXQ7xyA7s4PqtNQjQDdqAh7pdHGmnptgbjZg7+OQRfgIZ9Z1Sr8fw0y1g9dpyOymGLdydPXttPwOqIchy6P/+djUQOiVtx+K3WhiwL6M7dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730888611; c=relaxed/simple;
	bh=6DxisW7D7zjNCbF4hlBcke6SsDosV23ni3y7W/phmvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBne/yHvifDGrqflwWtVtpQ1fEsWpMUPrP2aWR7N3KKKR0IPlMUHT2jxEPsrmRw7ty/jz6tz9KI1uSYFr6HylNgcJX90rwr1TAFOyjMrnrN11KH1U2WvSpH8oW4vBhPO9Wd9s2Hb/kRCN8b9c2jgr2s1zT8YuuAzNsYq5cFIc1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bglYgFtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0050C4CECD;
	Wed,  6 Nov 2024 10:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730888611;
	bh=6DxisW7D7zjNCbF4hlBcke6SsDosV23ni3y7W/phmvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bglYgFtlGDDSFSE6HvhUiwDNerouRy8APG6TIzlAtdh4cS4ccBmejqicrrfMZWLs1
	 +Fqet/7XzmLAK8PT0VHJJGKxTEzdjjbU3CViA+hDYaQtfHlktaincGVuRP58MC1PPu
	 3z/64zEsU9oDC7bGK6APrOfIzBsdSzcxo43I7TGQhB/JIO1VfXCYkFl42yJzM+LK9G
	 uK3/CxDLTu5tJYqtd0wY1yotZDqHDWLe/nGmDi106VVeOUgR3feW5bCP4jipTjFV/V
	 52Kb1v5k7U7EaYXAxIAFXK45dXGh4ZDxI0GNd/1SHAK+U8CeYpkQsSEWIuf1yeIBPm
	 Bl4zJuSN0cFTA==
From: Christian Brauner <brauner@kernel.org>
To: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Theodore Ts'o <tytso@mit.edu>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 0/3] tmpfs: Casefold fixes
Date: Wed,  6 Nov 2024 11:23:10 +0100
Message-ID: <20241106-hofnarren-bestuhlung-b98bec741179@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101164251.327884-1-andrealmeid@igalia.com>
References: <20241101164251.327884-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=brauner@kernel.org; h=from:subject:message-id; bh=6DxisW7D7zjNCbF4hlBcke6SsDosV23ni3y7W/phmvs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRrO8+q2d6qclPisbCzydK+DzoFdkp9ugoXr/3dcSbkF y9PXNDujlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8+MnwT2v7lefdCj+MPvza vy9fRF/dZJtHTeYX5Q8cV0y2rdI1msTwP2T589KPm2xtJh78WjyHMXr+633bamIVn5z77Po7yXH ePjYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 01 Nov 2024 13:42:48 -0300, André Almeida wrote:
> After casefold support for tmpfs was merged into vfs tree, two warnings
> were reported and I also found a small fix in the code.
> 
> Thanks Nathan Chancellor and Stephen Rothwell!
> 
> Changelog:
> - Fixed ifdef guard for tmpfs_sysfs_init()
> v1: https://lore.kernel.org/lkml/20241101013741.295792-1-andrealmeid@igalia.com/
> 
> [...]

Applied to the vfs.tmpfs branch of the vfs/vfs.git tree.
Patches in the vfs.tmpfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.tmpfs

[1/3] libfs: Fix kernel-doc warning in generic_ci_validate_strict_name
      https://git.kernel.org/vfs/vfs/c/33b091c08ed8
[2/3] tmpfs: Fix type for sysfs' casefold attribute
      https://git.kernel.org/vfs/vfs/c/18d2f10f6284
[3/3] tmpfs: Initialize sysfs during tmpfs init
      https://git.kernel.org/vfs/vfs/c/65c481f30896

