Return-Path: <linux-fsdevel+bounces-58433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C2EB2E9B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621601CC2F91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B811F4CA0;
	Thu, 21 Aug 2025 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8kaFNZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915841DDA15;
	Thu, 21 Aug 2025 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737425; cv=none; b=O3EJifAVufIlgSlajRrTCJFyJur0Nagdvt626oYSd5MGHtnFjxn1ikaMcVqfV3p8s33AdUCZBuNfpW6C/7r1P2kAsVP0N5IHMruK3eEHX9VOQRQd9xpAiwSvY7ag/WkmZs/nys9NMHdaTnAj68m5asiyQq6y9GotzDkkAZ1cgSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737425; c=relaxed/simple;
	bh=4M+Vw6fcC2wl3nLoRUqd3SM5Jaf2hmqZiSqPBlURgcs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLCCVVO+Jkx3SjtikMVG5p59XaaF2xV5eyKOqRJ5USq5h363vg8Mj1ky3BcbGFNWxRkhP3VEBSkKnlcwYRVNaXP+pePgHOYfPWiihqWNdkz4ln/STaPDI4hpNAZEnDQp/46uhr4zDoTU/QL1HoeOP3dgJJWb2NGHVTw48mStqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8kaFNZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660E0C4CEEB;
	Thu, 21 Aug 2025 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737425;
	bh=4M+Vw6fcC2wl3nLoRUqd3SM5Jaf2hmqZiSqPBlURgcs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=T8kaFNZYo69vjDDMwWrzeC89fxIeSxrfZVV3eNWtfdMqB1C2Ld2br5p+H3WHS/mSJ
	 xSHLZB58FethnGJ1lPNxfSq0xQ+Uc7it+6s1E5hAFF3QYx8wK+jrVyiCvmCmUqDFOB
	 GdCOJw74rpVamY5o5pJ0MkVoWC0L24rJJHQPPLp4RH1Vmoi5xNNatd023rWJFg6Bf8
	 /0fsHCqG9whNoi/8CaPzmQuzYmWMraQIoZZUenOkiB54BoNQ1MpMktiFkXN1dWbW1e
	 LsXw7+4gWhvyGkTtL14Z6Alm9P7a0lVJqEi/RTW1btSS/iXdWF2yKLxGQ1vX3wyDm+
	 gyl9QlADsDPqA==
Date: Wed, 20 Aug 2025 17:50:24 -0700
Subject: [PATCHSET RFC v4 5/6] fuse2fs: handle timestamps and ACLs correctly
 when iomap is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
In-Reply-To: <20250821003720.GA4194186@frogsfrogsfrogs>
References: <20250821003720.GA4194186@frogsfrogsfrogs>
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
 * fuse2fs: skip permission checking on utimens when iomap is enabled
 * fuse2fs: let the kernel tell us about acl/mode updates
 * fuse2fs: better debugging for file mode updates
 * fuse2fs: debug timestamp updates
 * fuse2fs: use coarse timestamps for iomap mode
 * fuse2fs: add tracing for retrieving timestamps
 * fuse2fs: enable syncfs
 * fuse2fs: skip the gdt write in op_destroy if syncfs is working
---
 misc/fuse2fs.c |  237 ++++++++++++++++++++++++++++++++++++++++----------------
 misc/fuse4fs.c |  193 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 304 insertions(+), 126 deletions(-)


