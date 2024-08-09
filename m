Return-Path: <linux-fsdevel+bounces-25504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1228E94CC38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 10:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90116B2514A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 08:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9148A18DF77;
	Fri,  9 Aug 2024 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQVq0oVO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23DE1863F;
	Fri,  9 Aug 2024 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192252; cv=none; b=oRtVKLHbAG9Wltra02L23LwSO/7md7FlUaJt1jeIRLRRavP7LxbQ5vzjLqZtTH+8YWncQDc2lgmTBE5TXlRR/cXiG/8xsCg3OKN5nN1sUHdU45b8/inI9QTlkAqAEBfqFGpo9Po8u98gnANhUjJnfzncc110Cla180WhO4b5S9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192252; c=relaxed/simple;
	bh=bot++aTeRZfnvfp+MoFCyBDJ+H2oRT7IxXulr5OLvkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnAzhHr2quT6g1kIpmZIQ0T8zRBWPkuXjiWqzAu3rJr2AW5WGIIq+X8qXkXFxCjJSI4k1jR/AZ4HoXxwRRFTDhkg7MGHcyesFmv0RvidZ7wCQYDFPm5b4OwI381EzdK2OgMW3ADI2olOD4dFWxVneiqaRTxGls02FRAsStygsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQVq0oVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3BDC32782;
	Fri,  9 Aug 2024 08:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723192251;
	bh=bot++aTeRZfnvfp+MoFCyBDJ+H2oRT7IxXulr5OLvkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQVq0oVOBaD6CdJMdqQ6AQK1KJU9QsgRV3CdXBJ6CCtczUmrlGMy6XJMJz+GRwL4r
	 Akm21TNppzTnRsXhc9j0iMHnG7BgIcjPqdxMpzZPHZ8pU0lrak9jk68BCjx8siuEm9
	 i1WzuO//1Z/4VfoWOyOppjfICThVjpLZYVh1IUJR+G1+f0rkS9lB//fjjIoAV2y7P8
	 0nXBokc35E3kCoynm4hn1dUdK/O8DI8RISuiIPOjxFFBpXhrD9n2pabk+VdVnXRVFS
	 Rh8JIHq8KrrVfOwAsFAwkGAZrvEd/6LxozDYQVD40hXlM2NrU0QoYvN4TW80MvFCwA
	 1Zp0ZDNb59Ytw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: only read fops once in fops_get/put
Date: Fri,  9 Aug 2024 10:30:42 +0200
Message-ID: <20240809-kompendium-zylinder-270cabc854d4@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808155429.1080545-1-mjguzik@gmail.com>
References: <20240808155429.1080545-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=brauner@kernel.org; h=from:subject:message-id; bh=bot++aTeRZfnvfp+MoFCyBDJ+H2oRT7IxXulr5OLvkI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRtvbzZL7i7rEYqY0vA6emau5sWrL90vvib98Odwc/m6 XxpW770YkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEzsxmZHjckla196xI/FHR 7r9sbQKv6kqiHE76vt2iwC16+U5sRBTDf0erDrl5PWzNp68VHWC8UOOju6C819Uyb1mEtPpxkQB DVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 08 Aug 2024 17:54:28 +0200, Mateusz Guzik wrote:
> The compiler emits 2 access in fops_get(), put is patched to maintain some
> consistency.
> 
> This makes do_dentry_open() go down from 1177 to 1154 bytes.
> 
> This popped up due to false-sharing where loads from inode->i_fop end up
> bouncing a cacheline on parallel open. While this is going to be fixed,
> the spurious load does not need to be there.
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

[1/1] vfs: only read fops once in fops_get/put
      https://git.kernel.org/vfs/vfs/c/2a2dc5eb79c4

