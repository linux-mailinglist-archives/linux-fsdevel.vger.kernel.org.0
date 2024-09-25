Return-Path: <linux-fsdevel+bounces-30045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B8D98559B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 10:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8608C2840C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 08:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04B115AD83;
	Wed, 25 Sep 2024 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0bt3k+z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A721552E0;
	Wed, 25 Sep 2024 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253420; cv=none; b=bhKMsnYi9l+cAa0cyneizxLUhgZXzrkbgnk2XtmtwNpGfjFvWjrfj2mcxQnI+0C1GiygyVdldJYmSFFErRUNZnlysLIyqr+yxaE9WrlSh1bm4Gz6GtzUhtMvSF8SygBkaUhJr1apd7myRn6hAhNIxkDn9qvecG7rvyfAgLLAvSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253420; c=relaxed/simple;
	bh=cGjKLO2n10hPXOXos6Sv2SnFdFGdPhqx9FtuWSkdvfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kK3HdKlbNeecRrj9k2BRltpq0EilF6dWEv5q2vRFjTRRkfv+UEHHxSvmNILLXofNsCJuEptHzV4mXqLpd2VeejCq7UeiWmw6PReFqKuGi6rMEDPW4KFfqp+gdPS+HrGq2bLYI2bY5FA2RTMSCyFE+wjPmXMNf6YdAXCnB0Y51rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0bt3k+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2F3C4CEC3;
	Wed, 25 Sep 2024 08:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727253419;
	bh=cGjKLO2n10hPXOXos6Sv2SnFdFGdPhqx9FtuWSkdvfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z0bt3k+zTmDzv2XFwkCxxV9bJ5nPcVBqxA7ujqIQ0zW79gE2Oe7K7/NHjDSVMZ9MD
	 VPzvxTQnGiILx4v400Lx/dbpi6u4/aM7Mbq4xCitHjJh7aNU3jN4xK3cYJ7G6ludkU
	 HJhkhZysvBXmCQQsQzuM8GUh9cSHXxC1qTrE3T7+EnQq5fKu30H8IsabEf0Mq2a//a
	 8jffyBoqOzNcFplY31Rv25sj/8GNISbHRAtpQ+nBZzZp/PXRRNVys5i3jjMvUtQbtf
	 oxqpp1zf332KB7c2WcsDaRpOnDmgmcMhwdJx1AtAZf1TrROzg32NTW3/NR+r3E7sdA
	 WUheLEtCnnNpw==
From: Christian Brauner <brauner@kernel.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	stable@vger.kernel.org,
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com,
	Dave Chinner <david@fromorbit.com>,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] vfs: Fix implicit conversion problem when testing overflow case
Date: Wed, 25 Sep 2024 10:36:51 +0200
Message-ID: <20240925-gewillt-bankintern-0fd0ba5bca82@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920122851.215641-1-sunjunchao2870@gmail.com>
References: <20240920122851.215641-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=brauner@kernel.org; h=from:subject:message-id; bh=cGjKLO2n10hPXOXos6Sv2SnFdFGdPhqx9FtuWSkdvfQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9Pr1k5ow+k5tygcnOBqlbl/Vk8BxcLhTDNfW7Vnbdj nnmM7xiOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyoJuRYXKY3jLm7Qdyzz+Q iHtey94Roq26bLVdsa+zlGj5v7qor4wMj0zMX1+vZKmcv+vK0h/Ku/v0xKs6ZLS2hl2XmP4+bf8 hfgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 20 Sep 2024 20:28:51 +0800, Julian Sun wrote:
> The overflow check in generic_copy_file_checks() and generic_remap_checks()
> is now broken because the result of the addition is implicitly converted to
> an unsigned type, which disrupts the comparison with signed numbers.
> This caused the kernel to not return EOVERFLOW in copy_file_range()
> call with len is set to 0xffffffffa003e45bul.
> 
> Use the check_add_overflow() macro to fix this issue.
> 
> [...]

Applied to the vfs.misc.v6.13 branch of the vfs/vfs.git tree.
Patches in the vfs.misc.v6.13 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc.v6.13

[2/3] vfs: Fix implicit conversion problem when testing overflow case
      https://git.kernel.org/vfs/vfs/c/8f3ab2511887

