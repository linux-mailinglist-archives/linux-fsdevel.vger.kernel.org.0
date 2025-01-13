Return-Path: <linux-fsdevel+bounces-39044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25912A0BA22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF7B3A1B1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3139246344;
	Mon, 13 Jan 2025 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlM6IauN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DA922DFB5;
	Mon, 13 Jan 2025 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779214; cv=none; b=a4xFPZMRDDmgBG4RQCen2LOS6OjO4LqpT1zd/XXughapPN2M/0+2MZV0PK9SXTOL7/72tVxQ0sMQXTlayH4Zt3W2MWcBSlNMlfGTyKuSMc5//RFIFI1Kofi0yRNthga03YjF3QpYoqMjSs7kRLwztJJTcT5gGOvp1RzkIDT/qEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779214; c=relaxed/simple;
	bh=LXLnwsUoapd7rB4MXtppWJ/94xPhiTZNAMTipBuP1bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b28MHzabP1Rm36GXQugq45SqPblu46Z35rDtOA1TvKvytnT2KmVbnabxz/Boy3cn+k7oD9QQo9XjKX+d6M4N9HYh8sYWYHoMDmShCx71Q4w8av11t+vULAh/Z41OpPsYZQ2GFVXGGLTqQiC8HETApzINhnVO62TVEAOX/eRYqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlM6IauN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8E7C4CED6;
	Mon, 13 Jan 2025 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736779213;
	bh=LXLnwsUoapd7rB4MXtppWJ/94xPhiTZNAMTipBuP1bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nlM6IauN5qYlDDo4U7ZhhsBv5Ok1CYmeBYJAmeDupHgXGneA26VqJJSTqSRAKJ9Pv
	 RiPP/OuRNq1MX+RWrq1yTWckWwvvLbPelYQbf4Fehf8urTpzFqTgk99izZ+LEncos/
	 CBgg6qY0/kfUmKQEDrMah+NwNJDngF1laqmmZbULZ1IPTGC269FfXZ/Lr7aKInCVT8
	 v997u48DODE2Sd7fn0NS4qB5ConucOopQD/p5uq0btvPHIme9y9CiVPkzh5OK/Xj+7
	 jBAu/EAEOB1yvFAvUZcJ41gEeWGcwMg7tkqvexy4VVp+hCGiiN2R52TKhdy+nE2uH9
	 ZlG6I9UvtmFmw==
From: Christian Brauner <brauner@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] select: Fix unbalanced user_access_end()
Date: Mon, 13 Jan 2025 15:39:56 +0100
Message-ID: <20250113-sitzreihen-dezernat-86551af2a480@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <a7139e28d767a13e667ee3c79599a8047222ef36.1736751221.git.christophe.leroy@csgroup.eu>
References: <a7139e28d767a13e667ee3c79599a8047222ef36.1736751221.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168; i=brauner@kernel.org; h=from:subject:message-id; bh=LXLnwsUoapd7rB4MXtppWJ/94xPhiTZNAMTipBuP1bM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS3qp5gyGz4k7n9RtSLbwu4Q8Nq1K7ONS75vXnOJS31F HcphdWHO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDaEi1MAJrJ9B8N/T8slD2264hU27rFs j7XdOE1t5uas49fy1b8yFfwXZbfaw/BXKuMfa4ld7eOD8W1bGTviM5oPHW+2uNS+eMXbDyqhbem 8AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 13 Jan 2025 09:37:24 +0100, Christophe Leroy wrote:
> While working on implementing user access validation on powerpc
> I got the following warnings on a pmac32_defconfig build:
> 
> 	  CC      fs/select.o
> 	fs/select.o: warning: objtool: sys_pselect6+0x1bc: redundant UACCESS disable
> 	fs/select.o: warning: objtool: sys_pselect6_time32+0x1bc: redundant UACCESS disable
> 
> [...]

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

[1/1] select: Fix unbalanced user_access_end()
      https://git.kernel.org/vfs/vfs/c/83e724bcabc5

