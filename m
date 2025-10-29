Return-Path: <linux-fsdevel+bounces-65975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C36C17900
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E47CF342113
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54E32D0292;
	Wed, 29 Oct 2025 00:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbZAX4mW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF6219E99F;
	Wed, 29 Oct 2025 00:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698276; cv=none; b=JhhEtsusLN09CTx1Ke4slFPwIun36+fOttlz+l+JxOtR9IiNJAMdtp/IkUGe4x/+s/OTl6oGphn1OO9sNefikgKfMYYHImIdMCediyjnGBEf/O8cy7vPuQJlXIDDoSv8d8xds51XD7rMPIvVe6Hh5YPN5USTBpcKzTCBBmaxXCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698276; c=relaxed/simple;
	bh=/br5Wdgw3v8NjB4BQ3E1Mm/Zqo5SHGKIIWUE6svTXCI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAaYf4aji3YUh2p1TloJAtk5tjr1IduJQQ/KvB/cZLbx0g8VkYpdA7HXqe6oXhC+Z+qjdDpfV2KC3OWO4XKUja0tKJB0s9nRqUkOpN5xV+XQ3er5ggzzz1x03pd8HwHbw/9fAMoD0EpE8ktCtiP++ff9MhdUU9bJAV93bW4PbMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbZAX4mW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06A9C4CEE7;
	Wed, 29 Oct 2025 00:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698275;
	bh=/br5Wdgw3v8NjB4BQ3E1Mm/Zqo5SHGKIIWUE6svTXCI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KbZAX4mWUCyFKwe8JJvvFcpvl4beeWcUlafpjeLTQrNpMJB9lw/xfBLwD1Mt6XyXq
	 tOlCvwKd9+HoGg34I+Xtb+wKvztajFaYLn8efFpreZf+7u/cVdtV/rCHQH/f0ZtZ4M
	 cwrqqRASqaZW4hbY2q+vSVxOEbyosoDzTANV/pabEBp+ljom8DQf3zPsod7GOm0ENg
	 vvTavg8xu+LcLcKZBHROryiT0QOkwpHK2d9nF2JOlgjlCAGaEAlYEA1Gps5Wwn7Mnz
	 BNdckzAaZoQ+qCSfrzVWJBJuJAg2RPvBKLfC9txdSEtctQEeJas7jtgq+N8zfwfFiW
	 uZBKPfXSQBwKg==
Date: Tue, 28 Oct 2025 17:37:55 -0700
Subject: [PATCHSET v6 1/8] fuse: general bug fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
In-Reply-To: <20251029002755.GK6174@frogsfrogsfrogs>
References: <20251029002755.GK6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Here's a collection of fixes that I *think* are bugs in fuse, along with
some scattered improvements.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-fixes
---
Commits in this patchset:
 * fuse: flush pending fuse events before aborting the connection
 * fuse: signal that a fuse inode should exhibit local fs behaviors
 * fuse: implement file attributes mask for statx
 * fuse: update file mode when updating acls
 * fuse: propagate default and file acls on creation
---
 fs/fuse/fuse_i.h |   62 ++++++++++++++++++++++++++++++-
 fs/fuse/acl.c    |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev.c    |   35 ++++++++++++++++++
 fs/fuse/dir.c    |   96 +++++++++++++++++++++++++++++++++++++-----------
 fs/fuse/inode.c  |   15 +++++++-
 5 files changed, 289 insertions(+), 27 deletions(-)


