Return-Path: <linux-fsdevel+bounces-43422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D996A56736
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 12:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA191899223
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 11:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D942185AC;
	Fri,  7 Mar 2025 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1fW41S/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ABF217F2E;
	Fri,  7 Mar 2025 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348594; cv=none; b=YfCuxAlmFUN51op05Z331IpHAJtFxxKLrM9krIPVUBGuZMtjMvH2S9VvzuWBj1i52NZEN+SffkENWNEtVgSjRwzKU5KDNhMTi8xdBxl0xw9mWPf3r3Z6iel9rmeI0AYUVGY5+uCkjAZVo/Fo8yR241944lh3zp+N+hescQEr/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348594; c=relaxed/simple;
	bh=oAFciDR1Vxq86btuDLpOuRTtkzHNuS6NA8tiIfER8p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKls/xkr6AD0Dx7OOC24WWjGqIU6NXGE91uzjmsDoCXSHfbTBCDgOc6KLDpvuHEr3uKPeWG3Fz4oTX9V29zxwXoM850hquwgAy9QRVSd1KhoI2N+hSlXstZY69F+bdXQI4ZbXD+NQCP8UA7+nlPfebOMC9KpQubU9vvgfDXbPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1fW41S/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266E3C4CED1;
	Fri,  7 Mar 2025 11:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741348593;
	bh=oAFciDR1Vxq86btuDLpOuRTtkzHNuS6NA8tiIfER8p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O1fW41S/oxubBOUvCGjbLNC+Xp9M1sGgGcwr3o+d2dKGpb963DnDHadM4DQ1pMaKz
	 y8r7XoXAbke0VuoyF3q41E+ZPpfvTMXqz2e5TLV3mA38+NIqSLb/3l4yjkGj+HDF0b
	 WklHcY1xEZwrXy++v/PWnJqNrJ7QDzXV3Jg/jDSRNgwhFRoQb5gpnuVtED/qJ9SDY5
	 TkjxaJAxSEce/WJsNdJ7VjmAxr37iUAVZpc4qbylsK20EwAoOvSNTYmo8RUREwfe+C
	 c0DwSv6JQDvFTcuVFEvfKMZbni0RqYRePC0r+KOm3lND2NdJIcLCY0OEc1cOsjK+Oi
	 3sxN5M9JKMP/g==
From: Christian Brauner <brauner@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	kbusch@kernel.org,
	john.g.garry@oracle.com,
	hch@lst.de,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	Kent Overstreet <kent.overstreet@linux.dev>,
	hare@suse.de,
	willy@infradead.org,
	david@fromorbit.com,
	djwong@kernel.org
Subject: Re: [PATCH v2] bdev: add back PAGE_SIZE block size validation for sb_set_blocksize()
Date: Fri,  7 Mar 2025 12:56:17 +0100
Message-ID: <20250307-vertiefen-nordost-369b80cc1925@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250307020403.3068567-1-mcgrof@kernel.org>
References: <20250307020403.3068567-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613; i=brauner@kernel.org; h=from:subject:message-id; bh=oAFciDR1Vxq86btuDLpOuRTtkzHNuS6NA8tiIfER8p8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfuveS6d6PvDC3+kNyb6YZ96+N7Xr3Y65rntH6J0efz vDZyrP/UkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEzrAy/OE5ahIj82yjc2tr +i0J4Zr6FtHo+C7W/zwtjzS2PChn6Gdk+LX13wplyXlZPs8mbg74nRFttXfhhuADj2bt/XVdVKp agR8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 06 Mar 2025 18:04:03 -0800, Luis Chamberlain wrote:
> The commit titled "block/bdev: lift block size restrictions to 64k"
> lifted the block layer's max supported block size to 64k inside the
> helper blk_validate_block_size() now that we support large folios.
> However in lifting the block size we also removed the silly use
> cases many filesystems have to use sb_set_blocksize() to *verify*
> that the block size <= PAGE_SIZE. The call to sb_set_blocksize() was
> used to check the block size <= PAGE_SIZE since historically we've
> always supported userspace to create for example 64k block size
> filesystems even on 4k page size systems, but what we didn't allow
> was mounting them. Older filesystems have been using the check with
> sb_set_blocksize() for years.
> 
> [...]

Applied to the vfs-6.15.pagesize branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.pagesize branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.pagesize

[1/1] bdev: add back PAGE_SIZE block size validation for sb_set_blocksize()
      https://git.kernel.org/vfs/vfs/c/a64e5a596067

