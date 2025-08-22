Return-Path: <linux-fsdevel+bounces-58793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1F9B3180F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DFC188496C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4192FC006;
	Fri, 22 Aug 2025 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHPyZ14/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089EB271443;
	Fri, 22 Aug 2025 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866369; cv=none; b=IGqWGdiy/SeGoF8nj1Lx/Gr4ZLHVpw9nCjCW8DEIdLSE8G3VB3q9DWFa2sSCRuIYJmjwjC5bONGZUM2IzCBfgHFj7Uc7Bj3M/Swqx2BCs3orjTfm7Grc35jSWNErLE6Jf0q2hdXA8jziSUW9DRqeRoBfsqLyKAff6USbtWYQ15o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866369; c=relaxed/simple;
	bh=/Njx2dKk/x0Bia9w57MBf+NAh2t8oZ/tfmxV2nmmPsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sej6HX71a56Y2DTHVrfzF3/0iXUF34iQgIlyOttWOLEhdEKiQkm8CxxO9V+G2mywcmbVxvLeBAL1Q9qjUgf7Df0HnCnI7TsDGoWu5RkqcuT3q7/qQqCLWNGXTenPYU3RWyjvEmn4dRrIPwJaZszPeUD7G3RYl+C6XWYLwQWgf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHPyZ14/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBD2C4CEED;
	Fri, 22 Aug 2025 12:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755866368;
	bh=/Njx2dKk/x0Bia9w57MBf+NAh2t8oZ/tfmxV2nmmPsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHPyZ14/mYOIxYRjgFsWWN1VjlE5GZ3L18a9Gz5QTrU7WFrzouwKxWxICcO7yV0ZE
	 +wu2q4K45HR31VYAt3wZeWqaayvRGpR3vIlxEbTzp0aRySEx93fxc96gchdUuk4XaH
	 DBZk4IX5qUjqee7ffUEPmYv9t9zKoVs8VvX824KoavmyBhzRVTVgdUDf1t3dXPi9Sl
	 9ggCeXj6N8IywTR5MyR+eh5nb8334O1T9dlD4w9WhlNF7mAUncWe7aguxJowSQgPBK
	 /O/GxyqPfQxF6hP3x5LTkMYYWG460AY5bW9PMcsMUR64wLG9Lf4tFpPOw0MS7lO+vO
	 B88g+kGECUMNg==
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	viro@ZenIV.linux.org.uk
Subject: Re: (subset) [PATCH 10/50] fs: stop accessing ->i_count directly in f2fs and gfs2
Date: Fri, 22 Aug 2025 14:38:56 +0200
Message-ID: <20250822-herdplatte-fotomodell-8b323246552e@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <b8e6eb8a3e690ce082828d3580415bf70dfa93aa.1755806649.git.josef@toxicpanda.com>
References: <b8e6eb8a3e690ce082828d3580415bf70dfa93aa.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=brauner@kernel.org; h=from:subject:message-id; bh=/Njx2dKk/x0Bia9w57MBf+NAh2t8oZ/tfmxV2nmmPsk=; b=kA0DAAoWkcYbwGV43KIByyZiAGioZPqhAHO5rjUmOvZjutYrMq8SDVrCRLqSgH58/v8POYeBx Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmioZPoACgkQkcYbwGV43KKtogD7B+Kw pOiih3Mh0kqt9h7Xhx1Bpyxd3e8pJe4GvX5Y0v4BAImNQgSp9e8pFC/+5tZY8uJlNFBjNln9Kse Sp5NG2uQJ
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 16:18:21 -0400, Josef Bacik wrote:
> Instead of accessing ->i_count directly in these file systems, use the
> appropriate __iget and iput helpers.
> 
>

I'll take that as a fix.

---

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

[10/50] fs: stop accessing ->i_count directly in f2fs and gfs2
        https://git.kernel.org/vfs/vfs/c/2c2be4cb82c2

