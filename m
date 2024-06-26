Return-Path: <linux-fsdevel+bounces-22487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D143918086
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3F628377A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F2C180A80;
	Wed, 26 Jun 2024 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9RSHzt7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810C180A76
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403537; cv=none; b=G56WxPc5cJ0A4DLq5/4k5W7LXrnQMfKnN0hMpjzdFBnYhtR6JSz09zdq5buDYCtGjqHLtE1M23xqtJR9DwOQRicTIBuy9u88sJ8yBK7xME/A0LMVIMWYmr1H/evWqJ0z55b+4uttVvSUK/rbH29Wvm2w4eTr9EAJgYUQzgG51yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403537; c=relaxed/simple;
	bh=2qATlfpOqGVz8nAkHzYagUGZQkhQM0eXbfdnVhDn0BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNGWBM5Y2f2M2Af1yWphWllmaJc9iBX4mE8rbjNfldprYPTC2zJ+55eOyzBFm/amzF80JJ+fo65Xpz7NtFPKEqmFep4SuhjD6X1rZQCK8BiEJvdA5KSuUUAO0BBw7UK3PPUoQG0xEupRH+E0Hpz7JWxZG7Yia4KApt1c0eB8Fw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9RSHzt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B803C2BD10;
	Wed, 26 Jun 2024 12:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719403537;
	bh=2qATlfpOqGVz8nAkHzYagUGZQkhQM0eXbfdnVhDn0BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9RSHzt7+ovBt+vuIJ2GisIilEsolZtIeSeBHrdO3MbWB/CkF5PWe2gl5OareQ/D5
	 TUC44s2QrN0WQX1jK8Tj1nZjUvToqpwRt3FQUPSdZZsSYxhrUr0WF3nNKJ8k3OgMQ9
	 UoReNEsGbmLZ0FMdYtMKGfHToMI4JpuojQBWub/OVT81EHnKmTzWledC61WBdZiyLU
	 fAeJDRhXmePiEiAy5yM53odJWWFv64s7iEo3L6DyD0KT7CBarxeuYa/ZJomLXWD+pX
	 LBqVXgmrMnJCp2CBPd4aP7YsT5NLiFUBlYbcyA8+LdaHFFcofLPCXsFLyRLOZIIpG0
	 xd9BMSpRpUmtw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>
Subject: Re: (subset) [PATCH 0/4] Add the ability to query mount options in statmount
Date: Wed, 26 Jun 2024 14:03:48 +0200
Message-ID: <20240626-pfirsich-geworben-2e4ab43da783@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719257716.git.josef@toxicpanda.com>
References: <cover.1719257716.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=brauner@kernel.org; h=from:subject:message-id; bh=2qATlfpOqGVz8nAkHzYagUGZQkhQM0eXbfdnVhDn0BA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTVsHA5xnZuNzdaXye227stYX5kkOwhxX45DrEFy1Ruf eHjtlPpKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIihBCPDxbI44w+C6oxx+xfv S5++VEdlpZNmQ8py5jlGXwy+8M32Y2RYba0t9v++QmRYmsMUBWbFvDTtlOLuQwvs39vwvtjYc4k VAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 24 Jun 2024 15:40:49 -0400, Josef Bacik wrote:
> Currently if you want to get mount options for a mount and you're using
> statmount(), you still have to open /proc/mounts to parse the mount options.
> statmount() does have the ability to store an arbitrary string however,
> additionally the way we do that is with a seq_file, which is also how we use
> ->show_options for the individual file systems.
> 
> Extent statmount() to have a flag for fetching the mount options of a mount.
> This allows users to not have to parse /proc mount for anything related to a
> mount.  I've extended the existing statmount() test to validate this feature
> works as expected.  As you can tell from the ridiculous amount of silly string
> parsing, this is a huge win for users and climate change as we will no longer
> have to waste several cycles parsing strings anymore.
> 
> [...]

* Changed to only call sb->d_op->show_options() so we only show filesystem
  mount options.
* Fixed/tweaked selftests to parse /proc/self/mountinfo directly and look for
  mount options, skipping over vfs generic superblock mount options.
* Since Karel is fine with keeping "," let's keep it.

---

Applied to the vfs.mount branch of the vfs/vfs.git tree.
Patches in the vfs.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount

[1/4] fs: rename show_mnt_opts -> show_vfsmnt_opts
      https://git.kernel.org/vfs/vfs/c/429fc05aefd3
[3/4] fs: export mount options via statmount()
      https://git.kernel.org/vfs/vfs/c/f363afa8cbe0
[4/4] sefltests: extend the statmount test for mount options
      https://git.kernel.org/vfs/vfs/c/06bedc037f74

