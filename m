Return-Path: <linux-fsdevel+bounces-21763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F28F9098FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 18:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240D01F21841
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C1349658;
	Sat, 15 Jun 2024 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8GCStk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2751DFC7;
	Sat, 15 Jun 2024 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718467468; cv=none; b=Dggi4rVQsORxP4tsmeUBQ4tLUjNX4MFkWYwE0uBbZttnzId+V7DBUOXOUn8+5rzAFaMgOkABnJbA5cD02W5M0Fvy1OgbO/935oFmFQBsnT4H1sFDgWVBUjGZhq36sPa2wzEnhLkiW2Jw5PidnsZQTlPEEJvwjy3hqOrsHyogRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718467468; c=relaxed/simple;
	bh=/pH+QGKRdc8Q2dh2z4DgFcC4sJ4dEUpDKJ8AryJ6txY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HT6RtBYotiYvHrzl4r15c3TuZY4flxrHlroLRXB75UxwOWYPdTCmyrZjcSkLjh4ayKRQSvLfFrzt/n3dPo5koef52hylW+ghqLzsScr93X+4R+O1DqKajWOULyLtcn3jZ6dyp+AwS4csypnHPo8EiK/pe27BffXhgb0Clb4HZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8GCStk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC108C116B1;
	Sat, 15 Jun 2024 16:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718467467;
	bh=/pH+QGKRdc8Q2dh2z4DgFcC4sJ4dEUpDKJ8AryJ6txY=;
	h=From:To:Cc:Subject:Date:From;
	b=A8GCStk0nc/NyZGFLUxaYmLb4gEj8STk67U8fqeT/8owCW0ynBUgPLqCPXfnhUccS
	 6Fofv6Yd5rXUqxusa2Nuk/JM6X+Ybo+u+nNt7Eg2HHPBXL7L/qmtdxzi4LaDfMvSks
	 NFZWdlVTfi9Hh/otV/bh5VEiErMtp5tcsP/hC7ZU30m1VOGEBx2R8F1UDghQH3HrCX
	 bwqu6NnGTI9vzMW4TZ9WcGaq7uIO2kAmG6RGrPNlbKu9xHV1fK84joKRCmGBjHl6eo
	 D7JLw2D1PtmJ8EHrfqYpw0qu/lDzCnJSEjrbQpQR4aO3ZveqJ/YBvR2va/nKSKqeSs
	 73n+iQB6sEfBA==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: bug fix for 6.10
Date: Sat, 15 Jun 2024 21:30:28 +0530
Message-ID: <871q4yfb08.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch which contains an XFS bug fix for 6.10-rc4. A brief
description of the bug fix is provided below.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git xfs-6.10-fixes-3

for you to fetch changes up to 58f880711f2ba53fd5e959875aff5b3bf6d5c32e:

  xfs: make sure sb_fdblocks is non-negative (2024-06-10 11:38:12 +0530)

----------------------------------------------------------------
Bug fixes for 6.10-rc4:

  * Ensure xfs incore superblock's
    1. Allocated inode counter
    2. Free inode counter
    3. Free data block counter
    are zero or positive when they are copied over from
    xfs_mount->m_[icount,ifree,fdblocks] respectively.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Wengang Wang (1):
      xfs: make sure sb_fdblocks is non-negative

 fs/xfs/libxfs/xfs_sb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)


