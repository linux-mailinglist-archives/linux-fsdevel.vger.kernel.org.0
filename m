Return-Path: <linux-fsdevel+bounces-20428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 283BB8D3521
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA891F24E6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 11:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F2316EBFB;
	Wed, 29 May 2024 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXGyI0ee"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D76B16937A;
	Wed, 29 May 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716980844; cv=none; b=W1o3RwSE9r0FEppADJ6qrFJpdNey7wXP2NoMZT6etQG08UOmDumSRQuF6upbH09zM1KbSG+8OUn6g+n/J9e4SVOSvbNx+aBoKEi7sNcHwZWpomo1pjwxBIW/NGuWBiSL6JXQdjlx804eSBc/+hKEwBBQuJqaWwrwnPtuJNHvR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716980844; c=relaxed/simple;
	bh=Zz5dcUJAjpstTHPJIb+etUveMtW/6Scwi5EQeOUJ7ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLkdl0uW71n9hhR6g2YwzI/3gwMkk3hwZ4aSsKGUp9S6fu0TmOiFfuHFCcUa4CyJiUWAEG1HLxKIiwVTrM0ey/orHGYang+l1TdpRxxgXtQYeP5rJE9Tvv8T2b4SPnKiIz6Qakj2lJzA9oPjSFu5hq8Xs5fIbxnwB8rlo1A/TAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXGyI0ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6A5C2BD10;
	Wed, 29 May 2024 11:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716980844;
	bh=Zz5dcUJAjpstTHPJIb+etUveMtW/6Scwi5EQeOUJ7ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jXGyI0eek+m4h8vLzCcIeqL3BResayzbn/9eq4eQdmX8aGvdadTDSyYhHbcWZ7SMc
	 oCHQG0OQdVbEsJSt3B2AbSXznOQSRzoJwEN5Cox/MdZ7LUZKIyLN+E5lH0+PfCsDRN
	 TGZF/nVM1sP/Icm7ACn92c6W04cxE/awFZkGYgQQSmtOOVLCVu9Iv12oMrqxF1myES
	 esvfCOgGZhdP02mrWdKyYm4BDL9W/A90oxT6Sb4FeOwgsoS00ldMD3kE2DTm4w+oFq
	 Mox9gT62Xm9LJZdYY3YHlfGoF/FY4TJfAmVS6NUnNN+yAmO3a8yUWCXmg2lkxK737+
	 ENQfbJjqd1Ecw==
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
Subject: Re: [PATCH v3 00/12] cachefiles: some bugfixes and cleanups for ondemand requests
Date: Wed, 29 May 2024 13:07:07 +0200
Message-ID: <20240529-lehrling-verordnen-e5040aa65017@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240522114308.2402121-1-libaokun@huaweicloud.com>
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2670; i=brauner@kernel.org; h=from:subject:message-id; bh=Zz5dcUJAjpstTHPJIb+etUveMtW/6Scwi5EQeOUJ7ds=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSF80RPn/nywh92lrKCzP0rxB1+/17elKrM5+26rmBZ2 JZzUuuNOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy34zhr8yErrj9TWUn1tkq PQysO1zQo8TAtoQhRa5EiEvt1a/+cIa/0uzH707ymRFnFLm2c8ElhUNcmVJXtrkVOp/hF5hcbfK ECwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 22 May 2024 19:42:56 +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Hi all!
> 
> This is the third version of this patch series. The new version has no
> functional changes compared to the previous one, so I've kept the previous
> Acked-by and Reviewed-by, so please let me know if you have any objections.
> 
> [...]

So I've taken that as a fixes series which should probably make it upstream
rather sooner than later. Correct?

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

[01/12] cachefiles: add output string to cachefiles_obj_[get|put]_ondemand_fd
        https://git.kernel.org/vfs/vfs/c/cc5ac966f261
[02/12] cachefiles: remove requests from xarray during flushing requests
        https://git.kernel.org/vfs/vfs/c/0fc75c5940fa
[03/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
        https://git.kernel.org/vfs/vfs/c/de3e26f9e5b7
[04/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_daemon_read()
        https://git.kernel.org/vfs/vfs/c/da4a82741606
[05/12] cachefiles: remove err_put_fd label in cachefiles_ondemand_daemon_read()
        https://git.kernel.org/vfs/vfs/c/3e6d704f02aa
[06/12] cachefiles: add consistency check for copen/cread
        https://git.kernel.org/vfs/vfs/c/a26dc49df37e
[07/12] cachefiles: add spin_lock for cachefiles_ondemand_info
        https://git.kernel.org/vfs/vfs/c/0a790040838c
[08/12] cachefiles: never get a new anonymous fd if ondemand_id is valid
        https://git.kernel.org/vfs/vfs/c/4988e35e95fc
[09/12] cachefiles: defer exposing anon_fd until after copy_to_user() succeeds
        https://git.kernel.org/vfs/vfs/c/4b4391e77a6b
[10/12] cachefiles: Set object to close if ondemand_id < 0 in copen
        https://git.kernel.org/vfs/vfs/c/4f8703fb3482
[11/12] cachefiles: flush all requests after setting CACHEFILES_DEAD
        https://git.kernel.org/vfs/vfs/c/85e833cd7243
[12/12] cachefiles: make on-demand read killable
        https://git.kernel.org/vfs/vfs/c/bc9dde615546

