Return-Path: <linux-fsdevel+bounces-14719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8768387E537
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 09:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73941C20D73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 08:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9442E28DD2;
	Mon, 18 Mar 2024 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn4Dn00K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037428DAE;
	Mon, 18 Mar 2024 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751738; cv=none; b=gtrWnbsBkpYglaPN9bfHwg0/bsN0Tf9AGV+6Te1x6DUfnKshqzOLDpMD/kwaT14aftLYB0odvd1qAhrX5VCTBba7Qn3AudvUqpFNJL3Wy1xUD+WVB7Q7DhECSr5gshvCOe/HLDqUqq2boyWb0L5j3CAlIbEGL7kU2+Dg0I0qLWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751738; c=relaxed/simple;
	bh=zr+WT/cxm5GWLn0il6aBrpvjRoQPdhKSPnO50VXsi9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFeBFKbKP1r/OuLJbQQFViRQwS3saO/MFFcZBJEU8J+Nk9GlZ8PB387DHoBdpPqU5yHrfNwlWCDdmuIDwm+9Jd3L4ZKIUMHxShBNG8m4xJekVaItt+RVY2Iw6ob7trK1VrRnMhuh+O+1VlZt1Ym6JRaXcS48LRq1EUPOUtOxV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mn4Dn00K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78021C433C7;
	Mon, 18 Mar 2024 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710751737;
	bh=zr+WT/cxm5GWLn0il6aBrpvjRoQPdhKSPnO50VXsi9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mn4Dn00KlXtFXHmQRfyzLRGZWoOvE9KofFoxfx8tvqqlFABwWiQHHQJ1P0UMEwjnY
	 jSplxwo8MgxDtYrsovBTOn0Kn8J7BSu2Lp3kbAELXbBnyUuoYI0ZrBDjtlVxpe1Vry
	 JP3Ikh/blRLspuQVcPXHNbMZsYj8JCPxgRjSl71+BwyWUsgNt91CQJckfr+fSv5ucE
	 MSUd9a5KKBojL45c/i9APrcjRo6VhgwnyN8Uj5Ugm9Xong5ntnztw+ZHX356pZtlkx
	 KomX9Wo1NfIrEI7GWKoU6Mm0dokdZ8IbN6O0gOF88k7gvtNcC0NWZ4yPdVepeIfBZT
	 mwBxA7hksGpMQ==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fscache: Fix error handling in fscache_begin_operation()
Date: Mon, 18 Mar 2024 09:48:49 +0100
Message-ID: <20240318-pfund-hitzig-d677830c953a@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3933237.1710514106@warthog.procyon.org.uk>
References: <3933237.1710514106@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=brauner@kernel.org; h=from:subject:message-id; bh=zr+WT/cxm5GWLn0il6aBrpvjRoQPdhKSPnO50VXsi9E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR+///JecHqV85pn6VmzX5bbzo7TocntiFCWfzVvofrm uOWJd4/1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR5QhGhmUSMiwne5XulERu Z7g2+5/FU47ws3+nbNv90vf5m5Yp7McY/qnp5H1flaaZ4GxSszHwln1xq/QywQiHz5u/m7905DP 8wA8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 15 Mar 2024 14:48:26 +0000, David Howells wrote:
> 
> Fix fscache_begin_operation() to clear cres->cache_priv on error, otherwise
> fscache_resources_valid() will report it as being valid.
> 
> 

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

[1/1] fscache: Fix error handling in fscache_begin_operation()
      https://git.kernel.org/vfs/vfs/c/d86f1160d819

