Return-Path: <linux-fsdevel+bounces-49495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B463ABD6A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 13:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1721BA0D32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 11:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538C5276047;
	Tue, 20 May 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODKh7+Ig"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95981262FCF;
	Tue, 20 May 2025 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740069; cv=none; b=SNTl2nJ3p+us8EffWMK37o9pNNF3vfBlQdZuUeRcC9jcXqCKwFz3v+XD9P1NwxJe6eqzOjev6Mw0o92cUoGOJ8XImnendWaY7W1VQAZrzZIyu5D5Ak1+EGlF7R1QVq2QEU+MbxqoSieEQeyhs3aUNFCcGxjVFrQtkRnrZ/xujK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740069; c=relaxed/simple;
	bh=SxZF7UQR/ESUvDdE3/QnwrqfcMM8WfbnJhTz/dGTTyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAQzxLM6o3Ed1/dpxYQuGJpfV0t3ic3OWus1j3Eku+ep7vanG7VwHT1RAplBlz9oYC57zCVkqjN0qCf5R6pdOwJwRb1Ys1CnTjPlg+0JJZrzyxkdJgqIcaB9FMBLtrV4QgPwj0uudKsgKIW1jlS2wu97c1EH2BEUj9c64nwv3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODKh7+Ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9183C4CEE9;
	Tue, 20 May 2025 11:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747740069;
	bh=SxZF7UQR/ESUvDdE3/QnwrqfcMM8WfbnJhTz/dGTTyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODKh7+Igw5KIRi/8u5+nTGJQp+jMs4JSk9o+fC9+2QLk3ByZZ105laATtt4wGWi1B
	 L+/87e6TVGkPlfa6WiNtIQ3+oaH+Y6uSMsYOwz0+qw3/XDoxgncfS4m7LtSbW7b+tJ
	 jjavKA13uZ/Rxs5m2Kl2guWpdYl785pMLzvIURxcy/Z0vpiGxX5GEA7DFqTNg0h2oL
	 oHybhGDrOZiuhrzPb/anbw9Hc5sV9ELs6db6UMQiLhHag1e4xYdstJ52jAi70DIinM
	 knthEzQx3dkbsY1/d9ozlSeh1WuC1+CbwLoDHaygmssjOadY8AbQWS4wKPna4yfV9n
	 c3Ra+e1jmVYHg==
From: Christian Brauner <brauner@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] netfs: Miscellaneous cleanups
Date: Tue, 20 May 2025 13:20:58 +0200
Message-ID: <20250520-biodiesel-lausbub-b47b9d0c8122@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250519134813.2975312-1-dhowells@redhat.com>
References: <20250519134813.2975312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=brauner@kernel.org; h=from:subject:message-id; bh=SxZF7UQR/ESUvDdE3/QnwrqfcMM8WfbnJhTz/dGTTyk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTopM5buV2MaXfDjYd/VmqVLFc5/nXqvw3zTS97h2lYJ XP7K9RrdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkJA/DP1Xmxqde9g43J4aw RD6wdhG/XOM/0euQ0yK3e/YduWe+PGf4w19VMPvW0VNLNT9NN3Arjc62/L1935d5tXtyd7genFt 0gh0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 19 May 2025 14:47:56 +0100, David Howells wrote:
> Here are some miscellaneous very minor cleanups for netfslib for the next
> merge window, primarily from Max Kellermann, if you could pull them.
> 
>  (0) Update the netfs docs.  This is already in the VFS tree, but it's a
>      dependency for other patches here.
> 
>  (1) Remove NETFS_SREQ_SEEK_DATA_READ.
> 
> [...]

Applied to the vfs-6.16.netfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.netfs

[01/11] netfs: Update main API document
        https://git.kernel.org/vfs/vfs/c/47373f2ab1d5
[02/11] fs/netfs: remove unused flag NETFS_SREQ_SEEK_DATA_READ
        https://git.kernel.org/vfs/vfs/c/ee14258fbbf1
[03/11] fs/netfs: remove unused source NETFS_INVALID_WRITE
        https://git.kernel.org/vfs/vfs/c/ddcfb59dcdec
[04/11] fs/netfs: remove unused flag NETFS_ICTX_WRITETHROUGH
        https://git.kernel.org/vfs/vfs/c/456cf30144c6
[05/11] fs/netfs: remove unused enum choice NETFS_READ_HOLE_CLEAR
        https://git.kernel.org/vfs/vfs/c/25d0f55b5f5f
[06/11] fs/netfs: reorder struct fields to eliminate holes
        https://git.kernel.org/vfs/vfs/c/b6c86807c1a3
[07/11] fs/netfs: remove `netfs_io_request.ractl`
        https://git.kernel.org/vfs/vfs/c/7327b21c7203
[08/11] fs/netfs: declare field `proc_link` only if CONFIG_PROC_FS=y
        https://git.kernel.org/vfs/vfs/c/bdbba439f946
[09/11] folio_queue: remove unused field `marks3`
        https://git.kernel.org/vfs/vfs/c/ac4c7df8c62c
[10/11] fs/netfs: remove unused flag NETFS_RREQ_DONT_UNLOCK_FOLIOS
        https://git.kernel.org/vfs/vfs/c/48f59da41422
[11/11] fs/netfs: remove unused flag NETFS_RREQ_BLOCKED
        https://git.kernel.org/vfs/vfs/c/e8900578e0f7

