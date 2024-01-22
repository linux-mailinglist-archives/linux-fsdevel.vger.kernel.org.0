Return-Path: <linux-fsdevel+bounces-8413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA098361B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 12:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E7229173E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 11:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A5C46526;
	Mon, 22 Jan 2024 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgbT7NR+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DB03BB25;
	Mon, 22 Jan 2024 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922352; cv=none; b=R4aplJk/b6MhYA7kqKUDrV5P0GfNeNiI4XZ+13OdIwLmPf+lndu39uwg+DQu/yZ1rIRnZF0PaEai8zqsWQiuGQSRn1gDX1lVs4T5ut+iZv1wvjIs4VgrL1M3dp5mC0eXLPvqgYJXwlqhvVwHhlrNN34eSmdcStxR2bcY7gfsUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922352; c=relaxed/simple;
	bh=2SwUAmTtPmO5NuF/3z610QfGvtisw0LXRHtu+pxb/Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J20nQMY54b0Tq+kCW0cx2kvHiyXces/P+/slm69vQefg/uZTlueCVLwHXntLyc7W8Z6MRscSIGtiqK7IEguRCQhqNbl3Fh14T3DZoJ/v5qjQh8zQIL6bm97x0qxCxg4R1S3UP4fPl0TN8+J7HQKbA45YjVifMie7Z3lClfdQa2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgbT7NR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEC9C433F1;
	Mon, 22 Jan 2024 11:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705922351;
	bh=2SwUAmTtPmO5NuF/3z610QfGvtisw0LXRHtu+pxb/Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qgbT7NR+Wn6rwJWBDMuLlqDS3FbXPSRRVSDsVeZe1dVMAZajmXqa4APlq55a1cWNY
	 aJkSSA5zMtNjsnPjldQLVYb8W3kXlhLVhssPSpxa5XxdU3oqffX+KXcyeS4hxp1TzN
	 B8P2b9zosp+UlG7T0ay2KBEkbRTVXi7t+XRBoYtovZUPbSNFO+B566xkp4TMIR5kff
	 mQEceZ8hbA4ImY6Z2RWE6b6K2/+h/VzpVQhciHYhSVfdTgXE2SvM+Y6LF94JWC2oBF
	 JFlxjkdW35gV0047RQ7I/qcUkcIOGw1K3aIEWjhdwMbIHiGkahnG5BQyY9VsCLd8Mx
	 TxbWxnP2uV7rg==
From: Christian Brauner <brauner@kernel.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	willy@infradead.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	yukuai3@huawei.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] fs: make the i_size_read/write helpers be smp_load_acquire/store_release()
Date: Mon, 22 Jan 2024 12:14:52 +0100
Message-ID: <20240122-gepokert-mitmachen-6d6ba8d2f0a8@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122094536.198454-1-libaokun1@huawei.com>
References: <20240122094536.198454-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819; i=brauner@kernel.org; h=from:subject:message-id; bh=2SwUAmTtPmO5NuF/3z610QfGvtisw0LXRHtu+pxb/Sc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu81f9PSNp96uU9X1nFjJfYlh1U2q3r3TY5IvTnS44v Z15StxUtqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiGWcZGRZYR8pU6ScKL9nt 4s8lsn/Zl3MtygWyMfrL5S8+Lli5eCEjw457hbnTC862NH9S/eVy42ShhNrzH3l3vDLfuljNDq/ n5wYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 22 Jan 2024 17:45:34 +0800, Baokun Li wrote:
> This patchset follows the linus suggestion to make the i_size_read/write
> helpers be smp_load_acquire/store_release(), after which the extra smp_rmb
> in filemap_read() is no longer needed, so it is removed.
> 
> Functional tests were performed and no new problems were found.
> 
> Here are the results of unixbench tests based on 6.7.0-next-20240118 on
> arm64, with some degradation in single-threading and some optimization in
> multi-threading, but overall the impact is not significant.
> 
> [...]

Hm, we can certainly try but I wouldn't rule it out that someone will
complain aobut the "non-significant" degradation in single-threading.
We'll see. Let that performance bot chew on it for a bit as well.

But I agree that the smp_load_acquire()/smp_store_release() is clearer
than the open-coded smp_rmb().

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/2] fs: make the i_size_read/write helpers be smp_load_acquire/store_release()
      https://git.kernel.org/vfs/vfs/c/7d7825fde8ba
[2/2] Revert "mm/filemap: avoid buffered read/write race to read inconsistent data"
      https://git.kernel.org/vfs/vfs/c/83dfed690b90

