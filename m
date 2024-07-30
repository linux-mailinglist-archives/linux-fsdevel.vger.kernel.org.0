Return-Path: <linux-fsdevel+bounces-24599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4E69411E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 14:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7F01C231CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 12:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A771019EED4;
	Tue, 30 Jul 2024 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkUnA/32"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0445418F2FF;
	Tue, 30 Jul 2024 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342597; cv=none; b=KM/4N43sq2SHReYbLciNSuWemMTLKK1tNlnL5pHmEK4MyTD3zE0cV1unOlOqUpK5PfbpyziSOJQrWZPaGAH9sBYanYXccGc3PSw5iMg1GzoJryOJzAVSjZxLRYEwWNGQ9xGsRCqShNXzo4bv/BC2mBZP5gtkaA9h82Poz8eqzxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342597; c=relaxed/simple;
	bh=VwgmwLcqB9ZFY4Gq8oFzw8DPmba5sKvUZygIQYJUFJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CM1WGLJyTYIX5Op/EgFbtrhPHQNb0FbZB7aaw0GjKfGE/QE0FjzNKPfe6Q/nzBOZBttsNpnwM185Kd1QpvtbJ0S8PfqhU/juFdCcuuxtEADYYqgF7yk5elVWTHY5dxHyXmjjw9fAPXRTD/11CJH1a1OO2ufldv1iEaJ287fLoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkUnA/32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6B5C32782;
	Tue, 30 Jul 2024 12:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722342596;
	bh=VwgmwLcqB9ZFY4Gq8oFzw8DPmba5sKvUZygIQYJUFJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KkUnA/32/zuP2yfY+2BHZWzBcAP6eKFvYJzwWg50srUl6w+CFGAAsp0WSVoyBsClT
	 RqacX6MYF5YOZXuFyCH1T+vUJ++Nz0X1eEHzYVtQCG70dV6lycBDRT1l0bC44Pawpd
	 +iPYigs44yG43C7YtEGs+CmmNOd07N1gVv7oVL3sAsGWuDWypjD0wUHbrIyVdGM4TS
	 vrI0xEOfD8OBBv8DrpRSzlAYcZ84bFwSacznjY87leU+5uoMBw6sHmr0W8MuWdQEGa
	 PdIEIXWlUrWuRQDGAlE0qFxCsmO+XkMEeW2ssvA5Zhnhvuu4KAm3BW6AkdQu1fHQWH
	 w+/JLXA6Quvug==
From: Christian Brauner <brauner@kernel.org>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	Max Kellermann <max.kellermann@ionos.com>
Cc: Christian Brauner <brauner@kernel.org>,
	willy@infradead.org,
	linux-cachefs@redhat.com,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] fs/netfs/fscache_io: remove the obsolete "using_pgpriv2" flag
Date: Tue, 30 Jul 2024 14:29:46 +0200
Message-ID: <20240730-bogen-absuchen-8ab2d9ba0406@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729092828.857383-1-max.kellermann@ionos.com>
References: <20240729092828.857383-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=brauner@kernel.org; h=from:subject:message-id; bh=VwgmwLcqB9ZFY4Gq8oFzw8DPmba5sKvUZygIQYJUFJ8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaStuLPXbsNutWrb//0s9qtDC+4qLxCUPskaGWuox6y2J pWnfcXUjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm0bWL4Z6Y6h3Vi5b6S3S8m Bl+YNE1i6+I5d4u91me4+v1Y+SriThTD/7znfiksf3dX7a+6M2XhuqRz75nya4/vVRJP31p8af4 DfQ4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 29 Jul 2024 11:28:28 +0200, Max Kellermann wrote:
> This fixes a crash bug caused by commit ae678317b95e ("netfs: Remove
> deprecated use of PG_private_2 as a second writeback flag") by
> removing a leftover folio_end_private_2() call after all calls to
> folio_start_private_2() had been removed by the commit.
> 
> By calling folio_end_private_2() without folio_start_private_2(), the
> folio refcounter breaks and causes trouble like RCU stalls and general
> protection faults.
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

[1/1] fs/netfs/fscache_io: remove the obsolete "using_pgpriv2" flag
      https://git.kernel.org/vfs/vfs/c/f7244a2b1d4c

