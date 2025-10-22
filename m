Return-Path: <linux-fsdevel+bounces-65245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB16BFE9ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 01:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813F11A02B39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 23:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2048A2EC097;
	Wed, 22 Oct 2025 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c05rHSNN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB62727F8;
	Wed, 22 Oct 2025 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177407; cv=none; b=bDEVz/KXWFPXDCM4Az1t+8HsHzNEvHufLgrC8yQx1ZhNXrtm8gQBL0UumP9NCvaf35GpOuvTWc2Jzxg4KkzNSHaudCYgMpRvtCSQlbED3OXrpUwbsXKTrB2y3+tkTMjr0dkUHT2mmj5e25SBhVpILhdRNdeAZNVExhGOf6C5ehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177407; c=relaxed/simple;
	bh=kaMFavPkuMtPJ7H7Wp6yDrA2mowKJ/hLpN2iLQ47Rcs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rUOGyXywjcCLDVhJ3PSpDbjCWvzHazD5toK1UkW4BX2A9+6K9h9rF55bSz61WjWjFyTAgeDXHZO5+Kk3aQ1+TgzTFZhVSH/HPAEh+I0N73LPNQ92bhmCSMmEb3HEJDLPumhHuhDm8T5ExXu5HM2BT1QrFS5y6AYfYL6xhgl9H0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c05rHSNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2BCC4CEE7;
	Wed, 22 Oct 2025 23:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177407;
	bh=kaMFavPkuMtPJ7H7Wp6yDrA2mowKJ/hLpN2iLQ47Rcs=;
	h=Date:From:To:Cc:Subject:From;
	b=c05rHSNNyZur4S5vFiazP5cV2LElY3oO448ge4rPTNccawZNFi9lJ6UgHca1uWZpw
	 YJh0iXaZlMiRRnEWNeRE6hgtGmkMJTNMOHHsjdSMwvlwTlmGQHVbnlD3j92kejRFf8
	 RQE/3OfPia7fCpE/AZy/gYQzpeCz5CMOc39MV4Q5j1UlwCPGrAG2u4WPavNqsWKviK
	 jz8Y4NaYpXa/X1UmGlssoy2fiB5HeSMyZYUNzjGmOTBtxJndvAHdAS4PcBWIHOJ7Xf
	 f+m8O06SH6/TfQAhNlg4YTo9W839rW1G0L4uPd3RUQBEMa7UfSU4BEsrlH44lhxBbl
	 Yxa6xWoF06tSw==
Date: Wed, 22 Oct 2025 16:56:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Carlos Maiolino <cem@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: xfs <linux-xfs@vger.kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	fstests <fstests@vger.kernel.org>
Subject: [PATCHBOMB 6.19] xfs: autonomous self healing
Message-ID: <20251022235646.GO3356773@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

You might recall that 18 months ago I showed off an early draft of a
patchset implementing autonomous self healing capabilities for XFS.
The premise is quite simple -- add a few hooks to the kernel to capture
significant filesystem metadata and file health events (pretty much all
failures), queue these events to a special anonfd, and let userspace
read the events at its leisure.  That's patchset 1.

The userspace part is more interesting, because there's a new daemon
that opens the anonfd given the root dir of a filesystem, captures a
file handle for the root dir, detaches from the root dir, and waits for
metadata events.  Upon receipt of an adverse health event, it will
reopen the root directory and initiate repairs.  I've left the prototype
Python script in place (patchset 2) but my ultimate goal is for everyone
to use the Rust version (patchset 3) because it's much quicker to
respond to problems.

New QA tests are patchset 4.  Zorro: No need to merge this right away.

This work was mostly complete by the end of 2024, and I've been letting
it run on my XFS QA testing fleets ever since then.  I am submitting
this patchset for upstream for 6.19.  Once this is merged, the online
fsck project will be complete.

--D

