Return-Path: <linux-fsdevel+bounces-58021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 599B6B2813C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCAB603B98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 14:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A841A83FB;
	Fri, 15 Aug 2025 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrWi6Ady"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D571E868;
	Fri, 15 Aug 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266587; cv=none; b=JprSdOl8BgSXcJ+56ByXToGLp4wliuvK+J0s69XRHZ5W8gF5UDKJ04ukIAbalDHr/Z9Rt2aZkq2rNCtvyVMxWPkEf4CzxXiG3VvRg2NUT4nILYdSsBbnR+sDZxBo1cu06ZvrDPuLnQ5PP2NOCS+O06G+CVq07VmHCrvsofwOVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266587; c=relaxed/simple;
	bh=rV8qprK2ejAjYWwOvpWArObtGsyxdPoh2ua2HwE9lPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LoXXNrz57aVLYKdNTz31It+nW1nx8ipGYeUs/mCzQTMrWcvYf8Vnjfjy1/ovztzruLNRLaJKn8Pz4XtsLnxwEyiu4KkfnN+cUq6d4/slsGvB0prgO5/Z5K3oGVU9SZ70gMdtZmn2FwDVrMaXNo38/BJCm9FazfPFaJigxdGnoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrWi6Ady; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AC4C4CEEB;
	Fri, 15 Aug 2025 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755266586;
	bh=rV8qprK2ejAjYWwOvpWArObtGsyxdPoh2ua2HwE9lPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jrWi6Ady7AhRyDUETW8pwgeS0wEnCdiKn2TPDPVM4awMy7YmsZCI3x0Gs0lsTeiIB
	 rQ41kfWbqM8x0twOOYg9NYuPZjyFpI2Xy4UTLIBk/g6IY2LN3zuFwxy9trzCAk8Rgn
	 uueI4dvuHelL8kklhRfmIfsqA6mygupn1+7cSKFIpJoAiMXPlgEvJQhj3hyrjsYWLd
	 yAiEJ7xQNcVzIgzaMhk9NpzHFECn0DD3hGo160RydW8MclHwrHPu5uIQfbIWbeU708
	 3fNqUyElE4y9S9hF6MYcx/K8oDkip+ZcxueLbUaAm23I8lMBEQHWc16l/Lud460RFr
	 BnwkGawVBR3iQ==
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J . Wong" <djwong@kernel.org>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	linux-xfs@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] iomap: use largest_zero_folio() in iomap_dio_zero()
Date: Fri, 15 Aug 2025 16:02:58 +0200
Message-ID: <20250815-gauner-brokkoli-1855864a9dff@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814142137.45469-1-kernel@pankajraghav.com>
References: <20250814142137.45469-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=brauner@kernel.org; h=from:subject:message-id; bh=rV8qprK2ejAjYWwOvpWArObtGsyxdPoh2ua2HwE9lPQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTMtxOZmV6fMvf3ERGBmFOyvmGtW5yestupOB+feb52k dOyPNWAjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl4bmdkeCD+SijArGMSx+pj E9aovxW/fMp8630Gu9sintOO7La5fYnhf5X+Z9+u29eDBfjsJCyip7MZzWHblHdWKJEpsOg6z0U 7LgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 14 Aug 2025 16:21:37 +0200, Pankaj Raghav (Samsung) wrote:
> iomap_dio_zero() uses a custom allocated memory of zeroes for padding
> zeroes. This was a temporary solution until there was a way to request a
> zero folio that was greater than the PAGE_SIZE.
> 
> Use largest_zero_folio() function instead of using the custom allocated
> memory of zeroes. There is no guarantee from largest_zero_folio()
> function that it will always return a PMD sized folio. Adapt the code so
> that it can also work if largest_zero_folio() returns a ZERO_PAGE.
> 
> [...]

Applied to the vfs-6.18.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.iomap

[1/1] iomap: use largest_zero_folio() in iomap_dio_zero()
      https://git.kernel.org/vfs/vfs/c/5589673e8d8d

