Return-Path: <linux-fsdevel+bounces-36261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4465C9E0734
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 16:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BDCDB23648
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3682144C4;
	Mon,  2 Dec 2024 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwjKLL26"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F43208961;
	Mon,  2 Dec 2024 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149974; cv=none; b=On2CVXErK7H60wE/vnW5ep1mHZrIHhy9ocFw1TC9MIO4BYTztba7U4W+LdBimtZLN1teLjCpbCepP0Xmi0+8E2YgUkmym2qpdJrzDT2ISJ5FG4k5mKxTZGVJD0zAurhogFGlu9r8n4izzebnurFNd/o03NK8oiZLzpuduOoGHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149974; c=relaxed/simple;
	bh=PFDcKh2Yc1TSoI97ey1UuU8Gn+EMMcBK8Q8pgOy+Huk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=os1s8mB0z6hriT32di6nbW7AdkiK+s974KZdzsezUVmMcRmEX+SINy3uYQxkjscK7ejI6SQ5QhqnckutVNBmGeOOhpaVzpDt3KOtg2fygzikZe5Vs4OYxgc+A+fQE3WQpPbsbqeTXAWG+yRPR3ZwUB1ciVbQpoiPCRP5fTX+Nyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwjKLL26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C97C4CED1;
	Mon,  2 Dec 2024 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149974;
	bh=PFDcKh2Yc1TSoI97ey1UuU8Gn+EMMcBK8Q8pgOy+Huk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwjKLL26SMa06STEA8hjFNBvkpC1GJ83S5cMQg0pRehM63S5dziGCiJNQ4kPC/zQG
	 8fEUKF4v3bLUv3Jsx7CW5g/u6KB/AUqWWdaScasEFRJIBNjMG58C2akDOXgJA+FREi
	 ycFYa9hDIj4io2B7S+gJJ7s6hvktKHplSmKnfoy6PnAeLhm9OLWVoyLrnSN3KqI5gU
	 SO7CPyWdVm5KWMHV28eLAlh7Ql5C12sbYUsIC96jMDS8Ngu8IM0wCYT/8jX2Fu1GbU
	 AfWmCAZiiGYQ1V5Ii+hMq/TreTrmxNLeyjYGvnasPzHVDwSv4cPhSS6bCCko4d2EO5
	 /Gmy0ZCrtqv4g==
From: Christian Brauner <brauner@kernel.org>
To: Leo Stone <leocstone@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com,
	sandeen@redhat.com,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	quic_jjohnson@quicinc.com
Subject: Re: [PATCH v2] hfs: Sanity check the root record
Date: Mon,  2 Dec 2024 15:32:39 +0100
Message-ID: <20241202-enthalten-elternabend-073d14f9889b@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201051420.77858-1-leocstone@gmail.com>
References: <20241201051420.77858-1-leocstone@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=brauner@kernel.org; h=from:subject:message-id; bh=PFDcKh2Yc1TSoI97ey1UuU8Gn+EMMcBK8Q8pgOy+Huk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT7HuU/+vPIPI+Tu96najpeU/f5YPVHooAxessaJ8WnC xj22HvkdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEdy7DXzHNmpJzH69usq43 2LPqkEPeZZeq+euum/25frblGu/xrVmMDFtcJcx5nZSSLQyjbiS17/C2MVj3XfqGe4rJz93rtDp KmAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 30 Nov 2024 21:14:19 -0800, Leo Stone wrote:
> In the syzbot reproducer, the hfs_cat_rec for the root dir has type
> HFS_CDR_FIL after being read with hfs_bnode_read() in hfs_super_fill().
> This indicates it should be used as an hfs_cat_file, which is 102 bytes.
> Only the first 70 bytes of that struct are initialized, however,
> because the entrylength passed into hfs_bnode_read() is still the length of
> a directory record. This causes uninitialized values to be used later on,
> when the hfs_cat_rec union is treated as the larger hfs_cat_file struct.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] hfs: Sanity check the root record
      https://git.kernel.org/vfs/vfs/c/b905bafdea21

