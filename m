Return-Path: <linux-fsdevel+bounces-63544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E1FBC1303
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 13:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA3C188581A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 11:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D272DC346;
	Tue,  7 Oct 2025 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ughDgvLz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED202D9794;
	Tue,  7 Oct 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836007; cv=none; b=G5/7gXIV03qcFc0UBJ0tdvwxkh11E6DfxzMAvGKFc2urhzBRi6tImv1q4QE7qbnmvUIiS91hzlOR4H0w52QobqWmQ3lZ1ATVGAFZkF8+G8j2K8EmDVzM7Byh2ZWoVkFBBC6k/dYOXCduSzARXsC215pNN4y+lqoiAwa0+Hyrgp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836007; c=relaxed/simple;
	bh=9x5Qye3a1SDhG/+WChzXzWwg1LdXhGu8ktiPeGnzj8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVg/p1EZdN2tDYqDxKxv0n6zddwffgW+AJNK2txo7st9TmQS185grsAQw7w957Bhw8U/fczRPrzyAh3CH2hBAmeecrj3rkS46EZaJ2V42X2Nw6ZLtFNAyrFlZ/Kh3MFey+5UMdb8KHRHBK5i9iraGFEg81roxk1H4V62s5faUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ughDgvLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14487C4CEF1;
	Tue,  7 Oct 2025 11:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759836005;
	bh=9x5Qye3a1SDhG/+WChzXzWwg1LdXhGu8ktiPeGnzj8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ughDgvLzk8zp6lJ4rLzLw4qRjWD9fny/NHjRb5ZHsbh4n25PHWfV0EQaQ0Ror1RCv
	 Y4+elYdLICAR1apJ/Elb5IMR9sXZCIKUMBO9gVOI7RaXErqO+jgKiEBViL7dRpAWWo
	 Ig2zHcnO8w3Mogzb9xjL4Y0BT5ZsjAYMu2w8we2VMxSK6ZXAs2yO1FxnZDRP9EnVZD
	 jXWF+UPO1OsDmR9mPT/uHqeaEXx2EZcLnPpyLuyr0dDUces6SeP/xiKrciuEc+rXf6
	 6LmA3PRhY3RxvIwlIovBHAYyIab/5BHjdOop6cR7mULKNuF14n2FBqhEvkhsDtKW+N
	 NPGu6pkD/jiWw==
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
Date: Tue,  7 Oct 2025 13:19:59 +0200
Message-ID: <20251007-rentier-armbrust-cec5f47fffb0@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250814142137.45469-1-kernel@pankajraghav.com>
References: <20250814142137.45469-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353; i=brauner@kernel.org; h=from:subject:message-id; bh=9x5Qye3a1SDhG/+WChzXzWwg1LdXhGu8ktiPeGnzj8g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ8+Z7w129ugNXRSYkvUpccd1I+Zbzsav8hq1+ZFtH/v 1xoVd7e3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRp7yMDFO3z3i081uKe+K3 23WBHrtiLtrLv4pzsNU5arls496A46aMDHcm60WIht92/nv0u8SJTdd8XizsN5Z7+PiESXXR9tw Dj9kB
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

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] iomap: use largest_zero_folio() in iomap_dio_zero()
      https://git.kernel.org/vfs/vfs/c/5a5809e3ac58

