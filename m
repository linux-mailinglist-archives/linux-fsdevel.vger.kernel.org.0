Return-Path: <linux-fsdevel+bounces-36236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E19E0250
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 13:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F226B2BB8E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 12:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC00E1FECA5;
	Mon,  2 Dec 2024 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CecbVG6c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8343F1FECDE;
	Mon,  2 Dec 2024 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140962; cv=none; b=O+MKr//iWk6EbVyI9sk4gneZAvb5jbu2LSFz48uILxLay9KfI4eQudx9hx7fr3qRRUtEBxuVSJly9P29Hx4mRDx1dlsZm1pagiFXoUZMJAtsKZC0iYmdg7rU0kGmR2PcoKa5rgq95FaHBTepHS7TaaAAXIsb8TWspLUIvo+AqRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140962; c=relaxed/simple;
	bh=LIqAOnQAK5/C8Gsp6t+WXhHMmwSekbD9i/eoRM7inNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=By9D2gSjswuqH16kbVVvRm1dYDnR40QHyKN3mXeYZBmKswRnaT9t0d/EyrjP6hAi7ACr2+vWBxU5Mt4I3jcZtFjL3Oc/CaxcBM2BTXESchbQOuTKni0DluKvYJAIG6/6Tjno2GtXi2QczAHpKj7GRimAtcNsU6DxSnT8qHRrqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CecbVG6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E98AC4CED6;
	Mon,  2 Dec 2024 12:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733140961;
	bh=LIqAOnQAK5/C8Gsp6t+WXhHMmwSekbD9i/eoRM7inNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CecbVG6cRoxmuWOZwbItnrFl/ffMncxzxRR+5iJcwRkOo/SfqUPo5Z+ivHCp8HbfR
	 pUeVsTO/Gjj4rvR/qCdENGZqw40W1j1b4xCmaWk48IrkrW2bTZyuLuDqWJtWv65gF4
	 SarY+/h3n4qAxwCz3Hh6kesC1JHOYc6ptV4swRdP1gn4xazVeN0jrjoakxZoJiEnBg
	 vMDk2hcgixkrfHGhbm0UxLXrL4sdH3dibhi9wspbymKYYGAtMIvU9rzVSvvRLMNL8a
	 ubKH+baor3EFlDXtJSDeiUSwXSgg46ID5Cxee6E3RFOhFB9aEBMLogJwCp0AfARKMW
	 vTkDq+FAeT5mQ==
From: Christian Brauner <brauner@kernel.org>
To: Guo Weikang <guoweikang.kernel@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: fc_log replace magic number 7 with ARRAY_SIZE()
Date: Mon,  2 Dec 2024 13:02:12 +0100
Message-ID: <20241202-tonband-klartext-0627ca3a3181@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202081146.1031780-1-guoweikang.kernel@gmail.com>
References: <20241202081146.1031780-1-guoweikang.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=brauner@kernel.org; h=from:subject:message-id; bh=LIqAOnQAK5/C8Gsp6t+WXhHMmwSekbD9i/eoRM7inNY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT7LrykPlFfx9T+ogHP0p9XUu9UrZ9kvNeyKnrFKn6LS 6nSWXJFHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5cYXhn+bRZKCGnk1n3p+t dEx2aH+tLXZL4FUA7yXmtgzOwsAWRob1f1L3mcubZHq+EIhN9ZGN0Gpe7HXpa8nlh2dMd7j9Wc4 HAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 02 Dec 2024 16:11:45 +0800, Guo Weikang wrote:
> Replace the hardcoded value `7` in `put_fc_log()` with `ARRAY_SIZE`.
> This improves maintainability by ensuring the loop adapts to changes
> in the buffer size.
> 
> 

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/1] fs:fc_log replace magic number 7 with ARRAY_SIZE()
      https://git.kernel.org/vfs/vfs/c/6814aad4d6ce

