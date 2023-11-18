Return-Path: <linux-fsdevel+bounces-3127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081AE7F02F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 22:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C00280F30
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 21:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6717A4F888;
	Sat, 18 Nov 2023 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uwn5OHpD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519A10A2D
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 21:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA1DC433C7;
	Sat, 18 Nov 2023 21:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700341840;
	bh=mXAbW6p9WqoD0u0t8uFy7V+znPdvoqa3NFm/kKJO2J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uwn5OHpDParhx2ekA8eLj8MCWKu+rNvgejNeHSyFkWC2QGhz8TyWVmREkKZvsgMRv
	 coVLbHiCpZGNpT3jcvxZH8rbXB0jOT2/VovZdXfRzfqDa0W/JuS6X9JZ8qAtfsEOzi
	 G54Nl2/nZfCAydTFMmbK3oTLRtzXl5NfpJxiFvTIj2UuiLWJGjtQGl+up3qCjRaz7E
	 /tip+pcC0Hf8aQ8YT06jf9XS6C34sDE8ilE7FM07nQubbWvKvY22qzoA0zHPhSIZEp
	 N7VqCOim5yX8duIL3bCpldAgpQ7G/yKg46JEMaqqzXM/3wCXRSJt2P+CPOUzwu6j/T
	 25vgwXGkwudUw==
From: Christian Brauner <brauner@kernel.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: Christian Brauner <brauner@kernel.org>,
	kernel-team@fb.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] iov_iter: fix copy_page_to_iter_nofault()
Date: Sat, 18 Nov 2023 21:25:16 +0100
Message-ID: <20231118-fachtagung-althergebrachten-0b15069e4778@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To:  <c1616e06b5248013cbbb1881bb4fef85a7a69ccb.1700257019.git.osandov@fb.com>
References:  <c1616e06b5248013cbbb1881bb4fef85a7a69ccb.1700257019.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=brauner@kernel.org; h=from:subject:message-id; bh=mXAbW6p9WqoD0u0t8uFy7V+znPdvoqa3NFm/kKJO2J0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRGyq6K6Ky7mbnay+5OnMI1jf2nLZ6GXec91CSxXD4mR MIy5k9BRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQs9jL8D1lmnCb2IT9m+9+S E4wzr2mIsuV5XVzw/73le8Z1zM29AQz/lN9t0T5/6WTDZ+t5towuGQrWoUHZ3w9G7WdLijR4v8K KHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 17 Nov 2023 13:38:46 -0800, Omar Sandoval wrote:
> The recent conversion to inline functions made two mistakes:
> 
> 1. It tries to copy the full amount requested (bytes), not just what's
>    available in the kmap'd page (n).
> 2. It's not applying the offset in the first page.
> 
> Note that copy_page_to_iter_nofault() is only used by /proc/kcore. This
> was detected by drgn's test suite.
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

[1/1] iov_iter: fix copy_page_to_iter_nofault()
      https://git.kernel.org/vfs/vfs/c/e15912e71ae0

