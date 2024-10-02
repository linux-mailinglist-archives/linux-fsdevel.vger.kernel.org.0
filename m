Return-Path: <linux-fsdevel+bounces-30712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8440698DE15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399991F220F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 14:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2758C1D0BA5;
	Wed,  2 Oct 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uacwZ6Rb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB81CABF;
	Wed,  2 Oct 2024 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880998; cv=none; b=NXhhcpioK7a4VywTMvYeTx5vVEe6IT2kIytheziOUjO9f6E+lBZVhlGbjgosS3K12uTWNw9P/2l+jv6FTTQbp1GSmdUtI3wSRC0ysRm0pLkfDFy704PSI9rH3M5hYkZSFfVJ+InezguAy47Sfy9Dhv3BPsb1Ru0ecK5dxnbcsWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880998; c=relaxed/simple;
	bh=xulxLHbslotqnPo0cfD7hXxtB//PfW37BKDUJN5XFp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsF5kzoELxm7YZiPK7BTKU9da9W86wihdu5JHozxx84xou5Az6yy+o1jRiwOD2zI4FIuWos9RKRBDNWpKsAfCYZ6tS44JID88+DAR2fr7e4swpiQGxjWjGXJ2qE6qYJV5qYFZ065fn/gy0MuEsYG0cJUX+urt6FakBVqmAKIg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uacwZ6Rb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF23C4CECD;
	Wed,  2 Oct 2024 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727880998;
	bh=xulxLHbslotqnPo0cfD7hXxtB//PfW37BKDUJN5XFp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uacwZ6RbH9djys8CgyBcpTpi+RLWZkAp4/BgrCJe6x+/jVoYj2PBOy9Cay1TMa3zD
	 2Jo2XWhRlAvmbivi1ctjB2UUOSxxEMCLJadlGy3Xnlo7N2PtAOjb5CfDHpVqUz+hsN
	 8Pm0uUgy7u9PPDqZWdlUMdlwfVp4qQ4JxqeBMMApAQEZ7G8AOPFWZSpSzEqSJ1Qok3
	 5rwx9jvhN1+8B6/1hF7duRXaMLB7SWH2Z3fePfH/B5AysZTKgiwkQTT5SOV5/zHDcb
	 8RKxLTSuqOuLcP3dcwnFv7EXr2Q07umByGQ6PLPPYS9Vt9DB9jttHTc8ypxYW29+ux
	 S1TRuN+15eZTA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix missing wakeup after issuing writes
Date: Wed,  2 Oct 2024 16:56:30 +0200
Message-ID: <20241002-sendung-rausch-9c589b8d09e8@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <3317784.1727880350@warthog.procyon.org.uk>
References: <3317784.1727880350@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; i=brauner@kernel.org; h=from:subject:message-id; bh=xulxLHbslotqnPo0cfD7hXxtB//PfW37BKDUJN5XFp8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT9jZcvtD+8IbBfofZ13baX6zf5uViFWNdmsOnIpUo7v L5x0jiio5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIvtBn+mV87pfj9xZbCg1/P Vz6uD8n7YD9H74sq568Nn6duWJdfasfIcOJafcBP7SbGe8UfZi43MjjM7WG2oaMwgyF+wauEB7v 9OQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 02 Oct 2024 15:45:50 +0100, David Howells wrote:
> After dividing up a proposed write into subrequests, netfslib sets
> NETFS_RREQ_ALL_QUEUED to indicate to the collector that it can move on to
> the final cleanup once it has emptied the subrequest queues.
> 
> Now, whilst the collector will normally end up running at least once after
> this bit is set just because it takes a while to process all the write
> subrequests before the collector runs out of subrequests, there exists the
> possibility that the issuing thread will be forced to sleep and the
> collector thread will clean up all the subrequests before ALL_QUEUED gets
> set.
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

[1/1] netfs: Fix missing wakeup after issuing writes
      https://git.kernel.org/vfs/vfs/c/1ca4169c391c

