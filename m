Return-Path: <linux-fsdevel+bounces-23003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FF5925564
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 10:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D311284EDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 08:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B4913B5A6;
	Wed,  3 Jul 2024 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="De8x6DGF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533374D584;
	Wed,  3 Jul 2024 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995474; cv=none; b=OcGVfzFeUZmjly9XhlWbNRYmrqZH4XVC9TPoIrEzER3xsQEtOkG+dMeTJq9YPG8v+e/GZnj7GjYhNMFMqRhOajWyEws56GvvluFbDU2faLAGmfm+YosKAvY7rc7qrb0gkExNOSwZu2cqzrcLxiwlxsXWTthcqufByun/m16WUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995474; c=relaxed/simple;
	bh=YDu++FQvyBbQ5q007YIq1M9txqwp9dKc/o3S30ODOmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbrKV8gy6iitBNvUKGUjc4B3Kua+Gj0Rr+n3y6f327gF5PIzQ9hOHgAM5sPWx0YpHal8YpQ1jyOxuQWBw9wSDePPPo/kEkQWPFErvXeBnlJunGuFHM+irBMg8JohH/SqdK6ISxLT+e80rZbD6IJ9QIRcw+jUyKPZwChw5DOH8gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=De8x6DGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10385C2BD10;
	Wed,  3 Jul 2024 08:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719995473;
	bh=YDu++FQvyBbQ5q007YIq1M9txqwp9dKc/o3S30ODOmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=De8x6DGFGSuDGJ9Fd92iKUb2XW3pL8/ay7jtZOpHAFu4EkQkGXk28CEzWBY4zqQqQ
	 LLulSEHgAtRsvUkG9EEaO0z2E8Xfuvp9Cn1fxSrqqqp8Zh1tw9rKGyGd9uUEq3kyTR
	 zx34zQ/4yOkCJN3JvLEF1niGnZ6jxyiUFbUs3OJZnjwdCI5pGdblQXuG/TAbWoArdm
	 wFpKbtbXyvlbOcF3TAJs/1N59b6RSSUPF4H3h3s0jkbtbNRoFP1+J8CijKpRxtSnRN
	 ac/3TBDqVqZP5959YIKjEOFe8++Ca088D8KzNsHGUPbz7OknTrs1BDL+R1C97f7jBv
	 1olW5FUw/KFrQ==
From: Christian Brauner <brauner@kernel.org>
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org,
	libaokun@huaweicloud.com
Cc: Christian Brauner <brauner@kernel.org>,
	jefflexu@linux.alibaba.com,
	zhujia.zj@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huawei.com,
	Baokun Li <libaokun1@huawei.com>,
	Gao Xiang <xiang@kernel.org>
Subject: Re: (subset) [PATCH v3 0/9] cachefiles: random bugfixes
Date: Wed,  3 Jul 2024 10:30:55 +0200
Message-ID: <20240703-miene-ausziehen-1f6a167a1020@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628062930.2467993-1-libaokun@huaweicloud.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761; i=brauner@kernel.org; h=from:subject:message-id; bh=YDu++FQvyBbQ5q007YIq1M9txqwp9dKc/o3S30ODOmA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS18rjf3fhdbtn9SEFvTZZnEz+xLrC75lD5Y5eYyue8b dxcivmTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiWcLwP6uI7eHCSFXlg75t rWt2T3IR4O2avGpbrV3qB34jcxXOg4wMF1LX5YReTFgbvXaLVebEdxEV+Tm63+IWzv58u+m8crY yLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 28 Jun 2024 14:29:21 +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Hi all!
> 
> This is the third version of this patch series, in which another patch set
> is subsumed into this one to avoid confusing the two patch sets.
> (https://patchwork.kernel.org/project/linux-fsdevel/list/?series=854914)
> 
> [...]

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

[4/9] cachefiles: propagate errors from vfs_getxattr() to avoid infinite loop
      https://git.kernel.org/vfs/vfs/c/b688bd1735e7
[5/9] cachefiles: stop sending new request when dropping object
      https://git.kernel.org/vfs/vfs/c/32eb47eab833
[6/9] cachefiles: cancel all requests for the object that is being dropped
      https://git.kernel.org/vfs/vfs/c/2f47569feef0
[7/9] cachefiles: wait for ondemand_object_worker to finish when dropping object
      https://git.kernel.org/vfs/vfs/c/343ce8c52dd0
[8/9] cachefiles: cyclic allocation of msg_id to avoid reuse
      https://git.kernel.org/vfs/vfs/c/5e6c8a1ed5ba
[9/9] cachefiles: add missing lock protection when polling
      https://git.kernel.org/vfs/vfs/c/5fcb2094431b

