Return-Path: <linux-fsdevel+bounces-13452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2608701E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126A31C22592
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048FA3D3B4;
	Mon,  4 Mar 2024 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKweJZFP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB9024B26
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557158; cv=none; b=E1QASUCb6sd74njRyK2ncXlKvOdGRaTkNjGyRIh+/Pv+hhpJooVHsaohc4/LQiNEX4agpqlGL+Tlic/CFXyQ5KVNESrv5OCGcR5PpZQY6O4TgD1+ZNEZ+qx6Nu3M0zjaMrtbdcDShb4WKv4McWAtQpPGoSCv7Kth7aD5FTSqBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557158; c=relaxed/simple;
	bh=JnCFbq+RIl8695Cmp7WXOoB3eReYnOBWpVgc4qEECFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FU4i0zbVmRlMtWIgONia8cPWjcOQ7xLQq2vYGyi4QoAj4U+jGLB6hNaOJ0piyUwqPyrUknvl6s6k7wmR1szHE1tb99DQdltA5/kKznM3pTDEKjfr5PLcttCODGbKg9IW+AmTrSv05DCMBOjyW5WX4dsuP2rXLPIo1Mm82kDMYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKweJZFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F11C433F1;
	Mon,  4 Mar 2024 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709557157;
	bh=JnCFbq+RIl8695Cmp7WXOoB3eReYnOBWpVgc4qEECFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKweJZFPWPoMbL1psiWcvZ5oOKyGKClIApk5HPXMXPkV8aST91wkWtY/LOE5h3yAO
	 pcIxBK8j7hLll6MKdbrd3+f2ILmGq/NZua+SmzWHwbd8gJ4hHHuoUZuhQb9Jy5OVC6
	 a7wT2wv4S2GZYJLB66TYgnYQBKrlkLiu0m043YBkxVoRwSYrKG3XXDljK4QIeIgc+4
	 8cYcqpLbBZgUUsSkiJ+acQxdghzdmtJwXlR2moRu7F9SGkcUIe57/uEcag+0WBZRVH
	 3uV1Ugmxdh+dWK6RDUy+FY7Nn68iDvrM9fd71VW+2XXllWMtGZm0W4j5XhWfPAF/2L
	 o1hWG7Tcrik8w==
From: Christian Brauner <brauner@kernel.org>
To: Bill O'Donnell <bodonnel@redhat.com>,
	sandeen@redhat.com
Cc: Christian Brauner <brauner@kernel.org>,
	al@alarsen.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] qnx6: convert qnx6 to use the new mount api
Date: Mon,  4 Mar 2024 13:57:01 +0100
Message-ID: <20240304-infostand-befrieden-7ea1414c5b73@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302165714.859504-1-bodonnel@redhat.com>
References: <20240302165714.859504-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=brauner@kernel.org; h=from:subject:message-id; bh=JnCFbq+RIl8695Cmp7WXOoB3eReYnOBWpVgc4qEECFo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ+PbqgQvLPQtbpKzs/WznXOU1+Kv/10L4TOz6UN559L Nqnd8FyV0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEnv9gZOjmfTdnzuIjgUaz uPfy6Vqwr5b6ZBje5/yuporpW76dXwzDP6XMM/sSQkLlS/O/vLU/pxp+4Kf/v0v1hS85vEuWNC+ 5wgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 02 Mar 2024 10:48:34 -0600, Bill O'Donnell wrote:
> Convert the qnx6 filesystem to use the new mount API.
> 
> Mostly untested, since there is no qnx6 fs image readily available.
> Testing did include parsing of the mmi_fs option.
> 
> 

Thanks for all the work! I've added a new branch vfs.mount.api where
we'll continue to collect these conversions. Everything in there is for
next cycle. As we're getting too close to the merge window now.

---

Applied to the vfs.mount.api branch of the vfs/vfs.git tree.
Patches in the vfs.mount.api branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount.api

[1/1] qnx6: convert qnx6 to use the new mount api
      https://git.kernel.org/vfs/vfs/c/af96d3456445

