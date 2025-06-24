Return-Path: <linux-fsdevel+bounces-52721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB9FAE6044
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2188B192454E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2909427AC21;
	Tue, 24 Jun 2025 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEkMxJaJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D04827A92A
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756064; cv=none; b=TjHZSHR2I+4p5KWwsCxKOf+iXB21XEoldJC5TBoYnHJ+nXgm3AALlV+TkdFXSOmMNpljeKZTcMsQTBqWz19KJEhsjazQVDOamAmR+yh6S8+2AqD33B1JkqU+MIDEdnNiuLhvu8/yZNvH65+ueqx/nfXyzXQzIPQ0fZlVOA2rml4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756064; c=relaxed/simple;
	bh=96QP0+BrvR2ir3iM55sfZnI3//5KRHJZm9Z7YsY5aGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cg13gcx9PYsOFMZHrnzIa89nemKYbUbwHVWwcsT+gGsF0WGeBwiNI2JimGYWRnjVrdegSx11pvWzxUOkaUbCovWwKnI0GWRjbi8+8O9igNMaabZV8BeqtExzHaxfFw6Kr8e057N6Nu/Op/Ti8s9B81RQI/1rEb1ohVKR1gbmkn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEkMxJaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F53C4CEE3;
	Tue, 24 Jun 2025 09:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750756064;
	bh=96QP0+BrvR2ir3iM55sfZnI3//5KRHJZm9Z7YsY5aGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IEkMxJaJE4qUq9O8cah5YFU+nn8VHFWxFtoe2QHQiKbV7rsP5bO+jxxQgpPeDDYBW
	 kAGf8O3JqloMH64P516Zeq3aQfclnxxsHVmMHXYMPGU1S8b6tqpLyd1oG+Tikcxrwr
	 TKcMdXuaipTWX5jvyJr8XNL563SINoc3l1hQrYRld5OZvPZ5gzpP24H7tkdmH6ZSr1
	 ShIEweszJU3M44pubiiTbs4s+m+JPD42EE6amhoTjmOf778drCq/l72hSMLQ8+wsDB
	 AtZQRUp6OB2Unoyi2Vw1eJ6pMjou/5DmMrt97u9KQj51ogOvni+ZRPzgjW+zhnPop5
	 kAKCskApdgbiw==
From: Christian Brauner <brauner@kernel.org>
To: miklos@szeredi.hu,
	Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com
Subject: Re: [PATCH] fuse: fix fuse_fill_write_pages() upper bound calculation
Date: Tue, 24 Jun 2025 11:07:31 +0200
Message-ID: <20250624-bohrinsel-unartig-97566e5f511f@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250614000114.910380-1-joannelkoong@gmail.com>
References: <20250614000114.910380-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=brauner@kernel.org; h=from:subject:message-id; bh=96QP0+BrvR2ir3iM55sfZnI3//5KRHJZm9Z7YsY5aGw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREZd3e+1Knsj/00U3FKyeF0mMqOnUrFpb9WOkskVIVG Ojp+Gl2RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESqMhgZrthNeXaA87epVbxH y6dXrya1zJ948cimdl5htfbAmjPHpzH8U/546symKa4n2hmvei36WLXdasWMvbK7xQTePk8+779 2CiMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 13 Jun 2025 17:01:14 -0700, Joanne Koong wrote:
> This fixes a bug in commit 63c69ad3d18a ("fuse: refactor
> fuse_fill_write_pages()") where max_pages << PAGE_SHIFT is mistakenly
> used as the calculation for the max_pages upper limit but there's the
> possibility that copy_folio_from_iter_atomic() may copy over bytes
> from the iov_iter that are less than the full length of the folio,
> which would lead to exceeding max_pages.
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

[1/1] fuse: fix fuse_fill_write_pages() upper bound calculation
      https://git.kernel.org/vfs/vfs/c/dbee298cb7bb

