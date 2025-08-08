Return-Path: <linux-fsdevel+bounces-57094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED19B1EA2A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 16:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FEAC4E44CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC87927816B;
	Fri,  8 Aug 2025 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFWqfvWH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9BF4F1;
	Fri,  8 Aug 2025 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662638; cv=none; b=S3/2wiRvXJL4UtWp554qmXE13o4QvVWV0yygnox1VNihn38DJqE0IX7ZKytTZdlANHQ0J18kAhChgLzM2H4NRVz3h6VaFHRVWqpqf8sU6n0IcH7kSaZzbMF5bOfUE7XJanG0RF2jpFXdn7dpu2ApSIjkKE8LJijAcKxFUOQRxNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662638; c=relaxed/simple;
	bh=FN1yrR+pKPwucphh9TBMxiQFtFhUAgNaMIP8D20nNeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsCMfz39xctTEsLuPkhJt8zenRh/qnDJ3gXUum6U3FCYsdcUDyjkySpebFoo+X/i6mzWBej9G6olw/XltV1b697sr+RFiBUfsw9eeUcl2E69W2DxXFb8zjXy1Mr8q0q/miHzEgd8a9Mz3oSv6+EFAdhWXAVZ/lQgvKKZO7Lu/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFWqfvWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D216C4CEED;
	Fri,  8 Aug 2025 14:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754662637;
	bh=FN1yrR+pKPwucphh9TBMxiQFtFhUAgNaMIP8D20nNeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eFWqfvWHroqzq09/phqN0Pd/7oeeWTq/EWBXhu73T3/owBEnEJisVvzlmqgd9WTW/
	 QtnSapeJtTkQQUpqWyEdoR66XijFMGm/tQhvL/0h6Yp0/UiRzXyAnMibyWm6XeCtd1
	 21p069tS1p16zKl98FmSecdLFFGmXF301zC9/Pm1WO8oesuZH/IWlwMi4xxSszoxb3
	 de3IgN/d6E+tD5siV8l1Lw5o5DCkFMBDxc+5VOlC2Mr4drVr4I2Dheg0aZ5qCB1BlT
	 q6NDOkZ8yUCog1qaMbn2ChKlJ7ACBI1g5RunxqiPKO8YK2oNARrKgrzc4qn111hAUj
	 ucH5PEq641DqQ==
From: Christian Brauner <brauner@kernel.org>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Sargun Dhillon <sargun@sargun.me>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3] fs: always return zero on success from replace_fd()
Date: Fri,  8 Aug 2025 16:17:03 +0200
Message-ID: <20250808-lernbegierde-amtssiegel-cb2104469f1d@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250805-fix-receive_fd_replace-v3-1-b72ba8b34bac@linutronix.de>
References: <20250805-fix-receive_fd_replace-v3-1-b72ba8b34bac@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; i=brauner@kernel.org; h=from:subject:message-id; bh=FN1yrR+pKPwucphh9TBMxiQFtFhUAgNaMIP8D20nNeI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRMY3tRmPFWfdMCqT22T8RNF5U2nVA41b3/f/Wjx2c/K L6RDboxr6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAikqsYGRqFNc/ODtJ9OTNk v+u+EkOJZz+mrNRbtfdZ7sy62X9X2b5lZHgalcUz40zetKmaoleOLD5uHs1vHjObgSWYnUdpp9d LN24A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 05 Aug 2025 14:38:08 +0200, Thomas Weißschuh wrote:
> replace_fd() returns the number of the new file descriptor through the
> return value of do_dup2(). However its callers never care about the
> specific returned number. In fact the caller in receive_fd_replace() treats
> any non-zero return value as an error and therefore never calls
> __receive_sock() for most file descriptors, which is a bug.
> 
> To fix the bug in receive_fd_replace() and to avoid the same issue
> happening in future callers, signal success through a plain zero.
> 
> [...]

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

[1/1] fs: always return zero on success from replace_fd()
      https://git.kernel.org/vfs/vfs/c/7db5553d705f

