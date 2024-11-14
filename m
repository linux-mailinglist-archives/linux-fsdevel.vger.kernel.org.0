Return-Path: <linux-fsdevel+bounces-34734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874229C831B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 07:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9881F23928
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 06:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259621EABBB;
	Thu, 14 Nov 2024 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSKTElfH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BEB1E4B0;
	Thu, 14 Nov 2024 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731565633; cv=none; b=ia6hQxnkply138StBhmFVXu0e70dtg/sBMeOJdOnR0A/EfNsex6wjbkfUsCOzwe0ivpeXaxzzDToGjlMeZXzAs9QnhXnxfkw5HVqqzx3BJjpnDF5loIaW4j0ILCbjetk86hAuVYraU2JFUt3i3dyTF4BTrFCyBdzdiU1AqnSRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731565633; c=relaxed/simple;
	bh=B8W2Vh8Zu7YGB/xrLgeQ8sKFj8KaqifvaKvs2qYSK0M=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:In-Reply-To:
	 References:Content-Type; b=t2Nup8k4SPnWyKc4Zr46VRBLAwzW0rGICkLkNgUu3oC4QhRrw/G9DWxhLv3vXoup86+nPtYr1sdTmMM7ZSkvtOATQ0R8xUWmYmOtfZmU4zZdoxgnYfaz/qe08JxcavxIgeFFLMb5yBKdqxwXAinV4hvVjJGyt+2jyFW8+4CRyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSKTElfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D7CC4CECF;
	Thu, 14 Nov 2024 06:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731565633;
	bh=B8W2Vh8Zu7YGB/xrLgeQ8sKFj8KaqifvaKvs2qYSK0M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HSKTElfHhBZSjdU7Z5TXWpgbNpEvdLqd69srF1MhHvmI3ZCmeImnuYTlOnj3pjtJW
	 JrTrZhSYPo8eeqUfuwsFrZKAl4iH9koVmsfxyOlzEA9e+7qlEztMmbgVyY2e8P4dil
	 nizcKqUImazaYxH0ypFDmNlJYEFJ34RgUXV9qQlV0wVserC9m8AaTrRQu0IDpcrMVo
	 Y8D4AT236N4hx65DDNWEgbJ9rFhC5PPbD9SaBlmhtLdY1o4H/j9aFvJewqNwKC8l59
	 QDcUR/iHyC7oYhlXhbXqla2Yhb1mhruF79lgzcYHuTO0MPiIDG/TpHTW3gQAUn7sk5
	 Lyxyfbl7LcoNA==
Date: Wed, 13 Nov 2024 22:27:12 -0800
Subject: [GIT PULL 05/10] xfs: preparation for realtime allocation groups
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <173156551464.1445256.17858830260130923725.stg-ugh@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241114062447.GO9438@frogsfrogsfrogs>
References: <20241114062447.GO9438@frogsfrogsfrogs>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Carlos,

Please pull this branch with changes for xfs for 6.13-rc1.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 9d64db093d7b4974d24af34aa3fa85a394195292:

xfs: make RT extent numbers relative to the rtgroup (2024-11-13 22:17:05 -0800)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git tags/rtgroups-prep-6.13_2024-11-13

for you to fetch changes up to 7b91a30e441641733672f691244e5973ff1ca6de:

iomap: add a merge boundary flag (2024-11-13 22:17:05 -0800)

----------------------------------------------------------------
xfs: preparation for realtime allocation groups [v5.7 05/10]

Prepare for realtime groups by adding a few bug fixes and generic code
that will be necessary.

With a bit of luck, this should all go splendidly.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Christoph Hellwig (1):
iomap: add a merge boundary flag

Darrick J. Wong (1):
xfs: fix rt device offset calculations for FITRIM

fs/iomap/buffered-io.c |  6 ++++++
fs/xfs/xfs_discard.c   | 19 +++++++++++--------
include/linux/iomap.h  |  4 ++++
3 files changed, 21 insertions(+), 8 deletions(-)


