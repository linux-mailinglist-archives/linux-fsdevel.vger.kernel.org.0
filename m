Return-Path: <linux-fsdevel+bounces-33062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644669B3076
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 13:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2877B282921
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 12:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA791DAC8E;
	Mon, 28 Oct 2024 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi/wilZE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768281DA0EB;
	Mon, 28 Oct 2024 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119084; cv=none; b=RhV2JqZPQbfK9RwtQzY+4VUFIPgRX5NPF8Y8vBOFhFpzSsRVVZX60nhGmirX2KAw7yANzV7j/aiQSMh5i8/h+luMgKPLz9HV4x+0XBSk2W7hKNXs39VhWhFDhKuTG86ROeDdbD7pWCU8/eaNGOeUOHv8lW5XRbwAOthO3L//wfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119084; c=relaxed/simple;
	bh=NqmQvkSNrzmvc95bi7m+zsa58QtgzwY83REKZHIaAVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeQGTafaK8ivCr4OHNKQEczxXaCpy9DKVh88D6AHVCTwIiuhs5ziGFc/MsQIC6cr+AtOFf3q/wds41VasXhWC2Cb7o8eSBDoLymwhJkvc1qAFYm3xU0kFKrPv/+G5VS9olwLR/MdCpyXVFbQgqlBqospIjL8I5Ta/pHkmA5DAwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi/wilZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDA0C4CEC3;
	Mon, 28 Oct 2024 12:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730119083;
	bh=NqmQvkSNrzmvc95bi7m+zsa58QtgzwY83REKZHIaAVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qi/wilZE/fumEMCmXEmxt4ohnNPjbdJLPzteXFtpE3jdzVzhxnqx7/5q/kG+64sym
	 rr9QaZxVAcl47vKl6+3Bm/QCYVbez6k4/O69I3DsxZwQve2VK+VswGf+4dlIahQz1Q
	 fqKKJbTHVDhqLUK9xD1gRzftZaUCCWepagjMncyubRrGa4d+I3ZsiX+km3ta3D+w9I
	 VyUlpHoxTtjTaYyL0xOBP4CmqqyWIyhJfsBfKpZGfmhZMBA7yV+FTxgePcBg+HQ4vw
	 SGPpv1QruJin/kukNpjdinxBk08HI3LxNB646Q0DAUtUnDlfRYSf3THONovUf2vnfr
	 Acxvf2RxeoQxQ==
From: Christian Brauner <brauner@kernel.org>
To: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Cc: Christian Brauner <brauner@kernel.org>,
	kernel-dev@igalia.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Gabriel Krisman Bertazi <gabriel@krisman.be>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gabriel Krisman Bertazi <krisman@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	smcv@collabora.com
Subject: Re: [PATCH v8 0/9] tmpfs: Add case-insensitive support for tmpfs
Date: Mon, 28 Oct 2024 13:37:45 +0100
Message-ID: <20241028-weinkarte-weshalb-1495cc5086ab@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
References: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089; i=brauner@kernel.org; h=from:subject:message-id; bh=NqmQvkSNrzmvc95bi7m+zsa58QtgzwY83REKZHIaAVA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTLty4SjWyV+euxuTR8W9hd5z/znucEadfnFC7L+dlpw WXL8f1aRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET+9DP8j/3isG+TaObMzqKb dn8nvJ8k+Pzvnt+y91SqV0k+TYtlz2X4wzPzZWiecewxuTmrzRh+bz3zdH33RYvOyAx/Oend60t +cAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 21 Oct 2024 13:37:16 -0300, André Almeida wrote:
> This patchset adds support for case-insensitive file names lookups in
> tmpfs. The main difference from other casefold filesystems is that tmpfs
> has no information on disk, just on RAM, so we can't use mkfs to create a
> case-insensitive tmpfs.  For this implementation, I opted to have a mount
> option for casefolding. The rest of the patchset follows a similar approach
> as ext4 and f2fs.
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

[1/9] libfs: Create the helper function generic_ci_validate_strict_name()
      https://git.kernel.org/vfs/vfs/c/0e152beb5aa1
[2/9] ext4: Use generic_ci_validate_strict_name helper
      https://git.kernel.org/vfs/vfs/c/3f5ad0d21db8
[3/9] unicode: Export latest available UTF-8 version number
      https://git.kernel.org/vfs/vfs/c/04dad6c6d37d
[4/9] unicode: Recreate utf8_parse_version()
      https://git.kernel.org/vfs/vfs/c/142fa60f61f9
[5/9] libfs: Export generic_ci_ dentry functions
      https://git.kernel.org/vfs/vfs/c/458532c8dfeb
[6/9] tmpfs: Add casefold lookup support
      https://git.kernel.org/vfs/vfs/c/58e55efd6c72
[7/9] tmpfs: Add flag FS_CASEFOLD_FL support for tmpfs dirs
      https://git.kernel.org/vfs/vfs/c/5cd9aecbc72c
[8/9] tmpfs: Expose filesystem features via sysfs
      https://git.kernel.org/vfs/vfs/c/5132f08bd332
[9/9] docs: tmpfs: Add casefold options
      https://git.kernel.org/vfs/vfs/c/a713f830c903

