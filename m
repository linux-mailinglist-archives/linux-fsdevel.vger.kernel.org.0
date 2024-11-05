Return-Path: <linux-fsdevel+bounces-33699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081B29BD814
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 23:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A6328397F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 22:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD342161F6;
	Tue,  5 Nov 2024 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf/nJ+TN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6D553365;
	Tue,  5 Nov 2024 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730844311; cv=none; b=ZzHTV4FAH2xdpvkuTSALVJ1Tx6cpOMOu8wY13feDbUbnp4363zGizN7FX3kTxdzP14LF3Nr94+/dN54UN7jxsHffQEOSPdUcKaRaTwq1njFqrkD8tuT+qclSpo0nlB2YlhGVNNCD96ggCf+qQN1nUlxHQ7oB2PGMGWTl0OUGfPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730844311; c=relaxed/simple;
	bh=093GP+BD8Qv8cpp5xw0wBRAVM3y2dh8kDwaJ7/Ejy4I=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCDd38B35B1wkRmStkFIYstEswzfqneuMfN2R2mcAbqXKw+DlOgAXQQ6HoIU0KGOspOuOkZbqJvccCHX6Lz9/xCLDop/zurD7lZC6kG3E9Qi8LVI3nNbcRYWoAKIHfmM54PgUTHKBRpPyyNUpDLQFtjX6d+Pb8bPOAmy2GdpI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf/nJ+TN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F92EC4CECF;
	Tue,  5 Nov 2024 22:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730844311;
	bh=093GP+BD8Qv8cpp5xw0wBRAVM3y2dh8kDwaJ7/Ejy4I=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Xf/nJ+TNI0r0MqIS9T8ggV9bOdDcldMrkrW97jO13FQdeYWScdo0+MEKsfoE2GR3Z
	 Z5KB9woDbpheEfouHGnvBI0kHzJzeJLbPpv6aWz+q9Vh1SzSNmRgoWpcUdoQ6HcT7Q
	 62plv3a3xE5dsPScPWH3jO/X/E0cGY6pBk3i9fhDHaKBvrM2OQ6Ke1Aw3X0LyzsCw2
	 oBAzwVonj2lCi1U3CFHnFsSojUgzHsvfmGq8mivi7wrwcWUe0PULDzS+hJhce4ymSw
	 DaVsV4NsnMOsU1rMSYY7NNV7+CT2dwURkdUm2yb/Iw9n1ROut/PLpsOsqbdFHTv3lT
	 OE6HGSYwnujfg==
Date: Tue, 05 Nov 2024 14:05:10 -0800
Subject: [PATCHSET v5.5 05/10] xfs: preparation for realtime allocation groups
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <173084397642.1871760.15713612607469138511.stgit@frogsfrogsfrogs>
In-Reply-To: <20241105215840.GK2386201@frogsfrogsfrogs>
References: <20241105215840.GK2386201@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Prepare for realtime groups by adding a few bug fixes and generic code
that will be necessary.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=rtgroups-prep-6.13
---
Commits in this patchset:
 * xfs: fix rt device offset calculations for FITRIM
 * iomap: add a merge boundary flag
---
 fs/iomap/buffered-io.c |    6 ++++++
 fs/xfs/xfs_discard.c   |   19 +++++++++++--------
 include/linux/iomap.h  |    4 ++++
 3 files changed, 21 insertions(+), 8 deletions(-)


