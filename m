Return-Path: <linux-fsdevel+bounces-15307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8242688BFD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF12B24E0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423ED38DFB;
	Tue, 26 Mar 2024 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0erkZwc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3F15C89;
	Tue, 26 Mar 2024 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450105; cv=none; b=dIEkTpGGT5a2bw5OjRGXkRs2ZX21hfhFUTP6hIt1Q/nwgxD9UfmvwkltQH6z/o8Zx6+tUMcRoHL390/eus/HcLTHzIJaF05J+apYh+vxZPSnFyfnPRNVSitO68G1D9oJK4uJ84kWiE4ajA9emk6JEOjkzuuYYbY+OoCz6mBiaNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450105; c=relaxed/simple;
	bh=ItD4cQ9/T2Lbjdnw5EA900Xzkb3YwHbPekHFYEjw/bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDO0QxIwGHJ1R65gdfFGYftT7zZXdH77b3hrd2TK64d9xcaqRvgsFOSZGfAW7/RpTB+lltFILtiFSKr8TR5qjx/Hdh/6QXhTW1Kn6afKBoIPfWXrwpEapGLb4psXEmgGnDNbQUQk4wBO+xbq3FMk08hqsVF5Pwa8X/wPczDp7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0erkZwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1367C433C7;
	Tue, 26 Mar 2024 10:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711450104;
	bh=ItD4cQ9/T2Lbjdnw5EA900Xzkb3YwHbPekHFYEjw/bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0erkZwcejRAAkYW76kntsUngRhDYzXvc7hnjtn2mV+QMff9yChh3gREXkmvEjoHs
	 Zdbd/ng1CyKBnI7E9Twpa2ZEnRpLubCVfDZt9fvcFJcZUKyISrXmctME8vaYVaw1wZ
	 zwBxQUJkqzuweKwzx0KMO3fgwwQVaMeeTiIruiY3c9t1hhrPWB1tu5yXAIPU1uj9zn
	 GD1QhxdYCOQ/RFwuTib6lK6tiAh/mnTx1jWDEW0cV1cagvYbS81FJnELaQGLNlsJ7C
	 cayUn9PVEjO7Vw1pwDJm8x2IuQeZ+61ByvH25HjeZo67WijH/gf6zvGlQ2MaaqfVDm
	 WN7o/urREB59g==
From: Christian Brauner <brauner@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH][next] fs: Annotate struct file_handle with __counted_by() and use struct_size()
Date: Tue, 26 Mar 2024 11:48:10 +0100
Message-ID: <20240326-sehen-flogen-52373eb09da1@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZgImCXTdGDTeBvSS@neat>
References: <ZgImCXTdGDTeBvSS@neat>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=brauner@kernel.org; h=from:subject:message-id; bh=ItD4cQ9/T2Lbjdnw5EA900Xzkb3YwHbPekHFYEjw/bk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQxLX9v/LRZ6tJv0wjO1uKP82unMT8rtZNIPJ0dfCK4K iXjf9PnjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8c2JkuB7Itl/yisKcg0KM Z5gaTkR8F96nqLx3geQHr4V9E/ljzBj+R17fe4t3qpmaPJsGu/36bem/31rNXv1ZxCJ2+a7c9QY K3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 25 Mar 2024 19:34:01 -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: Annotate struct file_handle with __counted_by() and use struct_size()
      https://git.kernel.org/vfs/vfs/c/1b43c4629756

