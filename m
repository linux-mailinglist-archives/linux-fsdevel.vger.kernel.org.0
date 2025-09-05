Return-Path: <linux-fsdevel+bounces-60358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FE8B459B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 15:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F595A0278
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 13:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A90430CD93;
	Fri,  5 Sep 2025 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="przlC0vI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031035CED7;
	Fri,  5 Sep 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080489; cv=none; b=fmLk1oancpWGHvtaEs/ImmNCgJoBmMBE5FvegwM6SnOzTLcEOzVh+3JlDOkg4H34pCarNW9G7Zgfr8ZJC4OVFs6ce37aQO18Pk2eGExbcUuA4WzFk4DRrWNEzCokncttOdRjk5L06hPYMAO8CamddxwldRzenEeq1AHhrD8lito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080489; c=relaxed/simple;
	bh=J+R0vAgYI1pVH3pG4Eny88JJuYWH64ZFWRsxIrhwP4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1iPS4yxnAzORo8uO0jpQ3Wmk9V5j7+1+6dfjsVkexT95vj+l1/viA9VYdN/hkpiMQwrMk4n6gLiz7jTylykCaHspni6Tg0us5LrNao7DFnLM+yn49/zGny708Zrxr0LFOG2gxDAF4TBpLWMko8gIpak/PX6z17Ye2AXOFooaVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=przlC0vI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD04C4CEF1;
	Fri,  5 Sep 2025 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757080488;
	bh=J+R0vAgYI1pVH3pG4Eny88JJuYWH64ZFWRsxIrhwP4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=przlC0vIer93IgncZtpS+r2yF9Kb1+MEL6SNzrxv/BYbtJDMtF2O7Qk/ULpHGwmDd
	 uvNxnm0K7azcWFlN0DBIv8CpS7oCBBc0bVolASgUsfhyzA5UVmiH8RknDygSmcJRhE
	 8Y+oCdVFzbhbdPiDtg6lmpAv6oqwShOX/ry4GKtIs8wsUQ45FL0Tha4hz1es/snm9j
	 NFuwKpgMtdHdPBfSL8noNJIvl2gIc6Jka+RCdTkBQ++veL7dHO53cAczbubDYsIUh5
	 AOKzOLz1PCJi9QsUrDzN2pIW66kHxr9v9TQl/CeRJB1j0ZIwIcSUpDtSxj2IvzNF+6
	 oncIVv940NIJw==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] filelock: add FL_RECLAIM to show_fl_flags() macro
Date: Fri,  5 Sep 2025 15:54:37 +0200
Message-ID: <20250905-zeitweilig-klebt-bba897e58a0a@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250903-filelock-v1-1-f2926902962d@kernel.org>
References: <20250903-filelock-v1-1-f2926902962d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=brauner@kernel.org; h=from:subject:message-id; bh=J+R0vAgYI1pVH3pG4Eny88JJuYWH64ZFWRsxIrhwP4o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTser1EpZzd9mhNzbmwFNUzgf5nQnbP/bREVkm9u7lm+ rNnrAX9HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJes/wV6rPzS1UscWuduo6 xoMr7MXObGb5stHy8+fHZ4o4NmQKPWP4K32RccIb72nTJiTaLtet3zpVYWHTnTltYm8mTj6zTCJ Plg0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 03 Sep 2025 11:23:33 -0400, Jeff Layton wrote:
> Show the FL_RECLAIM flag symbolically in tracepoints.
> 
> 

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] filelock: add FL_RECLAIM to show_fl_flags() macro
      https://git.kernel.org/vfs/vfs/c/c593b9d6c446

