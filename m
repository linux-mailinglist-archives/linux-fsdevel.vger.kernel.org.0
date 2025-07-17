Return-Path: <linux-fsdevel+bounces-55309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0472BB0973B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8904A6F46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D69244690;
	Thu, 17 Jul 2025 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/iyiTnb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64D2241667
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794717; cv=none; b=B9VfBX6/APZ0ktw42aSiMs+loje5DmCOy7iGvfM7EfbSpP+m52vn5VIzZ7wkaXBauAr5kcCCBWXMP1HNSi37cjIV7odpCRN+soxJPRc/oY60jfmR9bevEyyd9DgeItyw7qi5oYZW0JY5gynYCnd6c2WgmZbuUeGFCRoX2tG4d6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794717; c=relaxed/simple;
	bh=P5I9AyNlyvoP57shAu3Nb9IqdEpGFBLM8keBcJTe/DM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiBBpVL2WV8upkuUQKi/wnxRqxKpNR/djWUQetdYMk2u2RX25RJSq3692qKMv/U+nK6P3+KmfDGt/EDnq7sMjc6izBJrtgyCRhh7A/6YcCgWaK2eSf6nU3UhbwEpzhMuE/hPzVEKKr/yDZxHsy1ADbyY/bXE4BTCem1D2dtJCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/iyiTnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8230BC4CEE3;
	Thu, 17 Jul 2025 23:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794717;
	bh=P5I9AyNlyvoP57shAu3Nb9IqdEpGFBLM8keBcJTe/DM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=U/iyiTnbXVPeZoNX63bzAirG6NDfKEUj4Vi1pZMEdZRDRz4kjKpkKcBQkGKtkbg4F
	 K4QtYoQczhT80WQrnKV22eRfENoy7nrz61vMambXLB2bAlDm17AmPi5izCPgi+tw+G
	 NZDrjBmCjLnP0b3LYSBbSfJQDlP0U3MCr+0Tz/6zS3k0UaqWxQSzP7qm9BZ2Tz3en6
	 8LumOOfH7RA3jLEXG8AQiwM9V4BkuSWF/d6sIUXlScYZ6tW6Xu7FsQFUajp65d4emY
	 JL3xA7SIbzU9GF0pq8xGxJWzHFi6P4KsFBcxTB2PQokeaaDCCVAbrnLFBTzp1xBZYy
	 8MQU0hWb4mQaQ==
Date: Thu, 17 Jul 2025 16:25:17 -0700
Subject: [PATCHSET RFC v3 2/3] libfuse: cache iomap mappings for even better
 file IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279460162.714730.17358082513177016895.stgit@frogsfrogsfrogs>
In-Reply-To: <20250717231038.GQ2672029@frogsfrogsfrogs>
References: <20250717231038.GQ2672029@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series improves the performance (and correctness for some
filesystems) by adding the ability to cache iomap mappings in the
kernel.  For filesystems that can change mapping states during pagecache
writeback (e.g. unwritten extent conversion) this is absolutely
necessary to deal with races with writes to the pagecache because
writeback does not take i_rwsem.  For everyone else, it simply
eliminates roundtrips to userspace.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache
---
Commits in this patchset:
 * libfuse: enable iomap cache management
---
 include/fuse_common.h   |    9 +++++
 include/fuse_kernel.h   |   34 +++++++++++++++++++
 include/fuse_lowlevel.h |   39 ++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   82 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    2 +
 5 files changed, 166 insertions(+)


