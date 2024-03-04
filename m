Return-Path: <linux-fsdevel+bounces-13471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA3D87028D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A15AB23752
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6FE3D578;
	Mon,  4 Mar 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFCa3PHb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE43D564
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558538; cv=none; b=JM8w6eg4cN0zHfzlzPns6ATyhnv6CNw1sa+yQpfTu+b+e7FPyTn7nWGlzdbuOtG3nTul5Wjj2wMv60dHKG0CrRsh1SToCxvj1REJheDYXzauKfwDl6dk/Wl8AkIw+d70N7T0UAMd5ogqadgisBFtd9OSUOXFOXTSDIls68Yf8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558538; c=relaxed/simple;
	bh=pLi4ilcDPmVqptBSjUxUvEiemj+3Myh1M6X5+qwLY+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5Z14JzY7hJIFVHQQUwtJcoaM59Imcj09ah4QeeVszKjUQCNEFE96JtO/98cGZacU6LUQrcA4hBFPv4/OKVPmAX+5ei6YH/Ss9UDE0h97Zo8mq8/2frfkUhygd9pyvpzn8TnJtKuTes+YmT3frZfqVbRzlVysyO2ez9TN0UdofM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFCa3PHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F4BC43399;
	Mon,  4 Mar 2024 13:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709558537;
	bh=pLi4ilcDPmVqptBSjUxUvEiemj+3Myh1M6X5+qwLY+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFCa3PHbHIEweZJriSbPisyEvBwBVNMce4GKBUzsBd8VbBegPVDpVvQBfL5vSp1YA
	 Pqv3nOwcR5+woBX0RBJuDjIB5acCv7a6o3RwOtAXrMtWaWQAgH55UXG1qPT9ZzoKTS
	 g4QIUpIDrHRYdwcvn4+v+cB49noAbH18BWIAyEI9n26VMu+5bUR8HpmH6YLs46nnt1
	 0irOjabyfWOWiVMxu3JHR5Mfm6UwKmFcpRctetLlidB2iPFDPuUNADyfencqgi9fLz
	 mp5atTSlcZsXjyIC6DW2lqbT3JEIZVv2gi9f0Ipwds6fTunSmPgqMHtmTHilrO0A6G
	 /Ajw2ei8jBw3A==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Eric Sandeen <sandeen@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Bill O'Donnell <billodo@redhat.com>
Subject: Re: [PATCH] openpromfs: finish conversion to the new mount API
Date: Mon,  4 Mar 2024 14:22:10 +0100
Message-ID: <20240304-vorschau-zutreffen-68ca8da184e0@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <90b968aa-c979-420f-ba37-5acc3391b28f@redhat.com>
References: <90b968aa-c979-420f-ba37-5acc3391b28f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=brauner@kernel.org; h=from:subject:message-id; bh=pLi4ilcDPmVqptBSjUxUvEiemj+3Myh1M6X5+qwLY+Y=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ+Pc2sVXjzbe7Bd7dM3rb83ZcU+3labrDgN7YjURHs8 2pNT5906ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI89sM/6ua9Ow9te2XZ/ts OVId8l9JbktyausmsT7Pueknty7MSGf478J/Sv3Mb901SeYd+zb3F4R72X44LxHx40hg9tZlhmk hnAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 01 Mar 2024 16:33:11 -0600, Eric Sandeen wrote:
> The original mount API conversion inexplicably left out the change
> from ->remount_fs to ->reconfigure; do that now.
> 
> 

Applied to the vfs.mount.api branch of the vfs/vfs.git tree.
Patches in the vfs.mount.api branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount.api

[1/1] openpromfs: finish conversion to the new mount API
      https://git.kernel.org/vfs/vfs/c/0540b5e5fc1f

