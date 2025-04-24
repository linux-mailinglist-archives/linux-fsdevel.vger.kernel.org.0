Return-Path: <linux-fsdevel+bounces-47213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75308A9A74D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 11:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D2117722A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 09:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BC31B040B;
	Thu, 24 Apr 2025 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOnnURS7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB32F202995;
	Thu, 24 Apr 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485345; cv=none; b=iz7Dqn8zWhHYa1n4D21tYJjLYUNU1qsOfVMOGZLXPqVufPWi1uF6g9tmJPSJIHLtI+0rJqrOlGFETakqfRvs79fbnENwO6lBUu6MZhk+ejqdRF02ykwegRhx6ae9IqPk3fduviN0KGQUAW3j+H5Yy47CRyNoOi8IDpFNzq64lOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485345; c=relaxed/simple;
	bh=diIqjmOsqO/CfgCcwj4ZbCMQicoCf54SyvxIClNMmQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/Di2iK7HOI1f/CxIcaX5uLasDtcY+Vn7q05UoXQXEMg4KwzVAUMRxSthP9C3B17a8yBHtO/U6hsCZof65ecvzCrW6xUlkFqZQ31OUXdRuceH/r07wa4qRECwMA0gk7LW326v6NlUEnr9Jpo9nXea9nIzgDdYgx5J5KkgZWB/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOnnURS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9271FC4CEE3;
	Thu, 24 Apr 2025 09:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745485345;
	bh=diIqjmOsqO/CfgCcwj4ZbCMQicoCf54SyvxIClNMmQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOnnURS7073NypU9HiF30j2vv9Nb+hTzDZT5AS3pMlzBvMagMleTNasnyP4jMlzkU
	 BB6jayEgl+MRfh4RnX7Ee91fM1QGaIDUuwJeK5B3FZk5av4EK75uHq+5Yjw22VFoTj
	 YmWH950XiuhdzI/Tx2qn/I4g0cY70lhNED1zyTIK06jQOMCpcnXbowocHDzfc3TZZ1
	 wp27E2PWM+kTkDQ6+JiQVjbdAPDkszEOZ3YLHZzF0uc0CdPF9YK8AqhWk7bCM3XjSI
	 36MRlnKiXNgodf+jhTtxKchBChEuNQlOEfRNhuuMI6IqXxdxZxcHQm7Os9FPb0brmW
	 8XN7e8ZYhXFMQ==
From: Christian Brauner <brauner@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] splice: remove duplicate noinline from pipe_clear_nowait
Date: Thu, 24 Apr 2025 11:02:13 +0200
Message-ID: <20250424-zackig-wehen-f508a33e9409@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250423180025.2627670-1-tjmercier@google.com>
References: <20250423180025.2627670-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=brauner@kernel.org; h=from:subject:message-id; bh=diIqjmOsqO/CfgCcwj4ZbCMQicoCf54SyvxIClNMmQU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRw/pPZ0JAUXS9bmH5dTFj7i/Ydw9B9llvPG30tv2kaJ Xew0vF3RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESUNBkZbp90v/jsU2PMlYkO 7nk/PA9s/6+wL4rFf3nBn7/pUkHrRBn+lwrZnud+I9yznvkGX+rhd6uf9hhP+P1jSruLgWzGlUk WrAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 23 Apr 2025 18:00:23 +0000, T.J. Mercier wrote:
> pipe_clear_nowait has two noinline macros, but we only need one.
> 
> I checked the whole tree, and this is the only occurrence:
> 
> $ grep -r "noinline .* noinline"
> fs/splice.c:static noinline void noinline pipe_clear_nowait(struct file *file)
> $
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

[1/1] splice: remove duplicate noinline from pipe_clear_nowait
      https://git.kernel.org/vfs/vfs/c/894399bf728a

