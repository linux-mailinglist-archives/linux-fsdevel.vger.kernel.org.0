Return-Path: <linux-fsdevel+bounces-29567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AFF97AD7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 11:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF671F229D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 09:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3C515B963;
	Tue, 17 Sep 2024 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ/yANKh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26F2136357;
	Tue, 17 Sep 2024 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563813; cv=none; b=eDt3xRD70BrWFBvNp7lrq2h3u99JKEKyOq2PwqLHZ32stn9D+FDUWDdk8VJlJAr/DoqvS/X9PUI7h+kuF7tvtQ0aRXuVF8o1cqFfwa6nn6RXPKhKgAWVbAzYDRBFP1eWfNQkUs2nHYLx6hlze+H0VRIxTeRfYb2VGyvs0QvhcPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563813; c=relaxed/simple;
	bh=EltNu/Vvs2dUaVxhrsZoanhKyc7N5StGFgimWX0o+4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQ1Ln7CqDBd9Pwkd//NTlBPblSGFxpk7zgJe4pJoISHQHdIJeMrjBoGEKkcl56dmGwujv+eYw8vJuARZhWXGgwhR4k6it8tyg1URcbUvzdy6pbTVgN71pl9LSz93ixsyyOUpZAJ6U18YK/rrUepBw5fUqQnzawX+mG5jeBvhpks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ/yANKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A3BC4CEC5;
	Tue, 17 Sep 2024 09:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563811;
	bh=EltNu/Vvs2dUaVxhrsZoanhKyc7N5StGFgimWX0o+4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQ/yANKhnddSqulNweiFVaryGn6CGgbcQ6UcZlMfKrPknKnYcKUP9MFP+cqeUMVcM
	 oBmLAOppc1865gs6utmZ5AEq7RN6oZbGfidJEP8dJoGboU1DUv2Cgp2AWpHzVWdIt5
	 YITHBvii9sspSNKH5/jSDrOAleRV5c8zkumZzM0kHLUNprvTYNlwbIn33+kJMGnM7Z
	 Le8qw7A6CUYhw9Pb5MiDuPI4ryqwsrb/APjIlHO+/aMrPSvQMhedmfXrJWZQrlO2gL
	 tBDJetlSQGD/w3nZ0YL6zUBaKeqoJPr60aUUlsQ6f8FiMApwzTYXkxoHsMzuIfDSNQ
	 bsBMFhvlMSVbQ==
From: Christian Brauner <brauner@kernel.org>
To: netfs@lists.linux.dev,
	libaokun@huaweicloud.com
Cc: Christian Brauner <brauner@kernel.org>,
	dhowells@redhat.com,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huawei.com,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH v2] cachefiles: fix dentry leak in cachefiles_open_file()
Date: Tue, 17 Sep 2024 11:03:19 +0200
Message-ID: <20240917-ursachen-umsatz-3746ab6636a8@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240829083409.3788142-1-libaokun@huaweicloud.com>
References: <20240829083409.3788142-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1589; i=brauner@kernel.org; h=from:subject:message-id; bh=EltNu/Vvs2dUaVxhrsZoanhKyc7N5StGFgimWX0o+4Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS9dL1tmNoz0SxnS82BXuV4j459Ti7XWO+85k8TYXBKY F4689PsjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInY5TMyNB861azxZYP1hOsl z4IfLt/p+ve2+xzG9etuSj2M/fB9XwYjw5Wir3wewlPMdCb38aTXM+T8Ufjj+frIrrOKU6OeX76 VzQ4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 29 Aug 2024 16:34:09 +0800, libaokun@huaweicloud.com wrote:
> A dentry leak may be caused when a lookup cookie and a cull are concurrent:
> 
>             P1             |             P2
> -----------------------------------------------------------
> cachefiles_lookup_cookie
>   cachefiles_look_up_object
>     lookup_one_positive_unlocked
>      // get dentry
>                             cachefiles_cull
>                               inode->i_flags |= S_KERNEL_FILE;
>     cachefiles_open_file
>       cachefiles_mark_inode_in_use
>         __cachefiles_mark_inode_in_use
>           can_use = false
>           if (!(inode->i_flags & S_KERNEL_FILE))
>             can_use = true
> 	  return false
>         return false
>         // Returns an error but doesn't put dentry
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

[1/1] cachefiles: fix dentry leak in cachefiles_open_file()
      https://git.kernel.org/vfs/vfs/c/31075a6ed624

