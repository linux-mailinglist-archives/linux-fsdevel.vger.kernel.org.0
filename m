Return-Path: <linux-fsdevel+bounces-16659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF128A0C25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 11:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68EE286F0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 09:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B8E144308;
	Thu, 11 Apr 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4ccmrpl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E441411FE;
	Thu, 11 Apr 2024 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827107; cv=none; b=YvsOHMzHGkV/zi2iIJwd2wdrZtnJwdcom9RLmLX3LPaCNQvNAF9ePYQGwHyhlFvp6wyTXfVQ9lomFwVrle3aNRRrOjoBcAwDKmVlkBY7c9g/FNeOaqBribexCu4A9c1DC7LGW77W1Ewye5y0xQPaAm1XasKMqArZHVtZj3XDVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827107; c=relaxed/simple;
	bh=iawV5IlmIfzwPZ6Jvl07hYMoUYW8ES3B4AE5r55S2w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKSsVwYnNp6cSuvhnsAUxb3Hw2HdQzsrVqrksUsyGPRGegtj6AqWsOyQfTYDdD7cPn5LnzI7mBFRmYYNyT+jW5Yymq2IgLLnSZalodOkYAUDl8R20uOOCsSjXY/IX+87f6sJzP44so2Gjr3aplosIU8dV7pYRuini2jMJZSksoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4ccmrpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560CAC433C7;
	Thu, 11 Apr 2024 09:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712827107;
	bh=iawV5IlmIfzwPZ6Jvl07hYMoUYW8ES3B4AE5r55S2w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p4ccmrplhy3Ug9qyOJwBmf3OxL+iIo0dJRmwXPOAHO1nNejvX07EvmJw9W/7UhrUD
	 fk7ZHwccDxiOepwrxG9djfZT5PRQbfRxx4h4GZYu7AiHRBRVbBhJxqFl0JzZhVqLJn
	 5ax1kXbE+AMQMw7sCFCmgYXXqKBLCX3GLP09divyoVvXGGnwZAdhfCxkpPcO476bbY
	 1gFtxCMTYxRgrBb0LBz44hxeCvl1g27tEh9c2aw0o534/du6toOePd4/MF9WVQvyLy
	 cgzhVIOQ+tOTkEYsxNJK3ReCwZ9AgeAmcH6jTxMVMeVOYn90rnqo/AVE79j0nJxUIy
	 hT2V8ms5vjR/w==
From: Christian Brauner <brauner@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	yukuai3@huawei.com,
	jack@suse.cz,
	hch@lst.de,
	viro@zeniv.linux.org.uk,
	axboe@kernel.dk
Subject: Re: (subset) [PATCH vfs.all 21/26] block: fix module reference leakage from bdev_open_by_dev error path
Date: Thu, 11 Apr 2024 11:16:09 +0200
Message-ID: <20240411-redet-meistens-d80377f01848@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406090930.2252838-22-yukuai1@huaweicloud.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com> <20240406090930.2252838-22-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=brauner@kernel.org; h=from:subject:message-id; bh=iawV5IlmIfzwPZ6Jvl07hYMoUYW8ES3B4AE5r55S2w0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSJr8rT/FYkr+ileIn51A31g5XyMrc/uaeedZq0Ni3Ib UZMbsqFjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk8PsbwP3v+muizgU8mmDZw 5voZ2avI8a//W8SRNzvGPXcON/cZXUaGBfWHimxfWcRuajyxx2eyrf5pBb2y4tg3Tff3KV/Ldwl kAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 06 Apr 2024 17:09:25 +0800, Yu Kuai wrote:
> At the time bdev_may_open() is called, module reference is grabbed
> already, hence module reference should be released if bdev_may_open()
> failed.
> 
> This problem is found by code review.
> 
> 
> [...]

Bugfix for current code that should go separately.

---

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[21/26] block: fix module reference leakage from bdev_open_by_dev error path
        https://git.kernel.org/vfs/vfs/c/9617cd6f24b2

