Return-Path: <linux-fsdevel+bounces-13453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC058701F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D1528249E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7883D3BD;
	Mon,  4 Mar 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqTAsr9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D33B797
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557372; cv=none; b=Kqe6luQ6IvfuLzP7AKQuNFq0i449nnEHlw40yyZW+NUiuWDJVN1c5kNOXb6mz86AP754SUY2+bWX4UqM4rH2V6d7t00G4vdSd1CM5mOx7es7EjYVf3xmVifrJzOgd0nQJU/qjMAmuR9cwV0++ZO4e1oJk8C3/LJ1gWFkKKxt4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557372; c=relaxed/simple;
	bh=Ud2/HlilqpxkTNisE2/i2YL7+VoKCR1+WWnDQnQ5h9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5HGNZgLa/8Z8235qIBSFmRxShh/z9aYyMVBwAtjGcNDCyW2BsZ0LRpVbuIwWbvOppbcP9UFGoIaTro7VNT/QPH3J17Yido9hvHNqheLs66+NyTQ/o/5+XVGPBQuJprx15wPuNruoGN/29lpqOdjrawZpwalngLBN28lP6G7ako=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqTAsr9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBCEC433C7;
	Mon,  4 Mar 2024 13:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709557372;
	bh=Ud2/HlilqpxkTNisE2/i2YL7+VoKCR1+WWnDQnQ5h9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqTAsr9x6wcImairg3YBjjnj2RsaR1RatJAYzhXfg+II2Gkyfjl7ufTLFRqLVI19Y
	 GEywVhzMJd8MjRZO9QXTwq8c9lWQYFHiTPt6UPLm9on6rnJpr4bXok9BPAJI3H3Z9S
	 P95zI6nqrSIIz63zX/WuCvQm7jQj3b12C1cSPO9x79esDu6AMg2GtjvxHI4j2Evh0m
	 m7fJuF1DcIw5Heoa8eSXJVeU9psWtlTQwDA1lgyu7wdcq2VTJ/3EHhDr4hgnzRZasn
	 PtHLqnQzBN6grkKI3SKv/JgB06JWku1ycmUpm+PO0wLY8fjPecla0+Rfu8/Z5p7CjU
	 oVBbbU3GZldWA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Eric Sandeen <sandeen@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Bill O'Donnell <billodo@redhat.com>,
	Krzysztof Blaszkowski <kb@sysmikro.com.pl>
Subject: Re: [PATCH] freevxfs: Convert freevxfs to the new mount API.
Date: Mon,  4 Mar 2024 14:02:43 +0100
Message-ID: <20240304-grasen-fehlen-6ca8c1bd6f8e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b0d1a423-4b8e-4bc1-a021-a1078aee915f@redhat.com>
References: <b0d1a423-4b8e-4bc1-a021-a1078aee915f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111; i=brauner@kernel.org; h=from:subject:message-id; bh=Ud2/HlilqpxkTNisE2/i2YL7+VoKCR1+WWnDQnQ5h9g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ+PVaaavNwHm/a/nstj175HTkStmwH84nbevO4puqsz JfuNPoQ2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRRSsZGS4E6Ltc5zriIPY3 0Pfa93w7xW3TogQatxZ/SP6+ZNbslGWMDP8MZl+qU/vIK305ZF7zFpWVamb+CRaGGz8FFz3rrbm czwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 01 Mar 2024 17:04:31 -0600, Eric Sandeen wrote:
> Convert the freevxfs filesystem to the new mount API.
> 
> 

@Krzysztof, sorry I had to butcher your last name. But git send-email
keeps breaking the mail headers for me here. This isn't the first time
this has happened but I haven't found a remedy for this yet.

---

Applied to the vfs.mount.api branch of the vfs/vfs.git tree.
Patches in the vfs.mount.api branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount.api

[1/1] freevxfs: Convert freevxfs to the new mount API.
      https://git.kernel.org/vfs/vfs/c/f65b9daeb55b

