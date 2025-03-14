Return-Path: <linux-fsdevel+bounces-44026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CE1A61529
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 16:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7855D7A5AF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AC81FFC46;
	Fri, 14 Mar 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6qVt9AY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BEA3A8F7;
	Fri, 14 Mar 2025 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966816; cv=none; b=sKXOQ3qRaWrGBl6WpSPRvJEgIfYQ0LxB/BJ+p6B9IbCIKurqDr3tBhjCNml/C+D6qHTpn6zpcyMuX6C+bMuMlAPycaraVSvUSI3LOG5RbsERxovQ6aZ41cSwa/YUKwvZFk6RoV532xNxDoGwmL6zK52X/Gk55G3yDVr5AgkvybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966816; c=relaxed/simple;
	bh=KaGpwJGyES9YlzeaSEs71SSB0DlkQlxNseafP/srjQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdN6/UkOTdhl444XypV6PicnuGoF8d+l75Jdrug38+/rLUyJ/LCUGovaix/bVYrrCz5FczhUlpHD9B5JJkVUVoju9MgAaHwuMbIj4wAPWub5uscwohIioY7qWx0IkCuMjVPL8A+uWXE0DbcdC81WotjU0UMqzFzI8GhFDzV8STQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6qVt9AY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE71C4CEE3;
	Fri, 14 Mar 2025 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741966815;
	bh=KaGpwJGyES9YlzeaSEs71SSB0DlkQlxNseafP/srjQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6qVt9AY7d+DMmTPBVoGrdYpTpT4VV5xQ5FExzmtARp8bciMkcQDbJuOyIEu/RWJF
	 rWx586O9gl8maXuFHR3TXw+9FA3BGhLOw+L84viI6v1M3lfF7Q2cGikj0J5OvDkE/k
	 WNspKpKyDV92ASKPtKp9lIVilWodqBcZSfuFlgQLDPbi43jTLUAUFtkd+k6ITlfIs7
	 hIGBNcRA6rpzepFCm/6wnSRfSkUsxNS10XN3z6fyF0i9biK3J0OtQw3/1lwudYFazX
	 rTRSSXBiu2ZBs6tbTwQbkTCjs7zmOlTMvLKZ05ooVLDBGmdl2z2Q81aM+t6IyxCWUm
	 ji9WO3gk1YXBw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: consistently deref the files table with rcu_dereference_raw()
Date: Fri, 14 Mar 2025 16:40:01 +0100
Message-ID: <20250314-lastkraftwagen-kundig-d6790f4fc117@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313135725.1320914-1-mjguzik@gmail.com>
References: <20250313135725.1320914-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=brauner@kernel.org; h=from:subject:message-id; bh=KaGpwJGyES9YlzeaSEs71SSB0DlkQlxNseafP/srjQM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRf8b01Y8GZgrWBMo+lZRumnPE3rUh9YNVm2+jPP+F8S cH8umNFHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpf8PIcPP6cXOZGt6IV72V vi3R139J3Z//OJYr0XQeO/Ok0jPHxBn+R/jO2eebFPb6Y1wE32f7xupNt980MR5fH7PnQ/+kHub XfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 13 Mar 2025 14:57:25 +0100, Mateusz Guzik wrote:
> ... except when the table is known to be only used by one thread.
> 
> A file pointer can get installed at any moment despite the ->file_lock
> being held since the following:
> 8a81252b774b53e6 ("fs/file.c: don't acquire files->file_lock in fd_install()")
> 
> Accesses subject to such a race can in principle suffer load tearing.
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] fs: consistently deref the files table with rcu_dereference_raw()
      https://git.kernel.org/vfs/vfs/c/c72b20d10034

