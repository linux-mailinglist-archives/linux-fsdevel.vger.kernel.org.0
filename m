Return-Path: <linux-fsdevel+bounces-29050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2948C9742F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 21:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656ADB257E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 19:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9301A705E;
	Tue, 10 Sep 2024 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SnaPKb/1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B58917A922
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995161; cv=none; b=ArAgMvKmK8Ce8cf9t76g+jsWsbvHWH3AZTjs2z13ooPyWISbe0rrCE3lkIrD7COrQNI0gb4S7HQLdhl9mF1dYlqqxszw9KG9awP3I5ZwyzW3f8ho7b7l8/e6YKH3z+M2b5MfPCSaCVc/BfuoeGPuf+gjVYcnvL/2QLGWj5OpT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995161; c=relaxed/simple;
	bh=SLV+XYn6nBs2t9meQ3KO1h4sWaLFdMza/UJh7pcED8s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=II//WW6jfcOizSVI6BOwdwRaGHtng6tdsFBcqHA7pjlorAwy6ZtPRbKYj6lJnNkJsmRNPwYMpflfMLlQOVLEIu0WyIjyqeh8HLJwMfKmQjYBpZZ6o6CNYHmWNclUYrhBUVAmgYPiU68yJ1+5z7Y0rWgeJOutPdEtkSt3r9E2oSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SnaPKb/1; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Sep 2024 15:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725995157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wrDNV0GgXZMc30bnmbuGsHXq9dkPpuKdk+3TqbVzVJw=;
	b=SnaPKb/1M1LDbQj9Oy4xpNbg56/HJL+GuYsgOQVUV9zp/QNmVP06AmcM1dEnQ11ict1TwJ
	0IWypLju1KnU6Oz+Omzh2sFb6hXVRXPxfAoQTDcySLhg7eb9PsOIzYfO0RFax+yphra8Gg
	liS0k0GMITqvpeN/1iyKEqWQGQIRrUg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.10.y
Message-ID: <6ykag7fdhv7m4hr2urwlhlf2owm3keq7gsiijeiyh6gd45kcxr@jfmqoqrfqqfa>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hey Greg, couple critical fixes for you:

The following changes since commit 1611860f184a2c9e74ed593948d43657734a7098:

  Linux 6.10.9 (2024-09-08 07:56:41 +0200)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-v6.10.9-fixes

for you to fetch changes up to ee64e00984ec3ea3fbf9b4331cbd073690ff8765:

  bcachefs: Don't delete open files in online fsck (2024-09-10 10:52:16 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.10.10

----------------------------------------------------------------
Kent Overstreet (3):
      bcachefs: Fix bch2_extents_match() false positive
      bcachefs: Revert lockless buffered IO path
      bcachefs: Don't delete open files in online fsck

 fs/bcachefs/extents.c        |  23 ++++++-
 fs/bcachefs/fs-io-buffered.c | 149 ++++++++++++-------------------------------
 fs/bcachefs/fs.c             |   8 +++
 fs/bcachefs/fs.h             |   7 ++
 fs/bcachefs/fsck.c           |  18 ++++++
 5 files changed, 95 insertions(+), 110 deletions(-)

