Return-Path: <linux-fsdevel+bounces-37798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD2E9F7CFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F57E1883CFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4471225411;
	Thu, 19 Dec 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbGy5UMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984E69D2B;
	Thu, 19 Dec 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617941; cv=none; b=D96YMDtuo/o/laMpZKa0E3bAHIt4TeTU4lYhm7f8FWFivVLWfljeD5hziZmqmBy7dJKk2DLI4enedd8mpyLT+DHY1hOnIb08GXdgnSqf6csiWYr5c1tEuBBz/bLRMYtnc94HZEKRRP55uqZc8oZs/0oNcGhuBC8OUkZR/sADYrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617941; c=relaxed/simple;
	bh=bezBEVotZ7/coP1M9fU2+K217m7EdBho/lMX6Ic5nEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJXvj4FBoAlj/Mau1EVdyJvGOWjZ0/yautqsZnSsuvlfjbCUpOUr5mELaybLFDZN8+ag68e5JyhYhAZd2ROmcNSjXMvdG7OfjghxWa30hJogjZ6uCfO1idHWcsXaaSQzueRotLv9aj5G/j9Vl9Jq1hkxD+xkVE+/7cCEjDCzAeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbGy5UMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57D1C4CECE;
	Thu, 19 Dec 2024 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734617940;
	bh=bezBEVotZ7/coP1M9fU2+K217m7EdBho/lMX6Ic5nEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mbGy5UMoN2G8lg9+YzBciwVT56DOtkcM+wmlAJEZMZyWHEZct3EVjh/XHCMaLwgnn
	 evZp1NjoQ+ZQ1T9EeNYByHQGO9ZlG3YXaKtfuIKhc+zPGgZRlPHSROVSHIxBHk7Oon
	 YVAHubo6MWrvlP0rLttZTekhcQN3/GBvq8fAX0h+WIA2U0Vh4FohsGddUtT63gGFto
	 dxEwoa/s1NkET9qOgIsr1d4TN/31bBOFOHQZz9Ij09bGWLztjznLG/A2q2VlVyobus
	 YdCpxd8w379rbsxGb1870uZyTVMXtW675zMbzjB6yP5AxwI0anexsFbH/9hqcbbwOY
	 faDjBU6WPF0Fg==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Edward Adam Davis <eadavis@qq.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH] fs: relax assertions on failure to encode file handles
Date: Thu, 19 Dec 2024 15:18:50 +0100
Message-ID: <20241219-unfreiwillig-trugen-d3e26f0b6498@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241219115301.465396-1-amir73il@gmail.com>
References: <20241219115301.465396-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=brauner@kernel.org; h=from:subject:message-id; bh=bezBEVotZ7/coP1M9fU2+K217m7EdBho/lMX6Ic5nEQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSnaHvL1Io4HRPQiXYya+8OfrM5yvr3I5nbFt+7Zymov CiR3BTXUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJFv1YwMcy4pMp2trVoT6Slf vZwvJYp1rc/zWd79L/5v+f5qr1n9F0aGcxkXl/h8nbXS8YCNp1HlJK7CD3wPTTybH8sl/jw/tWY iGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 19 Dec 2024 12:53:01 +0100, Amir Goldstein wrote:
> Encoding file handles is usually performed by a filesystem >encode_fh()
> method that may fail for various reasons.
> 
> The legacy users of exportfs_encode_fh(), namely, nfsd and
> name_to_handle_at(2) syscall are ready to cope with the possibility
> of failure to encode a file handle.
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

[1/1] fs: relax assertions on failure to encode file handles
      https://git.kernel.org/vfs/vfs/c/974e3fe0ac61

