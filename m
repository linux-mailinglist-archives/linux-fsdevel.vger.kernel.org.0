Return-Path: <linux-fsdevel+bounces-56388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F12B17057
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 13:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4B518C2DA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 11:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3652C08B0;
	Thu, 31 Jul 2025 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mck/8Cfv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDADD2BDC38;
	Thu, 31 Jul 2025 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961083; cv=none; b=CZCS/fCtGMnQKCArszJqShJNApkzuYjgnK4nlnNRzCVA1VjTrQGvcBtq1H97nCo8JZI5r+LswgZ7U/lQ9UXwLuMOUyZJeQCcvUPCb5gUZzqNRgWpfldrqc8O6FGEQ3G/Ys/NjU9ctDqnyKUfLFVOAyLyj293nbUMvcBVP5EN1vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961083; c=relaxed/simple;
	bh=JHSaOCbpZCUVajXOtrMAa09eXfXSlqRlabPkVQTQSsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEwc7/8aHpF72oX+olFz2c30BUQUhYYCEqzRTf8C8z7X4u4M0Rm1HnZVEo4coZvYPbPRjaoEyfRlqSs4RNvcQzJBFqyqtAHnPzII27/KnurqN7DCK+vBGR8SrrBmRKs+fMCXOtJNkaSehra9+ZEzlEmXNGT7awKLBWjYovm6Hu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mck/8Cfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4FEC4CEEF;
	Thu, 31 Jul 2025 11:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753961083;
	bh=JHSaOCbpZCUVajXOtrMAa09eXfXSlqRlabPkVQTQSsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mck/8CfvElUaoOtqb8LBXnZCEPgD1s6KrT7MuLXubFvLk9cEaSB/wPTRv0IhxhjKH
	 fPN4DnIzvwX2yZWUUEWlgMBbs5L1mqr0TbDbjReDT2Z19DQJdH41WZpxr1W9TD817o
	 InJqa3KT7pSm5iCehBG921emzvDPKbZJygXDLDHzjZcEtknSQIwUl6RZGMLfoONaXp
	 Dw7idfkvj6YDArS/kdVgTJhinkYnFou4jO5wuVQ54FqAYmSK0zQOgDtVocCSgxLoIJ
	 SsLKgVnDxVUn9/E3oETubTTEWKFaPZumkV0vugPSRkpYj+6+pX6mmQovLBQqjcyR3G
	 tNkz+fgOsayTw==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] iomap: Fix broken data integrity guarantees for O_SYNC writes
Date: Thu, 31 Jul 2025 13:24:37 +0200
Message-ID: <20250731-kultobjekt-ansagen-2961e4be4ad2@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730102840.20470-2-jack@suse.cz>
References: <20250730102840.20470-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376; i=brauner@kernel.org; h=from:subject:message-id; bh=JHSaOCbpZCUVajXOtrMAa09eXfXSlqRlabPkVQTQSsk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR0B5W5zUl4E+aw2UrzrG5eg67Had8LPus67X9xP9ywU 8Zm5naBjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkU1DEyLPtVtmGLZ8y8s07v p1u4Vnqd+hN3UjFt27P2nWcLTG+qLmP4X3BmTmCekWmvziuep59nT7eq27tgSoya3IPt3vWzvQ/ OZQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 30 Jul 2025 12:28:41 +0200, Jan Kara wrote:
> Commit d279c80e0bac ("iomap: inline iomap_dio_bio_opflags()") has broken
> the logic in iomap_dio_bio_iter() in a way that when the device does
> support FUA (or has no writeback cache) and the direct IO happens to
> freshly allocated or unwritten extents, we will *not* issue fsync after
> completing direct IO O_SYNC / O_DSYNC write because the
> IOMAP_DIO_WRITE_THROUGH flag stays mistakenly set. Fix the problem by
> clearing IOMAP_DIO_WRITE_THROUGH whenever we do not perform FUA write as
> it was originally intended.
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

[1/1] iomap: Fix broken data integrity guarantees for O_SYNC writes
      https://git.kernel.org/vfs/vfs/c/16f206eebbf8

