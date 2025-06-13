Return-Path: <linux-fsdevel+bounces-51599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91003AD93D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 19:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D047E3B82D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE5D225419;
	Fri, 13 Jun 2025 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWNE67u0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942B132111;
	Fri, 13 Jun 2025 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749836231; cv=none; b=Yu8sB8o99bPhKoOyXjgTRp9SsmVocHa9HG2op/DeYcp+BQYXRqMbVNHNNcI+S6U3WCQpOBFrkHEPE2k04x5IDCfwFTBBcRv4y2hPYT/BZrNksDChYuBCE+PgXTc8Oi/jtLgAXkAnzzdVwo9ns8KjpfYRH+6Bb7aJRzv1tvbBCU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749836231; c=relaxed/simple;
	bh=Rxqdd1Hi/O/X5yWPvjVhk1zHnxTbhH/N+jvZv/0yg3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sn63gfqFwetHGTNAoN4pTrBaamGIp3tfMacRkTOYGPKP3zIhVkpkdI9VuluHuHwsCUyYDvk9A5Px1sJN3HJTlgvNNTa07GSLzbUrcRTmcVsIoKR34UTY4f/h47A1x5QwHUBCTCV9TaegCGKgJEjiwk/MrKSSJhyUY1I0Tp6ysW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWNE67u0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E52C4CEE3;
	Fri, 13 Jun 2025 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749836231;
	bh=Rxqdd1Hi/O/X5yWPvjVhk1zHnxTbhH/N+jvZv/0yg3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWNE67u0+vZPnln+WmWzxW86k9tpPOvy8mWLU6ETDJlbNpvdbQiPdmJwMxRjdzf3a
	 J7pdlGQA17Q7BNC1SexUvyX+DP53AIzug6mTB915xJA9wu2V65P1ysBQ4PTdNnMB/K
	 TelyVvZj4vVIzdHV5b+t5i6Z2NVuwyBsUcYGgio9UKA17zi797HmBrbqFfBaVl/P1I
	 W799jgxzUrVo8F83FAM1eYKWnrvRAp2attdJKblpZlVcpXkhynBsEloOp7BEHyf9i+
	 0bKe6SR9vniErlCaWBRDGu0W7faalHIQVVaJal2ObTslkK5iIqMZt+yrAtTjkSDPjL
	 H+9makmrmjYYA==
Date: Fri, 13 Jun 2025 10:37:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net,
	bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>
Subject: [RFC[RAP] V2] fuse: use fs-iomap for better performance so we can
 containerize ext4
Message-ID: <20250613173710.GL6138@frogsfrogsfrogs>
References: <20250521235837.GB9688@frogsfrogsfrogs>
 <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>

On Thu, May 22, 2025 at 06:24:50PM +0200, Amir Goldstein wrote:
> On Thu, May 22, 2025 at 1:58 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > Hi everyone,
> >
> > DO NOT MERGE THIS.

Three weeks later, I've mostly gotten the iomap caching working.  This
is probably most exciting for John, because we were talking earlier
about uploading storage mappings to the fuse driver and this is what
I've come up with.  I'm running around trying to fix all the stuff that
doesn't quite work right.

Top of that list is timestamps and file attributes, because fuse no
longer calls the fuse server for file writes.  As a result, the kernel
inode always has the most uptodate versions of the some file attributes
(i_size, timestamps, mode) and just want to send FUSE_SETATTR whenever
the dirty inode gets flushed.

After I get that working I'm going to have to rewrite fuse2fs (or more
likely just fork it) to be a lowlevel driver because as I've noted
elsewhere in this thread, the upper level fuse library can assign
multiple fuse nodeids for a single hardlinked inode.  The only reason
that worked for non-iomap fuse2fs is because we have a BKL and disable
all caching.

For fuse+iomap, this discrepancy between fuse nodeids and ext2 inumbers
means that iomap just plain doesn't work with hardlinks because there
are multiple struct fuse_inodes for each ondisk inode and the locking is
just broken; and the iomap callouts are per-inode, not per-file which
leads to multiple layering violations in the upper level fuse library.
Also as Amir points out, path lookups on every operation is just *slow*.

Interim branches can be found here:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache_2025-06-13
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git/log/?h=fuse-iomap-cache_2025-06-13
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-iomap-cache_2025-06-13
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fuse2fs_2025-06-13

(I'm not going to respam the list with patches right now because the
quality as told by fstests isn't quite where I want it to be for such a
thing.  fuse2fs+iomap passes 87% of fstests (down from 89% without
iomap) but that's still pretty bad.)

--D

