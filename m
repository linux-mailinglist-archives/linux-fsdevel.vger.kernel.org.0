Return-Path: <linux-fsdevel+bounces-36408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A909E3842
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB52DB31BAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4929D1B219B;
	Wed,  4 Dec 2024 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMqFm5ar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D921AF0AE;
	Wed,  4 Dec 2024 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310065; cv=none; b=rfO4o9fT0SlA0UTG0KC0TrSS6lPKj/VtIu2DE7edOVO6kYEpuH4zV3ZXDYcll3VPgEYGdoa6fbMAn03pP90x1u9SsGzbF2eBJYXxToXFDsgbCh3tEihSFXzBaDGNvkBjg8XtRZw6e2b3XXE99pA7tGxjPmppy+0DVKGJwGSCToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310065; c=relaxed/simple;
	bh=zMeQnCSXMhMpabd2mv5aFnby1I1S8bBNePtGcJHBo+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddt1QeGC9XVBYIwFOIFcoH3MLUmfYIsVNSz0P8ani20TWM50SfU6ZttXlBadNGQz3ofIYqY5ery56lu36T5SZrc0VTKgVDVNw/OtTMulfpv5It8jKa0NXV5rkGaV2K3aluOe/lK9nDLgB2vEULRc7YHJsHQJ79UpQW7PnMXR56w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMqFm5ar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD5DC4CED1;
	Wed,  4 Dec 2024 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733310065;
	bh=zMeQnCSXMhMpabd2mv5aFnby1I1S8bBNePtGcJHBo+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tMqFm5arAJxP/iuOHQH0rmIez/xmyUF8j3wKmqCP8wJK5VkAWndD+0w1hPDY6yGBR
	 sZTnSlbj+vaDnYrBHBUfJivxqgvzA+nwTaY7MqUPWjuLIdR+UPt7MTlUurmWOyayfo
	 A5e0JOE1NUSUxKqWRcQefGVza8wfDQQhw2JS4fHLz8pUotA70APDlPJDI4OkNZMjoL
	 BFVQm61Y7xo7DE2gmIIYr/YzxpIJ+/o58aqM6ORtr2YTldkl5w0Jzrc02HrnIZgJxi
	 GScFBHLxcTEstFhOJFJsTVuUdZzhNJfvXwx1xrgYsTCToDgzJFe2kZDSXcMniJnMYR
	 bLwQTjeFm4d/Q==
From: Christian Brauner <brauner@kernel.org>
To: linux-ext4@vger.kernel.org,
	Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH 0/2] jbd2: two straightforward fixes
Date: Wed,  4 Dec 2024 12:00:55 +0100
Message-ID: <20241204-landen-umwirbt-06fd455b45d2@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203014407.805916-1-yi.zhang@huaweicloud.com>
References: <20241203014407.805916-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=brauner@kernel.org; h=from:subject:message-id; bh=zMeQnCSXMhMpabd2mv5aFnby1I1S8bBNePtGcJHBo+w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQHmGXoMJ9frfaOOWuDqY5/656V559GJd1kcGz3/yE2c 3FXzk37jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIns4WD4Z1T4xLBMdm753z9x zjwKpscnT06IN5+i9SNLXjiWOaK9lOGf1YMQ9gu39l/TY7FbyMWw2VibJUBZ8IEg+7bHVb9PJWz hAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 03 Dec 2024 09:44:05 +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Zhang Yi (2):
>   jbd2: increase IO priority for writing revoke records
>   jbd2: flush filesystem device before updating tail sequence
> 
> fs/jbd2/commit.c | 4 ++--
>  fs/jbd2/revoke.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
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

[1/2] jbd2: increase IO priority for writing revoke records
      https://git.kernel.org/vfs/vfs/c/ac1e21bd8c88
[2/2] jbd2: flush filesystem device before updating tail sequence
      https://git.kernel.org/vfs/vfs/c/a0851ea9cd55

