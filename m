Return-Path: <linux-fsdevel+bounces-24074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C7F93900D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 15:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501A1B2122E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 13:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7525016D9AE;
	Mon, 22 Jul 2024 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mua6d5e4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD31D696;
	Mon, 22 Jul 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655724; cv=none; b=PCHKrOHSqcrbFirI0SzAsv9TjhRIycSA36lLV/gq6e3YnLsWTJPFezTXtGVyY1+EK19DN95fpus3K6qs1zgjkWk91KEp/81ySNS4furgsjue3VANdZd9gu+x6T3ol0jBttfIQA1iBU1lY9iX+Rp+sEnQNJg7cnummcaE0PU8Qs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655724; c=relaxed/simple;
	bh=99EO1k0o8YDQtkUpSIzsfA64IvvnUDYcndvdN/LqiyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PI6PpkBsT25uvsIC0Vhhz1NSL5NhYV8Jrb93wyTJoxT8s8rDiS4k+UKyiBA6rHy78TuXf4fgHe4Yf9wC6qRJDU//hNCrFSUjN5UlRfPny4PKfq/WMRUt6EB8pI7UW6Ap6ZjTergtQeguFUzemLEarNw5oTyRx/orJnR3JgJ/zi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mua6d5e4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34A4C116B1;
	Mon, 22 Jul 2024 13:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721655724;
	bh=99EO1k0o8YDQtkUpSIzsfA64IvvnUDYcndvdN/LqiyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mua6d5e44UFy8/iraVKBwQ22OYIM8zIq91MYOuYmVgjr1Mr1uemJOG2qmh9ARlGfQ
	 a4HQuOJYD3dK7HG9Vlxc0bxaWajk5/Tgp/DMPBjnIer4pfEVCKkAGuyoNpTwvDlL27
	 priRtBVxYItcuzoh+tRsL8gxcBKtcrpKcC+J68Qjt/8jFm4ixJPdV+YfUcc6qvcGe7
	 qdVm0ho1jQNc8aInoFMQexNGcBce8zySh3IcgabRNzlP1ukaJU1amkhUkPbnc+JiUx
	 E33ih5bJrQPYJhe14auf0iIGS1pfbRJy0vGYdsqASVtCwsdrzYxbokJbIqtq21dJ2e
	 B+VBxdN+QgsgQ==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix writeback that needs to go to both server and cache
Date: Mon, 22 Jul 2024 15:41:57 +0200
Message-ID: <20240722-umringt-kurgast-1fbd329ad5cc@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1599053.1721398818@warthog.procyon.org.uk>
References: <1599053.1721398818@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=brauner@kernel.org; h=from:subject:message-id; bh=99EO1k0o8YDQtkUpSIzsfA64IvvnUDYcndvdN/LqiyQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTNS1zGY/rrg46N9sY6lrOXS9ceKJinUtS4pPhcUqnhg uKMl7pzO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyhJvhf83jq2LNFque625n dnfaxyVhxPrB5tkqPcEz0u2nFaxmbWb4X1amEc5wOOX0FOP6C0Gyat3cZxUbowSeHQ1hZnu/7cR TLgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 19 Jul 2024 15:20:18 +0100, David Howells wrote:
> When netfslib is performing writeback (ie. ->writepages), it maintains two
> parallel streams of writes, one to the server and one to the cache, but it
> doesn't mark either stream of writes as active until it gets some data that
> needs to be written to that stream.
> 
> This is done because some folios will only be written to the cache
> (e.g. copying to the cache on read is done by marking the folios and
> letting writeback do the actual work) and sometimes we'll only be writing
> to the server (e.g. if there's no cache).
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

[1/1] netfs: Fix writeback that needs to go to both server and cache
      https://git.kernel.org/vfs/vfs/c/55e81a4aa9ae

