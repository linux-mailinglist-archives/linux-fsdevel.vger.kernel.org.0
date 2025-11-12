Return-Path: <linux-fsdevel+bounces-68040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A20C51B3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFE71889B29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 10:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19E32FFDE4;
	Wed, 12 Nov 2025 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwE9SkE4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BACE267B02
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943683; cv=none; b=smXhctdgzD2DDCfoyKRgsguuBkhBtEJaQk7n9ryGEhw+23LElAAIKTgiQVRD5noocJOiqbe4Xhed6x+9WF/eN5MN1Qeh2lsuvFJ9JO53a/wRAL53Ve1H4bT2fy9vT68aVfuFscAya63TRuUR2/OYa/m6tgVwuZRplMM+GlOyAnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943683; c=relaxed/simple;
	bh=2vG33zjVaWSRfnjXOQi6T2luGXpjj4r30wwUtiucVF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvKDb4UnPDBb0F9QZoB5iYfIb7ij7Dlc0xQSZjCZY1yCzpU6B2jgPDzAGH8DjDmamNK5DQWvGuUNKhmYxkdaeZJwDcMRsxIioKRPD1VgCe+8ecM3c7xHXM0EFZuX8lT5CYM4eJ1H+G3aG6bVvGPZ8QRC43ANW/wsKXSCchbEl7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwE9SkE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A86C2BC9E;
	Wed, 12 Nov 2025 10:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762943682;
	bh=2vG33zjVaWSRfnjXOQi6T2luGXpjj4r30wwUtiucVF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OwE9SkE4hr76C3XhPzG1c9UDAI9zITZzSRl9hcD/CMzJDhTp683KlsCY52R2aDMic
	 zV0+PNrCM0Ajs7cKtPK2JwlqIjYSAsLxdgzRqCNQ0CaUk/k14jv2AfxbOxBeFUohq4
	 9z2s4XBmpypcjKEAW+bJOud+Q5k9u7VcWnqBanbsMj5Rqetwhq36qGZvlC2KQesQoV
	 mdUYjXpcy3PUOImdq7lYlPw2LNHCYzBzVAlVPoKLl1Ls4s0kL6weuwzhXop0ehkHwm
	 BPkcQSPjYliNwf8VlWnxeXBj2kTK1WF9vdAwaLmGlUROksLB2YbewBUUs2XCZTa/Os
	 hcIcL85G+tFhw==
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 0/9] iomap: buffered io changes
Date: Wed, 12 Nov 2025 11:34:35 +0100
Message-ID: <20251112-zuerkannt-lobgesang-bdc74266e9c2@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111193658.3495942-1-joannelkoong@gmail.com>
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2008; i=brauner@kernel.org; h=from:subject:message-id; bh=2vG33zjVaWSRfnjXOQi6T2luGXpjj4r30wwUtiucVF8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKJO2rvFp8XO1X8oKEnVc+Xg22MTnFnSs24/D0jro0b 2bLYNOujlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInM4GT4zSJgn+/Ep9bX88pm wZuktyLd0krhc7svpSU//PZnWcrtiYwMv5lm5X183KDS9adxenXSzoTbq9cfVPloppRxZRP/cdl pvAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 11 Nov 2025 11:36:49 -0800, Joanne Koong wrote:
> This series is on top of the vfs-6.19.iomap branch (head commit ca3557a68684)
> in Christian's vfs tree.
> 
> Thanks,
> Joanne
> 
> Changelog
> ---------
> 
> [...]

Applied to the vfs-6.19.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.iomap

[1/9] iomap: rename bytes_pending/bytes_accounted to bytes_submitted/bytes_not_submitted
      https://git.kernel.org/vfs/vfs/c/a0f1cabe294c
[2/9] iomap: account for unaligned end offsets when truncating read range
      https://git.kernel.org/vfs/vfs/c/9d875e0eef8e
[3/9] docs: document iomap writeback's iomap_finish_folio_write() requirement
      https://git.kernel.org/vfs/vfs/c/7e6cea5ae2f5
[4/9] iomap: optimize pending async writeback accounting
      https://git.kernel.org/vfs/vfs/c/6b1fd2281fb0
[5/9] iomap: simplify ->read_folio_range() error handling for reads
      https://git.kernel.org/vfs/vfs/c/f8eaf79406fe
[6/9] iomap: simplify when reads can be skipped for writes
      https://git.kernel.org/vfs/vfs/c/a298febc47e0
[7/9] iomap: use loff_t for file positions and offsets in writeback code
      https://git.kernel.org/vfs/vfs/c/b94488503277
[8/9] iomap: use find_next_bit() for dirty bitmap scanning
      https://git.kernel.org/vfs/vfs/c/e46cdbfa2029
[9/9] iomap: use find_next_bit() for uptodate bitmap scanning
      https://git.kernel.org/vfs/vfs/c/608f00b56c31

