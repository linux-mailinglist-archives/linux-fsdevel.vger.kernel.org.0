Return-Path: <linux-fsdevel+bounces-26060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF658952ED2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 15:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA0B1C2418A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E456319DF9D;
	Thu, 15 Aug 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmFL2Gfm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D411714A2;
	Thu, 15 Aug 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727456; cv=none; b=N33C5nXXKtybZQucAFpwmSm0+rtX8rIzTxIgkH0CDNLYzruAlsbjta4fkk0Bc31f5lAN3RGdkRQE/ck7WkgIs0s0CZCy766NitlJ2jYiHSiDmTAE/BVx4XY542aAclbGfXUdOq6T8eevAq66gdmwGFwX4eqPEdo6hmdeD50vlFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727456; c=relaxed/simple;
	bh=5GxrifkwgDDU8FVJ7SFx02XcVFuwRfBC0Pmkg9TExfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5TQGhqT00IFfqcNNeGeDv6hKC6qvenn9AwHOLLpJhbgwCJHtWkrvlG0IBT2VfO7N9WGCMioCuyjyTIe+ZGTZ5TrKKp/KlZ1Iy/wSR6XO36oDRFcCcPEwTSk2bzON6Dg8BBZv5594oc05LePCOvOKcJN2mGwtj3Hg236OKAjV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmFL2Gfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F6EC32786;
	Thu, 15 Aug 2024 13:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723727455;
	bh=5GxrifkwgDDU8FVJ7SFx02XcVFuwRfBC0Pmkg9TExfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kmFL2GfmGcDAr5HuVoWi2j4G4gfkl4+DY5BDY3VblsMOJj6SovIowh+58I7iII6zL
	 dGHYPygUYWue2rdOzgqqmcYh4hEn9G4cjRj8OHhLJoITnKkppc3cLUfdsgpiNUHJU5
	 MwoCvvGJofO5g16wHZPe+jbIWkvdNk2SgA0Jk26KM/J0PgufzfG034lu3ALM1N70qa
	 ENL1HgA9YpEnDN41THaZUcZgCm4boSvmyICV7H41sdFoyJX5rEoajKDVXvPitcFr/2
	 nG6tlE4xXOmm7qT/r6N+Uo8Lyy8SiSi/IgNSulXIDEm0nFNmMZb0KvrhCKwoaXMiLf
	 2TsMvLz7je5Rw==
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Christian Brauner <brauner@kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] autofs: add per dentry expire timeout
Date: Thu, 15 Aug 2024 15:10:44 +0200
Message-ID: <20240815-genie-dreschen-db0d18e4d849@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814090231.963520-1-raven@themaw.net>
References: <20240814090231.963520-1-raven@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481; i=brauner@kernel.org; h=from:subject:message-id; bh=5GxrifkwgDDU8FVJ7SFx02XcVFuwRfBC0Pmkg9TExfc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTt/Rc164OMzrJQ3+U3dptEvf6//1yNfXJvxYTvOb92r DvIHCTg2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRbhuG//HKvRqmbn+Or7dL +rSs9kB8WGl4MiM7n/VM0b3fVk768ZPhnyZP+JO+wiXHv955+uH6unRXW77Pbxsj9io2bfafFrK WgQkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 14 Aug 2024 17:02:31 +0800, Ian Kent wrote:
> Add ability to set per-dentry mount expire timeout to autofs.
> 
> There are two fairly well known automounter map formats, the autofs
> format and the amd format (more or less System V and Berkley).
> 
> Some time ago Linux autofs added an amd map format parser that
> implemented a fair amount of the amd functionality. This was done
> within the autofs infrastructure and some functionality wasn't
> implemented because it either didn't make sense or required extra
> kernel changes. The idea was to restrict changes to be within the
> existing autofs functionality as much as possible and leave changes
> with a wider scope to be considered later.
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

[1/1] autofs: add per dentry expire timeout
      https://git.kernel.org/vfs/vfs/c/70089655316e

