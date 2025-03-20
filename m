Return-Path: <linux-fsdevel+bounces-44593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43ABA6A875
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689B41B6059E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D4B222580;
	Thu, 20 Mar 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBeojsTi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA767FBD6;
	Thu, 20 Mar 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480352; cv=none; b=WffuCy1oOSJ1tTvyUKDNpzMwAitLN0zXBhPFoqJu3+HEEzT9wcbCjz/9Cb52DgMQ2sR2N7Uu6VcZTtrzJfHtJgs4KOF/rcqPSTF+5OcDQ1i56B0bI+L6w79WdIkWGbBierPbeHFCEX2Rdo3O0rTMWtzvuHVYc38RR+pC2tY83/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480352; c=relaxed/simple;
	bh=ykMiPvcTwQMVIvfcRVO0FVXDV8aKd7Cnvgwwftoy0Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGMnyb0H1FDE6nTtUfguI6sTt7G0IFGFy7Pq0UQ6c+AKjYRajOxwrYvVgXsgZRPx794T955uxF0Fi2Jbz4HxNQu73Hqph37aFRZ7dw0NNzCWtGWvHZiZAGSb7O/Snt8oQVwLihEsP+XDnW3Lv52q6muqIbDC2a2DOCuBWAdKy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBeojsTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908BFC4CEDD;
	Thu, 20 Mar 2025 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742480352;
	bh=ykMiPvcTwQMVIvfcRVO0FVXDV8aKd7Cnvgwwftoy0Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZBeojsTi8VAKDev+l82UocdghtoV0RcrCHY2iNl+/4OYj7NrCjyeMxGJcFoEnlX+3
	 Q1rJwsOCJ0MyJNhd6xHkkAuTI/BQ06ljhebXaJC1ZCatxIEKnIYqypifRgNFR+QvRQ
	 l7oMYrpY0DhgZEruwNYYaRw3DAiFsDonVGSpbDH3bxbTG7Vl27XgmBXkB9e8vGNk9V
	 lMmFFqUBRMgS7MxpLcwm2YZW3rhb7bpMYWIDUhBnwF5YuUHfI7G+E5IkeElgZ2dYTk
	 dLO8dDe3Zmxy6ai8P8yqmE3NZaGyazvCsT2sCHICIwkS6pZeP4f8wVBKlpl1Yeon76
	 GsChH/oB1W+uw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: sort out fd allocation vs dup2 race commentary, take 2
Date: Thu, 20 Mar 2025 15:19:06 +0100
Message-ID: <20250320-glitzer-losung-a9d47764b766@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250320102637.1924183-1-mjguzik@gmail.com>
References: <20250320102637.1924183-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=brauner@kernel.org; h=from:subject:message-id; bh=ykMiPvcTwQMVIvfcRVO0FVXDV8aKd7Cnvgwwftoy0Ew=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfUb6VUC7Sq7/TnTtW/Tj789xvnlNefoya8bcmKuJHf tuRGfNfdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkYjDDP02Xbu270/O1K6pE BXfFx7A7nXmdu6jjjGFrz6vQj2uaFjH84Zq0wcZ59vvEwuOX7ioLZV5/uqQqZ4tYcOvMpxekG3R 6mAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 20 Mar 2025 11:26:37 +0100, Mateusz Guzik wrote:
> fd_install() has a questionable comment above it.
> 
> While it correctly points out a possible race against dup2(), it states:
> > We need to detect this and fput() the struct file we are about to
> > overwrite in this case.
> >
> > It should never happen - if we allow dup2() do it, _really_ bad things
> > will follow.
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] fs: sort out fd allocation vs dup2 race commentary, take 2
      https://git.kernel.org/vfs/vfs/c/4dec4f91359c

