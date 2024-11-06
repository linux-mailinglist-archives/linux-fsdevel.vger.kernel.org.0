Return-Path: <linux-fsdevel+bounces-33710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4290A9BDABD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 01:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8801F213C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 00:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01621474DA;
	Wed,  6 Nov 2024 00:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU1x2eZA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05E2D613;
	Wed,  6 Nov 2024 00:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854662; cv=none; b=eJBPvOeenoUD0FTUHi6xTfQTRIfWUxypzfcqArBAJ+xiNkdhQqdKNV6XU2UtLUz589jq5YF7ccPiET5Gw7voWnOU0YDpa11MAOTa6FoYeaXIskMN8e5+dDfEEwkPOA3SOYDdtSHhMCcAAZn0HcgvW3bdHZgYgGqmapVFu4Cuoa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854662; c=relaxed/simple;
	bh=goa/cIX22Cl5f7cGc755k5BLCpVCIYhtzQep8rQrGi0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hm6Yf36QRTQl5eKrPsngiMZ4KT8PsfEfDO8rZHuTjYELQSDmK3eWSbLxkqOvxMQApxwFUnMEYuTuNE2z5kAWTZf4LAYclLNmIiovTSmGlJxK7OGf35VOIGgbBlyiYKDL8LABcsuDY7xf5MmzbeBQ2/a5ULFVO0y5ns2Fari1dGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU1x2eZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A296CC4CECF;
	Wed,  6 Nov 2024 00:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730854661;
	bh=goa/cIX22Cl5f7cGc755k5BLCpVCIYhtzQep8rQrGi0=;
	h=Date:From:To:Cc:Subject:From;
	b=GU1x2eZA9XHMIO4M9v9jE9MleHLUATw50umb4dKqqzAEKt47KLmAA6I8BlfHVpUuI
	 4cszwID984YUqCVHKuybA9ufRga2t32Vw7E76eUX8x34o0iYOoWzJsQV10izZAZi3M
	 CfqQLlG5mYjIm8f9shAsfW2P1tIrmcssBxDEZTe1x9Z0ejacqlQi4nIBd/TDxTdxdY
	 6zBaiD3ZB3yme3ZLRWjwYH15wJPbeYu+qs/MCHGeLiinSkjAYfV7rDk1ih+fYysaOa
	 3lpINihHVT5hRJGRDSSYKmK1OJy59oN4Ajqdtrg0gP0tWrV/nyeZoqZW0uYjnDWiXF
	 +AYpsq2O36OjQ==
Date: Tue, 5 Nov 2024 16:57:40 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: brauner@kernel.org
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	John Garry <john.g.garry@oracle.com>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-block@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [ANNOUNCE v2] work tree for untorn filesystem writes
Message-ID: <20241106005740.GM2386201@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

Here's a slightly updated working branch for the filesystem side of
atomic write changes for 6.13:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fs-atomic_2024-11-05

This branch is, like yesterday's, based off of axboe's
for-6.13/block-atomic branch:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block-atomic

The only difference is that I added Ojaswin's Tested-by: tags to the end
of the xfs series.  I have done basic testing with the shell script at
the end of this email and am satisfied that it at least seems to do the
(limited) things that I think we're targeting for 6.13.

Christian: Could you pull this fs-atomic branch into your vfs.git work
for 6.13, please?  Or would you rather I ask rothwell to include this
branch into for-next/fs-next and send the PR to Linus myself?

(Actually I might just ask rothwell to do that tomorrow regardless...)

--D

#!/bin/bash -x

# Mess around with atomic writes via scsi_debug

mnt=/opt

true "${FSTYP:=xfs}"
true "${MIN_ATOMIC:=32768}"
true "${SECTOR_SIZE:=512}"
true "${FSBLOCK_SIZE:=4096}"

umount $mnt
rmmod "$FSTYP"

rmmod scsi_debug
modprobe scsi_debug atomic_wr=1 dev_size_mb=300 \
	SECTOR_SIZE=$SECTOR_SIZE \
	atomic_wr_align=$((MIN_ATOMIC / SECTOR_SIZE)) \
	atomic_wr_gran=$((MIN_ATOMIC / SECTOR_SIZE))

sleep 1
dev="$(readlink -m /dev/disk/by-id/wwn-0x3333333000*)"
sysfs=/sys/block/$(basename "$dev")

sysfs-dump $sysfs/queue/atomic_write_*

for ((i = 9; i < 20; i++)); do
	xfs_io -d -c "pwrite -b 1m -V 1 -AD $((2 ** i)) $((2 ** i))" $dev
done

case "$FSTYP" in
"xfs")
	mkfs.xfs -f $dev -b size=$MIN_ATOMIC
	;;
"ext4")
	mkfs.ext4 -F $dev -b $FSBLOCK_SIZE -C $MIN_ATOMIC -O bigalloc
	;;
*)
	echo "$FSTYP: not recognized"
	exit 1
	;;
esac
mount $dev $mnt

xfs_io -f -c 'falloc 0 1m' -c fsync $mnt/a
filefrag -v $mnt/a

for ((i = 9; i < 20; i++)); do
	xfs_io -d -c "pwrite -b 1m -V 1 -AD $((2 ** i)) $((2 ** i))" $mnt/a
done

# does not support buffered io
xfs_io -c "pwrite -b 1m -V 1 -AD 0 $MIN_ATOMIC" $mnt/a
# does not support unaligned directio
xfs_io -c "pwrite -b 1m -V 1 -AD $SECTOR_SIZE $MIN_ATOMIC" $mnt/a

