Return-Path: <linux-fsdevel+bounces-33681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E919BD23C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 17:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0C11F22DF7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 16:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6A11D2B22;
	Tue,  5 Nov 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfLyciYR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391CA15C138;
	Tue,  5 Nov 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823816; cv=none; b=X1nuF1ws3QvabYH19IoUnd22nzEbgQVcbrqc+XNz9n/oiYRdcCi+AoOIrwCE8VlWmb1c8XfnApgKGicDg4e+Uq5DELBSrBNiyeWdfpUyTVa/Ri2Gd1AJVXDr/GV9egl2Geg0l/uQECz2SJRARziWaH2+mziLH6Ab74WEpHP5InQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823816; c=relaxed/simple;
	bh=SYabQGF+mNiDvJMTK40v1FOHtZBigPP3e+Ea7xTU2WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGxUomBHdeOWkV+QYLkU9YQ3PYTL8VLs86KpEEzhbvn1t2tFHLMij5Ue4RG6a7aMOXfbf/EwJSf0lqcHA1fUXmlWGzo9pm4msSp8s+CqDKDpOUTFkPLZNgZGPbdf+PZtR7l9Ak4dv1OaQeBwnoDbcV2/+21ZGmaH544g19LkJeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfLyciYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F962C4CED2;
	Tue,  5 Nov 2024 16:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730823816;
	bh=SYabQGF+mNiDvJMTK40v1FOHtZBigPP3e+Ea7xTU2WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfLyciYRNJJKB/xDvloMJ3dhvkRpm+uQ86nqvDfO+ttL1bIXldsFv4u0c9Nv7RtET
	 1r/Rfa+/FfICZdQyJ8tr41BYnZjoR/wIxH0EmpR8GeOQYGGSsuMqQwyrNxkpsJw9qh
	 RuOFkmD0Y+60tDwS/Yki9tEa3s1gm6sO0wltsd2V7DtS0fpKIkFWHszQwn98aotBvT
	 QlwLwY6c6nwN5wwgn2nWy39iikKGu1+wa188IMuGNw37DAZp5WjnaUqkkhXdkEsGGL
	 ZqFVJQ4+YDh5FbeRhhijDwXyKdLE5BEhg7ZBiKOBwi00rFwMvuJY9DpqZJzDFRNvYo
	 hiW8M7+q4Qg9A==
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH v2 00/10] Convert ecryptfs to use folios
Date: Tue,  5 Nov 2024 17:21:20 +0100
Message-ID: <20241105-geste-statik-9e3f7793abb8@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241025190822.1319162-1-willy@infradead.org>
References: <20241025190822.1319162-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2726; i=brauner@kernel.org; h=from:subject:message-id; bh=SYabQGF+mNiDvJMTK40v1FOHtZBigPP3e+Ea7xTU2WE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRrudUfKW48/Hf1/EYX4+q1vFkWpw6H3/u/4K3rCrWX+ 3hd0jUWd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyE/wfDP4WlqXnR6dr7Diql u15TZHFVCZ7z4tiFMrPbt2vKMte0XGZk+P1ob0n061eStdN8hL90KSnVvVJ8NJnNRu7qqb+vviZ c4gAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 25 Oct 2024 20:08:10 +0100, Matthew Wilcox (Oracle) wrote:
> The next step in the folio project is to remove page->index.  This
> patchset does that for ecryptfs.  As an unloved filesystem, I haven't
> made any effort to support large folios; this is just "keep it working".
> I have only compile tested this, but since it's a straightforward
> conversion I'm not expecting any problems beyond my fat fingers.
> 
> v2:
>  - Switch from 'rc' to 'err' in ecryptfs_read_folio
>  - Use folio_end_read() in ecryptfs_read_folio
>  - Remove kernel-doc warnings that 0day warned about
>  - R-b tags from Pankaj
> 
> [...]

I hope to be back on a regular schedule tomorrow.
I have been down with atypical pneumonia (who knows how I got that) and
have not been able to do anything for a while.

---

Applied to the vfs.ecryptfs branch of the vfs/vfs.git tree.
Patches in the vfs.ecryptfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.ecryptfs

[01/10] ecryptfs: Convert ecryptfs_writepage() to ecryptfs_writepages()
        https://git.kernel.org/vfs/vfs/c/807a11dab9dc
[02/10] ecryptfs: Use a folio throughout ecryptfs_read_folio()
        https://git.kernel.org/vfs/vfs/c/064fe6b4752c
[03/10] ecryptfs: Convert ecryptfs_copy_up_encrypted_with_header() to take a folio
        https://git.kernel.org/vfs/vfs/c/497eb79c3191
[04/10] ecryptfs: Convert ecryptfs_read_lower_page_segment() to take a folio
        https://git.kernel.org/vfs/vfs/c/890d477a0fcd
[05/10] ecryptfs: Convert ecryptfs_write() to use a folio
        https://git.kernel.org/vfs/vfs/c/4d3727fd065b
[06/10] ecryptfs: Convert ecryptfs_write_lower_page_segment() to take a folio
        https://git.kernel.org/vfs/vfs/c/de5ced2721f9
[07/10] ecryptfs: Convert ecryptfs_encrypt_page() to take a folio
        https://git.kernel.org/vfs/vfs/c/6b9c0e813743
[08/10] ecryptfs: Convert ecryptfs_decrypt_page() to take a folio
        https://git.kernel.org/vfs/vfs/c/c15b81461df9
[09/10] ecryptfs: Convert lower_offset_for_page() to take a folio
        https://git.kernel.org/vfs/vfs/c/bf64913dfe62
[10/10] ecryptfs: Pass the folio index to crypt_extent()
        https://git.kernel.org/vfs/vfs/c/9b4bb822448b

