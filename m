Return-Path: <linux-fsdevel+bounces-10463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CBF84B680
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C15828A0D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ADE131749;
	Tue,  6 Feb 2024 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dd0p/5+W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C0130AE9;
	Tue,  6 Feb 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226524; cv=none; b=Wzw57ramyNuMWYJd8nuf3V40/BnpzyZ1StRSEFI+H9lA798z+DVU+k3JRn3cPzsodAHQehTUeNNKwjFKSvO+Bop/I0nQt5IFpu9tYiXJBK4bq41mbX6k5LK9PB9Y1FJngFmONe+xWjb+v7ywtg+mooiRN0pMzMGATJkeMBwVNIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226524; c=relaxed/simple;
	bh=Ndx6g5tAF+XgTm70AYNjYRW+FT8tUyA8GjMMJGLG++A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgTDK7KHWG35AyAoShZxMW3wmppD09xe3nXJMluvpfeF+DMRfmVpKxSi0x8qDeCw/lJcdDqhT0CyQhdyaNu5sSZWXm4w2PHYxcT9XFqER9M9Hvr+6r/TYMVHxqtQWnwieT/SyGct7PJtZSaZKdWOO+5+0cveXgX+RVQglByDgoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dd0p/5+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9CDC433C7;
	Tue,  6 Feb 2024 13:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707226524;
	bh=Ndx6g5tAF+XgTm70AYNjYRW+FT8tUyA8GjMMJGLG++A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dd0p/5+WEW+UYIhUIdFW5Rvs8dXvnKTVWWkkQ8nwy30llgvEtnxKUvRZqYi2nNjI1
	 Bm3ukIscNAIV8Qk32O92HuujkEQi9DV7cXDiKP6ZETGS2+ixHlIwd6gnLKqbJvDjxu
	 Kd4+MZTxm5d0PdaYvbBcV15kdxr+jonFbotj46NP16M7BhlR8jptmnlOXW+Tixl9T6
	 MIIFJtWBBF7SoCvg3QvLvKFkTrd2FFiK004diEa67sD/znVuuOHx4NC/vzAV3trj9L
	 XX8T3ScSQDNRxZ+bQw4911mvNZoh3zhUk0LjQk60ooRFN2ZKBa3Wf3NTpr6XLfYTdY
	 B8MXr4JUhnNwQ==
From: Christian Brauner <brauner@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 0/6] Restore data lifetime support
Date: Tue,  6 Feb 2024 14:35:05 +0100
Message-ID: <20240206-kunden-postfach-7fb32cb79486@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202203926.2478590-1-bvanassche@acm.org>
References: <20240202203926.2478590-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1649; i=brauner@kernel.org; h=from:subject:message-id; bh=Ndx6g5tAF+XgTm70AYNjYRW+FT8tUyA8GjMMJGLG++A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQeMu1qWjl17hepsHkx62PUSyZcaN/58V+mv3uvd9CpR 98mHbuxpKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi/w8z/C/3ObQ1/+ex7xyi eiccJcofPY3+9nemoDMvL8cZY/+uOccYfrNPWmnNxP0/YvuqDsacrcoTYnmuT1i6pNv99r5Y85k 7+jgB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 11 Jan 2024 17:22:40 +1100, David Disseldorp wrote:
> If initrd_start cpio extraction fails, CONFIG_BLK_DEV_RAM triggers
> fallback to initrd.image handling via populate_initrd_image().
> The populate_initrd_image() call follows successful extraction of any
> built-in cpio archive at __initramfs_start, but currently performs
> built-in archive extraction a second time.
> 
> Prior to commit b2a74d5f9d446 ("initramfs: remove clean_rootfs"),
> the second built-in initramfs unpack call was used to repopulate entries
> removed by clean_rootfs(), but it's no longer necessary now the contents
> of the previous extraction are retained.
> 
> [...]

I've pulled this in. There was a minor merge-conflict with
fs/iomap/buffer_write.c that I've resolved. Please double-check that
it's sane. I'll treat this branch as stable by Friday since I know you
want to rely on it.

We can do it right now but I reckon that there might still be an ack or
two incoming that you wanted.

---

Applied to the vfs.rw branch of the vfs/vfs.git tree.
Patches in the vfs.rw branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.rw

