Return-Path: <linux-fsdevel+bounces-44420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E88A686B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BC2179BDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8187251789;
	Wed, 19 Mar 2025 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXvK76Sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1505C250C02
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372665; cv=none; b=XdpGsvxZ+ZAnrjkp4W4fVBhmngm2l0t+tC6WSU8BcS2KObLqOamzjuO6JtqcSG0HTNRTiUS7KV4HqODgLk6RbGIv1+Gr9/ArqY91fNr6cuzL4kP7hXX44tITHW3f5LfdTSBPsNZUVu5al2Z+iUZ3yB+fPTM5m+nrS0VrbEdd3Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372665; c=relaxed/simple;
	bh=3YXzRQghXBqMUskoi8HXA6w6KK3Zs+BW7oynrIo0qJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q86WHaVQLi6aA5CYF06Ba37x/EojkuYsS7K8TMFG7n8Bn4majCwkh9G54RuvKQl+mgakzucFk1n+4O1QaCmh2PUT33qSxgA0KMFjrNg4JxBFslFnO+iBeu/xHUDNgmnQbMHPPEIeWN8GNqkrxo7qqWMw1zBoSQ249F4Cil4l5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXvK76Sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B226CC4CEEA;
	Wed, 19 Mar 2025 08:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742372664;
	bh=3YXzRQghXBqMUskoi8HXA6w6KK3Zs+BW7oynrIo0qJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uXvK76Sw8fmqoVdjmq64EGT9IJJMIc1/lYCgUeYXrnel+WP2JhDwV3ub1Ee/wrkTK
	 PvCC+QIeIIDVhdKIczTsxnbfaV+N7aFgkJOsVpb8CX9WKTOJy2yVemjclIWknAec8A
	 RXtnFBYafWoi7AVybGICypypl4CCLUwqxLZLRTkbB5oJW+iBPTaqoU5mfm7kTWQuCn
	 nE30/alYJ9D95MRZwvCU4t7e9JDzubD3FE/vvWd5E/ByxLu7fxwNcNB9+FhRBIvCOk
	 BEc+QwdjA8goXoEMJT55G5vFN8iN/CFL/gEH47GYEJUB3SMMW4YRiysV+VajMwDN/A
	 P1A8+87hkpryg==
From: Christian Brauner <brauner@kernel.org>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: Re: [PATCH v3] fuse: fix uring race condition for null dereference of fc
Date: Wed, 19 Mar 2025 09:24:16 +0100
Message-ID: <20250319-eingibt-sessel-424855e381fd@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250318003028.3330599-1-joannelkoong@gmail.com>
References: <20250318003028.3330599-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; i=brauner@kernel.org; h=from:subject:message-id; bh=3YXzRQghXBqMUskoi8HXA6w6KK3Zs+BW7oynrIo0qJM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfqjeumLXKunf9zsA8p9031lxceXJ/zI951YfPHmxhC ZA417Dyc0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEJtxkZDj/zdTovvX1SSv3 H1n3TYtBy9d1orrrg4bJUsYPX+vN+fCIkeGTHGunNZ9V7kY7te5b6UsSHid2nFywPuHl9QvXbXt 4VVgB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 17 Mar 2025 17:30:28 -0700, Joanne Koong wrote:
> There is a race condition leading to a kernel crash from a null
> dereference when attemping to access fc->lock in
> fuse_uring_create_queue(). fc may be NULL in the case where another
> thread is creating the uring in fuse_uring_create() and has set
> fc->ring but has not yet set ring->fc when fuse_uring_create_queue()
> reads ring->fc. There is another race condition as well where in
> fuse_uring_register(), ring->nr_queues may still be 0 and not yet set
> to the new value when we compare qid against it.
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

[1/1] fuse: fix uring race condition for null dereference of fc
      https://git.kernel.org/vfs/vfs/c/d9ecc77193ca

