Return-Path: <linux-fsdevel+bounces-72050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67568CDC379
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14DC830A3069
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CF7338902;
	Wed, 24 Dec 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kE1sijUa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0E1315765;
	Wed, 24 Dec 2025 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766579485; cv=none; b=JyAhqjOiBrnONeroISRZcw9tyiWRJQrO4sKPean9BoYpHA9PwMttWik7O5IiClt/m/ixDPhZ3ZV8L3fCnHRe5kgUsDBdyXNo5CFk36f+P5/Pkg2ZTbTNpgP75JiiUftxNnH74M8aYmuYZ7pDVsnU3FPMSYDgEx0E+YpgX7F1rZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766579485; c=relaxed/simple;
	bh=bwXJJa5UIvtNLv3UOr4xkIKceEE7wzh9E4B/3ZqQ138=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwgoltHxISw4Gh6fNRvd0cbBOhVT4KaRZwpc7a2COfd2UMJCnH5JuARuMOg9hR7y9iJvog/OwLkh4DMmc/QYlN0Bjk/qsYkro605KPLoqiFbU+uaG4XtvLsO5+nLR8nNiFdRLeazvZWUWi+FNdWTTUDW0Dn9OgSCKq/EgCVMXq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kE1sijUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A178C19421;
	Wed, 24 Dec 2025 12:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766579484;
	bh=bwXJJa5UIvtNLv3UOr4xkIKceEE7wzh9E4B/3ZqQ138=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kE1sijUaDNKRy2uClNM15cW5Wa3Iloo5Flu8VR2jjbJWn+m4OdyOkbYvnOmOWTzfI
	 +Lyf+0qfVFQ/aafBcqPQukxxdlIbeKrYod1ey7FNvDrcK7XOlKqxwgbgpAw/tq/iWT
	 19k1PVui5xuUvZffDcckOqdklP0dbTJgtkckUZo5Mf9GoWL7bnjC8yYxsxA91/VcUK
	 RnlIi5T2IJvxPb7uuU97r6OpfgiUvB45cuk/Jc3bG3OcEJkSsgL6deiTE0pNciKJV2
	 0LsDXQK+E3OUapUigErrE/liMT6k4/PqonyJdvx6wtAEFgXsB1WuQtQ/y3r/9qQLG+
	 jN5zOE9rNNa0Q==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Chris Arges <carges@cloudflare.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <sfrench@samba.org>,
	v9fs@lists.linux.dev,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix early read unlock of page with EOF in middle
Date: Wed, 24 Dec 2025 13:31:14 +0100
Message-ID: <20251224-petrischalen-abtreiben-c023b9242319@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <938162.1766233900@warthog.procyon.org.uk>
References: <938162.1766233900@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975; i=brauner@kernel.org; h=from:subject:message-id; bh=bwXJJa5UIvtNLv3UOr4xkIKceEE7wzh9E4B/3ZqQ138=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR63xWR1tC5vbRLfbpM9WEmnplbNTK5xCe3JtpYRcx5E dLJlc7ZUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJFAY0aGD1v6JA4c8NiUmq5y ZrK3LOOrG+/UnmgtaBNbvk1eNtfJj+GfrW26z1KxVZsiGbpmulun+Cq2pz2+K5d7IPSefMmynTc 4AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 20 Dec 2025 12:31:40 +0000, David Howells wrote:
> The read result collection for buffered reads seems to run ahead of the
> completion of subrequests under some circumstances, as can be seen in the
> following log snippet:
> 
>     9p_client_res: client 18446612686390831168 response P9_TREAD tag  0 err 0
>     ...
>     netfs_sreq: R=00001b55[1] DOWN TERM  f=192 s=0 5fb2/5fb2 s=5 e=0
>     ...
>     netfs_collect_folio: R=00001b55 ix=00004 r=4000-5000 t=4000/5fb2
>     netfs_folio: i=157f3 ix=00004-00004 read-done
>     netfs_folio: i=157f3 ix=00004-00004 read-unlock
>     netfs_collect_folio: R=00001b55 ix=00005 r=5000-5fb2 t=5000/5fb2
>     netfs_folio: i=157f3 ix=00005-00005 read-done
>     netfs_folio: i=157f3 ix=00005-00005 read-unlock
>     ...
>     netfs_collect_stream: R=00001b55[0:] cto=5fb2 frn=ffffffff
>     netfs_collect_state: R=00001b55 col=5fb2 cln=6000 n=c
>     netfs_collect_stream: R=00001b55[0:] cto=5fb2 frn=ffffffff
>     netfs_collect_state: R=00001b55 col=5fb2 cln=6000 n=8
>     ...
>     netfs_sreq: R=00001b55[2] ZERO SUBMT f=000 s=5fb2 0/4e s=0 e=0
>     netfs_sreq: R=00001b55[2] ZERO TERM  f=102 s=5fb2 4e/4e s=5 e=0
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

[1/1] netfs: Fix early read unlock of page with EOF in middle
      https://git.kernel.org/vfs/vfs/c/570ad253a345

