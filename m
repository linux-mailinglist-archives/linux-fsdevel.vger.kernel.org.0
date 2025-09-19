Return-Path: <linux-fsdevel+bounces-62224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F475B89690
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 14:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C08585DDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E209E3101D8;
	Fri, 19 Sep 2025 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vxm2VlYl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E07C311C3B
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284263; cv=none; b=E/iAFgDmMrPqhOgiSDsg4tCYnX07B9dYpYe6URMYwf+VipyvXKIcltaEIJKRj0xL3baMMZbnHLn0nARxphuXMGw4H5wFvxG+0GONpGCgxCDFJwkC61W3A2metREZeJSy7st1GYEJsBy22/oy6qJQq5elTgoufmiSAQBQ0QKxVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284263; c=relaxed/simple;
	bh=m0MvJjCFaTA9+3zLFtb524MPkBqT8ijZrhjKMYdpXs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XH4i9d02ZCE8mj5sn/vGK6MviyCZVRxK5ILv/nPFUnfYBKxGNeR6rO/aihjFkqcfn2XXquqy9WHqlkpEwL1b+cG2QKmjtGGVII4x8DpB0MRbYOwOIkHHBi228iVnlz0yUYIz6/ghc9AJd8uzjWT5ieeOGA4JgaztBuvPbz+CsBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vxm2VlYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FA9C4CEF1;
	Fri, 19 Sep 2025 12:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758284262;
	bh=m0MvJjCFaTA9+3zLFtb524MPkBqT8ijZrhjKMYdpXs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vxm2VlYlGXdxdozVrnP4pZnlyyGppQZ0PMi0AYC7vQPB3NAkQA5Z9uyqCaO8sUQrq
	 iKX/yAtGYc+Eq8Ejoa1KaUG2a8ifbpDSGs1vujvWm9V0lOYTFI7X4E1ccmlgc62Pby
	 QfiIhOntcH16hU/IsSUmMRd8GoVoG4GShghD0OJ1AxZdZhBn5PLAHO+Z5rb8HjFdes
	 BN3G7BUKRVO6CWpJ3VfrK2AQbGUXjY/LVti9/PQI5FScXtTgIObZoD1lpNUfGaaN6h
	 66mZnck8i4EgZj8D+1BpqDTHnuF+LWQFUkCIQIUvHYzEWtVN+ma6jqRi+6E4tYpi+Q
	 fiowMXC/lwXsA==
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHSET v5.1] iomap: cleanups ahead of adding fuse support
Date: Fri, 19 Sep 2025 14:17:38 +0200
Message-ID: <20250919-eisblock-pferde-d5d6190f82be@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <175803480273.966383.16598493355913871794.stgit@frogsfrogsfrogs>
References: <175803480273.966383.16598493355913871794.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285; i=brauner@kernel.org; h=from:subject:message-id; bh=m0MvJjCFaTA9+3zLFtb524MPkBqT8ijZrhjKMYdpXs4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc9Xw0obtMd1mXjROT9auPdk6Xj6XP4+g7Njs8S8S5/ JbKNwmpjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlMnc/I0J0yue/cjABxjbUs 1z0fXV4zp2JRXQ2T4u00Ta5ApdApbxn+im3OnenJwHKQcUvjusqbjSc3niluPKEawfJ8utvmBWb 57AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 16 Sep 2025 08:00:24 -0700, Darrick J. Wong wrote:
> In preparation for making fuse use the fs/iomap code for regular file
> data IO, fix a few bugs in fuse and apply a couple of tweaks to iomap.
> These patches can go in immediately.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> [...]

Applied to the vfs-6.18.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.iomap

[1/2] iomap: trace iomap_zero_iter zeroing activities
      https://git.kernel.org/vfs/vfs/c/231af8c14f0f
[2/2] iomap: error out on file IO when there is no inline_data buffer
      https://git.kernel.org/vfs/vfs/c/6a96fb653b64

