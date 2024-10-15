Return-Path: <linux-fsdevel+bounces-31960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9F499E530
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C608B26179
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432C51E7C33;
	Tue, 15 Oct 2024 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMWRb0Rn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2951E571A;
	Tue, 15 Oct 2024 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990586; cv=none; b=slTg+FEozPaERP0AabGVg4+BnYCguzGIf4embQR+Wh3Lw3PRGl0g6WZsHkOnGSQXUcZUsh4Qfy5tcU+PiWo+5N9qbbjPRnyQgnIL8rdKT/zFuK7Pt0weLfp18b9lAUjy31OVOdWUMgVRjm//yXO5qKIGZ8p9YUIt2BM9qugtEAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990586; c=relaxed/simple;
	bh=1KvhG18Mgp0Xd7rZwa7rNWBfzuNqYTIEHZh1WWV57AI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XJjmgsJfFSzpGkGA5N9xR8maUhYYJQBRmh4AU66y+62p2wtFfFHH1RiNMAeTUg+rwKWtGS14n9I9dLWtc9sHtnuqPIhdb1s1v4PkakMVrkL2wCM9Eoy1rfjHx4i5tUbd3I2cqMyzJbIlkPqpBLKnXUhfyLr4T/u6LmCvwZc/yIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMWRb0Rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01501C4CED0;
	Tue, 15 Oct 2024 11:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728990586;
	bh=1KvhG18Mgp0Xd7rZwa7rNWBfzuNqYTIEHZh1WWV57AI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cMWRb0RnpysovJ/f0wP600M2jF8wlrsxX1zQXrOOmTtE2KyPA1Cjwmm0WhxxM4Cyl
	 bLC0j988bPo7POlLUwd5whGdkDZeHCahAheA0OYMVRaF8t8QCquwWVFSONBMG5/qa6
	 7B2lWZLzoil0IjalfRrFFqi5d39ymaheIPZ8V9ke7RIrD3sqXwTBhAHbeHbgK7sBrI
	 i+gbMngo+fIqJ1l0xvRiy9htP3dYAZL62JVU3HyXmPP2fhMQr7T61WVBQDLpcKOJui
	 XWMOIszRAOIDvEbJyPdL4OV0zWJ4XnHBwKK80mIKYRpBVTTzMfvoU+5ufLoVLrStNO
	 Z8l1Nxf0V5ZVQ==
From: Carlos Maiolino <cem@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20241008085939.266014-1-hch@lst.de>
References: <20241008085939.266014-1-hch@lst.de>
Subject: Re: fix stale delalloc punching for COW I/O v5
Message-Id: <172899058471.231867.8845545554612107226.b4-ty@kernel.org>
Date: Tue, 15 Oct 2024 13:09:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 08 Oct 2024 10:59:11 +0200, Christoph Hellwig wrote:
> this is another fallout from the zoned XFS work, which stresses the XFS
> COW I/O path very heavily.  It affects normal I/O to reflinked files as
> well, but is very hard to hit there.
> 
> The main problem here is that we only punch out delalloc reservations
> from the data fork, but COW I/O places delalloc extents into the COW
> fork, which means that it won't get punched out forshort writes.
> 
> [...]

Applied to for-next, thanks!

[01/10] iomap: factor out a iomap_last_written_block helper
        commit: c0adf8c3a9bf33f1dd1bf950601380f46a3fcec3
[02/10] iomap: remove iomap_file_buffered_write_punch_delalloc
        commit: caf0ea451d97c33c5bbaa0074dad33b0b2a4e649
[03/10] iomap: move locking out of iomap_write_delalloc_release
        commit: b78495166264fee1ed7ac44627e1dd080bbdf283
[04/10] xfs: factor out a xfs_file_write_zero_eof helper
        commit: 3c399374af28b158854701da324a7bff576f5a97
[05/10] xfs: take XFS_MMAPLOCK_EXCL xfs_file_write_zero_eof
        commit: acfbac776496f2093e9facf7876b4015ef8c3d1d
[06/10] xfs: IOMAP_ZERO and IOMAP_UNSHARE already hold invalidate_lock
        commit: abd7d651ad2cd2ab1b8cd4dd31e80a8255196db3
[07/10] xfs: support the COW fork in xfs_bmap_punch_delalloc_range
        commit: 8fe3b21efa075f29d64a34000e84f89cfaa6cd80
[08/10] xfs: share more code in xfs_buffered_write_iomap_begin
        commit: c29440ff66d6f24be5e9e313c1c0eca7212faf9e
[09/10] xfs: set IOMAP_F_SHARED for all COW fork allocations
        commit: 7d6fe5c586e6a866f9e69a5bdd72a72b977bab8e
[10/10] xfs: punch delalloc extents from the COW fork for COW writes
        commit: f6f91d290c8b9da6e671bd15f306ad2d0e635a04

Best regards,
-- 
Carlos Maiolino <cem@kernel.org>


