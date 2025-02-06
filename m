Return-Path: <linux-fsdevel+bounces-41066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C47A2A899
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 13:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC251885538
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22D522DF93;
	Thu,  6 Feb 2025 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKOeWMDQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE47A59;
	Thu,  6 Feb 2025 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738845346; cv=none; b=iDmhN5gXFaJvv6rAzy5zoz0fH6m9i0dyfx3z0+YIDEJLOpAeKybfX3vPgXSVvbgRLxQ53Q99JEI9SGmF4bvgmpZEMPiQRXtsTuspBuUVv2bBt2aS/W0ge7dr1qnfDDIgvUF6KQuf3C2fcpeAPPB06ZvdIkX5LBc9QLtnBEZw3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738845346; c=relaxed/simple;
	bh=EBxdpJegjXjeyb/qVTWCqv0DJ6+TWFh4u6fWtLxgkBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKdiVneKe82x4R8QMpQD0f0886I0bZoxoNhDxjVkvw8vDT3qgkVH9onyqPgnSDCm0XsnSnEux3mH1BLMuo1aAbJBQYFDrCg+8knklWtB6AMvyP1B/Vv14YOnMRMnCtKewHspdzIalXNk2NFEOYsgc5PnCXSwv1LKXvI0F+6mBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKOeWMDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D52EC4CEDD;
	Thu,  6 Feb 2025 12:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738845345;
	bh=EBxdpJegjXjeyb/qVTWCqv0DJ6+TWFh4u6fWtLxgkBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MKOeWMDQD9Ml/WCPQPM2mOJ4WOdrigzg83WycAsdBBwy0P9K4OeCoVkdKrFmeSTv6
	 3MukEnQVpISlwe7nzDKBm846D7eKr5musuIfksf3NDwc1ZqqSxVCCJXHhnqtWWYQEm
	 82rqhQOO8/w5fV5yYFCnBPFbkfPV9SurfUJjBc6F/yBQLPJnE7j6TanB9sACsKBLwM
	 MipJOj8YWrJH0pQojdSrV7D8FdxKCUzb+K5aCrQs8P2/vfS9isRwpKj6J9IT5NJLOF
	 N1OqVapzcW9Zpw/74PU2Et3TRa6AnbyfzPpvUeYqtNQ97yie8lI3N9wONKbBWyGlIA
	 Va79Vph0alayg==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: (subset) [PATCH 06/19] VFS: repack DENTRY_ flags.
Date: Thu,  6 Feb 2025 13:34:53 +0100
Message-ID: <20250206-axthieb-winden-0a179d554651@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206054504.2950516-7-neilb@suse.de>
References: <20250206054504.2950516-1-neilb@suse.de> <20250206054504.2950516-7-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=brauner@kernel.org; h=from:subject:message-id; bh=EBxdpJegjXjeyb/qVTWCqv0DJ6+TWFh4u6fWtLxgkBw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQvWTN1vafyie7Ch0+/fPZSN5l9rrJoE1v8ihU2e0Nk1 y99aqOm2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRwGyG/w7Fxopi7mLGrQn3 LscvnRy/auWPVVsC8rgbD234GaI+7xUjw6a8CR7PLNZvy+H4I3jmVrnCKb6a419cjNLF3shlHGH 4xQ8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 06 Feb 2025 16:42:43 +1100, NeilBrown wrote:
> Bits 13, 23, 24, and 27 are not used.  Move all those holes to the end.
> 
> 

This is a useful cleanup independent of the rest of the series.

---

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

[06/19] VFS: repack DENTRY_ flags.
        https://git.kernel.org/vfs/vfs/c/893dd4ccbb7b

