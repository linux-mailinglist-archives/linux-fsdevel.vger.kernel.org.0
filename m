Return-Path: <linux-fsdevel+bounces-61479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A669AB5890F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2389B3B4DBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4559E19E99F;
	Tue, 16 Sep 2025 00:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbKuKz36"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A690F19DF62
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982024; cv=none; b=A5xeIwZ0c+fVS1X3MLRhJN/u9krKxbkHn8GOc5sAY8UX1iQ95+cTidN1/Z+TsTHa4qKUcsCLbp2RWPmbssFmnf7vqoaAYXb5hwQVENJ0WbVsMoWZBskpENRiHgstb1LlkUpANEfxELW5LwW6wCH+FckWnKtdcqnZ1jmwsqX4Jac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982024; c=relaxed/simple;
	bh=x94rOtR88DtMviWe6z9XukoN9p+lmc+Y16UCOPU2hMw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLPb1/cBesoBzwaweLq0JTZ+P17FXd+K49loPq6eZqoDjp+iA5in8CYf4TeSmoVft/Qh2+viS/kwj8KymexUUV+wBM+Zjlq+J+8kdc7t0DjOBaI+ehfh2LwTy5/Q2AbyvVRRoDgpMCSsDkqrIF6pjWyMPN1/bjCqaKPeDUF66ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbKuKz36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899E4C4CEF1;
	Tue, 16 Sep 2025 00:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982023;
	bh=x94rOtR88DtMviWe6z9XukoN9p+lmc+Y16UCOPU2hMw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EbKuKz36GiV9mYupnfvPk7cA5nv7IwtQo+hMRaB8P0MGrk3OtS+EWdLC2FHYi8NpF
	 Xw1Zew5+SHatq+R5to5Quwqg1mT7tigfmkgmejE/C/vLQZQDdO+fL5VZBUAsvQx/UL
	 mWerVZuCjFAHdyLEhIfyTLBw16Pj6RJUBDPgax/hzNtZwdU4oAGrIdZv8MWixr9D+H
	 tIymUHvX4MlzDf1/ShZrfZXbt/IRRjxix/nl0FxFFlPtcHl8Ygzv7UZX29beCyaJEs
	 ZYAz0PLDiX+XFJUTUufFgzn3X3/Dl0vU3n+DPupWjyRaM+bOah2jYlNwCsu1cWZ4cv
	 /9M8IACzOJALA==
Date: Mon, 15 Sep 2025 17:20:23 -0700
Subject: [PATCHSET RFC v5 1/6] libfuse: general bug fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154222.386823.13485387355674002636.stgit@frogsfrogsfrogs>
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

Here's a collection of fixes that I *think* are bugs in libfuse.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-fixes
---
Commits in this patchset:
 * libfuse: don't put HAVE_STATX in a public header
---
 include/fuse.h           |    2 --
 include/fuse_lowlevel.h  |    2 --
 example/memfs_ll.cc      |    2 +-
 example/passthrough.c    |    2 +-
 example/passthrough_fh.c |    2 +-
 example/passthrough_ll.c |    2 +-
 6 files changed, 4 insertions(+), 8 deletions(-)


