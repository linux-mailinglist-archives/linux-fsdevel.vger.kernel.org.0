Return-Path: <linux-fsdevel+bounces-61472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F216AB58901
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD002A0328
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8193919F40B;
	Tue, 16 Sep 2025 00:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZxsDMKn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D982F18DB01;
	Tue, 16 Sep 2025 00:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981914; cv=none; b=ANbYsjQQbt2xtrtCZOPDN3vao0bmHJiDbJaEfsLWAzWuHwSu5nAz6gImeqwazoQpTndoB2+FGAFd96BtljYLVF/ud5VfpVSgxidu3ZAtUPCMOi05ze58H+m+VDy+8BjnypelRTZq543pXQUTycYPBf1b5UVG2miNVAj+J2RkklY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981914; c=relaxed/simple;
	bh=xNkzkt/ApJgYkE7Tj8GS7VU6hvjvJptCvYziq2/0I8Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVEOxG9Vcq2wfOmZMFpAkfYWBRHrF6tWamb7kzXe1NSWCfCsvYxTSBVsF+J1MCQIRyO2cnnEbou7/UmXPA/OcTml/d2lGQO+xZEa9CycHVSamEAbLVVMkTZjlGota7SCN/VJbPALyz9RIYBLyqkqe4Vv8HhN5k0vVJbfhjAF6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZxsDMKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8E8C4CEF1;
	Tue, 16 Sep 2025 00:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981914;
	bh=xNkzkt/ApJgYkE7Tj8GS7VU6hvjvJptCvYziq2/0I8Q=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=uZxsDMKnraD8LoaAayRzs56OQokHznDcimYUZUse7PCJyzRjN8hKa4i5FJaBLaXoC
	 KB1AvrDemy/QUFBu3i7DFegTkjpRTE9DqH2hqpxS7r+IU0rNhDMaaVGz3VtSiRL5Ek
	 t6VVDbtV+sWeIwEC39Vu6mCSAn0w4jw9QsvMaz5LKoUBurOtu/gjqr1Xr5oVd4edG1
	 kWoIVUU+o8uk1vVJDaQzMBhpZXQYq1XS+i7P8xXeE8EIeeGaKb0KUbHiTIERbB7mIY
	 4Rn3ANaJ2Q9IqjkV8gM9GItmKflApWPyzd3Ljh9QyAxb7bz16lG7/aSC9Fb9Af9vab
	 j6nWmU/3dhxYA==
Date: Mon, 15 Sep 2025 17:18:33 -0700
Subject: [PATCHSET RFC v5 2/8] iomap: cleanups ahead of adding fuse support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798150409.382342.12419127054800541532.stgit@frogsfrogsfrogs>
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

In preparation for making fuse use the fs/iomap code for regular file
data IO, fix a few bugs in fuse and apply a couple of tweaks to iomap.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=iomap-fuse-prep
---
Commits in this patchset:
 * iomap: trace iomap_zero_iter zeroing activities
 * iomap: error out on file IO when there is no inline_data buffer
---
 fs/iomap/trace.h       |    1 +
 fs/iomap/buffered-io.c |   18 +++++++++++++-----
 fs/iomap/direct-io.c   |    3 +++
 3 files changed, 17 insertions(+), 5 deletions(-)


