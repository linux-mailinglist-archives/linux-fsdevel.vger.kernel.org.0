Return-Path: <linux-fsdevel+bounces-44422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2AAA686C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB56D17DC60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD052512D7;
	Wed, 19 Mar 2025 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSzLal1s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F324E4C6;
	Wed, 19 Mar 2025 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372913; cv=none; b=OKaDQJKXU3ItimUr9jSBMLa2do3msIx1VXacibIINbnVUEWsECHgT6fQMi/ykDDVTxCFX3+xggeC4NXJ4tzy7Pq0Vh0+DcPl+v7pIByGsZeUzZbQWTVdG8bdlYCZSEDsajMxNOYuILn92LRmmaR1BU+I8yahEDo8t213NxSUu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372913; c=relaxed/simple;
	bh=mBqjz/BnDz4OJKVEtX06Ia/9DwMqMPB3XggP0oABitY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3GoSBy3srGuXgYfpEjVDvyWvAKxZ48CpIn270JksP8LRC0CFnTDnCAR7v4Yr6oGNwtkbulx/cUyFe5saQ+Nal7r7UnS5jWdJMPcIoYXLflHrm8BiMqEYMhHXW9/asMrPfaxHtfbXbVcjbdc+F5MjxCS/+BDKkOVdLVeUowdEw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSzLal1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F04C4CEE9;
	Wed, 19 Mar 2025 08:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742372912;
	bh=mBqjz/BnDz4OJKVEtX06Ia/9DwMqMPB3XggP0oABitY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSzLal1sjG0YfoXZnyepzkZ/PTo/JGJzxMHE6r1Q0ICXZ+XluHhFaQHYGv5Opf9QY
	 bznflldLi9qpyk++tWe7lilRzjTkV8Wds/lcZD9PWsltKWqr2yCyKg5sPznB8Q48Hc
	 M+4sDt9ecq7uhzWhcDjctzpqe3VYP4xHbg/v7msW9cBYdDvAGslYv+n9Dgxty7/3ap
	 oQfG4a/AyQHm8thV1WuG2v56+tVIHSyEbbTQUU8/1Myh0Zhe+K4LRDaCUyYrQsagio
	 ldJnAfW76u1Jnx4RkgYEWSL/jWyhbJqHk5s9b8sZVP98sDlrzh3V3/KcUvx1YOwRJo
	 1BnQBRxEpc1Fw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: load the ->i_sb pointer once in inode_sb_list_{add,del}
Date: Wed, 19 Mar 2025 09:28:24 +0100
Message-ID: <20250319-geben-tiermedizin-6f83e28a46d1@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319004635.1820589-1-mjguzik@gmail.com>
References: <20250319004635.1820589-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=992; i=brauner@kernel.org; h=from:subject:message-id; bh=mBqjz/BnDz4OJKVEtX06Ia/9DwMqMPB3XggP0oABitY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfatAqfh/BJGjyZXb8maqnd76xOnNtcaqtembXWMLjt 0Kst2pPRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERiNRkZXoXUx3r7ft3pk9de OHPux7O6f+6ztPJnXtLvYX8bYcZ6nJGh7Y7NLLF3330P/DlhH2Sau+J+03WjGWbryoxeHda54Py TFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 19 Mar 2025 01:46:35 +0100, Mateusz Guzik wrote:
> While this may sound like a pedantic clean up, it does in fact impact
> code generation -- the patched add routine is slightly smaller.
> 
> 

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] fs: load the ->i_sb pointer once in inode_sb_list_{add,del}
      https://git.kernel.org/vfs/vfs/c/5a607aa94398

