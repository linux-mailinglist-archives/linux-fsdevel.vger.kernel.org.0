Return-Path: <linux-fsdevel+bounces-44417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD03A68693
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667513B3DCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C4E250C05;
	Wed, 19 Mar 2025 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On+xef/r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFB02505AA;
	Wed, 19 Mar 2025 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372373; cv=none; b=YEo2T0gZC/+NlpAhIW+PgzHfKe0MLZAUubPVutaSbkaFnPGsIuUBuTYCzP+iI26yWNOBsU5B2unEezQO48BUbONHeViEilvkhnDboiymlp/0lb2QvoYDiMOs2XFNfCzxD73zcG2wLpLs7ExggePUVdL0lOaDDM0On5Ef67LVltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372373; c=relaxed/simple;
	bh=AIU0izELLfVsmUnUZGvBo7Wtpo3Jg7KQs2WJYmfFS8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hxh04kR83IpVoq2lBVwcCktkbJ+jI1ICPNCqhvjchQOEZe4ck+9NMdXw/XwSf1z2MI6ZHq+Qh3SoA2tCvPbmvcHwHIP8VaVTL/3APpius3fbCsCb7RG/gl37dkAZmonVVq7MhxHmFedAoXKH3LIq2SePUswY7P2y1WnnRfhMAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On+xef/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8521C4CEE9;
	Wed, 19 Mar 2025 08:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742372372;
	bh=AIU0izELLfVsmUnUZGvBo7Wtpo3Jg7KQs2WJYmfFS8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=On+xef/r2qHnyEwX90PVNfqSIdEskAuaEpvCzy+LFvHZE9PGyYGjMzhFqG1pjpLao
	 FQJ+AAu49BxcG9OXYm8pcPDxM6l6pWRMXjzvU/rqQZF+qRVM5vkYxkOjGzpYPzUnia
	 TD/xNdn+zrdWlFTHkF9vEH2ay9V0wJlc/nh1Drioy7eRvuwRs/1VgeLS3hgLS/razq
	 Fe5QNihFM2qNisdm0vJkIaatgkrQ8peUESH0yP620QlRKN0epX1lZWaw1wcKjCKD4B
	 aFEOqGl4zMiug1hRaRPBQVCcvlClkTWQZBecWed8oOTzIycapI137WnCHATJrrht2Z
	 ojSBTzOtkgWUA==
From: Christian Brauner <brauner@kernel.org>
To: trondmy@kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] umount: Allow superblock owners to force umount
Date: Wed, 19 Mar 2025 09:19:17 +0100
Message-ID: <20250319-verebben-kahlschlag-6567088ede4d@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <12f212d4ef983714d065a6bb372fbb378753bf4c.1742315194.git.trond.myklebust@hammerspace.com>
References: <12f212d4ef983714d065a6bb372fbb378753bf4c.1742315194.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=brauner@kernel.org; h=from:subject:message-id; bh=AIU0izELLfVsmUnUZGvBo7Wtpo3Jg7KQs2WJYmfFS8Y=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfquPb92qFVP/frX8vx/A/O9Bw72ajTJlS0d4FvLcbr HoWBF450lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR2B2MDHfZpj09+/+6wYSE 0C88HU8OmZX+qV1kxbG4dsUK7+1mW94xMixf6pL5f+5+4Xn7pJdYvFudINqWtE1wWldxwTuXWRs F9jEBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 18 Mar 2025 12:29:21 -0400, trondmy@kernel.org wrote:
> Loosen the permission check on forced umount to allow users holding
> CAP_SYS_ADMIN privileges in namespaces that are privileged with respect
> to the userns that originally mounted the filesystem.
> 
> 

Sensible.

---

Applied to the vfs-6.15.mount branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.mount

[1/1] umount: Allow superblock owners to force umount
      https://git.kernel.org/vfs/vfs/c/e1ff7aa34dec

