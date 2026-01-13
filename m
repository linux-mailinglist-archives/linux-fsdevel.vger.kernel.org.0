Return-Path: <linux-fsdevel+bounces-73388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E975D175E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75F5A3011EDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9264033986B;
	Tue, 13 Jan 2026 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4azGyq/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA7283CAF;
	Tue, 13 Jan 2026 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294057; cv=none; b=jE/4nWmQGFqVX3PQSoVV2hnLOzzwtz028J9rXq+VEef7TGVBpMpGjoyQDiwyvnsVIJOwlfLkyE+rDdKyV0KFF4Ke1Y0axX9KitkE4a8MDuIUsOYbvQ2OXuBlB9q1TW6YKJ600zORVuhjuP7DY+KgNh0zEBrkN6/khRIH95LIrc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294057; c=relaxed/simple;
	bh=vRBOsf7Kt0bzO5i/4o4BOPT4sVHHdI5Ct6nsXJ//NyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwPlm9xvdmYQvqOrDY44p0ySpCn8QQ/KNgFEtl593XqMPLBwC37uprE6Ozdy3esZuIYZ1u0OHxF+cGLQKGVpH39+gGxeET6IF6cC/3jAYzUyaj9ZIM5+QLLsGelBBXIIoP/Be6e773mSNU9JrrsvjIXqAXvaqQewNFO5Y/gu/Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4azGyq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067A1C116C6;
	Tue, 13 Jan 2026 08:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768294056;
	bh=vRBOsf7Kt0bzO5i/4o4BOPT4sVHHdI5Ct6nsXJ//NyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F4azGyq/kTpRE1aMqv2cEP5iGmdlrqDKA+5fhRa1NJgTgMa0y3YaCsWPOSvoxHIsl
	 aTD8qyPYagGMCn4fkLmllDcx1Pj9p0tLYT477nPRq0mHDbCT3+Kt2Z6zWzR/UhB+cL
	 cXkqBGq8Ubdh6QYc+gRn7KM/JC2iUPQA+5dPEaaqSN2S0HZMWqqrYE9XmD35J6yS2g
	 9iw4UMeDYQ6WARZd9PPeVRJEuCB/kKTr1wCOlzwuq7qRDnvzBJSKV8sVhmSHQbJcxY
	 Qfzam2qNwev1S1ooTszAdpHX7XB3YokBaOSDKOMGx/gCXghPi1pda5aZ0ufmjEhIRC
	 GZLsaayA24X8A==
From: Christian Brauner <brauner@kernel.org>
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] fs: improve dump_inode() to safely access inode fields
Date: Tue, 13 Jan 2026 09:47:23 +0100
Message-ID: <20260113-mietzahlungen-leuchtdioden-dd50a4fe35b8@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112181443.81286-1-ytohnuki@amazon.com>
References: <20260112181443.81286-1-ytohnuki@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=brauner@kernel.org; h=from:subject:message-id; bh=vRBOsf7Kt0bzO5i/4o4BOPT4sVHHdI5Ct6nsXJ//NyU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmsS2+0qgelGjaqJUaqDMnW+GU3Au3IsWoLG6mkB+LL l1ujVrTUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBGLUkaGs+9nbGCb+nyZ8MyL 6Tf2mC3c/PLyf/8n68IrnNw/zpd+E8zI8HXF9YjZac9Yfjcwf7P5Jufw9m/D/oA8v/ubfXazX3S cwQgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 12 Jan 2026 18:14:43 +0000, Yuto Ohnuki wrote:
> Use get_kernel_nofault() to safely access inode and related structures
> (superblock, file_system_type) to avoid crashing when the inode pointer
> is invalid. This allows the same pattern as dump_mapping().
> 
> Note: The original access method for i_state and i_count is preserved,
> as get_kernel_nofault() is unnecessary once the inode structure is
> verified accessible.
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] fs: improve dump_inode() to safely access inode fields
      https://git.kernel.org/vfs/vfs/c/92828c00fcd3

