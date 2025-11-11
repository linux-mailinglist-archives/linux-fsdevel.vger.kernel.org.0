Return-Path: <linux-fsdevel+bounces-67879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F93AC4CC19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DEEB3AC7BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196742EFD9E;
	Tue, 11 Nov 2025 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0ji5CgG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEDC2D7398;
	Tue, 11 Nov 2025 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854199; cv=none; b=RsjCMVDcvomqeIHqRfuW9XBLvD3nhVN+Qv2BV54vVwbRByAxUotwlOfsXadDk4ampCAnBnnJQn3/fJ2VkOWMgaZcns3IeM1x1lN1c5Qytip5oIUnwIjSYhxXJvaHMbc3CRJ4fjehK2WCpF4Xh1IzqERd2F3O9f+RMlBpxbwcsTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854199; c=relaxed/simple;
	bh=EFgckVy4iUefAejLks1ILzXNYSpboVM39lPnuZZQi/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLWJNC6JgGLlzEE6kV9mCsbI9wbGOIn9jmHQEwInsmLPgA3n9DJDsj60XOK5saNHai8bYNZDFTfdH/W4rDaxwLsT2ogna+XnIX0U994xZjatMVXDBgB1QOMSd8w7AA1JhfhK0c7ZNdX/JV2UPvJlHFYox18z5tgtyt1WrTx31oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0ji5CgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811F9C4CEFB;
	Tue, 11 Nov 2025 09:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762854199;
	bh=EFgckVy4iUefAejLks1ILzXNYSpboVM39lPnuZZQi/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0ji5CgGYgojSOQ7aitsv8rjpxzC8QSsw/0Tmlg9hBFa8QwueIzfgaFh9H8+PbX5z
	 taA9fr1w6EC3bi8GBD1yrHcbe7SRnngbraRWa8K59YApEqwhq1uPaUATVzgCxcn00X
	 Lz96Gtw51K5mXTfIFf1PpG+pFq9igzWEkWVGE+ze4IVpAk5AGfzgHC9nmMhcmuA7qt
	 UAaXbkmzjFAzF1ERkV7eCdRaqSzjNI4LaQbzvPU6yxs/5vP7eqqIo7GeCQyQABzZx1
	 9u5n192KyC8R9PrVwjh8Et9oDp+sARxkHSmeRae0z89Lbxc7wHrPfY8LdqYTv07276
	 zc/buY0rsjnsA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	libaokun@huaweicloud.com
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] bdev: add hint prints in sb_set_blocksize() for LBS dependency on THP
Date: Tue, 11 Nov 2025 10:43:11 +0100
Message-ID: <20251111-golden-drinnen-9a205c60b6bb@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251110124714.1329978-1-libaokun@huaweicloud.com>
References: <20251110124714.1329978-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; i=brauner@kernel.org; h=from:subject:message-id; bh=EFgckVy4iUefAejLks1ILzXNYSpboVM39lPnuZZQi/s=; b=kA0DAAoWkcYbwGV43KIByyZiAGkTBTGibdmvDS7qhLpXIdlKff2bR5kUG5IddbdFxZHnfAVFQ Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmkTBTEACgkQkcYbwGV43KLnqwD9F6LC Ri0sbdi79L+VaY7T1gL8OMpzo+Mdp/fE/QsxIacBAKnj26g5vA+q5JBxvmtNOQQ3P9xJE5qcS9f ycynnswME
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 10 Nov 2025 20:47:14 +0800, libaokun@huaweicloud.com wrote:
> Support for block sizes greater than the page size depends on large
> folios, which in turn require CONFIG_TRANSPARENT_HUGEPAGE to be enabled.
> 
> Because the code is wrapped in multiple layers of abstraction, this
> dependency is rather obscure, so users may not realize it and may be
> unsure how to enable LBS.
> 
> [...]

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] bdev: add hint prints in sb_set_blocksize() for LBS dependency on THP
      https://git.kernel.org/vfs/vfs/c/5382107fad9b

