Return-Path: <linux-fsdevel+bounces-26901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA8995CC83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 14:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC031C233E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 12:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8681865F5;
	Fri, 23 Aug 2024 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqr7a4k+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A496185B70;
	Fri, 23 Aug 2024 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416789; cv=none; b=WdFCcEPrcNUQcM8+bsUdx9V4Ye+e2ecGxv2Be8+gXFEb9ZmJFpnYWzXCrJnCoyt8Qym8K6Hm9zSaQwBxaSAqCq9FUKCbEI0GjI/2jqNSE1+xgPV50nnT56SYETGlEiuhb9F3+Bvg/qSuZGbXmlnirEOKe0jhx3rZCQIgpJozVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416789; c=relaxed/simple;
	bh=OQN7Mf7HQDUQaFApg1+V9RgbCzXwyxIPK7zuLgztQ10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4Iy58aDqMM5/otSEiZEI+1chBtHNHaq7IgVYtYB7XDVfmH9Hmb0eTajIeAnOVg//CCtHVX4zCFBu8L1+XFRNBXLAS+xREmKB47QjNNM3D++EwrKvsOtJ+g9oN18dx5HGEk5p/oP7v/iv598TEJffhcODImVBuYdvXimKEvzpXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tqr7a4k+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292C2C32786;
	Fri, 23 Aug 2024 12:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724416788;
	bh=OQN7Mf7HQDUQaFApg1+V9RgbCzXwyxIPK7zuLgztQ10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tqr7a4k+ccRM4DsoOY2ydy+JCEJZDrohUYfQJAvlzdh5t8ixJwsUBY0DES6Rl/oKr
	 VbmP+9k+07wMjNk+o+6XDCeUoaTgI+jsXsnIn3Y+JR/tF5scYDamudVnGlgnKYE1Zj
	 B9eyNR1aQwtl8u76hHA5tLSIpbqRml4b4IBNw3J2On5pNEYSKjCjIZVWrKKwFhcMIR
	 5IgtarUhZ2Zksg/LALvyQdsi9YCec95qCJzNSZySlA/dzymJPqm59ggAOXaNvY7Q9R
	 cr1VJYKZNJqn/sTSV9L9HnTyWNLdfrm5bUTvSFNM9zUDFDpMCtQLsWpMFM+lFU02tB
	 ay6weNJME3dSA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] netfs, cifs: DIO read and read-retry fixes
Date: Fri, 23 Aug 2024 14:39:34 +0200
Message-ID: <20240823-relation-offiziell-fda6c4626508@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822220650.318774-1-dhowells@redhat.com>
References: <20240822220650.318774-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=brauner@kernel.org; h=from:subject:message-id; bh=OQN7Mf7HQDUQaFApg1+V9RgbCzXwyxIPK7zuLgztQ10=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdaOZRKjvtxCkjtZRpcoliflzLrNA9yto3dz9n4D2cN mNb+YKqjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl8bGFkmKibfHdXY2p8D2P7 gt4dxrZNMYKPfzS8Mpxuoqb24KpAIiPD/M//2mKuxJza36Alxn+QTc3k9y63rq8fDFb8+Hsssus eOwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 22 Aug 2024 23:06:47 +0100, David Howells wrote:
> Here are a couple of fixes to DIO read handling and the retrying of reads,
> particularly in relation to cifs.
> 
>  (1) Fix the missing credit renegotiation in cifs on the retrying of reads.
>      The credits we had ended with the original read (or the last retry)
>      and to perform a new read we need more credits otherwise the server
>      can reject our read with EINVAL.
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

[1/2] cifs: Fix lack of credit renegotiation on read retry
      https://git.kernel.org/vfs/vfs/c/82d55e76bf2f
[2/2] netfs, cifs: Fix handling of short DIO read
      https://git.kernel.org/vfs/vfs/c/942ad91e2956

