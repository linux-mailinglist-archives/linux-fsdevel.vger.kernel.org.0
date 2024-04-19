Return-Path: <linux-fsdevel+bounces-17279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFC98AA847
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 08:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB291C20DB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 06:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77410D26D;
	Fri, 19 Apr 2024 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMTqoaDs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD971B667;
	Fri, 19 Apr 2024 06:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713507051; cv=none; b=VTflJqbwBIVSHG8j6mqN4WW6LC1Z76wL8WqinXhisDqLZxjvkGWIkudRMZ+4iCsigxA+dbp/nVwNKopt5Lj4+JuTEaKDaSjs0cd3fqjTPif41OaCmbUI2tpCPyyumsNl2eu312a//Ko12YjojM3op+tIUWGlAkb/Snttw7YKnZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713507051; c=relaxed/simple;
	bh=gTKwXvsblCudz6DySMG8Bzhl47r0kTOoiMzPOa8wdcs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=AMVikubDwpvQ43lLTYDDHF57vkMhli0O9MiRbNTQisdAlUMe1WwQj01IjkE3EaWVO/xKK1zJVMjcocebxaryBamCZrJ3mcGvUjRWXtGhYGdykzqy1i4+BbeIbKDpfmpDeKpUf83kSDeMImiLAFDYYP1SXs5q2eIHG2Oki8My+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMTqoaDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA297C072AA;
	Fri, 19 Apr 2024 06:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713507051;
	bh=gTKwXvsblCudz6DySMG8Bzhl47r0kTOoiMzPOa8wdcs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=LMTqoaDsdGEUNpHPHgjHLNdg/bkiD4jzjz8qAbwZd2rRa9qLx/iBqUH/bDhhsIk8Y
	 JdHn3gj03z9+Y1RWfIXrBfMDAC19ytGvBZYy20Qd2JFZ28QPeC08f/NblRa2rPBelB
	 wYjO/QzLFh2qbh65J1uVqLX2qhqvwLIW0pxA+orqN4kVQM8C9nomOngRhrgip0tHLi
	 II41zb+bRmfmfQiPzetFruOWShCv+0ZATa+rnTb6mxX72Qtx8yuEqM6qLAjqzxnLTg
	 i0VpwiV2/wIFV5a1kGGpjk6lUJPTlmDBELcXDfUq3a7I6Acqql/HjQ44bo2FC7oWdN
	 fw229PrhpEyCQ==
References: <20240320110548.2200662-1-yi.zhang@huaweicloud.com>
 <20240320110548.2200662-7-yi.zhang@huaweicloud.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 6/9] iomap: don't increase i_size if it's not a write
 operation
Date: Fri, 19 Apr 2024 11:37:51 +0530
In-reply-to: <20240320110548.2200662-7-yi.zhang@huaweicloud.com>
Message-ID: <87edb13ms8.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 20, 2024 at 07:05:45 PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> Increase i_size in iomap_zero_range() and iomap_unshare_iter() is not
> needed, the caller should handle it. Especially, when truncate partial
> block, we should not increase i_size beyond the new EOF here. It doesn't
> affect xfs and gfs2 now because they set the new file size after zero
> out, it doesn't matter that a transient increase in i_size, but it will
> affect ext4 because it set file size before truncate. So move the i_size
> updating logic to iomap_write_iter().
>

This patch causes generic/522 to consistently fail when using the following
fstest configuration,

TEST_DEV=/dev/loop16
TEST_LOGDEV=/dev/loop13
SCRATCH_DEV_POOL="/dev/loop5 /dev/loop6 /dev/loop7 /dev/loop8 /dev/loop9 /dev/loop10 /dev/loop11 /dev/loop12"
MKFS_OPTIONS='-f -m reflink=1,rmapbt=1, -i sparse=1, -lsize=1g'
MOUNT_OPTIONS='-o usrquota,grpquota,prjquota'
TEST_FS_MOUNT_OPTS="$TEST_FS_MOUNT_OPTS -o usrquota,grpquota,prjquota"
TEST_FS_MOUNT_OPTS="-o logdev=/dev/loop13"
SCRATCH_LOGDEV=/dev/loop15
USE_EXTERNAL=yes
LOGWRITES_DEV=/dev/loop15

-- 
Chandan

