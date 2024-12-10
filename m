Return-Path: <linux-fsdevel+bounces-36907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 553BF9EADBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 11:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2120C2873CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 10:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8022B1DC980;
	Tue, 10 Dec 2024 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEjwbBI7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10D78F40;
	Tue, 10 Dec 2024 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825724; cv=none; b=caini+fLXC+vecFZ2ok3480zJutzGyeDmx49vOQky1+lU3KtqNedosUR+z2QOVLatS7zRZFBviSEc6ro6gYZHNoNg6VimQ3HqzO5XiPgXCoH8i3XcHQeJ66KFeW6QZ2+hu03nhIUdskdZBgCdhGI/uX/+LjqdLUnWsVvepKIefk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825724; c=relaxed/simple;
	bh=+rEiKxhqUygOWTVSpD3oK/giPTOjYVuMvSl36cahWvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9BZSK5A2fIPMmCvd832NgoBaMLcdl/O5tFAX6Tyn7/6gXJlCTuOszQQh91MXu7bFROi9ZphlhJxDBLg+NZxwZyCdDMq2h3RIgNMp4ryDgRG//kiOmWKHueYbuXX+RdZZgYCNp7jVPmSEZS/mMatEWa50Jbk+SJmJjqg9LKDd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEjwbBI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED457C4CED6;
	Tue, 10 Dec 2024 10:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733825724;
	bh=+rEiKxhqUygOWTVSpD3oK/giPTOjYVuMvSl36cahWvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEjwbBI7iqQzDf5DkptjzT7N4RgSvGiDQzKOsKtoP6O8ncLyR8fHtTdowT+dS7q98
	 0TMG2eRX3A3vQeqx8oI7Hwyu/W+spZF9N5lN+lUKa5JolMZxd3KlGWxtEgjfQKedHg
	 /BjMVQKYtmQnXu+ORZ64IHs4A5fRuOxdi3GV+sNE4HTbtRysrmc8h2z+ESv0bmkXhg
	 Kmhvcu/b7kP1q1JMR1GJEWsurOvlFenr7Tad2RFrjwFE2zBKS72Ys1E3dZM740FINV
	 z6DdtXn01cfQ/8mWGDMbS1ywT3wu5/ml1WzhbqJdjX+hyGIoXhuTxTcZUXI4YUVA+K
	 +p8LW9SFwhgwg==
From: Christian Brauner <brauner@kernel.org>
To: djwong@kernel.org,
	cem@kernel.org,
	Long Li <leo.lilong@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH v6 0/3] iomap: fix zero padding data issue in concurrent append writes
Date: Tue, 10 Dec 2024 11:15:13 +0100
Message-ID: <20241210-strecken-anbeginn-4c3af8c6abe8@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209114241.3725722-1-leo.lilong@huawei.com>
References: <20241209114241.3725722-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=brauner@kernel.org; h=from:subject:message-id; bh=+rEiKxhqUygOWTVSpD3oK/giPTOjYVuMvSl36cahWvE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHiGx57vg4X+rPkk8qlRd0bUx8N6y44Go2Zf37ioUTl 20KMvd52FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRmbkMf+WZ37wJjOPaXb4p Pd5TzmDCk/gNLs/v9TEFJc5v+vilK4SR4YpK2evOZZvTimolVDa56f/4qWlaERfJl5LKW/GyW8C TEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 09 Dec 2024 19:42:38 +0800, Long Li wrote:
> This patch series fixes zero padding data issues in concurrent append write
> scenarios. A detailed problem description and solution can be found in patch 2.
> Patch 1 is introduced as preparation for the fix in patch 2, eliminating the
> need to resample inode size for io_size trimming and avoiding issues caused
> by inode size changes during concurrent writeback and truncate operations.
> Patch 3 is a minor cleanup.
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

[1/3] iomap: pass byte granular end position to iomap_add_to_ioend
      https://git.kernel.org/vfs/vfs/c/f307c58239b5
[2/3] iomap: fix zero padding data issue in concurrent append writes
      https://git.kernel.org/vfs/vfs/c/33e72d56fb3a
[3/3] xfs: clean up xfs_end_ioend() to reuse local variables
      https://git.kernel.org/vfs/vfs/c/30e611890d89

