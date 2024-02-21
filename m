Return-Path: <linux-fsdevel+bounces-12266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF5985DB6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 14:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6937A28372A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B7778B4A;
	Wed, 21 Feb 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCD33a83"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EBB1E4B2
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522881; cv=none; b=Q2XcNH+1X7EWw8tveLv7bVCC1qdz2H89tN4c+8mg2ge+CE87jR8xU5sZKmP2GdNfvGIfV/VhqEN428uZ6y/jUsdf/GPhDu6E/vmaGDpGmYFAhbpnWlTQZhCbCiAtc9xdrNFud8yR/D2vk4tjOG1AoTSAOalepSNmo9JLvnKdzU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522881; c=relaxed/simple;
	bh=DLZjN0IABD/QcAekm0SzL8sn+qu3LEWEMqutZAPtYfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPQIl+bukck6BHHsM9+1UnSSiaC6IehvkvzOnceTeRduYGaCFslD1D7Hr7jARPHE3k5JQKD/rmOI630iwPM70RZ0BDTijcmvQelZlRtpmnYtFJ00JTWxgnYQLC7jf7VgjZqgalwgbOTn7ILoljPCmAPsOeSeXmTDIWgfmwUx5zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCD33a83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D47EC433C7;
	Wed, 21 Feb 2024 13:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708522881;
	bh=DLZjN0IABD/QcAekm0SzL8sn+qu3LEWEMqutZAPtYfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCD33a831DvJBbTS1PKgBkPRsQLrAzlMIUZpv1btTBSYjEEhHdjikTkCBQD8Hz9qf
	 Rndc6wAmkVmgYkgXyTu4Dp9Y2j5RWHPBltJ/gPOhI2H/ghy2qlVcMoNXmEDjjtAIKv
	 C3XaRn0ctgf3I7lErhEn+le3pHqlL13unXeis/ETXJ5tS7dbwYiKjXC+XdKld6Kg01
	 XhzLjo5j8XSTtEMlZdmAYluThIQeeolEr8tOgSYa6bgc9FDd6S8tGD/KSeQ+WUpg0+
	 VskGUwEgQkzKpZVIgzISfo5dNOZjdwOa8pWRJM4T0CJjgYMaCMitIkqSpnfz96Di/z
	 oZ7nMJZbT3T2Q==
From: Christian Brauner <brauner@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: Re: (subset) [PATCH 2/2] eventpoll: prefer kfree_rcu() in __ep_remove()
Date: Wed, 21 Feb 2024 14:39:37 +0100
Message-ID: <20240221-ebnen-gebacken-b7cda0ed075e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221112205.48389-2-dmantipov@yandex.ru>
References: <20240221112205.48389-1-dmantipov@yandex.ru> <20240221112205.48389-2-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=brauner@kernel.org; h=from:subject:message-id; bh=DLZjN0IABD/QcAekm0SzL8sn+qu3LEWEMqutZAPtYfw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRe/Vv9msmeY6mXu4jdVd9LbDH//RMW93Nvnlp7x02R+ 92zTds2d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk3UNGhtXT7yR9NE0yeF8+ beed13tlOy+GrH8y/3TQG5U5qbVZygcYGRZvvLapObzUdFdzAGf79UsZ6ae3G3d+avp8jXW3eej +LXwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 21 Feb 2024 14:22:05 +0300, Dmitry Antipov wrote:
> In '__ep_remove()', prefer 'kfree_rcu()' over 'call_rcu()' with
> dummy 'epi_rcu_free()' callback. This follows commit 878c391f74d6
> ("fs: prefer kfree_rcu() in fasync_remove_entry()") and should not
> be backported to stable as well.
> 
> 

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

[2/2] eventpoll: prefer kfree_rcu() in __ep_remove()
      https://git.kernel.org/vfs/vfs/c/486a793c866f

