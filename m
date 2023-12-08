Return-Path: <linux-fsdevel+bounces-5378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD93E80AEF1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 22:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655C8B20C72
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 21:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9714E584EA;
	Fri,  8 Dec 2023 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tF7HO8t6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2C1D55F
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 21:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D536C433C8;
	Fri,  8 Dec 2023 21:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702071994;
	bh=YxUWtkRWJpGUAr3ky7ntglE3+KUpdRkTzGFHiaaIaj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tF7HO8t6qxKPtPqWQcmb7u0lHrlYtgVHpW+7EVe9JYIYvwjwpfQGqKhWrxzpHI2gi
	 G+XtnfDqNSpryhmqySnfxkWfeb2fAOA9uVHsfmJOtprwfXhqvTasEdb/TdNmvmDhuH
	 0dcSwQoNqki3pp16GTpT8NLLPGTCJEW2SlFo8i18KW2Iwi6s4xcDl4kmdUiRzbCHaF
	 tCa1seRh1xbRX3/KWbF1/hGiz4F++y+S0QS9mkm9NJn6ReS9VteFAVwaOJ2l70Hl5u
	 T/vvjtBLmpWMCIf9viWJcxBjTA9sToKEBe6sMhZMkxQDWkGQ7LYGol7KfPNhyDQ6Qf
	 5kbkxloS/XJag==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: super: use GFP_KERNEL instead of GFP_USER for super block allocation
Date: Fri,  8 Dec 2023 22:46:26 +0100
Message-ID: <20231208-monolog-podium-bd91de100ebf@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208151022.156273-1-aleksandr.mikhalitsyn@canonical.com>
References: <20231208151022.156273-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=brauner@kernel.org; h=from:subject:message-id; bh=YxUWtkRWJpGUAr3ky7ntglE3+KUpdRkTzGFHiaaIaj0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQW9210P3U52+lH14SjmTdmerjfuDL9tn6WzvJH+5c6m OxaMC9PtKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi3moM/0NS+UTrmr4fvFPO uGxu1KTGDJmFdo6MVft2NxonrfB5HMHw3/tNgcq/voRD3xr/hlw8klucVFjxYcJJY1E7s00fTh+ SZgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 08 Dec 2023 16:10:22 +0100, Alexander Mikhalitsyn wrote:
> There is no reason to use a GFP_USER flag for struct super_block allocation
> in the alloc_super(). Instead, let's use GFP_KERNEL for that.
> 
> >From the memory management perspective, the only difference between
> GFP_USER and GFP_KERNEL is that GFP_USER allocations are tied to a cpuset,
> while GFP_KERNEL ones are not.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: super: use GFP_KERNEL instead of GFP_USER for super block allocation
      https://git.kernel.org/vfs/vfs/c/b91dbdebd653

