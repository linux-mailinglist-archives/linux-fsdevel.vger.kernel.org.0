Return-Path: <linux-fsdevel+bounces-26900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB8095CC73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 14:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6339F285407
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF79185B59;
	Fri, 23 Aug 2024 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgD5VoXW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621339457;
	Fri, 23 Aug 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416620; cv=none; b=hzi+oJz4rB74a+3lPhg2Qp36/nXK9kUKVuuo8btmiFiFhIX3lCvdeXXgLU9ZVo95dFFd4g5OIu+Z+eaDAlFXizg4g8aH2cqx4RzvnDj/cNAhTnCaV9igyGu3+l/jOTZoocq/ZWBokqT81fqMu88S3VuT6vw7KohLMAjd10B200Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416620; c=relaxed/simple;
	bh=wJm/cK61ICsrxHTxRJLxc2PoHQxXnV6Nne6+HqDiJW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgEm23S2YuUNdb87zk9MnUO+nNvHLHm6huIoosEUuRPZ9Hv4RN8XUxvX4907a8c4njIzv010JG19pT9ehGG1zCHBwKL0PHra2xH2ED+oFMVuZ99FKPB/AjjeLrtb9IZE3jvhlfZo6F1jdHuYpq9phMGWvcKSMnPlkJLeA7dnPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgD5VoXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DE4C32786;
	Fri, 23 Aug 2024 12:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724416620;
	bh=wJm/cK61ICsrxHTxRJLxc2PoHQxXnV6Nne6+HqDiJW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QgD5VoXWbeZLTru9Tt25aCYhK02rbbQac4qidyVHfGzE+bV8LU4NPLi4BMcFJEsSV
	 Mja9oOTr8okQXOVansqh1krU3Cdl0UkXQ++CuZqDD7wNa7LEQMqfo1uq9OTEiVMqLG
	 6XCFsnL4xDGQi3XY77gs5evZpPZn1oWkCHRKqKjeLUJ550XFskgHz+Nngj497f8GsC
	 YNwH43SjXX7y4e/I/AHcpp8/0sf/Ze2I/tdzCQjx2h6eKRwg/I0bNiYx3MdTPoxX8L
	 s6RwuOf9mnw/xOXzbBtTUBcWJj28i/GZYwqXsXfHwVZF5Ur2JSlw5ytJE1Gqb1tD8U
	 yS1VVo76yrUHA==
From: Christian Brauner <brauner@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org,
	djwong@kernel.org,
	hare@suse.de,
	gost.dev@samsung.com,
	linux-xfs@vger.kernel.org,
	hch@lst.de,
	david@fromorbit.com,
	Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	john.g.garry@oracle.com,
	cl@os.amperecomputing.com,
	p.raghav@samsung.com,
	ryan.roberts@arm.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH v13 00/10] enable bs > ps in XFS
Date: Fri, 23 Aug 2024 14:36:42 +0200
Message-ID: <20240823-anstieg-nachwachsen-be47155a7797@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822135018.1931258-1-kernel@pankajraghav.com>
References: <20240822135018.1931258-1-kernel@pankajraghav.com> <ZsesYqVivEAToPUI@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2513; i=brauner@kernel.org; h=from:subject:message-id; bh=wJm/cK61ICsrxHTxRJLxc2PoHQxXnV6Nne6+HqDiJW4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdaIrLviV+VlbhcaZ103ODmJXf29vOvTnKV1taYex2c v1Ng/8KHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABORfsPwP2zF82efLh7WelQn lbx56vdLCzYlJnn5PpzyUPTTMY+0HU8ZGf7mBDRzz3s+SaMhbUlH7MLY1pjVd4XCnkzdJpH4wGP +Ik4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 22 Aug 2024 15:50:08 +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> This is the 13th version of the series that enables block size > page size
> (Large Block Size) experimental support in XFS. Please consider this for
> the inclusion in 6.12.
> 
> The context and motivation can be seen in cover letter of the RFC v1 [0].
> We also recorded a talk about this effort at LPC [1], if someone would
> like more context on this effort.
> 
> [...]

I've rebased this onto v6.11-rc1 and did a test compile for each commit
and ran xfstests for xfs. Looks good so far. Should show up in fs-next
tomorrow.

---

Applied to the vfs.blocksize branch of the vfs/vfs.git tree.
Patches in the vfs.blocksize branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.blocksize

[01/10] fs: Allow fine-grained control of folio sizes
        https://git.kernel.org/vfs/vfs/c/e8201b314c01
[02/10] filemap: allocate mapping_min_order folios in the page cache
        https://git.kernel.org/vfs/vfs/c/c104d25f8c49
[03/10] readahead: allocate folios with mapping_min_order in readahead
        https://git.kernel.org/vfs/vfs/c/7949d4e70aef
[04/10] mm: split a folio in minimum folio order chunks
        https://git.kernel.org/vfs/vfs/c/fd031210c9ce
[05/10] filemap: cap PTE range to be created to allowed zero fill in folio_map_range()
        https://git.kernel.org/vfs/vfs/c/e9f3b433acd0
[06/10] iomap: fix iomap_dio_zero() for fs bs > system page size
        https://git.kernel.org/vfs/vfs/c/d940b3b7b76b
[07/10] xfs: use kvmalloc for xattr buffers
        https://git.kernel.org/vfs/vfs/c/13c9f3c68405
[08/10] xfs: expose block size in stat
        https://git.kernel.org/vfs/vfs/c/4e70eedd93ae
[09/10] xfs: make the calculation generic in xfs_sb_validate_fsb_count()
        https://git.kernel.org/vfs/vfs/c/f8b794f50725
[10/10] xfs: enable block size larger than page size support
        https://git.kernel.org/vfs/vfs/c/0ab3ca31b012

