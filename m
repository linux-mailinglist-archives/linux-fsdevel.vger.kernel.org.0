Return-Path: <linux-fsdevel+bounces-25072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1229489BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 09:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA702812BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 07:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706EB165F14;
	Tue,  6 Aug 2024 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr2Zz0EN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE342B663;
	Tue,  6 Aug 2024 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722927985; cv=none; b=Pt741f2MfYwLIP6MFPimK8qlV8hL9ukdMZeYoYnhqWNDDxwY/+I9MpIFJD8hKWm5p1E9smlNL6BM9GjFLK5kjtRlI/LwPXyGAuSc7nnhf6tyUh4woGZFIoe4DmI4SaWWjurLGYhgLKE+XU+5HQ006tDdk6uxa20HQd6naSMaCcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722927985; c=relaxed/simple;
	bh=kGY8n6Su1JvqpXyWjEuQ6qSeT9M+Bh6NQpKsUwtjaZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5RtYW/Cj+3siHcv1txDyKERb2kwkz3klZufU7FcS0i4W5XIqM73wt4saryXwuCfwS49syC+fFwH5TMXLe12UYyj0mGS/Am0fO8Bybsrn17hmPXBvqf8RgDfk3unU6uz5zXN1Qpgjsx2aFtcm0JW1iu6db6o+MN1A/ZIZSN44h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr2Zz0EN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E621C32786;
	Tue,  6 Aug 2024 07:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722927985;
	bh=kGY8n6Su1JvqpXyWjEuQ6qSeT9M+Bh6NQpKsUwtjaZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dr2Zz0ENpPWLdlpf8A/xlwPoQUVWMmowjSamX1bIhlZr3YK6C2DKzfuhO1cYizB2B
	 +ckcCNgHEJbo1jDbEEbPbJVG05TLR3k8qpGeBxXW1FkxDs7rspbrOV8h39/tUCE13l
	 kstU2g15HQR9HlO8siUB14aePccO1N1zUz79C5WFzQVxUS1vGEWD46bSUpbMmVfUS/
	 JxItIyQdClBBmCO3X++sZI7PVovSyjwEt3luoEjDhQ8ZeAlmG44wyUXXPZHb+Il/n1
	 tzc6plA8IrQxvTSK0QL1QodDHuelpio+zsggpRFE0WA6CInOla1EK3m1I9m9utrRn/
	 +iT8AyfcNKd1w==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	wojciech.gladysz@infogain.com,
	ebiederm@xmission.com,
	kees@kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] exec: drop a racy path_noexec check
Date: Tue,  6 Aug 2024 09:06:17 +0200
Message-ID: <20240806-atmen-planen-f0eb6e830d8e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805131721.765484-1-mjguzik@gmail.com>
References: <20240805-fehlbesetzung-nilpferd-1ed58783ad4d@brauner> <20240805131721.765484-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=brauner@kernel.org; h=from:subject:message-id; bh=kGY8n6Su1JvqpXyWjEuQ6qSeT9M+Bh6NQpKsUwtjaZE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRtPJ0ZZ7EiSWP7x9e1J8QOBxxTMq+M/GjDv9B86fvrJ lFvl+dd6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIThkjw7dizpkduyapznxz nkvhaTdDf8bJiStLMsoXBP3dFu2hZczIcEDNfuIiva/a23Xlbb5ddnKzanRxXrKuaCXXVMOGeL4 XPAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 05 Aug 2024 15:17:21 +0200, Mateusz Guzik wrote:
> Both i_mode and noexec checks wrapped in WARN_ON stem from an artifact
> of the previous implementation. They used to legitimately check for the
> condition, but that got moved up in two commits:
> 633fb6ac3980 ("exec: move S_ISREG() check earlier")
> 0fd338b2d2cd ("exec: move path_noexec() check earlier")
> 
> Instead of being removed said checks are WARN_ON'ed instead, which
> has some debug value
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

[1/1] exec: drop a racy path_noexec check
      https://git.kernel.org/vfs/vfs/c/d1968fae98da

