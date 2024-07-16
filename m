Return-Path: <linux-fsdevel+bounces-23739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7D39321BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 10:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8751C21BE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 08:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606A744369;
	Tue, 16 Jul 2024 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxQ2yis4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D3B3224
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117849; cv=none; b=s48drBbUuPQ2qylVeYOhchjSQ5LsOO6OaRVux7CuGM6fqinld/oOtnSyB7W6+DwJSA1tHRQkSb0/cg458oRM9Ba/PMVbY6nafi551/aXhujrHvjha/mko913Cs1pD71/FkHaMu45LLCmR76RLqnEgXAFF7suFDLthlucccp6zMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117849; c=relaxed/simple;
	bh=wOUtarsBn2V4/v89dUbAUfHM6pK+Nph4pCRHh/l2eR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcwwP29Drd6k7xJSpl48rdbosSdXZpsZnXgZsGnM8Fvz8zB83lCX33eTFZfiRBGXzBkaW6S3BIEImd9yZNn5uvVeVpD8fACQPA+dhY9w8vmQyvZuWS1bTSk6lgD3D9VIgFUqwrmLj0GnSArId8rMYV0nWgR25TckHgN8EBOBlyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxQ2yis4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D6BC116B1;
	Tue, 16 Jul 2024 08:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721117849;
	bh=wOUtarsBn2V4/v89dUbAUfHM6pK+Nph4pCRHh/l2eR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxQ2yis4QseX+MWFTuTOk5mbODXoolnSO5sbbt5IWLGgWKJY5I6LHtVAO5JwnjnJt
	 D4MdEQ/MfSgdygJHR2011pePYzoBRyxhLN24SPpKXpUjVdhUuMcvAPHU7XD6RE1jVR
	 05z24/FRKrMWvnjPLaKwxg9p3CRUnIBR5sEtY/DdW+clxBwQWd/KU8msWMhvqYBNg3
	 Ksja8q0sD9WYpiwVjJ2MWWg/SL/8JS/UtrmciqMQk8utS4oHpjr23dgQ7p0IzGeKw1
	 9VVyCnlAXjt2z9ukWd9q4VMYKrAE93kwcDVqA4dJxMi32/lQRSW5yC+Xp9e2Me3kJe
	 H4UVKjWF6E3iA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/7] Convert sysv directory handling to folios
Date: Tue, 16 Jul 2024 10:17:22 +0200
Message-ID: <20240716-karaokebar-dreizehn-993c98ad53a6@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709150314.1906109-1-willy@infradead.org>
References: <20240709150314.1906109-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143; i=brauner@kernel.org; h=from:subject:message-id; bh=wOUtarsBn2V4/v89dUbAUfHM6pK+Nph4pCRHh/l2eR8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRN05l0JHRWzzntvWl/7hrfqexWjD0pJf/o7C85R2X1y 347Vkxd21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRsL8M/51iriS4b7cuN2rW EyqctPDs45kXON/4Zy0SW3nvmfnMro0M/1T2e15xbw2KOiV7a90Mo+0SNopv/jH8WqLiud2ZWYg 1igMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 09 Jul 2024 16:03:05 +0100, Matthew Wilcox (Oracle) wrote:
> This patch series mirrors the changes to ext2 directory handling.
> It's a bit simpler than the UFS one from yesterday as sysv was already
> converted to kmap_local.  Again, compile tested only.
> 
> Matthew Wilcox (Oracle) (7):
>   sysv: Convert dir_get_page() to dir_get_folio()
>   sysv: Convert sysv_find_entry() to take a folio
>   sysv: Convert sysv_set_link() and sysv_dotdot() to take a folio
>   sysv: Convert sysv_delete_entry() to work on a folio
>   sysv: Convert sysv_make_empty() to use a folio
>   sysv: Convert sysv_prepare_chunk() to take a folio
>   sysv: Convert dir_commit_chunk() to take a folio
> 
> [...]

Applied to the vfs.sysv branch of the vfs/vfs.git tree.
Patches in the vfs.sysv branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.sysv

[1/7] sysv: Convert dir_get_page() to dir_get_folio()
      https://git.kernel.org/vfs/vfs/c/b4e73a41d327
[2/7] sysv: Convert sysv_find_entry() to take a folio
      https://git.kernel.org/vfs/vfs/c/1f1099c58539
[3/7] sysv: Convert sysv_set_link() and sysv_dotdot() to take a folio
      https://git.kernel.org/vfs/vfs/c/14ee02c67a40
[4/7] sysv: Convert sysv_delete_entry() to work on a folio
      https://git.kernel.org/vfs/vfs/c/8e71393b2017
[5/7] sysv: Convert sysv_make_empty() to use a folio
      https://git.kernel.org/vfs/vfs/c/ff6dcbb30cc1
[6/7] sysv: Convert sysv_prepare_chunk() to take a folio
      https://git.kernel.org/vfs/vfs/c/aedfd2c0a3cf
[7/7] sysv: Convert dir_commit_chunk() to take a folio
      https://git.kernel.org/vfs/vfs/c/6adec8dae1bc

