Return-Path: <linux-fsdevel+bounces-27322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C76B99603B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 09:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6789CB2222D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22840176FD3;
	Tue, 27 Aug 2024 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6tisHsW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F825156C5E;
	Tue, 27 Aug 2024 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745397; cv=none; b=tJiPSluaVd7Kdpcb9XFCrV80aysLJ6GkzDPw6Bi4uG2rEEZYoJyg+9H75KOdqo+fZFEwN1MnWuOZM8A5HjYTwVj/GT5yFmMz50WIBVX6Z4AlXnD3uItbo17bAyZKpVhYvsSpZIHZWko/X+JP8thiZV492UDWIVlrvsbKTOJZ07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745397; c=relaxed/simple;
	bh=oO5gSw8M0jsTcQ+YuJSX9e785Wg33X/8V5dNeYaomok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UH3lNpbmmTHmN8kbhPonvQJQzctUw8QmDpkN0gj8hFqlHWWaWOAaGvXv0ottcGnYP1G/PeuQ1j9rDsrr2jGh+poFVAGsc70J8cuu1cALeBAvTJmr/8+5pLnM791mo2i/O7t2emwATWJVDGLvI+76s320f3bZxePkEyfc9ulOO0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6tisHsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E53DC8B7B0;
	Tue, 27 Aug 2024 07:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724745396;
	bh=oO5gSw8M0jsTcQ+YuJSX9e785Wg33X/8V5dNeYaomok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6tisHsWG0ji/gBthhf5i+dy+y8wZGai14x3XI6gvyiCCqERJpEk4qHq8W1pRSAsR
	 WGixFKSfVOskEK482soXwwc1nE4yo71X2VPbNRuotsRHAKpHdJOYNgZ20IW190kwvl
	 Jb5jPFdQEpPtZncjnCOkfFidgyj2N/CyiEaEb4mMNx5QTt5KmVmAzr6P89AxyBCPLo
	 ywKWaN4Dcbyg9tozGoC9xSibmh01yhEAYJ8nU7s/SD39uWE70l/Qzb+iizYqPm1WLk
	 dM4/V76DKSUnqrB9y6+bCf8rld0LPnr0Gw/FJ3KeDtV36Pxy8dYnpQFRhcXQLHDayu
	 DcYq6NceqjByw==
From: Christian Brauner <brauner@kernel.org>
To: djwong@kernel.org,
	sfr@canb.auug.org.au,
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	p.raghav@samsung.com,
	dchinner@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: Re: [PATCH] iomap: remove set_memor_ro() on zero page
Date: Tue, 27 Aug 2024 09:56:07 +0200
Message-ID: <20240827-gebilde-zaudern-9b332d7cf0b6@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240826212632.2098685-1-mcgrof@kernel.org>
References: <20240826212632.2098685-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429; i=brauner@kernel.org; h=from:subject:message-id; bh=oO5gSw8M0jsTcQ+YuJSX9e785Wg33X/8V5dNeYaomok=; b=kA0DAAoWkcYbwGV43KIByyZiAGbNhq2gQ6q0MKW9tglwrmDjBP10C7DLt09BqYxRLYmOrGAOc Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmbNhq0ACgkQkcYbwGV43KKKZgD/WaQU /MQ6E1JRCUz/DicibuEasydNCDl6EooIlSg2gb0BAKr0Yro3bz32NQ4WeA6SdmGaD1NySAcQ58J QLULefEAM
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 26 Aug 2024 14:26:32 -0700, Luis Chamberlain wrote:
> Stephen reported a boot failure on ppc power8 system where
> set_memor_ro() on the new zero page failed [0]. Christophe Leroy
> further clarifies we can't use this on on linear memory on ppc, and
> so instead of special casing this just for PowerPC [2] remove the
> call as suggested by Darrick.
> 
> [0] https://lore.kernel.org/all/20240826175931.1989f99e@canb.auug.org.au/T/#u
> [1] https://lore.kernel.org/all/b0fe75b4-c1bb-47f7-a7c3-2534b31c1780@csgroup.eu/
> [2] https://lore.kernel.org/all/ZszrJkFOpiy5rCma@bombadil.infradead.org/
> 
> [...]

Thank you for the quick fix!

---

Applied to the vfs.blocksize branch of the vfs/vfs.git tree.
Patches in the vfs.blocksize branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.blocksize

[1/1] iomap: remove set_memor_ro() on zero page
      https://git.kernel.org/vfs/vfs/c/51eac77be01b

