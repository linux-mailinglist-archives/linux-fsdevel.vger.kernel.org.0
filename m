Return-Path: <linux-fsdevel+bounces-61489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540FAB5891F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148713B4430
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632031A0711;
	Tue, 16 Sep 2025 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXOvZUM4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE8B625;
	Tue, 16 Sep 2025 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982197; cv=none; b=n6TDZX+SAyak60hgUA2XeECFFzUOO6zg0ZWHj9n9bA5tYi3gEcpDayfsd628YyYfRWvgaqZH+rkOe3IoLerTMjzRpXgBA3lOa1vwDYsFAWalVim21elwT9QJzuqYt4eP10hDKsL3/InvmYJzabsCyahR8l79gkh3DS1HcymMPaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982197; c=relaxed/simple;
	bh=IuzpYHqk9aBAMhvWG79JpYqaWqKSVe6h4wSpx9fIkNk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOS3Zd3CQauNIH/rb619rLA4bALBc6arZtoUs043edXulHxMm49iY/EwlORHLNIC0XXnvpx8zlW7HiwSDSjbhLk0Fvnr18NeMMbcvyrska10e97ySEr9hOczWF6Vbi7iKOjF8uDAAhmJT0gXhRYEjASQiZJK6nE+pjcY0OFD7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXOvZUM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39061C4CEF1;
	Tue, 16 Sep 2025 00:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982195;
	bh=IuzpYHqk9aBAMhvWG79JpYqaWqKSVe6h4wSpx9fIkNk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fXOvZUM48LB4Bzma1l7KMfqjzv3AcGo4FyW9N1wvxWvIVsawQsranCwXwm0kbnQN/
	 30qxuNCh9Q1TS3tMGneJETtd3ImL+2n0XMIPbHfq9MJb3UcnV6MmIC01izzeBv5z6f
	 P7nJVEAM7EOVxCZJGS9Ildb35zxodqk1DM6Z9b4JjydB4kD543R4rFoadx6KiJBj2Q
	 6aiQR/5FnF5ePyn6KxuU7apjZoazB0QHV4wNGMAUkuJa8PJyqo0xWlhXger/JyoAfi
	 dLSS78A/TxUqXSM0AHwPgEr1M1I3X826kRDtwh4oqPV9ZB6QLDcs+P2rVm+z9aTLEP
	 pvhLGUlcB4qrA==
Date: Mon, 15 Sep 2025 17:23:14 -0700
Subject: [PATCHSET RFC v5 6/9] fuse2fs: handle timestamps and ACLs correctly
 when iomap is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
In-Reply-To: <20250916000759.GA8080@frogsfrogsfrogs>
References: <20250916000759.GA8080@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

When iomap is enabled for a fuse file, we try to keep as much of the
file IO path in the kernel as we possibly can.  That means no calling
out to the fuse server in the IO path when we can avoid it.  However,
the existing FUSE architecture defers all file attributes to the fuse
server -- [cm]time updates, ACL metadata management, set[ug]id removal,
and permissions checking thereof, etc.

We'd really rather do all these attribute updates in the kernel, and
only push them to the fuse server when it's actually necessary (e.g.
fsync).  Furthermore, the POSIX ACL code has the weird behavior that if
the access ACL can be represented entirely by i_mode bits, it will
change the mode and delete the ACL, which fuse servers generally don't
seem to implement.

IOWs, we want consistent and correct (as defined by fstests) behavior
of file attributes in iomap mode.  Let's make the kernel manage all that
and push the results to userspace as needed.  This improves performance
even further, since it's sort of like writeback_cache mode but more
aggressive.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-iomap-attrs
---
Commits in this patchset:
 * fuse2fs: add strictatime/lazytime mount options
 * fuse2fs: skip permission checking on utimens when iomap is enabled
 * fuse2fs: let the kernel tell us about acl/mode updates
 * fuse2fs: better debugging for file mode updates
 * fuse2fs: debug timestamp updates
 * fuse2fs: use coarse timestamps for iomap mode
 * fuse2fs: add tracing for retrieving timestamps
 * fuse2fs: enable syncfs
 * fuse2fs: skip the gdt write in op_destroy if syncfs is working
 * fuse2fs: set sync, immutable, and append at file load time
---
 fuse4fs/fuse4fs.1.in |    6 +
 fuse4fs/fuse4fs.c    |  231 ++++++++++++++++++++++++++++----------
 misc/fuse2fs.1.in    |    6 +
 misc/fuse2fs.c       |  304 ++++++++++++++++++++++++++++++++++++++------------
 4 files changed, 413 insertions(+), 134 deletions(-)


