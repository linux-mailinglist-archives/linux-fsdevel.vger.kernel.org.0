Return-Path: <linux-fsdevel+bounces-61475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DD1B58908
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD3F1B219E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662F119F43A;
	Tue, 16 Sep 2025 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R50yAed2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C330C19CC28;
	Tue, 16 Sep 2025 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981961; cv=none; b=tf4Wm8AaXQFWBI4YQXvRWd+FWgBNnB4CQ4MxmrtGkOLBDabflJsQxQKESb9+LGQSC7OFrmk8pwIY7ZVui0/tkezsR/yZoDFOvuleoPSoNqCQthmvms5c/eZftCiwpQ5/hcP6sp8nTe8KFl6BWf63+VniBQukWw9E0+CT5Ernz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981961; c=relaxed/simple;
	bh=4I5hXOs36K19a9LmOPEQFqBNGALqwnBMZ4YoX5qFXuE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQP1rsYn81+R9AB2milT+K7Lu0V5S7UsFwp04DoeWCxG+sHRf3z+Q5YbrrhOdbxhF6i9eic3kJz0eu9xAxOu2k6RXX0uewA1k0KwKnRTfDBEpC7FhEkJVize3cjHS2OgqH15XyOoO+apjylC1Q13OWs00T8pybghRwx2hUviC4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R50yAed2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6B3C4CEF1;
	Tue, 16 Sep 2025 00:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981961;
	bh=4I5hXOs36K19a9LmOPEQFqBNGALqwnBMZ4YoX5qFXuE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=R50yAed2ka6kkDMH+NoVPsXsyksIRHjg4w00Ewdx3JsYVREgpb3m286ZI/zrLKEq4
	 tLyu0Rdr2vBDzaG46qMaoUxAVuMTGbLVIWBMBP78YDGIKVysvFd39Zlmh+dPJ0ifmL
	 HHP1BUCzSQ6hflCmxQUHYii5R2GvFxDKuq9lCSGbCH5niBqJbJgnx1sXZDrAImP2Ky
	 pQApqEQOHy2xtrLur8IarepbaO3fzzq2rHZFFrvkyAd2wYZijCmVXT1j6ClfJO2Eg0
	 3SA8OxRBWUL07F3CKACbh42lbUt6R88eMerUPXJusZQEwfUBRx/k8zF4vtNEFMWN98
	 B0XdtaU/9Ja+g==
Date: Mon, 15 Sep 2025 17:19:20 -0700
Subject: [PATCHSET RFC v5 5/8] fuse: allow servers to specify root node id
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152081.383798.16940546036390782667.stgit@frogsfrogsfrogs>
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

This series grants fuse servers full control over the entire node id
address space by allowing them to specify the nodeid of the root
directory.  With this new feature, fuse4fs will not have to translate
node ids.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-root-nodeid
---
Commits in this patchset:
 * fuse: make the root nodeid dynamic
 * fuse_trace: make the root nodeid dynamic
 * fuse: allow setting of root nodeid
---
 fs/fuse/fuse_i.h     |    9 +++++++--
 fs/fuse/fuse_trace.h |    6 ++++--
 fs/fuse/dir.c        |   10 ++++++----
 fs/fuse/inode.c      |   22 ++++++++++++++++++----
 fs/fuse/readdir.c    |   10 +++++-----
 5 files changed, 40 insertions(+), 17 deletions(-)


