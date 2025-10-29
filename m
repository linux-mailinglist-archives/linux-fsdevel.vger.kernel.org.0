Return-Path: <linux-fsdevel+bounces-65984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4002C17945
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE921C81211
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49682D0617;
	Wed, 29 Oct 2025 00:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFdNdZH8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B73F20FA9C;
	Wed, 29 Oct 2025 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698417; cv=none; b=IoapOr5W1/fiS+YK/hLbL/tiRi+Vjm2HcngXPN/Z/jVB1f9KjMMChmfCXU6hzyDyKHJeB5MzuSbRrQoDu5+0O9kPNt9eNSa1VlH1jxitadjrcUm3Dq9ClFoD5AohyyanCnu4V0mzA4Lhie0tdtkfomZDAGcK1JHpGY0FtC+SUZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698417; c=relaxed/simple;
	bh=9V6S+ToqYOKGoCF4liioLukqlDyrfN2J298ylaop/4A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dH140Npgrczmr4pQzVfe9iEt+yWgVvUja0CsNNK7fsthP06YWX4W4IWA4WKaG2CtrFuk0Hyt+hglpNZ4AQiaZsVrszTbAGRPRtGhyiU/c9WXc+0muohRKkjvjm6vSlzo4o1LmgzTG3KDja/M+Z71oXL95TkKBsLDy8wh5fc1B0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFdNdZH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E9FC4CEE7;
	Wed, 29 Oct 2025 00:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698416;
	bh=9V6S+ToqYOKGoCF4liioLukqlDyrfN2J298ylaop/4A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JFdNdZH8cDP4iGHGUw50mJibwB3v3jMbMtjSDHMh8V7BvU3Sk6XxtqNO7CbeS7LAk
	 5VaFI9PY660NAgdY55zX9AqqvZ2wA/fbulkJzlpV9CkxkqJTGhKxQcZtoVxMbPVbPD
	 3LLvsdFd84X9voPuyymTTdehxIyFPr7saXRONd+5ZnqQ+NEIiuSHKOLB80Eij7B8Px
	 lGAQjB79WER0oHe1UrySWOY/dngSbiELuaFPYTkosJCtyTnKY23EyhzeqTVBk4Trs+
	 6Drh/vlGPOpwc3Pp50S+MKuu78QT60DOGVg9mbkO+ndslvYdH7ynSqw1q8dAsw3hPV
	 kzCrNf4ATWstA==
Date: Tue, 28 Oct 2025 17:40:16 -0700
Subject: [PATCHSET v6 2/5] libfuse: allow servers to specify root node id
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169814111.1428289.10086098597397617301.stgit@frogsfrogsfrogs>
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

This series grants fuse servers full control over the entire node id
address space by allowing them to specify the nodeid of the root
directory.  With this new feature, fuse4fs will not have to translate
node ids.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-root-nodeid
---
Commits in this patchset:
 * libfuse: allow root_nodeid mount option
---
 lib/mount.c |    1 +
 1 file changed, 1 insertion(+)


