Return-Path: <linux-fsdevel+bounces-71342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5406BCBE457
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91EEB3014AAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 14:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2A733F8CC;
	Mon, 15 Dec 2025 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnzJVDvd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD533E36E;
	Mon, 15 Dec 2025 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808282; cv=none; b=drDL8X4D0vSbrXHGvu33q/wIDSaaTmKcfertusDtboupgaToUf8wLHGYCnsJI/xYoyhkekJlIO/FNbBTHPAqBp+F6T0OqMuT6QaX2d23SbUWsDFGNDpVgxWGc8PYUaEyHOFth+q4oHDx5/pVTS12aLnN62sL/8vnLIhkd5RoHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808282; c=relaxed/simple;
	bh=jvGfyeRPYJpR0xeP/qNszMAHQlTZr4ehS/J2PA7MOMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z79WaH+BcI9k/qUEKjQ0sKOcmsL5jRRR6fCVIt2kaQFt/wsNQzARUHSiIMRR+akkU+XC6mzQYFVKQrFCEFpO8HQzOR/CVr0GoTFb0MCPpqV1w4KipgRkJj4tDNpqEbyTiM+rObNpiZW23hBoXwLMk5y+KguKjmgnEzE2m63bJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnzJVDvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FEEC19422;
	Mon, 15 Dec 2025 14:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765808281;
	bh=jvGfyeRPYJpR0xeP/qNszMAHQlTZr4ehS/J2PA7MOMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EnzJVDvdhaBM6DbRPOiK20Pwhk3RmDR4M/3dDxLssxXJ5qWYXDw7jWCyZcHwqIcSl
	 Mo1gNWDJn9R3ZGFYSMHaXb+fmQF08aK2aq9IXp5zSTnVlsvo+0O9/xapbjTHaioq26
	 6OIK49f3JWsRdso+mtZ2U048xG2O9ElypG7IeiiMvRu4C5z5ibrNdJEQqNwDgLetlU
	 f3atL9mG7gaMYDODjXTR/iKYY8LCFSGaoLbFtW+IABVepdEIir0nGiQc2T/PnxDCpC
	 eS9KUAZEjYNfefVp4+Hno4j0apiYOMbQTfRxOj8ZxsKbgd3yeHDdcnc0oO4AaH3+WD
	 Nnsire0rnO7Tw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Brian Foster <bfoster@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3] iomap: replace folio_batch allocation with stack allocation
Date: Mon, 15 Dec 2025 15:17:54 +0100
Message-ID: <20251215-asketisch-funde-601bd5a5cbbd@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208140548.373411-1-bfoster@redhat.com>
References: <20251208140548.373411-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=brauner@kernel.org; h=from:subject:message-id; bh=jvGfyeRPYJpR0xeP/qNszMAHQlTZr4ehS/J2PA7MOMg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ6SEyx23XdXaNOQ2vvvbnR29Uj62O9y30WnU7POjfNo qD7fTVTRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETyaxgZ1hznvKcxaeqR8/4v E+/t3NnzdrZcrJLm11Vb6vdtn5tl8JCR4Z7Jn3eiYpd73qj9F3y7PWcb9zPvngmTd4TvyFw0d7/ sSUYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 08 Dec 2025 09:05:48 -0500, Brian Foster wrote:
> Zhang Yi points out that the dynamic folio_batch allocation in
> iomap_fill_dirty_folios() is problematic for the ext4 on iomap work
> that is under development because it doesn't sufficiently handle the
> allocation failure case (by allowing a retry, for example). We've
> also seen lockdep (via syzbot) complain recently about the scope of
> the allocation.
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

[1/1] iomap: replace folio_batch allocation with stack allocation
      https://git.kernel.org/vfs/vfs/c/ed61378b4dc6

