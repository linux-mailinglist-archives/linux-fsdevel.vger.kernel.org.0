Return-Path: <linux-fsdevel+bounces-44418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C42F6A686A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A599A7A5A6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E32250C18;
	Wed, 19 Mar 2025 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5eVenJ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8A250C00;
	Wed, 19 Mar 2025 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372604; cv=none; b=lHQv9F6coUrRCvHxwzwOmCnOQehLIQuhrgBcca2rsJISuDJWWiUR0MiJ0pp+iPbzZwM07zoyS7gmEgfXIh18eb1c+KTf8HpFgXJhQmBnrCk0W3AdmHqKmQxdwrvn4SEpVhwaI+fd7YfxSJLUuPI5bCINr+y+wa27ogaqG8Hy4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372604; c=relaxed/simple;
	bh=E/A+U8CK9cL5sTDTTQWLtcLh51j40uskyQwk1pU+gQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsK/XxQUqlg9FkW/W+iggGEDawc4/tkXHtUrgA5iZGpmk/SOqL6Lzp01YqA1RA+4A80rbROfgErb6H3Lsr37Spn+yNDOOcvyqGMRM+kKDTQ3/8JTSZOXhRmPr5KtDPbQPyMVI8KsSAkNT9/EwpBIWPz24eJBy0vm0txHe3X0Tuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5eVenJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFB6C4CEE9;
	Wed, 19 Mar 2025 08:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742372604;
	bh=E/A+U8CK9cL5sTDTTQWLtcLh51j40uskyQwk1pU+gQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5eVenJ1Rbbdc5uiKIoPWzFevkS7MB5O4kiieDAboX4Xl4ddn4xZNhLmNtK54tQDb
	 JLqvfmGNWxTQWHJwWfAZGNplCC+Yy122t1X/UsNjK8aMHb0JGIpoStJU8PXTt7ytxe
	 DY0cuiq5DSlr8T+jCa6ZXK3FFEmoJoFv11F7ZHNZvDMVwWtaePGXybR1ntigMh5GyX
	 aM/9tXw4XFlsLKFQhTRpmCZGXS4btzFbT36ACVGi/LH7Rgb01yDsareyQygKekaxZm
	 tObs3EK+n9pt+jRCF4z1w5mZ2doQ7Hg3wShkWblhg3udAnw4jVb4VLP84o4ZYP3S79
	 MbyDy/Ok0c9Xg==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix afs_atcell_get_link() to check if ws_cell is unset first
Date: Wed, 19 Mar 2025 09:23:16 +0100
Message-ID: <20250319-ahornbaum-beinbruch-d4d7048ef45e@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2481796.1742296819@warthog.procyon.org.uk>
References: <2481796.1742296819@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=brauner@kernel.org; h=from:subject:message-id; bh=E/A+U8CK9cL5sTDTTQWLtcLh51j40uskyQwk1pU+gQs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfqvumtmhH2DXLxzMK1l7d7Ob5LMbq4fnA0zfCDa+/r fMM9TmxuKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiX58xMkx5NrP+Ff9l0b/e L6Yy1a1cOVvkzbm4gIN6KSteti37/iyVkeGK5/6ZcmWRdU9cM/zl/rz757VzTmGP9ZqD6Ve5OIr fNvMCAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 18 Mar 2025 11:20:19 +0000, David Howells wrote:
> Fix afs_atcell_get_link() to check if the workstation cell is unset before
> doing the RCU pathwalk bit where we dereference that.
> 
> 

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

[1/1] afs: Fix afs_atcell_get_link() to check if ws_cell is unset first
      https://git.kernel.org/vfs/vfs/c/0307d16f3610

