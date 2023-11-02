Return-Path: <linux-fsdevel+bounces-1822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C43697DF2B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 13:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E219281AC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 12:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0BE569F;
	Thu,  2 Nov 2023 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1jJwRfj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0BD2FB6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 12:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5862C433C9;
	Thu,  2 Nov 2023 12:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698929300;
	bh=6xeGbI1L+DfUU9h5pLLEoRq/boiO9OMP2yYIoh7hJ5I=;
	h=From:To:Cc:Subject:Date:From;
	b=O1jJwRfjZruxvUj0hqU9Y6g/JHMxGzSFXyKuDtSiTkl5uO2K/T8mc8cJfC2HE10CL
	 9S1wFbm92AJPptjq5Nu35AHGU/AUiqx1MstMHyp0TAiZG+dO6g+Ey2EnBJGPT/Ko4v
	 sGyu4v9lWaYhm1Bc0D5RqkUWg5xFhwTBLTWMgb1UHXr1+Z/dCAlTz2QS+umODv2TKS
	 b0g6rS3KovF9ytieekI+cgGqWHVsrOVY5QhkUicDxaNKUK3zK+DNs+QXUceKFgXOZD
	 z+FW7pRJcQFz/2f5pOGgyOK9vGDpRCurMpTkLIgg6TMQGZOF/HLlnUw/8Cjq4Vylqm
	 h74Wn0BteriEw==
User-agent: mu4e 1.8.10; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, djwong@kernel.org,
 linux-xfs@vger.kernel.org, dchinner@fromorbit.com
Subject: [BUG REPORT] next-20231102: generic/311 fails on XFS with external log
Date: Thu, 02 Nov 2023 18:06:10 +0530
Message-ID: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

generic/311 consistently fails when executing on a kernel built from
next-20231102.

The following is the fstests config file that was used during testing.

export FSTYP=xfs

export TEST_DEV=/dev/loop0
export TEST_DIR=/mnt/test
export TEST_LOGDEV=/dev/loop2

export SCRATCH_DEV=/dev/loop1
export SCRATCH_MNT=/mnt/scratch
export SCRATCH_LOGDEV=/dev/loop3

export USE_EXTERNAL=yes

export MKFS_OPTIONS="-f -m crc=1,reflink=1,rmapbt=1, -i sparse=1 -lsize=1g"


The following is the contents obtained from 311.out.bad.

QA output created by 311
Running test 1 buffered, normal suspend
Random seed is 1
ee6103415276cde95544b11b2675f132
device-mapper: suspend ioctl on flakey-logtest  failed: Device or resource busy
Command failed.
failed to suspend flakey-logtest


Git bisect revealed the following to be the first bad commit,

abcb2b94cce4fb7a8f84278e8da4d726837439d1
Author:     Christian Brauner <brauner@kernel.org>
AuthorDate: Wed Sep 27 15:21:16 2023 +0200
Commit:     Christian Brauner <brauner@kernel.org>
CommitDate: Sat Oct 28 13:29:24 2023 +0200

bdev: implement freeze and thaw holder operations

The old method of implementing block device freeze and thaw operations
required us to rely on get_active_super() to walk the list of all
superblocks on the system to find any superblock that might use the
block device. This is wasteful and not very pleasant overall.

Now that we can finally go straight from block device to owning
superblock things become way simpler.

Link: https://lore.kernel.org/r/20231024-vfs-super-freeze-v2-5-599c19f4faac@kernel.org
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>

--
Chandan

