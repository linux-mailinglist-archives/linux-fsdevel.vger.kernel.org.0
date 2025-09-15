Return-Path: <linux-fsdevel+bounces-61370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75334B57B1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3ADB188CF54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E85D3081C5;
	Mon, 15 Sep 2025 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cf8wf+jC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6762AD24;
	Mon, 15 Sep 2025 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939240; cv=none; b=b9YpG9M2qiE+GpXa1pH/2zrLriGzbYP2BZrWvBAZJAUvVtA+9kAi7c2UK6PTDAaPQMKoB5vwDQKxReHuLv8cKKaynRK2RgwgT2HyPocN6VqV8wFpvucr2Se8LLBrp/ctT5DuKlRJ2Q+o3HGqMGxPLx7pjr3Zh4XbAEl9Jlb72kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939240; c=relaxed/simple;
	bh=hzvoZDxJjvZEzFahfQI9/ys/P8WfMSn7GHZeMGHj4x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmZK9ulQ6fRZB95qAn5IRb0nzVGNRgF40kRfEefIakGF1rlNpk6H/i5xFfK4edj+UaD86QGW89GAIDiv52gNsTAhdnLIuzlG6QWQW31V0nNOQBAfNDCXkltjKFonNHgQUYL17cMPTZx3SvPbRu2NR657CT7XXbLOsFmVGrUsb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cf8wf+jC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDD6C4CEF7;
	Mon, 15 Sep 2025 12:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757939240;
	bh=hzvoZDxJjvZEzFahfQI9/ys/P8WfMSn7GHZeMGHj4x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cf8wf+jCSXg0VazZ2TxhDlLfdnCFDlzyFxno9iAj7+CzSp0zfR3E1dcBfjp2HmGbN
	 CGMQrOaNWD4zGRSnkbC67byhcPtWgsKDMomedECtk4SFqcqI59Q74B3HXx7KYo2IC4
	 CEEjpBAkZPnlsDAjgWCg2aIQDDUOFJMvu3xtTDuUlRbfWQzVEtZxJZ9/JqBicNWHzW
	 iUYa0wI1mkY2M8q8Cw4VwzqxupJ8GBn6PYWoWbhTvpka41Tu29ATv1jKhmHXgdCruB
	 5FXUUSWnUlkRT7wLIr2AKOlU3qm74iTT6hR9sEmIDlkAApHpd4tuaifMtvdRYyyGJK
	 FBs9+g0yhCwYA==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] initrd: Fix unused variable warning in rd_load_image() on s390
Date: Mon, 15 Sep 2025 14:27:09 +0200
Message-ID: <20250915-gelernt-gegossen-4663965109c0@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911094908.1308767-2-thorsten.blum@linux.dev>
References: <20250911094908.1308767-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=brauner@kernel.org; h=from:subject:message-id; bh=hzvoZDxJjvZEzFahfQI9/ys/P8WfMSn7GHZeMGHj4x8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScYFOe0npz/W2Hx51/2drbw8RWOs6482Rah/VKRm6ul W2yqkK5HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPx28zIsOLt6/oFO33WT1xw 5unp9iW23WoNM76knpRKU9j9dY3DZQaGv0J3/jdaJ87qniblI61Z8NP9uFnZ2SsLncK2bl3mdHw eNw8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 11 Sep 2025 11:49:08 +0200, Thorsten Blum wrote:
> The local variables 'rotator' and 'rotate' (used for the progress
> indicator) aren't used on s390. Building the kernel with W=1 generates
> the following warning:
> 
> init/do_mounts_rd.c:192:17: warning: variable 'rotate' set but not used [-Wunused-but-set-variable]
>  192 |         unsigned short rotate = 0;
>      |                        ^
> 1 warning generated.
> 
> [...]

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] initrd: Fix unused variable warning in rd_load_image() on s390
      https://git.kernel.org/vfs/vfs/c/7c1d7695216f

