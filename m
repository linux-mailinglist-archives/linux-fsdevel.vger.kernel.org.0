Return-Path: <linux-fsdevel+bounces-5460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B480C6F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 11:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92810B21079
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 10:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D794F2577D;
	Mon, 11 Dec 2023 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLcRQhqp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DB215AD8;
	Mon, 11 Dec 2023 10:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A87DC433C8;
	Mon, 11 Dec 2023 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702291551;
	bh=C9SWpDe50LejcoRBfB5+9Vj9FrSJV2LSQGio56TrmEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aLcRQhqpmVpI6Pe9RDF2UNzcNAgB0MvorxxDR0SVutDFClSz3hRe4moFXkhDKa0Th
	 wLYlvqwCxenK0kcC9N/+kL7d+R+UoDsebx+0ng2n+OD+JF15KlS0WX6OsAAKK0y3Xu
	 sW1rEdOgTe51bvkpHLKkOqVcjzJZUbfA+X0wWq3tlpzE/JjgphWlXaf4iW1vNOtJx1
	 IbQ0A9Xkj3Abr+Gw+uNxyjPpCF00bR+qy38ZI4UEV1HjwdgD3jPkH+T+Pa2/JsuMud
	 cNIUo59OgmF3KjRMgw/2RccwyW5N3xMQxp7udZCZ0ujv+XwrqaU7FumdH6YQP7HJds
	 DBcKwhaOFEQjQ==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: Re: map multiple blocks per ->map_blocks in iomap writeback
Date: Mon, 11 Dec 2023 11:45:38 +0100
Message-ID: <20231211-listen-ehrbaren-105219c9ab09@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231207072710.176093-1-hch@lst.de>
References: <20231207072710.176093-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3026; i=brauner@kernel.org; h=from:subject:message-id; bh=C9SWpDe50LejcoRBfB5+9Vj9FrSJV2LSQGio56TrmEM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSWvQgsjp5xwY3H+uAOockT/dOVbKMfTT0qOeXhz7REq dl6XPOXd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykaSUjw8V3zx7tmbrUxHdj 5XKv0tJ3B8QDVmaVqjzv3iFoa/szfjUjwwqT1B9ijBavMnMu3L6172Ad77R3S/TPdHB+eei3Ziv fUU4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 07 Dec 2023 08:26:56 +0100, Christoph Hellwig wrote:
> this series overhaults a large chunk of the iomap writeback code with
> the end result that ->map_blocks can now map multiple blocks at a time,
> at least as long as they are all inside the same folio.
> 
> On a sufficiently large system (32 cores in my case) this significantly
> reduces CPU usage for buffered write workloads on xfs, with a very minor
> improvement in write bandwith that might be within the measurement
> tolerance.
> 
> [...]

Darrick, Christoph, I gave us a separate branch for this. I thought about
putting this on top of vfs.misc but I feel that this would be a bit ugly.
Different layout is possible though.

---

Applied to the vfs.iomap branch of the vfs/vfs.git tree.
Patches in the vfs.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.iomap

[01/14] iomap: clear the per-folio dirty bits on all writeback failures
        https://git.kernel.org/vfs/vfs/c/7c821e1f5a5a
[02/14] iomap: treat inline data in iomap_writepage_map as an I/O error
        https://git.kernel.org/vfs/vfs/c/6571f184afe3
[03/14] iomap: move the io_folios field out of struct iomap_ioend
        https://git.kernel.org/vfs/vfs/c/e5f9e159cf10
[04/14] iomap: move the PF_MEMALLOC check to iomap_writepages
        https://git.kernel.org/vfs/vfs/c/fc51566e62ef
[05/14] iomap: factor out a iomap_writepage_handle_eof helper
        https://git.kernel.org/vfs/vfs/c/89d887160535
[06/14] iomap: move all remaining per-folio logic into iomap_writepage_map
        https://git.kernel.org/vfs/vfs/c/6d3bac5014bf
[07/14] iomap: clean up the iomap_alloc_ioend calling convention
        https://git.kernel.org/vfs/vfs/c/d7acac8ed175
[08/14] iomap: move the iomap_sector sector calculation out of iomap_add_to_ioend
        https://git.kernel.org/vfs/vfs/c/a04db4e40bdb
[09/14] iomap: don't chain bios
        https://git.kernel.org/vfs/vfs/c/7a579e360d15
[10/14] iomap: only call mapping_set_error once for each failed bio
        https://git.kernel.org/vfs/vfs/c/a64f2b75da6b
[11/14] iomap: factor out a iomap_writepage_map_block helper
        https://git.kernel.org/vfs/vfs/c/3853862b0b77
[12/14] iomap: submit ioends immediately
        https://git.kernel.org/vfs/vfs/c/ae00bec07dee
[13/14] iomap: map multiple blocks at a time
        https://git.kernel.org/vfs/vfs/c/2487070c95f4
[14/14] iomap: pass the length of the dirty region to ->map_blocks
        https://git.kernel.org/vfs/vfs/c/a828782eaff6

