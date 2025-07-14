Return-Path: <linux-fsdevel+bounces-54824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2F8B039ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 10:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8B91885AD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 08:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1323D23C4E3;
	Mon, 14 Jul 2025 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="py0ZCIOV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619202E3718;
	Mon, 14 Jul 2025 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483158; cv=none; b=WN/BRM14KxLWEgmJ7Fvvp1LO4jZMAPH3xbm3Lco5fFXmEb1yxXPw0PJswjjWHvgH1O7jb8Dc0gYBnfh6SbG7sXrteb1Vuq8CtXONw42Aqb3leOI5+5qFFnsg2i2EaPz3aaxNS93cCWB/TU/im4uUffrydahw2rv+5/nJCZLf9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483158; c=relaxed/simple;
	bh=FMNrS1Z1UilPJzSrb1Ap/6lM+9eqZRJQR6eXPg4Hlxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/ikDVFWF9WYB4VUQG5xqWMs7KGGTw2ZlXHAlVAMxAriqYAQ+kH3EpGzzouRlinYqQz0PC1rrk3ihSdacQpCU7hOY5ASkikNJ2lR0tsFhYx+oy1rooB8qSOGAPqUBRtlieGxBMYdQQ+Z7UGAA5IUd1du1WJIuj/bAzgNqAgricY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=py0ZCIOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADABC4CEED;
	Mon, 14 Jul 2025 08:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752483157;
	bh=FMNrS1Z1UilPJzSrb1Ap/6lM+9eqZRJQR6eXPg4Hlxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=py0ZCIOVIui3LKHdgAy9ffVUUf72EMbd0ZoWs6qMQc2905RrwGDd3SySm0k4zeV/l
	 NMki8OSXEU5962IcQn3u40q6UCo3C2xF6m864tCZzZTf3z6PQ48dxn7cXOhEw01cmi
	 B75+cIeYMA4/CKIua3oKVducjyMaVsP64oLLhDmyRqKzuATzVHYbkZynhndSh+Eg3L
	 nnJYtIIagI+IrtdRCmAuaEIgCMq+QaHm2iyuu77M70pGLk6g4GQrVHfkpVHvgjH120
	 SJFimMnKDu8XjxbkK8V75lMKw83KFmzLsDBOG1iNKYfYtRwl32YWf7TCoKDLdwcPm+
	 FTNDDbDfzwLsg==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: Re: refactor the iomap writeback code v5
Date: Mon, 14 Jul 2025 10:52:07 +0200
Message-ID: <20250714-untiefen-zonen-36da5ea68518@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710133343.399917-1-hch@lst.de>
References: <20250710133343.399917-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2905; i=brauner@kernel.org; h=from:subject:message-id; bh=y7lmWAifSLj+7kxdAkI5hCPYWKy8/kHG+/dQ0pKC5Ng=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSUHLWMDzx/1DbrLcs/fYvVr+JmNb9wXp2xZpHfdx1mu ffP22VFO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyfyXD/5Bp7mwzLG9JHP6a zZ6yo/HyIRetWytumgfsn/rJoH72rUyG/6kTG3cF/J+8KeWV/54Zj5SaPQT8XVo5ku2PTT2Xc9R 4CzcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 10 Jul 2025 15:33:24 +0200, Christoph Hellwig wrote:
> this is an alternative approach to the writeback part of the
> "fuse: use iomap for buffered writes + writeback" series from Joanne.
> It doesn't try to make the code build without CONFIG_BLOCK yet.

I dropped that sentence from the merge commit.

> 
> The big difference compared to Joanne's version is that I hope the
> split between the generic and ioend/bio based writeback code is a bit
> cleaner here.  We have two methods that define the split between the
> generic writeback code, and the implemementation of it, and all knowledge
> of ioends and bios now sits below that layer.
> 
> [...]

Applied to the vfs-6.17.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.iomap

[01/14] iomap: header diet
        https://git.kernel.org/vfs/vfs/c/8cd0a39cab56
[02/14] iomap: pass more arguments using the iomap writeback context
        https://git.kernel.org/vfs/vfs/c/67fd9615a782
[03/14] iomap: cleanup the pending writeback tracking in iomap_writepage_map_blocks
        https://git.kernel.org/vfs/vfs/c/40368a6acb95
[04/14] iomap: refactor the writeback interface
        https://git.kernel.org/vfs/vfs/c/fb7399cf2d0b
[05/14] iomap: hide ioends from the generic writeback code
        https://git.kernel.org/vfs/vfs/c/f4fa7981fa26
[06/14] iomap: add public helpers for uptodate state manipulation
        https://git.kernel.org/vfs/vfs/c/9caf1ea80ced
[07/14] iomap: move all ioend handling to ioend.c
        https://git.kernel.org/vfs/vfs/c/8f02cecd80b9
[08/14] iomap: rename iomap_writepage_map to iomap_writeback_folio
        https://git.kernel.org/vfs/vfs/c/58f0d5a30427
[09/14] iomap: move folio_unlock out of iomap_writeback_folio
        https://git.kernel.org/vfs/vfs/c/f8b6a94a4cca
[10/14] iomap: export iomap_writeback_folio
        https://git.kernel.org/vfs/vfs/c/8b217cf779cb
[11/14] iomap: replace iomap_folio_ops with iomap_write_ops
        https://git.kernel.org/vfs/vfs/c/2a5574fc57d1
[12/14] iomap: improve argument passing to iomap_read_folio_sync
        https://git.kernel.org/vfs/vfs/c/e6caf01d3f57
[13/14] iomap: add read_folio_range() handler for buffered writes
        https://git.kernel.org/vfs/vfs/c/c5690dd01978
[14/14] iomap: build the writeback code without CONFIG_BLOCK
        https://git.kernel.org/vfs/vfs/c/5699b7e21d20

