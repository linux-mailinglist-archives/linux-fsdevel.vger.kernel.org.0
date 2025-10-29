Return-Path: <linux-fsdevel+bounces-66303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77718C1B847
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF2D642A8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33117350D57;
	Wed, 29 Oct 2025 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fvv0r33w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A39350A34;
	Wed, 29 Oct 2025 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745273; cv=none; b=EeOWfIjjB+83FmXeNITvGXoiKJI17qKlSokrZ3lLhtwzPI7+OpsYLM2WW77X1Gcv4mIO8SqZizG+NwSHd3rZG0V6cWaGEsnAdSL5+hCg/SaRElkfooHSdGCOcWXTB0Mg1xLafN4ol72CLv+2AjjK8bZjfVKo0s7XDbM97aTzZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745273; c=relaxed/simple;
	bh=tovzWB7nFqgmLeScDZvmPqsvNB+Fj3C3M7MNwv8PzaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K45XM6Hc2u/s3iRHJiYncrZtPOKzwwdveCfLHh4UzKILPVElT/jd+qGHoGVl2mD19Oa+c6aP8H7fJnGzxLZ+4OaNsuBqEBoy7nw9oukQxWKhINzqDtX/C0L+5xMYKBI15+lS3gaq2hZanxWPSz+2utol9V5XMWi0ZwDcei9btT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fvv0r33w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85460C4CEF7;
	Wed, 29 Oct 2025 13:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761745272;
	bh=tovzWB7nFqgmLeScDZvmPqsvNB+Fj3C3M7MNwv8PzaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fvv0r33wyc7i/3jjjiVPhHGvbxi+sjdK/7TbW8C3Z/3ACpnJavm7U3aeQl9ji9BZz
	 RP6KE9LBMKbfMArVv+6v3PWf3yw5AfQuAK4Y0Jlpb+9yerExHK5sC51iGcU43vvJII
	 e1chZldZW6OvO6+CZ+98MB/8kz2av6HH5T5sLpxdjIAQRep03eBWeY6UB/grFrOBzp
	 ZV550JozoBlDDXzgbNxCfuffuaTNk9oD6rlW+Og6iBC9dCopXwPZP8c9YH1dktXS7z
	 tP+8NUc+tHiDG8UayhkREFFUUb7ffT9AKes+Bk0I9rpAaFGPxaQfswwh3IwD+wzwRj
	 ehOT6glsr3DNQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] fs/pipe: stop duplicating union pipe_index declaration
Date: Wed, 29 Oct 2025 14:41:06 +0100
Message-ID: <20251029-redezeit-reitz-1fa3f3b4e171@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023082142.2104456-1-linux@rasmusvillemoes.dk>
References: <20251023082142.2104456-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=brauner@kernel.org; h=from:subject:message-id; bh=tovzWB7nFqgmLeScDZvmPqsvNB+Fj3C3M7MNwv8PzaE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQySRbP9vwlcGNbz0IuBvHPkxc43qlcFbDo2643NtcLd vuxfy6y6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgIWwLDPyXv+dJnRFK41256 radga708f8rL/bMrWE6ws/isCpM8qcjI0MNS9/DPvTkX5rFOufv4pYCJTviPx1+edFSZtTM832u axQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 23 Oct 2025 10:21:42 +0200, Rasmus Villemoes wrote:
> Now that we build with -fms-extensions, union pipe_index can be
> included as an anonymous member in struct pipe_inode_info, avoiding
> the duplication.
> 
> 

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] fs/pipe: stop duplicating union pipe_index declaration
      https://git.kernel.org/vfs/vfs/c/ade24f8214fe

