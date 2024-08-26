Return-Path: <linux-fsdevel+bounces-27141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF44095EEFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C241F24363
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B27185B4E;
	Mon, 26 Aug 2024 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp0ilSam"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3423015539F;
	Mon, 26 Aug 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669477; cv=none; b=CbuE2ExnMv+QBWBKgIqQ0E2qmQgKz+ATnXPKoaTFCa6xw58o50jXAEnknEmP09EF4gCSzw3oqjT9GJkRFdKuLvC+C9pX3DsJjmtg51m8G4TErLAwAcSQNeBMHwDzLZfIAgRdCOyoFHU2MTKE+cJ8ulTlzm8NV0naps9Z8bxJgP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669477; c=relaxed/simple;
	bh=C5Y/qSHgQZACxwKSqcH92sWROtc2L1TL/YZtDg6REHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpdTpms7rG8dwXaFTV+fWVfib3faxOrPQplFyrdBD/rgEDYXZikc7rian4R9kkBBXSMZ76nbA0Ad/2S/NCIk3Hc99rCHZFr2dJ22lRKQrKnUPmkiETukjpjvbzjE8JYSjgFBcFt3DmxzhyHiOM3fAG+PRkYygA9nMDZ7VCv++w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp0ilSam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2387C51422;
	Mon, 26 Aug 2024 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724669476;
	bh=C5Y/qSHgQZACxwKSqcH92sWROtc2L1TL/YZtDg6REHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qp0ilSampHvHO/PKthgFW0Gu0htzhqZ9PlKJkZEM5B+TiK8gdWmCsJg1CBMx4yCH0
	 av7zhY4GN278cUhfvucrRanVqHUp2NINrP+boJVbFJCQTzbIcsRBiGvUOciiJle7Ny
	 f0RLW9EYjsJPMN0Act+e/ii83fb2cMlkeqcZ+U4TZEaWXeucI2+BlvDociFIwilPcc
	 jizA5IXpfrFUgDmECYbUYpLfEPZIpBAk8nr2n7aNtlvgVhtDTSKlVka7YzwTWgQP1Q
	 xofCJqOWxXW+bZhBS/9X5/M2K9J55rYWj9RY941BSs+hIpiJoEn6oSIkSdJlnF2YDC
	 znCEBmoYSyrnw==
From: Christian Brauner <brauner@kernel.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	david@fromorbit.com,
	zhuyifei1999@gmail.com,
	syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] vfs: fix race between evice_inodes() and find_inode()&iput()
Date: Mon, 26 Aug 2024 12:50:59 +0200
Message-ID: <20240826-irdisch-verflachen-c724c28dfc3c@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823130730.658881-1-sunjunchao2870@gmail.com>
References: <20240823130730.658881-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=brauner@kernel.org; h=from:subject:message-id; bh=C5Y/qSHgQZACxwKSqcH92sWROtc2L1TL/YZtDg6REHU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdiZPZ43DQ6OuTrN/pfQ3Pe1/8ua/2jEky4Y23DmvSn u1GZ0uFOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSn8DI8M0ou/rHJ42GrK/V n88+OPfArquuvKFpwbMHyr0yiX80njL899p8rXSLOzPHx3cBqfn1DTo9XBcWGkuu3+0rsv2HyMM pDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 23 Aug 2024 21:07:30 +0800, Julian Sun wrote:
> Recently I noticed a bug[1] in btrfs, after digged it into
> and I believe it'a race in vfs.
> 
> Let's assume there's a inode (ie ino 261) with i_count 1 is
> called by iput(), and there's a concurrent thread calling
> generic_shutdown_super().
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

[1/1] vfs: fix race between evice_inodes() and find_inode()&iput()
      https://git.kernel.org/vfs/vfs/c/f37af83281e6

