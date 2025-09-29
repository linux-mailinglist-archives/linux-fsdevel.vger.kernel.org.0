Return-Path: <linux-fsdevel+bounces-62994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFC8BA867C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 10:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66073189B7B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 08:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDBD22FDE8;
	Mon, 29 Sep 2025 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rccE4hrB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2EE1BD9C9
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134739; cv=none; b=K8obDpsyh4SE6vhhs2gTJyoTO01UCAYSzqVFsmTKDZPcQ3PwnhEywWfLW3O9WXVzkMl/yXYUUZMVEknnIq8aLQx6sX07xJ6teN8DXIeKM+euOlyN50epp4kCD6/6Z6aOJpAHKZ9fw1FgdtzNuLVrhA8z74kC342UStsZcA8ZG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134739; c=relaxed/simple;
	bh=9RX9AHt5lUAIIGYtZmueCzPYIX1sJF/76d4pP0IKAm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2nO5IerMfj5MxIM7uMIWWlEGxWVG345Vze58fw26FPpOa3HzHd7k7V0ScAToj/CT4r1eD3m7QpvvGyZCDPt/r1+rUNSO02Yfyv/QrMAT4L1DKxNkQ/oJMV4c+rMOME7kHVYyfEo+7+yneKU7Z7X6sQRFZ4LowZ4BKsd6Qz9xBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rccE4hrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D1EC4CEF4;
	Mon, 29 Sep 2025 08:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759134739;
	bh=9RX9AHt5lUAIIGYtZmueCzPYIX1sJF/76d4pP0IKAm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rccE4hrBmfbUfuIHNkdkCtevHt0xkAT5L8rDK7vwbyLxnfjulxTWMOh8DUk+zs2Ar
	 PX7zgn3LZ38f+M5JaT9Kv/hZpKZ6TL6Sr+/6BJVRYAasL8hf286OSIfpv11GcIaffj
	 hQSVAJ8X/WRO9OTmBfviEzYeJvVmXqUevUolX64/Bbzg+LtAfmN4A+c4lMCHFCWHyn
	 SuVinTtfEStBWCyfJgePP9+akl6cyALUC7aUPeqlFoQmTMW5hlvt6+9MZ19Z/Oq86r
	 WEOCXjSiiaa3iyC0KOaXAOIgTyRtKIq5dRpUoX2FBwSFiXPirp/F7GlJc5TnArJibE
	 0Gc1eoyUlQqQQ==
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	bfoster@redhat.com,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] iomap: simplify iomap_iter_advance()
Date: Mon, 29 Sep 2025 10:32:13 +0200
Message-ID: <20250929-covern-exkurs-8c67f82be4e7@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919214250.4144807-1-joannelkoong@gmail.com>
References: <20250919214250.4144807-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=993; i=brauner@kernel.org; h=from:subject:message-id; bh=9RX9AHt5lUAIIGYtZmueCzPYIX1sJF/76d4pP0IKAm4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTccuHbnc5TflbzssGVJK9J4lYp104vPsV6y/WH0JeNI qvOSvtbd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEMYmR4cW9xBcddx/rM5/S 5Tfb1rR1ZYcK77nFR/r2rL/4bcOyWDaGf6Yb1HdOVbb/Mef4UpEK7VWbP95g3hsqqWl7ilno7Qk jHz4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 19 Sep 2025 14:42:50 -0700, Joanne Koong wrote:
> Most callers of iomap_iter_advance() do not need the remaining length
> returned. Get rid of the extra iomap_length() call that
> iomap_iter_advance() does.
> 
> 

Applied to the vfs-6.19.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.iomap

[1/1] iomap: simplify iomap_iter_advance()
      https://git.kernel.org/vfs/vfs/c/ee96f3bc6900

