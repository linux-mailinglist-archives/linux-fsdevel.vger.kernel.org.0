Return-Path: <linux-fsdevel+bounces-40470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E3AA239D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 08:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA329188B31E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 07:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626BE1B85EC;
	Fri, 31 Jan 2025 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PImIyQUS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DDC1B6D1B
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738307443; cv=none; b=sZEmkxHZDmID+BRF9sicdbkeXl9gna8iMWWVoTOcNeMxLXnqJXl8U5b+XCrHCn4/eRSq/lGIYjBH6ebwNFcAHhG/3awBzhNZwyEEt6DVk3rwyI/lS/12ysV9vKrWOTVd6lEmUMktPQTH4iNyMRxXKU4Wh9WemlRynx5JmAJbQJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738307443; c=relaxed/simple;
	bh=OjTNQ2/hudDc11OSV25SMMspM9Q896cS5foq7SJIoNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjSa6UQhMugwrIOEdvu/XAMn8CMP+uwAC1yfJF13pm3LLB5uX2AAuDOBcDo0elnfCNoZcYWKSQZPWuHH6Lv3+ifoTfL5gGGN88nLR73h9scq9OAvvEjgNrjuefIGeOBaHxiZoYRdj8iMRYh9SOqrbPT3KNuS+SKuPDYxOSAwUBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PImIyQUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378B5C4CED3;
	Fri, 31 Jan 2025 07:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738307443;
	bh=OjTNQ2/hudDc11OSV25SMMspM9Q896cS5foq7SJIoNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PImIyQUSqwDz4bt5YYdZTY5h8O86M64V3BKNd+Q7cBDVnEzIWe6h9LT5Rp+h/eklU
	 9Upa1ojMO4o3IUvnuqGt778eG11V0Ipo/UjR3L7WCNQFWbn1XxC5Pqh5FQYAU+wZ4f
	 PFY7N/t28KD4HTLH/H85yKztrkPfLDw73RWhWApqiA8QjrmQXpxONYzhzuoCoTgshC
	 abg7y04Q/ckpL+4KO0BBelev07apCtAKTzm02U+ND32m7vRmu67rBREC2YWB5gwwzQ
	 augFATO96GPTcthS3BO7i1XJYRtQRll4Ji1iuqzT0ezIv6hzag4MpFJ7CRbZij/B8c
	 cuqh27wLvFH9A==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] selftests: always check mask returned by statmount(2)
Date: Fri, 31 Jan 2025 08:10:37 +0100
Message-ID: <20250131-achtzehn-modus-747ef9777fc8@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250129160641.35485-1-mszeredi@redhat.com>
References: <20250129160641.35485-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=brauner@kernel.org; h=from:subject:message-id; bh=OjTNQ2/hudDc11OSV25SMMspM9Q896cS5foq7SJIoNU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTPKc+r0TPZ3P3rtMjfDMZ8dyPLK1N3b9n8anX2+ohLP jM02ZSmdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEs5jhr9Rt/+TYRNUGx1m7 Tp5dMOlk/sLOUDnju78+r9p+jlXj3BKG/0WFH+/vmvtu3UruOwFlMxws11hnK9498/JWmUF/pqp fJx8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 29 Jan 2025 17:06:41 +0100, Miklos Szeredi wrote:
> STATMOUNT_MNT_OPTS can actually be missing if there are no options.  This
> is a change of behavior since 75ead69a7173 ("fs: don't let statmount return
> empty strings").
> 
> The other checks shouldn't actually trigger, but add them for correctness
> and for easier debugging if the test fails.
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

[1/1] selftests: always check mask returned by statmount(2)
      https://git.kernel.org/vfs/vfs/c/1213f42dca09

