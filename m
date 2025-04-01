Return-Path: <linux-fsdevel+bounces-45426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC90AA778E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6853188B690
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D911F0E23;
	Tue,  1 Apr 2025 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGgqhV7D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001345A4D5;
	Tue,  1 Apr 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503700; cv=none; b=CAd/ddkt8wgLEOTpJLKE9W0HuyYdGgsHZx8SzkiJMpnws2b5v/lacQX+yMSOq6eDDePa5ZoGWSWoM7KElVJqTXBGAKUdXTXPmk7BNofy9j4/u6pV0KuEImOWmiu9ZJOn0xn3z78A+mWvmcLesFMCkYEJEgVYunmjgxmAGMiCaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503700; c=relaxed/simple;
	bh=TD7XfWz5YDF4LfBDwutCvNXE2Wz+eKV/25wZX0rusfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrIGFcBwKC1Kj0EfMPS9I9UlJEert7GCPUNeO2hI7JqdQ5x7rXX2zARP1wAAfEkVbZ1zykXaANo/2wc8Fa8qilEQ0Kfm8jxKohAWP4vK5GPM8nXUiyCxsVR9+uY5aAM4cAWdXrrIfdTwFyw1/wGkRivFUPQJtqAABQjJDDgItGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGgqhV7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE41FC4CEE4;
	Tue,  1 Apr 2025 10:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743503699;
	bh=TD7XfWz5YDF4LfBDwutCvNXE2Wz+eKV/25wZX0rusfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGgqhV7DgvBSEKNwHpPPEH8rFaM8d0i9CNUsLtAeyTZvqy5GOfJYe998LxX8Cfrkk
	 TACrruFZkSy+eTp7q544QWS49Hk8vFIwJv8sqg4TMTuMSAvvENGKn0DUpr8xnO5UnN
	 ZBefYBqHFykpvrg/Y1sdc7pH+pmN+QHOlarKSEDcMM+dPB01XSXzBTotREPqeZrGBP
	 MctZY+2BrhA84l769HIo/sAkQNYNL7KOeeuaZzzTERxmRQj9KbM2DeegII/sE8WBQp
	 mI543IkzgJrMtmgmukK154o4kzdgbPlOz9OpVZHM8LYxLmiM9shx1bW1rWhdv0qVru
	 BfvdgLhuq7+wA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] speed up /proc/filesystems
Date: Tue,  1 Apr 2025 12:34:51 +0200
Message-ID: <20250401-zugute-wahrnehmen-d95d2334d0fc@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250329192821.822253-1-mjguzik@gmail.com>
References: <20250329192821.822253-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=brauner@kernel.org; h=from:subject:message-id; bh=TD7XfWz5YDF4LfBDwutCvNXE2Wz+eKV/25wZX0rusfQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/PuibtrLNP/GwxaYCxbleH3Lv9fquF+oUYb4VGuDsx HLnW7RyRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQOMDEyzD3OeGZf10FduQ+f FlekFs8V1NH98L9j6lMXhpOmrk3+WQx/xY+wFnb6zbJ2ehXewDm/V91myeXnEQ6alT2blArSRKP 4AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 29 Mar 2025 20:28:19 +0100, Mateusz Guzik wrote:
> I accidentally found out it is used a lot *and* is incredibly slow.
> 
> Part of it is procfs protecting the file from going away on each op,
> other part is content generatin being dog slow.
> 
> Turns out procfs did not provide an interface to mark files as
> permanent. I added easiest hack I could think of to remedy the problem,
> I am not going to argue how to do it.
> 
> [...]

Applied to the vfs-6.16.procfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.procfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.procfs

[1/2] proc: add a helper for marking files as permanent by external consumers
      https://git.kernel.org/vfs/vfs/c/6040503a448b
[2/2] fs: cache the string generated by reading /proc/filesystems
      https://git.kernel.org/vfs/vfs/c/9750cdeb327d

