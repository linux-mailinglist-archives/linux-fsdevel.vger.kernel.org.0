Return-Path: <linux-fsdevel+bounces-66291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B1AC1A8C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7E8F5094AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FB62FB97F;
	Wed, 29 Oct 2025 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8/tgfN1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B512DA740;
	Wed, 29 Oct 2025 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742318; cv=none; b=rHnKhgR0QRacN95DC3wSZG8EMpp4QPPo1i71CpmoZZiKB155k7lxBlUYbGeMnZxX2m12HRNcpvC64qa3zGEa7EGIoSt+K+SAbx97YskRGQ2/ckBHC+LrOTWw7wKK81/XNAlcxPXwuhjuPjufX5Asit01lPrHzWCtGnr8eUXNgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742318; c=relaxed/simple;
	bh=trgHu+OgJ4YBzaEsKqjIc/+pTNH39DWYH/f9B8ikyNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4IeHHfStDgfHHrhSVlL0/l97iOOaYA4GdOAMH+kH2fTRxD6XCoact1KKVqmGogRoRP0QOFiWF5ou60QCWH60qungeUtTdLQIhTfaXDAnu7kQGB+o2FJqYmadbZVd3afjcW8RxPaQINvLrwJV/rWkmR+VxBQRt5Cx2tXAnN7Loo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8/tgfN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E79EC4CEF7;
	Wed, 29 Oct 2025 12:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761742317;
	bh=trgHu+OgJ4YBzaEsKqjIc/+pTNH39DWYH/f9B8ikyNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U8/tgfN13n5SydJrSW2k3LUUZ4eNIY1HRTg1ElVY4cFXgSwpF0WWZ9eZPJU9ZckWD
	 lrb+ZAdbOozpfCIZ6Plzz02XXRPppgLj11zXJqYIYtqUTFP9PGISISqkaLAL7noOwJ
	 DNBmzZBaEDdycuFtLFh1LDJZBp/Z7P8P/GazUFK9EvbjNl0RCbuLwOETxpzAWRq75Q
	 FDkIuyQQ69dyVgUy68pgIR79nokhh0WBbwwSklr6vtSrVqj4ze/KAI4Owi+INz0co2
	 ZjVVXWHthyRqJ2kYOXa9ESLoVfQULwHffsr1Aq5RVYtEKtXZZIIKhHpIMWTBrtCU+d
	 JnGJ9PQRlW96Q==
From: Christian Brauner <brauner@kernel.org>
To: Markus Suvanto <markus.suvanto@gmail.com>,
	David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix dynamic lookup to fail on cell lookup failure
Date: Wed, 29 Oct 2025 13:51:52 +0100
Message-ID: <20251029-abgibt-bisweilen-e4d33dc3dbbe@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1784747.1761158912@warthog.procyon.org.uk>
References: <1784747.1761158912@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=brauner@kernel.org; h=from:subject:message-id; bh=trgHu+OgJ4YBzaEsKqjIc/+pTNH39DWYH/f9B8ikyNE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQy8b68z32Ip9M04kNPV1Hass8fRYxbVneXvNPyPlQTo q426d/VjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlImTIyPLzqsyNa8O9zoS1+ cVUrTcI7v9hG13X9O1/okseu3K3/n5Fh+gLuR1xVW1IK/ViqEyXKVV84/VUT2La1p5Gl6Zy0jQE 3AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 22 Oct 2025 19:48:32 +0100, David Howells wrote:
> When a process tries to access an entry in /afs, normally what happens is
> that an automount dentry is created by ->lookup() and then triggered, which
> jumps through the ->d_automount() op.  Currently, afs_dynroot_lookup() does
> not do cell DNS lookup, leaving that to afs_d_automount() to perform -
> however, it is possible to use access() or stat() on the automount point,
> which will always return successfully, have briefly created an afs_cell
> record if one did not already exist.
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

[1/1] afs: Fix dynamic lookup to fail on cell lookup failure
      https://git.kernel.org/vfs/vfs/c/330e2c514823

