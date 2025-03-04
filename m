Return-Path: <linux-fsdevel+bounces-43072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A70DA4D90D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF7477A2E93
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D9B1FDA62;
	Tue,  4 Mar 2025 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcROd9i+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BCE1F4E38;
	Tue,  4 Mar 2025 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081546; cv=none; b=PytNjDHuYEi/VfdqR1GOKgw01zKY/i7utghtTj6vkI2//eu2ftmk3tc7ZdFk8yCLeXOIODIBeczT7lPhkgKFid/vCs4z/aelLzb99JO+tx7v9qTLZPIgDeyh+xW17reI8w7OaBEOk68v1fi0gt5m8b9qHdYUKPOk3hALs3enxNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081546; c=relaxed/simple;
	bh=Zx8aHL8TjK/0JadzMPfxpvzacvveR7z9R5dYYUGLCOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+4PGWGhdR/th1UV7LjEelqVtqtTk7QSe3+Ga2RkD3OwnuezoOyk6V++MRVzRfG9evzGKAfD4XVXLT3ovLNDeMm1X43Mhj9t82is3G+QIVZYyLv85GOyCy/F5lYcMGvCeQEPo0F1jAaW9a92M+5wdT/o5OlibZxEvTf8o0q21/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcROd9i+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C474C4CEE5;
	Tue,  4 Mar 2025 09:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081545;
	bh=Zx8aHL8TjK/0JadzMPfxpvzacvveR7z9R5dYYUGLCOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XcROd9i+64hjCn50JTFmCZOYijO1ihYFHQEPqSF4puOuuXVsIPnf7TQHVj3qJyC/w
	 xYPDgYxaNUQJKVdEnr4EjlA8DM2g7yN5QmrP7njexaxch2IjtWPCaEPWTDnLCMTlLU
	 MZ/46w88BVaINh0t+2YCRKigcJvYvEZvoMuvNyUMJbhCNVncK8DpnRfC1KZmxz1C0m
	 yqwkxESK434RJxkVP2/FPmcUnvRAIentc5dEb61RGhx2ZLPaUcDeqtDpqmq0P6RyOf
	 COflYQRvfcZFx9fh5nc3RDhijliiUCTvGWbj7I5qKoDMKi0XrogxIBKChhTQYLtc1V
	 SwW388ceLWQIA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v3] afs, rxrpc: Clean up refcounting on afs_cell and afs_server records
Date: Tue,  4 Mar 2025 10:45:21 +0100
Message-ID: <20250304-fuhrpark-neuwagen-b66b75fd45e6@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <3761344.1740995350@warthog.procyon.org.uk>
References: <3761344.1740995350@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=brauner@kernel.org; h=from:subject:message-id; bh=Zx8aHL8TjK/0JadzMPfxpvzacvveR7z9R5dYYUGLCOs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO30oLpSlyf3B6levC+bs6xU49PXO0u9WMR02tuen/ XtSV6LN01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRAw6MDIfj3+2YIcHye5tr V6y4QQnLO8saRZX4oq+71XZ6HDnsWcPI8GBnnI2meaHc/Y+3v+qqhLDon5ussmnC4c+egq0lj6p t2QE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 03 Mar 2025 09:49:10 +0000, David Howells wrote:
> Could you pull this into the VFS tree onto a stable branch, replacing the
> earlier pull?  The patches were previously posted here as part of a longer
> series:
> 
>   https://lore.kernel.org/r/20250224234154.2014840-1-dhowells@redhat.com/
> 
> This fixes an occasional hang that's only really encountered when rmmod'ing
> the kafs module, one of the reasons why I'm proposing it for the next merge
> window rather than immediate upstreaming.  The changes include:
> 
> [...]

Pulled into the vfs-6.15.shared.afs branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.shared.afs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series or pull request allowing us to
drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.shared.afs

https://git.kernel.org/vfs/vfs/c/acf689e88306

