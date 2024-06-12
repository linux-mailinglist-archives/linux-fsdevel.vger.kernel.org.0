Return-Path: <linux-fsdevel+bounces-21530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2F290526E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 14:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5102B1C20FF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DDC16FF2B;
	Wed, 12 Jun 2024 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2tT9/xc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF8616F848;
	Wed, 12 Jun 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195368; cv=none; b=eagfM5/xJbTd5595f4Hq09M40q/5MgUtUqVh938XzZKXvwgS4e7OOoueMoON7h0yDUR4jVGEsXOuWprjm1Q/K+M2iV9csdXAaCBYFi5AbgFjZDiB8NWFdfy7aORC4rc/KB9rCdb0ehXbrRap3WjPw2F69NMZHGHZ0BpUUP2+iKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195368; c=relaxed/simple;
	bh=aPMJ7TzY2Dg+TsFr4Fv7AJOxLApsEqX6Hn4TKyXO1uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SO7SGur6UA2znWbDVt8b7xhAI0kaRsJRfKkOplPOZNzYDedWZmQY7SfOtqdD1lmr6Sll48i1Ux369Js72z4yyGmzwasJvdj3G1wBnLmyotjUovSu+g6MDzLTxcEeqoaix1zFWDZtaLy64N2i+hV9HtjuFpVaNUiZyZ609DsbZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2tT9/xc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D9EC3277B;
	Wed, 12 Jun 2024 12:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718195368;
	bh=aPMJ7TzY2Dg+TsFr4Fv7AJOxLApsEqX6Hn4TKyXO1uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k2tT9/xcri/krj9rQ0L3V9UnjefZUzMFU+lBND3HP2O8Wff3Nj1oTiVQ8W/LjwjPz
	 A2B5t3W2wTSJU5JX/nr8PSn44W2gEsr3hwfGa/00Ywy59/K64/WU1yABR8tFwI1aTT
	 TdsoyeoJs+30dmcDX4+3604AnHZZk8gndK8x7CG5ugcvXFl35X4gpAX5gBauYQZiPc
	 qmiEG+d3zSQ1z5v8hOCFAO2mtVqLNb6VCJGNELTTzkvt3NeGoQLJjFX63v+6/hIm/C
	 ctKhQVzqy1j6YK8kXI0gwAlQLA2K+/nLzpZ/hl1Udzg27Sq6vmbGEQ8OEj5EfAyxFB
	 MQW7eKbVccrrw==
From: Christian Brauner <brauner@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsi@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	jk@ozlabs.org,
	joel@jms.id.au,
	alistair@popple.id.au,
	eajames@linux.ibm.com,
	parthiban.veerasooran@microchip.com,
	christian.gromm@microchip.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Subject: Re: (subset) [PATCH RESEND 3/3] proc: Remove usage of the deprecated ida_simple_xx() API
Date: Wed, 12 Jun 2024 14:29:04 +0200
Message-ID: <20240612-mohnblume-avancieren-582d8e0e52ae@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <ae10003feb87d240163d0854de95f09e1f00be7d.1717855701.git.christophe.jaillet@wanadoo.fr>
References: <cover.1717855701.git.christophe.jaillet@wanadoo.fr> <ae10003feb87d240163d0854de95f09e1f00be7d.1717855701.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=brauner@kernel.org; h=from:subject:message-id; bh=aPMJ7TzY2Dg+TsFr4Fv7AJOxLApsEqX6Hn4TKyXO1uM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRlTpl9tfvL2dyQE3NWPjOs7Aifb7Iy6Mea2i3qORGt7 +Y82XzuekcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE9qQx/LNN/X3p7Izau73C PM631W/FPYg+MD/4sc4iNduVgh/KFgUzMny3mM8rbyTpYLVN9bCd7eyqxIuij/uu35ivtObWRd6 NifwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 08 Jun 2024 16:34:20 +0200, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_max() is inclusive. So a -1 has been added when needed.
> 
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

[3/3] proc: Remove usage of the deprecated ida_simple_xx() API
      https://git.kernel.org/vfs/vfs/c/08ce6f724ce9

