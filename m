Return-Path: <linux-fsdevel+bounces-29569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E985897AD94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 11:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFC92830E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 09:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B71E15AAD6;
	Tue, 17 Sep 2024 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUfcUy92"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7214BFBF;
	Tue, 17 Sep 2024 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564126; cv=none; b=klplqVg/5ap8icbGn8y1AmhlYveOLgFRfnRDonfxfId5Yf4Fr5421mpSexz0Z9P8e7oO2Dd+Br5PfafJflT3LZiOn+BHiw5lrpr1qHOB7Uls+S0N36fDOytz2/qOVZ3aLmEGWgRU/W27nAIE8VdyjFLHa0iJsuFTKqdERMOnzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564126; c=relaxed/simple;
	bh=azJUVNHYNElM/NT9dnn2Q0hDdHV7qlIV7OAkTgeCV4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtim8IppsLZeQpoyEPu4IsSZTWY1sooZMYpmsoX5uBZeH7IOPNBDuFIEb5tJzhEydmRECtnegdO0dlPgfs2UWS1kDFdX8uCUm6YFuhIAULC54+gVvIbbz+9VZTwK8P5rpSLydNQmQ55MYcFvCg8YyY+xEdlJrsOT+qQKI8PCroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUfcUy92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D6FC4CEC5;
	Tue, 17 Sep 2024 09:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726564126;
	bh=azJUVNHYNElM/NT9dnn2Q0hDdHV7qlIV7OAkTgeCV4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aUfcUy92PU0MPuiaRrGx0VIEyuAK4cWFnVl8n9U9Xw7zo2T8pVVaqKMiaYQGErvBZ
	 VZdmT8KmoiyKO0plJy0JstCw9jdkijXmMsebyyzriQXsgz8NUbZY21gURR+6SDGgu6
	 b+4WKjZGHNabmdLUMQ3vvbjR6Uee6Ey52slfOa+BzDjMUgJzawteuce90UFFOyLSHV
	 mEVQNuyoZJcQbHJix7hRdsPYPe16G795X0wzYJM8C2HeiJQUrxjDyoadscYFbNApAx
	 dVbQj2OwYjNjV1fHQv6W9vIFKg/CyD+XkkceFcmtJwIvdJ46BhZ96AT80tQUtHKvXU
	 hIZcqkG03TIQA==
From: Christian Brauner <brauner@kernel.org>
To: muchun.song@linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-mm@kvack.org,
	david@fromorbit.com,
	Hongbo Li <lihongbo22@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 0/2] Introduce tracepoint for hugetlbfs
Date: Tue, 17 Sep 2024 11:08:37 +0200
Message-ID: <20240917-tilgen-entlud-cc122ddfb41a@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240829064110.67884-1-lihongbo22@huawei.com>
References: <20240829064110.67884-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; i=brauner@kernel.org; h=from:subject:message-id; bh=azJUVNHYNElM/NT9dnn2Q0hDdHV7qlIV7OAkTgeCV4k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS9dBe7LhscwXBA9x/PlMms2t/T//Cs3PFEar8Tz7aah y+S9eemd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkcS3Df5/wn6zFew3u8P2Y rJb5jlP53+HIpcXmasdu7X9+OyNB9wDD/xSfo+n6Dtd/Jn7s//Tb3ezoh5TD4ZfyxKY9jKqdvjH 7PxsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 29 Aug 2024 14:41:08 +0800, Hongbo Li wrote:
> Here we add some basic tracepoints for debugging hugetlbfs: {alloc, free,
> evict}_inode, setattr and fallocate.
> 
> v2 can be found at:
> https://lore.kernel.org/all/ZoYY-sfj5jvs8UpQ@casper.infradead.org/T/
> 
> Changes since v2:
>   - Simplify the tracepoint output for setattr.
>   - Make every token be space separated.
> 
> [...]

Applied to the vfs.misc.v6.13 branch of the vfs/vfs.git tree.
Patches in the vfs.misc.v6.13 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc.v6.13

[1/2] hugetlbfs: support tracepoint
      https://git.kernel.org/vfs/vfs/c/318580ad7f28
[2/2] hugetlbfs: use tracepoints in hugetlbfs functions.
      https://git.kernel.org/vfs/vfs/c/014ad7c42a69

