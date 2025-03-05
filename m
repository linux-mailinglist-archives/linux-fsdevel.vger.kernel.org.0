Return-Path: <linux-fsdevel+bounces-43249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FF5A4FE1C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 12:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54D53AFA26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BADB1514CC;
	Wed,  5 Mar 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLxteMQ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC6241662;
	Wed,  5 Mar 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175859; cv=none; b=DYivf8zSLTKU9sN3dbwjSntiyo2ak8gICMqltVFfBm7joc8CqY6i6zcE8DU6p36Hd0c43ivk+eVQPwXuRPwBpqJrlfOZn5w+PeaDyhwnagxEmRBeJeyEeh9jcFYyq8QKNfzJLkC2nZAz3DINddn+vfpKdRNG/Y8nRdxRSh6YTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175859; c=relaxed/simple;
	bh=6SMrw8mQYRbSDmty+HMAtUSaCsG84lTRIG3k/Nq5pZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqFn/nv8C/qucjHhtxfn6dsR5QCqpKoQLcqnWtWImb+8mhHwKWbwkAXHaQ+/qx61QGoXv5+ilen1e7G7HlD+B/j6JhthBLubGbeffNzeypdTzYdB2PhJ9/W+zArVKeb7uVOMbdih7GFaCQ1dtIeIcRc2g0PTG4Ru8x3GJZRisk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLxteMQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580A6C4CEEA;
	Wed,  5 Mar 2025 11:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741175859;
	bh=6SMrw8mQYRbSDmty+HMAtUSaCsG84lTRIG3k/Nq5pZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLxteMQ1n11bFUfYE0YMySuc8KmFM2qjaYVjSRd0SRQ57rbuCjAVLrXzzWuuLY0fh
	 UpCea0RmE97CYh548pbv8AE+Hy34rS440xg9FohFcUBseNaJzZn4xmHNYHe4QweW1U
	 BAel386013R96cYjvKI9jJsudXvIRfwZ0kn+rCtlanaXL7AEDUteACXdXP3vA0kIMS
	 nig5RK5Q4433wvgvlm2o9iCYthD+nApB9B2qZujl309cgyhIZLPoAoUmQ1NaLZg5Fh
	 A1r9nTlgHowx1pbWCvnTmfQfEd02hSIl6LdKNhTg5L7sRyS43fi8NkYdLHB00wPxYo
	 LA9w80pH/RFNQ==
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-fscrypt@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fscrypt: Change fscrypt_encrypt_pagecache_blocks() to take a folio
Date: Wed,  5 Mar 2025 12:57:31 +0100
Message-ID: <20250305-parkhaus-erstversorgung-8568be8fcc6d@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250304170224.523141-1-willy@infradead.org>
References: <20250304170224.523141-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=brauner@kernel.org; h=from:subject:message-id; bh=6SMrw8mQYRbSDmty+HMAtUSaCsG84lTRIG3k/Nq5pZE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfsNHTubxe/GBjeaiM+3uP8K/G7v8FDmyuO9sy9UnX4 StP106b3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARnhpGhotWFk+sky7O+VOx t/btnxZxr0MS51WzLjPs7nrc+fD6NyGGfyabPrNuOOu1uPjeM9XtaVKPVDmnde6QetaUV7xAY1t PCi8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 04 Mar 2025 17:02:23 +0000, Matthew Wilcox (Oracle) wrote:
> ext4 and ceph already have a folio to pass; f2fs needs to be properly
> converted but this will do for now.  This removes a reference
> to page->index and page->mapping as well as removing a call to
> compound_head().
> 
> 

Applied to the vfs-6.15.ceph branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.ceph branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.ceph

[1/1] fscrypt: Change fscrypt_encrypt_pagecache_blocks() to take a folio
      https://git.kernel.org/vfs/vfs/c/59b59a943177

