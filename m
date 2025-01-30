Return-Path: <linux-fsdevel+bounces-40395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A881DA230BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 16:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37F0163B9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 15:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F8E1E9B1D;
	Thu, 30 Jan 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfjzJj1q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1713FEE;
	Thu, 30 Jan 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738249391; cv=none; b=SHOk9dt3UwUWdS7eH8FDjFOAkzUHHwBCafkr9+l0aJ2zYGIW9rHO6SyU7Ygfcq0CSyV+2YD/84ltZxMtvyYf+HFD+9ZpIGQBVCVL/HlSR6i7vbxFPktC4t/AwiRfgMmpKXNwhQwGe/FOuWkWNnXwRG04/BT94SzV2uoUbo6HENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738249391; c=relaxed/simple;
	bh=4YCm8eXSm6M4ZzJXQwVpKFjSlTUpF0dxjV4icC56dQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5jx/gjnaH3DcqJ5BZXgpuM+UzM6CEeEhBaExTShT0RzED64rMyEEImLpITsliJSqaVnpm8PK45taq3eyJagukNGer1hgSAqqc0HedEyHdBWJpyJ69sq/wzDsuWXEnQpcpjSKwF/vNFiSxBYGI/ICuV/7FMBeiQgYL0Szw+JaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfjzJj1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4980C4CED2;
	Thu, 30 Jan 2025 15:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738249390;
	bh=4YCm8eXSm6M4ZzJXQwVpKFjSlTUpF0dxjV4icC56dQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LfjzJj1qw9pN+iIAdmUxQqArHNJKApF/Xpq7gqs23TcdFPEEV2eUbW/ar79NiuwmG
	 OIanSaYk8NtEjxyRiS8yuxOtAhOT/aFJtUeH2ZUpXBIe2MmaZO+AMzaiJn9DMrxXpO
	 iFyFQTM0UIrBe03+oxL5vM+8rm7n9wCIehmsuMResiWPgdx/0QZbfbU9zMEKcJE4If
	 tBOB+7KKrMkwu/xwEdh789uHig+wD3sWr5P7nr/tWIJeJ0dWKuSogBaGwQnnkcX6UN
	 D9ClOslxJELZzhMMkZrTFhYWJsDICjraXIHkgkIZZ13AiiSKldKRJOtVBu+jd5cyeW
	 R4KYuhqDZ+84g==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] statmount: let unset strings be empty
Date: Thu, 30 Jan 2025 16:03:03 +0100
Message-ID: <20250130-nackt-anwendbar-698474ff2a4a@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250130121500.113446-1-mszeredi@redhat.com>
References: <20250130121500.113446-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1299; i=brauner@kernel.org; h=from:subject:message-id; bh=4YCm8eXSm6M4ZzJXQwVpKFjSlTUpF0dxjV4icC56dQ8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTPnrIyf6oHj3chs83/Ww5qgV7B32tawmcVxagaH1+uH /kgec7OjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksKGL477/ejDXtgNLkY9Pr oqeu1Xxr6hmU+OgF264PQpxzamdlr2RkmNGif6Ptg8MiKWudN2KmFpP2bNcQXLL6lX3AwyXFXus +cgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 30 Jan 2025 13:15:00 +0100, Miklos Szeredi wrote:
> Just like it's normal for unset values to be zero, unset strings should be
> empty instead of containing random values.
> 
> It seems to be a typical mistake that the mask returned by statmount is not
> checked, which can result in various bugs.
> 
> With this fix, these bugs are prevented, since it is highly likely that
> userspace would just want to turn the missing mask case into an empty
> string anyway (most of the recently found cases are of this type).
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

[1/1] statmount: let unset strings be empty
      https://git.kernel.org/vfs/vfs/c/756060a7cc55

