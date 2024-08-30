Return-Path: <linux-fsdevel+bounces-28044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BFD9662AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FF7281451
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F691AD5EB;
	Fri, 30 Aug 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ty5bAm6t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35861509BF;
	Fri, 30 Aug 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023545; cv=none; b=tZhIi89nC4kZzkx9UYNeiADPGulmpKVTxzyDFay9iPtJokwS+lq8e2fspG+A9wEGYlbnB6BXuZQmBtIzGSR7r9U88IECc4htqMSO96lF5gGMc6QjCIos2KcxNfoLuuhv28GHM1ge/ueTbdouzr7E9e7b0qjkis3bi3o426LTbjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023545; c=relaxed/simple;
	bh=WndIbO8xrC2aIrGdqBcilJuDXzO/BXzIA8VlzOJWcDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mc5Ianf6Qbk43jxiIjfMDTV5/OIoagTHVTLJQK/MkOc8h9JP8kO3u5zcEPHYsLPyUhTM93LZPXFS61TADHOHjEa7Ra0SoPwaQWYIYvcngVy3iOI7/Nzp67Ky518HGyaimIOd0q8lcd+EoXiFi6rUfqreFIBcCmPF8yq/FUrp4qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ty5bAm6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2B4C4CEC2;
	Fri, 30 Aug 2024 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023543;
	bh=WndIbO8xrC2aIrGdqBcilJuDXzO/BXzIA8VlzOJWcDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ty5bAm6tFv6bg4YA3HAyot4VdLW2RJKGdG1xvdXVogremu8LD3BqEh4VHwGPQbh1p
	 g5wB6d5xMedceeupVFRBiOJF2X1RQbXR7I/eTH3weokE6ad0t6Ezo6vHjcDKPVbTlB
	 Z3S4gJVFjrB6hycktKp1ueGv6wungGZ3cKnt0wXInlgTLGxuCAHj3w8ZYHqjF+GFUB
	 QTyvsjOBPVrVpsZuumcYH8TAjCVp5l1eYu4rXoVRWjPjq8sCLqJLVtHIh6i3fVU/nI
	 SVYRAvH1Ts46AhfsHIwkNzc0SvAJDkfT/NWnyDPoWUXLCHntm7LX/eW8iyDDIh7MGs
	 GI0a1819kd2HQ==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	devel@lists.orangefs.org,
	Steve French <sfrench@samba.org>
Subject: Re: (subset) [PATCH 4/6] mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
Date: Fri, 30 Aug 2024 15:12:02 +0200
Message-ID: <20240830-anteil-haarfarbe-d11935ac1017@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828210249.1078637-5-dhowells@redhat.com>
References: <20240828210249.1078637-1-dhowells@redhat.com> <20240828210249.1078637-5-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=brauner@kernel.org; h=from:subject:message-id; bh=WndIbO8xrC2aIrGdqBcilJuDXzO/BXzIA8VlzOJWcDo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPKr76Dezq5ehzM4jKYrG1ftWrXx6vvm+7LaNC7uZV E+srfHd1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRR5oM/1T7Tb2YfR5sYXnu FDtjHaviHxfHAmW1+apKn47PLwxJcWBkWDj/YHmXY6+ZxwZFZ420TYu1Jiiw5DG/WmQs9an18sQ 6HgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 28 Aug 2024 22:02:45 +0100, David Howells wrote:
> Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
> rather than truncate_inode_pages_range().  The latter clears the
> invalidated bit of a partial pages rather than discarding it entirely.
> This causes copy_file_range() to fail on cifs because the partial pages at
> either end of the destination range aren't evicted and reread, but rather
> just partly cleared.
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

[4/6] mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
      https://git.kernel.org/vfs/vfs/c/c26096ee0278

