Return-Path: <linux-fsdevel+bounces-24595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFCA940FC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 12:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEBF2816BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 10:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BF619F460;
	Tue, 30 Jul 2024 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9qFpIo0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C919EED3;
	Tue, 30 Jul 2024 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335833; cv=none; b=FLJZJ+ngMITkPFQCyeqlBM9u6zv1zGlXtQeXr+rJwj9NcVCd6LvigNi4M0gvDMcpLdjx3vZCtNA6vjCip3v6euW4PhA7XhpXLtLWNlLPa/lH+vR7zdynOU5iHoUH2QDl4dyib1+d0OOxuKWgvf1ImgfuW+BaSBilQBLkmF/yUPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335833; c=relaxed/simple;
	bh=M4eg2RA2dVioVZclF6JHvBR8dH2//m8JYd+0R0imYZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oS4hArUrx6Prr7CfWwKMfARlYg2SgGEowgRNKc8G/IaU0+Ek/SWet4JPz1Amuc+VJ8asIALEFWKUv8+HRgypCEEYvEqySjIv4Mtc6ACfdTp+12yC4uyukGBnJ/DXpnhjbpxm/Aa64HrZUV18RdhceKCUPjTatH9jViqlNv2EBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9qFpIo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF37C4AF09;
	Tue, 30 Jul 2024 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722335832;
	bh=M4eg2RA2dVioVZclF6JHvBR8dH2//m8JYd+0R0imYZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9qFpIo0XG2+as2sCBNP421gFXLGXitO22buNn5D+6stzkGoS9HaPxRMQqxX3xjf9
	 5e0x5+W/0YeRenNHJORfGa8KySj2GvC6/qYC74VKf3edqHJZtBdtU5wUEgxTiZIys7
	 dtAHSf71IblUjBJwJH68PfzO3Oy280ihPuDRIAMonzaoO+YKFYnoMFsAqUi1uDtKS/
	 ThKrqUheO+S2RtVhc0ZR4X0gXngw7CFN4oA0Dkj1d8hCBRHiH9HWcB81smZLZRrvxd
	 nLBYxt6mb/TF5Zv0aaFYjMjJ9kKYa+4zqrmAkyowfILhIoIbYwVRdRFZFEBp1JM1j5
	 LqOnkS4Ymt4sw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gao Xiang <xiang@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: (subset) [PATCH 00/24] netfs: Read/write improvements
Date: Tue, 30 Jul 2024 12:36:50 +0200
Message-ID: <20240730-kaschieren-glitten-89d803c5d4ae@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=brauner@kernel.org; h=from:subject:message-id; bh=M4eg2RA2dVioVZclF6JHvBR8dH2//m8JYd+0R0imYZA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaStOOQfILK00PPW9Etftt1+ufrx1Tc7OsPuXM7c9UVy9 72fTsfXtXaUsjCIcTHIiimyOLSbhMst56nYbJSpATOHlQlkCAMXpwBM5PF/RobHbwN1fQ3vrlPe zSXvY39gUXmtoiHrhCNck4/oH0uNlIph+MO777/y1U2XvSv+ZVQlPeSt+/k3J6znVvq6zOVlMw5 vUuYBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 29 Jul 2024 17:19:29 +0100, David Howells wrote:
> This set of patches includes one fscache fix and one cachefiles fix
> 
>  (1) Fix a cookie access race in fscache.
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

[01/24] fs/netfs/fscache_cookie: add missing "n_accesses" check
        https://git.kernel.org/vfs/vfs/c/965a561e4026

