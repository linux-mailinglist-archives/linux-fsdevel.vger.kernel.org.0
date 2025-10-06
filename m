Return-Path: <linux-fsdevel+bounces-63481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20429BBDE37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 13:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7C83BB636
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EC327055E;
	Mon,  6 Oct 2025 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bszp0Jq3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C140E26E70B;
	Mon,  6 Oct 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759750676; cv=none; b=QMeHzyKaId92myZQ+rww62HdcNUW2toJMhMFwka7CmZaQ/axrtEmlDM5xHGpoIRfGka9MJbuX76kN6ptWxPpYBz7PM7aBZijg/tJ5YHjdEkiRysuh5es3OLMFbcA+1wOu43SZJg9jdRNDm8IYdASnmEBiVC3jrO8zt8OMucRGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759750676; c=relaxed/simple;
	bh=4Z/iRF9EQRx6VVJtWLtlXGVmt3w8RmCR3Ot/liAqvZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnz6nd1C0vkwRcRXHzLJ6e1ZHsWu35vWDy4XzlBU0eeuW/UExI1IcBiN2YgYiMz+FaVEW5eO6l9z+YOuP+51gKmwDqHXs3tuvjqxMBFUuIyl9AKSB143qVGMfjEdocEbBZLX1zTMT6VswY2yVjY5Dk6zS5+3rcKEWobNq2Rldps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bszp0Jq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E09C4CEFF;
	Mon,  6 Oct 2025 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759750676;
	bh=4Z/iRF9EQRx6VVJtWLtlXGVmt3w8RmCR3Ot/liAqvZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bszp0Jq38sBFKB3MpjnJO4RYbh5L+e4zdy7S7jEGuEsUl6c2Z64jUZzXm5ch8QoDn
	 gKyR0kEqq4b/qswoblta5reytncwHWINXwN6XHEfwIDRPaUiLNk9JXoNmidUZg06TB
	 hp0JREKOS/hPA2pawcQAxK0TgJmpQO+uP8Ac27sqRX8smPkInGmDI/M4DfIqf/4kpu
	 x90HppNep0ulchjBeRaXp/6fPdubHkoxdCo2H45RtymffXKvRKLQ/AN848GbplcynN
	 qWE/jfV/FZqsXbjbXDfkw2bedOB1VHVw2FDcyzd2P/5BP/o3ZKMqoOxJKD9vWw3a/q
	 VM98i+WbANO2Q==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: add missing fences to I_NEW handling
Date: Mon,  6 Oct 2025 13:37:51 +0200
Message-ID: <20251006-hauer-salzig-7f287781757a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251005231526.708061-1-mjguzik@gmail.com>
References: <20251005231526.708061-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=brauner@kernel.org; h=from:subject:message-id; bh=4Z/iRF9EQRx6VVJtWLtlXGVmt3w8RmCR3Ot/liAqvZw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ8XiXw+cHB4It/dl28Ie+6YPqO56sNV4QlPWdvuBEYG nhzYduM7o5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJsMswMvx0uCC9QISlfuGL 9eUSm6anzEz6o/fS+35aBMO9Rz13jBUZ/rvGCTRVCGfZ/bb10w7yO1zwxuaUiMEpP3mmxyuDT/5 4xgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 06 Oct 2025 01:15:26 +0200, Mateusz Guzik wrote:
> Suppose there are 2 CPUs racing inode hash lookup func (say ilookup5())
> and unlock_new_inode().
> 
> In principle the latter can clear the I_NEW flag before prior stores
> into the inode were made visible.
> 
> The former can in turn observe I_NEW is cleared and proceed to use the
> inode, while possibly reading from not-yet-published areas.
> 
> [...]

Applied to the vfs-6.19.inode branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.inode branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.inode

[1/1] fs: add missing fences to I_NEW handling
      https://git.kernel.org/vfs/vfs/c/fb43e3dde8ec

