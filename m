Return-Path: <linux-fsdevel+bounces-13451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D088701DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5929C1F22EE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 12:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D302D3D3B1;
	Mon,  4 Mar 2024 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8+Gwp8c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFEA1D53F
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709556948; cv=none; b=NPMAXn//vJpT/oaj+PnplDQn4noWEwqSzZJtfEUNvAzWyofgMHNArj70KLRbQczyzGzereZvIBCYPHtVdKi5o2rIbUcZNmKnCS5d1JcGwxlSYtITYYHLHxILcW8CYE61y4he6EIGhlh3oRndiPB9kUD+4BRgax+YOHcSicbrmqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709556948; c=relaxed/simple;
	bh=BeWzHk0FLnZvjb/OrYCkt0mmXme/S0uXCARq0w7eI/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWsYwwwaWL9yRVoPsnrl/lJjHsZugZ8BfVvADcd4A9AhBt16GDKvbGlkaLi9ID4/j8Li8r28NZxk1Cr593QC++5WhgtkUvlt+AnfQnK24yHbdBOP+FemxRVDnHBArazsljFarRQKa8cW7Ojqn9hmkdgeCWyRDOPo/1HbOMga924=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8+Gwp8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A9DC433C7;
	Mon,  4 Mar 2024 12:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709556947;
	bh=BeWzHk0FLnZvjb/OrYCkt0mmXme/S0uXCARq0w7eI/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L8+Gwp8cqHv0akSo2JSHl8SBUkljN50o0KtQ11RG6nm/dmRERPlTSjfiuBZOtM8nS
	 cy3pGJJw3CpQay7Rnp/0wuE8wV6yma3agDG8UR4QTK+f9w4dL9AZOL8nBIZ2iXvUFQ
	 M+WFL2+q+d6xMOlgoES6UUT+B+mt7IBrWiO71L/LPF2YZ6dZAAFwGq70GLqVMCqf1f
	 RsHC8KUS8FT6pUiJHvDqMs5TQkzCByd81MdzmRY9qlUyAUuCQvhoZlmJCcfdbZ/q5J
	 nwkCZlaHiY5nEZt/5IEpcObKXcnVVAzq+tjE9Spf/xb5mH90ScicBZUnMjfcDkiRfp
	 RzZuAacN34XLA==
From: Christian Brauner <brauner@kernel.org>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	muchun.song@linux.dev,
	rodrigo@sdfg.com.ar,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] hugetlbfs: support idmapped mounts
Date: Mon,  4 Mar 2024 13:55:39 +0100
Message-ID: <20240304-bewalden-kantig-be2b899392d5@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229152405.105031-1-gscrivan@redhat.com>
References: <20240229152405.105031-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=brauner@kernel.org; h=from:subject:message-id; bh=BeWzHk0FLnZvjb/OrYCkt0mmXme/S0uXCARq0w7eI/w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ+PXJmehzTihPx52wLV+TkZq9fn1K1dsvFrdYrX+hvf PvOgPn7xI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJqIkyMkzgrG9KOanmfU3k uZat39Tw766nf+5juPbQc8GTWXkbGj8xMnSnbzZ/zFYpEvA6/FWGwCOtJMZCwRnWq69c3X1ZIU5 TnRMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 16:24:05 +0100, Giuseppe Scrivano wrote:
> pass down the idmapped mount information to the different helper
> functions.
> 
> Differently, hugetlb_file_setup() will continue to not have any
> mapping since it is only used from contexts where idmapped mounts are
> not used.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] hugetlbfs: support idmapped mounts
      https://git.kernel.org/vfs/vfs/c/91e78a1eb6b1

