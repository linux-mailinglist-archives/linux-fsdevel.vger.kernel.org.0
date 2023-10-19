Return-Path: <linux-fsdevel+bounces-731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A557CF421
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 11:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139341C20E24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 09:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18168171DE;
	Thu, 19 Oct 2023 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhZY85mW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4A4171D4
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 09:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CFFC433C8;
	Thu, 19 Oct 2023 09:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697708165;
	bh=hJZR4W2zZc1CrGsCWcAic1HmEejzXatx0UDZBAvsyjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IhZY85mWeObaIuqnAGTv3w41NuyOJlimTHFvXXypwg+TGlQ2DNmeeIH6jfDKW2nyU
	 RirgfhrmRelue2d20q3oj1VzmDBf4JwGI1gASTDNI/2+PYfDJVojdWZTuMChi2bttU
	 PrJlOcQb/xfmG65GleKUaapsZgHh+RnkTxNvmIgAWkMCr+81d4UhdtzDt1zBsexcum
	 eeXKA4/Q3BnXvs7RvgIolpk0ljvGL8vruG4ONGpdVNUqWuIPOs9bx+sKWvaA2A4cl2
	 SRBvt2iCpqSE9HDZ0TxuqAPbJgBVGMXF+VOA6mmvZrqeHGj9pgwU8AGerMenaYcA9+
	 pLzjduwxNaBuA==
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Denis Efremov <efremov@linux.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: don't take s_umount under open_mutex
Date: Thu, 19 Oct 2023 11:35:54 +0200
Message-Id: <20231019-gebangt-inhalieren-b0466ff3e1c2@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017184823.1383356-1-hch@lst.de>
References: <20231017184823.1383356-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=brauner@kernel.org; h=from:subject:message-id; bh=hJZR4W2zZc1CrGsCWcAic1HmEejzXatx0UDZBAvsyjM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQa/ChImW+UIbbFw3rSw5yNM/qlLa3E8qZM3Wf864DmtnlT Zcw3dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk90yG/wX9q+vfKi6M6S2tds/axc vIdWr9hOaVCSteht0J/vj28HeGPxwSPt94rts8NaiYO3+icqNv1jH35wtOil6bb2530r1OgBcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 17 Oct 2023 20:48:18 +0200, Christoph Hellwig wrote:
> Christian has been pestering Jan and me a bit about finally fixing
> all the pre-existing mostly theoretical cases of s_umount taken under
> open_mutex.  This series, which is mostly from him with some help from
> me should get us to that goal by replacing bdev_mark_dead calls that
> can't ever reach a file system holder to call into with simple bdev
> page invalidation.
> 
> [...]

I've applied this so it ends up in -next now.
@Jens, let me know if you have objections.

---

Applied to the vfs.super branch of the vfs/vfs.git tree.
Patches in the vfs.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.super

[1/5] block: simplify bdev_del_partition()
      https://git.kernel.org/vfs/vfs/c/b0df741ed69d
[2/5] block: WARN_ON_ONCE() when we remove active partitions
      https://git.kernel.org/vfs/vfs/c/2ff3adfb95a3
[3/5] block: move bdev_mark_dead out of disk_check_media_change
      https://git.kernel.org/vfs/vfs/c/6d4367bc04fd
[4/5] block: assert that we're not holding open_mutex over blk_report_disk_dead
      https://git.kernel.org/vfs/vfs/c/7addcb222703
[5/5] fs: assert that open_mutex isn't held over holder ops
      https://git.kernel.org/vfs/vfs/c/43ab05549df4

