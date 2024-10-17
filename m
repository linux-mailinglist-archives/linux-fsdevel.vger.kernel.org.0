Return-Path: <linux-fsdevel+bounces-32196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 008119A23E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA98928613E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 13:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4FC1DE2D0;
	Thu, 17 Oct 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pb9V0vO3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C301DE2AF;
	Thu, 17 Oct 2024 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172048; cv=none; b=dcLBqOkZYez5NAT9JB+PkichLROwf85fRO1BbXNRgjjXVdq9i+PTcQDTCs5w0GNA0yKl6X9vlBy9CNRECCgw1cNG4EK3HwRtDHVgORjSypawhcSFh9kd8a24gyIalUoLzDqGJFlFfhD1I9PDSW4R2KMCV1MaCIGEgUDWsFR5HxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172048; c=relaxed/simple;
	bh=CeVF+X05MuvzU9swOxqPqecBf77+ojkvUywy0CoUFIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCXqFTmbHRAdLxy8gM4tUpn8Ki2TCfVrULcVAkwsRMMaGxdGi8SADNj2atYNLEgIe162mcinwdt/jasHKoh3WqWFxwFaA/aRxQaUw+aFAxoomBpC0iXLtHDnY0N0rsQrEFyW7pPoJMvY3pyYtIHE8cOuCZM6hdxpMWb98rczZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pb9V0vO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6EFC4CEC3;
	Thu, 17 Oct 2024 13:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729172047;
	bh=CeVF+X05MuvzU9swOxqPqecBf77+ojkvUywy0CoUFIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pb9V0vO3FFWEAztMU8B6vVjbZ+1SqM9CkSmqvcfHrSl41OLbJPChBViXTse2Cwucs
	 BlTEWcOuLmpA2OQbd6omwzPBYouOJQ/vM3fTBcr9Py8cGBF4KL8CUG9fX0BDSo9vs9
	 0petghEMuHTA3nI6KhAMq5A0bCD2JC0Pobxl239HXdd4A4uuvvD1EbgZgj/drV8VOO
	 0bsZovuxQy9boFeSapL8B31TgMMQnkDXvRz1i08qHtPz3wocVGsx8GJmsQfB91Y65f
	 tF82PtwGpoiMODaZKnCAmTcQOiq0tsr9uJSsIlknMSy5rRzLzOxHv+0TAmPolJBeeZ
	 I2L75ddx0XHOA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] afs: Fix lock recursion
Date: Thu, 17 Oct 2024 15:34:00 +0200
Message-ID: <20241017-zeltlager-affen-15cdb3da5c1f@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <1394602.1729162732@warthog.procyon.org.uk>
References: <1114103.1729083271@warthog.procyon.org.uk> <1394602.1729162732@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=brauner@kernel.org; h=from:subject:message-id; bh=CeVF+X05MuvzU9swOxqPqecBf77+ojkvUywy0CoUFIk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQLCnkWXl3yLef3BTu1F8pbp3YJBtxWWJ0qIWu1I/b/M v3gDPH/HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZrMzwi/lm/Pan6mzhm/Ne T1usuLl24cMdH2JizspefBx1dmf5gsOMDN9zAndx2MV96OVx0oq5xzvrQtzLHdYNxV8bxY4t5VW YxgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 17 Oct 2024 11:58:52 +0100, David Howells wrote:
> 
> afs_wake_up_async_call() can incur lock recursion.  The problem is that it
> is called from AF_RXRPC whilst holding the ->notify_lock, but it tries to
> take a ref on the afs_call struct in order to pass it to a work queue - but
> if the afs_call is already queued, we then have an extraneous ref that must
> be put... calling afs_put_call() may call back down into AF_RXRPC through
> rxrpc_kernel_shutdown_call(), however, which might try taking the
> ->notify_lock again.
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

[1/1] afs: Fix lock recursion
      https://git.kernel.org/vfs/vfs/c/610a79ffea02

