Return-Path: <linux-fsdevel+bounces-66314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE924C1C066
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59986406D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC4F3314BC;
	Wed, 29 Oct 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biOKv4m7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151ED334372;
	Wed, 29 Oct 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749727; cv=none; b=bugn+Zj4ekUpXcxErbhuB416zt9T9vKze2na7xtYGPugdlZATDarDBscPAzjMTW8DGmHe2lbWJ42ZCt/G4kK45xlmQtHm/JL/HZ0gsh3baz0jCeMQ1rA2EP36guoM2TP3JlG+iLyyyZ0kKPyxiFpW59DHHat5MUhE7ENkqKGsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749727; c=relaxed/simple;
	bh=Tf3oyzfvHzEyA7ChKDcF+F1C9VdlPPMCKrZKRQ2B/Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRb9ZraAUHHTetjiE+RCdDYuE/ir9Nyj0PoRPgmlFAOavBBV57OufQkI+gujrbDd5RAoN1pds56ZC+yfYBTxEZL8Tn3/CtdH0jnx1fd2LGyCKixtIoihZr7SbsnXU4Crw6ja0TFyk1AXjKlBeZFWsC55D2Jv+GtIS7yIcydP/Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biOKv4m7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ED5C4CEF7;
	Wed, 29 Oct 2025 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761749726;
	bh=Tf3oyzfvHzEyA7ChKDcF+F1C9VdlPPMCKrZKRQ2B/Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=biOKv4m7wm5QgfmYIY19pFWU37OsKh6W28igBr/pVfCzRSMugFui6y+Mg2XEeeIKg
	 XEUpW7JPqP0enoOY9wyo4NNkXQYp1uB+ySk9FGSfpRObWuv+D0rWkvtkSaktIBBJKG
	 ZqzP09NHDixfOKfkrHxvrptyvDq9ZWfKzzgRcQGwAjYhFTGaWZq7qGk7RL7eyi4bLQ
	 y/RQTj2xFUTYylf94XlffqMFgx9LhLoD2Pmla0NNXeqHt4vJLazKsSRx/PUPnn1A9h
	 i6zbxYi5W78KqZyT5E7WZ5NRpfCt63PPEYekAC+VHDphOILKgdYA2dKTpW7LXXh4du
	 sOmJN72vR5pqw==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	willy@infradead.org,
	dlemoal@kernel.org,
	hans.holmberg@wdc.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: allow file systems to increase the minimum writeback chunk size v2
Date: Wed, 29 Oct 2025 15:55:17 +0100
Message-ID: <20251029-heilung-amulett-1b15f6b0b9ef@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017034611.651385-1-hch@lst.de>
References: <20251017034611.651385-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; i=brauner@kernel.org; h=from:subject:message-id; bh=Tf3oyzfvHzEyA7ChKDcF+F1C9VdlPPMCKrZKRQ2B/Rs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyaV2/s8reN6vaXC+/4+oitkvnE2LZXovULT5eKxX67 I1C0r+ijlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlMzGZk+NM048DH59lhr3Qv rsz69DV/wrrCycV9ZtNN/xa2ffU+eZjhf4w1j1nr3Z3b3/2b3aykcpuTWXSvxoXmyQf99UMvZt6 YzQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 17 Oct 2025 05:45:46 +0200, Christoph Hellwig wrote:
> The relatively low minimal writeback size of 4MiB leads means that
> written back inodes on rotational media are switched a lot.  Besides
> introducing additional seeks, this also can lead to extreme file
> fragmentation on zoned devices when a lot of files are cached relative
> to the available writeback bandwidth.
> 
> Add a superblock field that allows the file system to override the
> default size, and set it to the zone size for zoned XFS.
> 
> [...]

Applied to the vfs-6.19.writeback branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.writeback branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.writeback

[1/3] writeback: cleanup writeback_chunk_size
      https://git.kernel.org/vfs/vfs/c/151d0922bf63
[2/3] writeback: allow the file system to override MIN_WRITEBACK_PAGES
      https://git.kernel.org/vfs/vfs/c/90db4d4441f5
[3/3] xfs: set s_min_writeback_pages for zoned file systems
      https://git.kernel.org/vfs/vfs/c/015a54407782

