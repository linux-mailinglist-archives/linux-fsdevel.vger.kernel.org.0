Return-Path: <linux-fsdevel+bounces-12112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2886B85B5BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D207D1F22CAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 08:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0185F486;
	Tue, 20 Feb 2024 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcBcYY5I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C7C2E3E5;
	Tue, 20 Feb 2024 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418821; cv=none; b=m7zbDyGuUUOK8VlgG4v6tDyq1A8Ebdrzu4fUjVK6bSDdWHJk/FtYZelBMfBTwSIeFjBA1mbR0uLuJsgunD0ut7u32cRyCbvYQk4CWeoCcMT9y7TyJ3Q5kaFQAxSeTFDY054vWCJU8+hF3izpbAPi8YweU8MVQFqJjaozVUntQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418821; c=relaxed/simple;
	bh=GZ+HcFFNIzj0fwynEx3VW22XthB/JF29Bnq/DjlKiCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJcZs4n7sIGvTrDyB3knPo4CkM9XIMqkLEDTcRQr7VYa9mTd9a94SjyqaWxutSE2ePo5gRcLOPQTIggTOKnuf9W26htBKL/MXYYINFomYtZYqx9DxMdush3YPQW7zAROOxFgP9knHrq+h5DMgf+4+maghA5NaiVeeMOfuTuj8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcBcYY5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2086BC433C7;
	Tue, 20 Feb 2024 08:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708418820;
	bh=GZ+HcFFNIzj0fwynEx3VW22XthB/JF29Bnq/DjlKiCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XcBcYY5IgpVk3q4imoW0XKzb7mrMtt9TcenPFnl0dHvFc+JSDIGyIshkMRYvW9ryP
	 HSbgN7UYyJbzpRFj0hytz83QXfN3DWERvWR9B1/I0LHn8VxD+lcr/HrF1B0GdnV9GJ
	 dUEwe2bWRpegbYDqjrLCRls6A/p/VWNE65OoGtc49j1/WJAad3PaVW0ACAeyUTSckJ
	 lwsO4+cU7Ggp6ht3N37JN/OzXvqJEjEu67RVrgofo+6yrDvYI35tW19+uI6GRyhqt/
	 aJWUTjVcmqB20VE9u6o6VV9KbjS6WEyeNaO37cLjkRFkaU88HrDxSkVvltc1vYRR9L
	 MawQCvi5G96cA==
From: Christian Brauner <brauner@kernel.org>
To: netfs@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	dhowells@redhat.com
Cc: Christian Brauner <brauner@kernel.org>,
	jlayton@kernel.org,
	linux-cachefs@redhat.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] cachefiles: fix memory leak in cachefiles_add_cache()
Date: Tue, 20 Feb 2024 09:46:28 +0100
Message-ID: <20240220-lasst-hemden-8ab6d7d2e9ee@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217081431.796809-1-libaokun1@huawei.com>
References: <20240217081431.796809-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1939; i=brauner@kernel.org; h=from:subject:message-id; bh=GZ+HcFFNIzj0fwynEx3VW22XthB/JF29Bnq/DjlKiCM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaReSftzfxlfFb/gguUSEwRX+NxMdpaN2+MmY367w4WDf xKfl+n9jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIko7GRkuOhnJjtRN+W609ft Z2amV0QXZfxvVEst8RZ8G/f6lmCbOiPDs00/RMO7///JEuPMfFB8t/4Kn3zquytd/AGxd/RfKP7 hBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 17 Feb 2024 16:14:31 +0800, Baokun Li wrote:
> The following memory leak was reported after unbinding /dev/cachefiles:
> 
> ==================================================================
> unreferenced object 0xffff9b674176e3c0 (size 192):
>   comm "cachefilesd2", pid 680, jiffies 4294881224
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc ea38a44b):
>     [<ffffffff8eb8a1a5>] kmem_cache_alloc+0x2d5/0x370
>     [<ffffffff8e917f86>] prepare_creds+0x26/0x2e0
>     [<ffffffffc002eeef>] cachefiles_determine_cache_security+0x1f/0x120
>     [<ffffffffc00243ec>] cachefiles_add_cache+0x13c/0x3a0
>     [<ffffffffc0025216>] cachefiles_daemon_write+0x146/0x1c0
>     [<ffffffff8ebc4a3b>] vfs_write+0xcb/0x520
>     [<ffffffff8ebc5069>] ksys_write+0x69/0xf0
>     [<ffffffff8f6d4662>] do_syscall_64+0x72/0x140
>     [<ffffffff8f8000aa>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> ==================================================================
> 
> [...]

Sorry for the delay, David.

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

[1/1] cachefiles: fix memory leak in cachefiles_add_cache()
      https://git.kernel.org/vfs/vfs/c/e21a2f17566c

