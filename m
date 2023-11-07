Return-Path: <linux-fsdevel+bounces-2213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657117E37E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 10:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1297B20D7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 09:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B56125BE;
	Tue,  7 Nov 2023 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCF2Lwkw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A410A03;
	Tue,  7 Nov 2023 09:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8CAC433C7;
	Tue,  7 Nov 2023 09:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699349342;
	bh=6F92KsEvl6Q3W8UeFrDyhAjrbfGwTucvC1s6TlZV99E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JCF2LwkwU+V6Vbs3ok3wxatKrPGJdwisB6myZW64xlkKnBv3JUwcKhPCLhTI0ivBK
	 cDDbKq3MLrxwhOkgyIiGmg0kT6yjbrRom3NpZayZPaMnAGNRILOFHL7SJWHKcVHeQ3
	 LHSxq4KUhVNe17ZgoxmnTJwC9xgpCjUJ9cYjLwnnZsTxOICZEad2dtGmLt7NqMSK0d
	 /RFQmFYBX/GcnQsrmUXv3RIa98S7cOxD4A6HL119IXPQ6H7sgpldjOoPEtp6xClJtx
	 T+FR8byvG83LJnJRNfgmfiuyVsXB+U4rDjSU57AqRCQEaaB8NXN8njIjaVO9b20sJD
	 nnO/W2VeuC2Yw==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	syzkaller <syzkaller@googlegroups.com>,
	Alexander Popov <alex.popov@linux.com>,
	linux-xfs@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/7] bcachefs: Convert to bdev_open_by_path()
Date: Tue,  7 Nov 2023 10:28:53 +0100
Message-Id: <20231107-zugegangen-darlegen-b22727c25ede@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101174325.10596-1-jack@suse.cz>
References: <20231101173542.23597-1-jack@suse.cz> <20231101174325.10596-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=brauner@kernel.org; h=from:subject:message-id; bh=6F92KsEvl6Q3W8UeFrDyhAjrbfGwTucvC1s6TlZV99E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR6MbudbDjxdvW129aXNasCZ6p1uL3fab/OaplGSbfUg02z mqPDO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayPZPhr1ia578K/gnz1sVXz3Y1n7 887ZhSm+bXPXc7m7wD3rIvD2T4pxNcGjvpve6DjQZl2gW2Hx9bVF++uVZeXE91oe6M4wvZGAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 1 Nov 2023 18:43:06 +0100, Jan Kara wrote:
> Convert bcachefs to use bdev_open_by_path() and pass the handle around.
> 
> 

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

[1/7] bcachefs: Convert to bdev_open_by_path()
      https://git.kernel.org/vfs/vfs/c/8e897399352c
[2/7] block: Remove blkdev_get_by_*() functions
      https://git.kernel.org/vfs/vfs/c/1dc2789bf2d9
[3/7] block: Add config option to not allow writing to mounted devices
      https://git.kernel.org/vfs/vfs/c/708e8ecda49e
[4/7] btrfs: Do not restrict writes to btrfs devices
      https://git.kernel.org/vfs/vfs/c/b6b2f4843264
[5/7] fs: Block writes to mounted block devices
      https://git.kernel.org/vfs/vfs/c/48ce483465bb
[6/7] xfs: Block writes to log device
      https://git.kernel.org/vfs/vfs/c/dae1e956882c
[7/7] ext4: Block writes to journal device
      https://git.kernel.org/vfs/vfs/c/a8a97da12393

