Return-Path: <linux-fsdevel+bounces-67096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D69C354FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D0F3BF9AF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F15830F7EE;
	Wed,  5 Nov 2025 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2ZCZW2a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D2B30594E;
	Wed,  5 Nov 2025 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341190; cv=none; b=ed4oqJpiDmvr8Xe8sB/auCrHikzPaLRsGBPZCRXksuAup2+Z6yR18MnGy9gLBoKmRkQoFwgAz6HasrG3sySoVew3WbmQunbN8buZwDGHKk2OC8/hXNxrROd5EIiON3soeb2omvYRVkk/U6oy7dTjFTmNNy2aBu1dj7vOhGZe5Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341190; c=relaxed/simple;
	bh=5SRIi5stLzkcdcYgZc1z4fAx+Z2JyFKQR3FvjHjXFVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQfY5sJ9cGfH10SFbTF8n2xNit0RoXh6yupRWVoCMubbHRSizNzOdhD93w1b9CtOE2IWvCxFrppiDkEe0Fo3aLd8lrWthQJcwEFGex2vU4vwLnb33g+ZLXuFc2ogUxNXZ2vpdiwvL56UK/FHc/UWXXs3URuMnACl84c7vO8gwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2ZCZW2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A383C4CEF8;
	Wed,  5 Nov 2025 11:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762341189;
	bh=5SRIi5stLzkcdcYgZc1z4fAx+Z2JyFKQR3FvjHjXFVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e2ZCZW2aZUwTmoa8nkSKTRxmK//+yjCM1ni6ddcN6a2AYWWlP5SJSR2XHIhrosRhW
	 FkeXgKxkwalJCUXVL8ZRXwgQeXt/nkskp6283MjlC7lTTeCuKO0Zkw5rnVB3x1YRyj
	 IkGK3GVWDlaFeAKTHY2TEjLIKEY99//uecF4P0nnE+tIuUkMXWSwYWhzQql1Ie+lp8
	 9ckfH2KMKURDpq5BwetPWNUdAICq3iLfszaq3L/zO8lfcUgUw1gtrydLEZ7qvHClaA
	 JNdNSh8riDJiNFEj6Da9MO+mUDJRlVUmuqNFaRAMP1KIlqLGhZV6b56epn4ksLHO18
	 yhbfDM0b0kGmQ==
From: Christian Brauner <brauner@kernel.org>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] binfmt_misc: restore write access before closing files opened by open_exec()
Date: Wed,  5 Nov 2025 12:12:46 +0100
Message-ID: <20251105-gebucht-kaktus-f394c88493d5@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251105022923.1813587-1-zilin@seu.edu.cn>
References: <20251105022923.1813587-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1299; i=brauner@kernel.org; h=from:subject:message-id; bh=5SRIi5stLzkcdcYgZc1z4fAx+Z2JyFKQR3FvjHjXFVU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyGzpEqfTLxG8oWDwtuyDHk//Hodv72q+1JTE+rNLUP S2XwKDXUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHIzwy/2USCQ6Uvv2ao9L8c P/HVjsyJzqGC0yd7/tFbfbhk50ORm4wMl+a8PfrdePHd3vzCqUfPcFe6h3vY+M7acmZhwS7tn6s CGQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 05 Nov 2025 02:29:23 +0000, Zilin Guan wrote:
> bm_register_write() opens an executable file using open_exec(), which
> internally calls do_open_execat() and denies write access on the file to
> avoid modification while it is being executed.
> 
> However, when an error occurs, bm_register_write() closes the file using
> filp_close() directly. This does not restore the write permission, which
> may cause subsequent write operations on the same file to fail.
> 
> [...]

Thanks!

---

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

[1/1] binfmt_misc: restore write access before closing files opened by open_exec()
      https://git.kernel.org/vfs/vfs/c/0e0c1b03d6d4

