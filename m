Return-Path: <linux-fsdevel+bounces-12220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A760185D26F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C9228614D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 08:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B4B3BB37;
	Wed, 21 Feb 2024 08:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebPsFqpm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9225F3B1B7
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708503751; cv=none; b=Z+WA/11gURTMdtRgheZ/XRlgyGmOAckY60qpln+bsYJNYpxjsAWpc9p5N26NvporghHwzA9HkQ6OqAGbkcwV/QCClL1EwVtYAa2ubgJDXUJuaBFr6mCsjuSLmFPZF+nEFTFqlUAJV3lQWREAS8Uy5rJ97X5wMAaLx4rbGaAzxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708503751; c=relaxed/simple;
	bh=5+tnmNljxVod9NGskVeAlQZGDF9IWKFXJznsSe9F4gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dx64oqpZMdgWkQyoEZsOm/HiPuLyFsfQdaem0LdYkGGSIQBOIEgrvTSiLynbFCxWO77ybP3enLHNP3zo4yTWr2TzaVBFgD6XS9oI6zhKDGeOphbl3OfXM8zAAVj40j7PTpqlS7oelG5xvOl7EywzzZcXnlivuYc9x9r7Uc4Mxr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebPsFqpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2E0C433F1;
	Wed, 21 Feb 2024 08:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708503750;
	bh=5+tnmNljxVod9NGskVeAlQZGDF9IWKFXJznsSe9F4gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ebPsFqpmdXgnBBa5p4hDbazM9D8SsYC+sHARah32NjwFBMU6siMJ7Xt4K0ZfWXoa6
	 758PbnwP9GCV3eaxm1gAhdkymZgQL6yBxQZiwo7XzzOgc/fqs2oL7Ui6/GgZLdKxja
	 iRE5uvLVpUkDtDP/ct5R3VG5rjD5K0iUZ3zGvVVy2Brl8vGG1K+I3yAJxWPV1s+IEh
	 4NMOVaNlj/ScpIN0o7P8M5VTB7+fRYUZJTyeLr/C6OCsg8amFcAFG8apnzNmJdhrOG
	 cMPmQRJoYeDkmg9qENDPrHCaLIBREp8wjNNNLmfQ3vOnO0o/Ze0HuTyXdXgaK9Xuhy
	 z3FQ8OCDK20ZQ==
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Bill O'Donnell <billodo@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Convert coda to use the new mount API
Date: Wed, 21 Feb 2024 09:21:31 +0100
Message-ID: <20240221-podest-abbaden-74cf07baf6f1@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2d1374cc-6b52-49ff-97d5-670709f54eae@redhat.com>
References: <2d1374cc-6b52-49ff-97d5-670709f54eae@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=brauner@kernel.org; h=from:subject:message-id; bh=5+tnmNljxVod9NGskVeAlQZGDF9IWKFXJznsSe9F4gc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRe3bRny7MDsRl2c3hX7Gs7qNiz5EzRY+nH/rob1iwK+ 1v1zD4gs6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAifh6MDJP3laxqDzC6Lli5 a5H8h/Tn22WERF5PW3pa35TtptT2os+MDI9ELmtMl1T9VMKTplY+M6GtKmOJcmi2rQgfU2mRwao SBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 15:13:50 -0600, Eric Sandeen wrote:
> Convert the coda filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
> 
> See Documentation/filesystems/mount_api.rst for more information.
> 
> [...]

If I'm not supposed to take this let me know.

---

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

[1/1] Convert coda to use the new mount API
      https://git.kernel.org/vfs/vfs/c/059eec81913e

