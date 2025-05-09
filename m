Return-Path: <linux-fsdevel+bounces-48564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E93AB10D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE5C520B1E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332E528EA48;
	Fri,  9 May 2025 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAusieUo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDBD38FA3;
	Fri,  9 May 2025 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786968; cv=none; b=c8nqb+D184/SN4PngV5MzFOx08KxIA1peb1u76MlvqghGL0ClOy8XwNKsvc9JFENhZdiCG5bSIf5aNaEunu2ZXDuWIQkB56Wob4NO9MconnyFfAk/B7h2scqO/BJ9Go6QofNGeF2rMgvSU3yUwAbJSSPe1IQrZMZ81j65zJcGbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786968; c=relaxed/simple;
	bh=h25QaFlqIvdV1bFDozcN4LLuoR0lMJEzDQJPGHFD2XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajweyz+8QecrHRbrGudeZKFLw2F6h+yzWgVzHLrCvuqomjmOvcL5dPwcOH+Lgdf2imthH4ul+VNYBPw8y7kOjM3OmBcexjlaAuSLU3KH60ZAR9tdaPHJva/d/kjZ7Qa178xB2ZBZzrOUrtI+rOK63gOimJLtQ3bdAJgAMe/pDug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAusieUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60077C4CEE4;
	Fri,  9 May 2025 10:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746786968;
	bh=h25QaFlqIvdV1bFDozcN4LLuoR0lMJEzDQJPGHFD2XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HAusieUorm2Xj2kGRX86kusgMSo8DlZsu4pc8a30fW8O/zvgwCc+9BWBfJPs0UVhH
	 kI08vuYypenLPaCsqK6vX8V+RbfNGwGflULCUPJedFcGIdlQPDhPxLHCq+lieAIEN0
	 euOSYq929MDK5RjPDI/o3t3w0lDOD4fzG64RTInOU14LUvfGeb3FAZ6x92iXp0jLWg
	 QKC1Nbtg5RpThW0I8VNarQdJBVN5XXeiRUBucwmM6nFgGtgqJSN96jd2Spw9HYr5Oo
	 TznaMl4tnGBtmk3zQKeEBqoW5hHTSIGzYt6pXo+ROJJFgzlGza3Xi/Ssd9STy+7gXg
	 VYkrIVafYjP0g==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Brian Foster <bfoster@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org
Subject: Re: [PATCH v2 0/6] iomap: misc buffered write path cleanups and prep
Date: Fri,  9 May 2025 12:36:02 +0200
Message-ID: <20250509-goldkette-unachtsam-13b1dd364f53@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250506134118.911396-1-bfoster@redhat.com>
References: <20250506134118.911396-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1839; i=brauner@kernel.org; h=from:subject:message-id; bh=h25QaFlqIvdV1bFDozcN4LLuoR0lMJEzDQJPGHFD2XE=; b=kA0DAAoWkcYbwGV43KIByyZiAGgd2pOhrson6EdmBmgEGI6pH3JIr4jHKeSLKtgb7b+7L3c9d Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmgd2pMACgkQkcYbwGV43KJSSAD/baAk Q8mtGpBY/txkonilYjiAGJBgC9m3/w3XwHm0WmwBAI5feTCTQRRXrn0AKT2IW5NqK6EmmzJ2uK8 svUcRcG8I
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 06 May 2025 09:41:12 -0400, Brian Foster wrote:
> Here's a bit more fallout and prep. work associated with the folio batch
> prototype posted a while back [1]. Work on that is still pending so it
> isn't included here, but based on the iter advance cleanups most of
> these seemed worthwhile as standalone cleanups. Mainly this just cleans
> up some of the helpers and pushes some pos/len trimming further down in
> the write begin path.
> 
> [...]

Applied to the vfs-6.16.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.iomap

[1/6] iomap: resample iter->pos after iomap_write_begin() calls
      https://git.kernel.org/vfs/vfs/c/e356c5d5b10e
[2/6] iomap: drop unnecessary pos param from iomap_write_[begin|end]
      https://git.kernel.org/vfs/vfs/c/99fe6e61fd3c
[3/6] iomap: drop pos param from __iomap_[get|put]_folio()
      https://git.kernel.org/vfs/vfs/c/3ceb65b17676
[4/6] iomap: helper to trim pos/bytes to within folio
      https://git.kernel.org/vfs/vfs/c/c4f9a1ba747d
[5/6] iomap: push non-large folio check into get folio path
      https://git.kernel.org/vfs/vfs/c/c0f8658a9dbc
[6/6] iomap: rework iomap_write_begin() to return folio offset and length
      https://git.kernel.org/vfs/vfs/c/66c0d8551428

