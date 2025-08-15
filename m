Return-Path: <linux-fsdevel+bounces-58024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84997B28158
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694FF3B1806
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B9F1DF72C;
	Fri, 15 Aug 2025 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md3JX68y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0481DE2AD
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267125; cv=none; b=lC8v0tteyRTAQYFHZ/XLmB/iTfBGFY2THk5lm7eoGTNh/ILnOaqi+Fz/wsy1IGZgDbsNUkc5Ea4CY6XeIJoL1ShROMFP46R7F+us9LQ9szzF1FP9rdAXJPPGVTL/OXHUXUyN5QSevCYQmmKmgxie68OCu1VJlKkfE+pDagoM5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267125; c=relaxed/simple;
	bh=hICDYr36vJBnBxNMWJl03rALwiEPCK3W1F6LrcuMXD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJ2MOKuMpYjGlsMOU+eNb+QRUCDKlVbFR6CsEypcUaJVv0yK2pKad88GszPUGLvdLhsBQSk/9Ew7Uo9In+hgyiJqwwZy5yYujOw63yTRHhrdNT5nnR86JHsgiyNRZv1I4nCMmdQhOCp7BJ3jfep3Ai1VQAmcTIaH+/BewUjqbkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md3JX68y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C87CC4CEEB;
	Fri, 15 Aug 2025 14:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755267124;
	bh=hICDYr36vJBnBxNMWJl03rALwiEPCK3W1F6LrcuMXD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=md3JX68yH5rLyzYo5lANApSaHjbb1E2I++iM6O5NgOvmZUwE7/VLZMuVM9IOJUHwJ
	 SWtjh+W8hhfVYVDZzpuN+I8X/4SM/Z7oiZhOxrs6k0EgjL5Qxzr+2eNpA90LSkoEEk
	 Qiiex+uShgOHoB+JlhMLQ068pTH7Dsux1uq5qnA+sxituV1pA8zQyYNphs5wvixvE9
	 Vz1aM2jK5ZMNN6hULdLKyl5jXuN0L42g5qhV+jNCUja9fHYL/C8+SCVJj97kRz/5GE
	 6ilY7z6gMEtkfZ113vtgAFHSPCSk8TT4gU4YmL4/WeL/uVQbP2d/WIPYXkch2bNbUt
	 crYbZ0+u6AAJQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Bernd Schubert <bschubert@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v2] copy_file_range: limit size if in compat mode
Date: Fri, 15 Aug 2025 16:11:59 +0200
Message-ID: <20250815-februar-psychisch-532f486482b1@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813151107.99856-1-mszeredi@redhat.com>
References: <20250813151107.99856-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=brauner@kernel.org; h=from:subject:message-id; bh=hICDYr36vJBnBxNMWJl03rALwiEPCK3W1F6LrcuMXD0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTMdzCY2ybx8ZJr8j6lU81hq+q0pTSWtFibtzrPyWdU6 OtrkLPsKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMhaAYZ/KssFJs7au19L6lR5 z/K5O9aIyk4z/57o0ejD3Drl3FunCwz/ncPKbzLvWMv0SUpndYXojDu7ClIuTshcdlnnqJ1JypH 3zAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 17:11:05 +0200, Miklos Szeredi wrote:
> If the process runs in 32-bit compat mode, copy_file_range results can be
> in the in-band error range.  In this case limit copy length to MAX_RW_COUNT
> to prevent a signed overflow.
> 
> 

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] copy_file_range: limit size if in compat mode
      https://git.kernel.org/vfs/vfs/c/f8f59a2c05dc

