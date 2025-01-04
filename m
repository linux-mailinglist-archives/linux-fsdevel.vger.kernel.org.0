Return-Path: <linux-fsdevel+bounces-38379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E57A01357
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 09:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755BE3A437E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 08:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73B614F115;
	Sat,  4 Jan 2025 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tK6HjULK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295A114A0A4;
	Sat,  4 Jan 2025 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735980021; cv=none; b=Mj3GycGjI3P9M07UhsNd77nwjygAJeYJGX+O9rRSfukj4tDhT1p3HxsSdB1w3FeSDtnMszjicwQRvRobHhbD58HzqdY6TetQsiP0LdaZYHhxj5TE9WTk9Mm21yH6R675ygpHONAXj6SWq3gmeRl29Dbc2wFGhyq9Y4INg8907J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735980021; c=relaxed/simple;
	bh=dTex3vdxP6ejxc7KrkZsuKlOX0BnWAfCO5qEeR1fY58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T96QoJ1ZPPnMLa5OwA7TwLaejJoyMCP/La4r/sJABVhLkAOwui2I4By85b5V/tVdpQCMQEl3m7tSplYbxrMHnOnijJwMPGid8RyRJaKIIfqxFwqT1Kff5HKRHysK01ekwPY5VaAHzW/f2nr9RI/5nQEa83Nf/Zd22YI96GE2pDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tK6HjULK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F84C4CED1;
	Sat,  4 Jan 2025 08:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735980018;
	bh=dTex3vdxP6ejxc7KrkZsuKlOX0BnWAfCO5qEeR1fY58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tK6HjULKZr7ouhg42c1S5fuz6G23drJQ6xq24mhy4kMnrIrPVa1JtAGCrhnNxDeV/
	 iiHWaj3J17v+FD9t2ED9mXo+1hl/ejTbn5m/1igf1RLgAbldyt/jiI5BL/Q17oJZYl
	 pQ4081z0pnBtTr8bofeexIkdgzC1DrJOHrhg2jZfUYjbd9sXXkNqqmrGNSfx23dsC7
	 L/dn7BXC//vL48AhojzmBrbxDuvYFWbQm8EOLondh5lBKtwJhuEZY0OlFzOkX4Nlea
	 MoD09zuR33PYQYnxxviHKwGrgiwNIw/f1J06fLApq4mGDjzw7ue7Mwxm9TQ6rXcz7z
	 TBpjjKaHiOCHg==
From: Christian Brauner <brauner@kernel.org>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com
Subject: Re: (subset) [PATCH 07/12] fs: add RWF_DONTCACHE iocb and FOP_DONTCACHE file_operations flag
Date: Sat,  4 Jan 2025 09:39:31 +0100
Message-ID: <20250104-sonnabend-sogar-9621cd449aca@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220154831.1086649-8-axboe@kernel.dk>
References: <20241220154831.1086649-1-axboe@kernel.dk> <20241220154831.1086649-8-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=brauner@kernel.org; h=from:subject:message-id; bh=dTex3vdxP6ejxc7KrkZsuKlOX0BnWAfCO5qEeR1fY58=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRXfH6+hvvXU9WXX64bX3CsbgmueWCqfse4MSg58KX54 df3/4Ss6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIygpGhm+OJq+YuLgWnD2w IiLgz8R0r/kajGX/QpIP/yrqvH1A7AojwwybtTIiec8FWGVZ+1KM1zL7VT/4yehWOrspV+mIyqX pHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 20 Dec 2024 08:47:45 -0700, Jens Axboe wrote:
> If a file system supports uncached buffered IO, it may set FOP_DONTCACHE
> and enable support for RWF_DONTCACHE. If RWF_DONTCACHE is attempted
> without the file system supporting it, it'll get errored with -EOPNOTSUPP.
> 
> 

Jens, you can use this as a stable branch for the VFS changes.

---

Applied to the vfs-6.14.uncached_buffered_io branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.uncached_buffered_io branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.uncached_buffered_io

[07/12] fs: add RWF_DONTCACHE iocb and FOP_DONTCACHE file_operations flag
        https://git.kernel.org/vfs/vfs/c/af6505e5745b

