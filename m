Return-Path: <linux-fsdevel+bounces-47331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB75A9C210
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B70C3B7052
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 08:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD381F3FC8;
	Fri, 25 Apr 2025 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwhUcWoz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B9B151990
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570835; cv=none; b=gAX/6I7RBuYqWL4+xUvuOWab/K9FbFK4zoIogmDvHsfJMwKpxTxaPiaJ2cncmqll/qjTuqLKJe03PJpxkFDdhnZIWxMknKnfakGkgDRNa040z+j4aqvliRqVXCQmCjsFUbhQ99FAbHOkW3NCi8jKgHdpdsKa8flRR8hLcW/d088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570835; c=relaxed/simple;
	bh=E001UlVc6GeWI8Y9SP/ZEeeGaQMpfB7Vy1G95cDQtaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxKnRP9QxQG1KPaeVrqVZxoaehKb21SYU3wuTkyCzMarRPuWD0+FbbBOSNRsdSX1mENyn4/Vu5Er4cVnZvDCOzyJGw/hDJOfuAi3VCJR2OSNk9DUuVwxeuDvoRg495tIhnTrAugCQEmuGdhD+GuRqH6W25nJcuaXK6cDw3qHQNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwhUcWoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A254C4CEE4;
	Fri, 25 Apr 2025 08:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745570834;
	bh=E001UlVc6GeWI8Y9SP/ZEeeGaQMpfB7Vy1G95cDQtaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwhUcWoztCzt93Ief4n57/kGIDjyMdhTiD739U3v1mbLTnc73Q/Q5SBTD+KfXe+bD
	 Q1ZVJ8NpLP2hOBqqzMcB+woOU7Zm4oiZ2euVeTBRr4x1h3ol/94kfFAviI4krGjwqH
	 TN2wAzd3tcv+xzF3WmHAId6bb6hq+JpA1mUU9OZIWEisGoerkPBpEWGh9LI37JwaJZ
	 /1iulOtzYMgNWGUEAb1s22czjB2nmuaksiiQAfqrHFrJrxkSVds+Hdahu9TpezGCKr
	 GyLAssX72nMpyR8m2SYdASiT8iLeJ0czhuOgesWcFbHJ2hWMtyq6r23DUhR/ZoCraD
	 Zqa1L6hcwcBtw==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/xattr: Fix handling of AT_FDCWD in setxattrat(2) and getxattrat(2)
Date: Fri, 25 Apr 2025 10:47:09 +0200
Message-ID: <20250425-therapieren-nichtig-cc2ff04884f8@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250424132246.16822-2-jack@suse.cz>
References: <20250424132246.16822-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=brauner@kernel.org; h=from:subject:message-id; bh=E001UlVc6GeWI8Y9SP/ZEeeGaQMpfB7Vy1G95cDQtaw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRw+/B2M2X92OD/kmlWh0ZroMmLjdMYKuYu2eX7jW1l7 oRlnzf2dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEooLhv1cc01ZPFeXQU1tf yU+T9NhnVvCpkruM/dA7poQVXgWqLgz/jDTf+f6vfjv5lJ103Zkd094byPpyP1XkWG33LLot7pM kFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 24 Apr 2025 15:22:47 +0200, Jan Kara wrote:
> Currently, setxattrat(2) and getxattrat(2) are wrongly handling the
> calls of the from setxattrat(AF_FDCWD, NULL, AT_EMPTY_PATH, ...) and
> fail with -EBADF error instead of operating on CWD. Fix it.
> 
> 

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

[1/1] fs/xattr: Fix handling of AT_FDCWD in setxattrat(2) and getxattrat(2)
      https://git.kernel.org/vfs/vfs/c/0036de2100d1

