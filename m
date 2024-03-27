Return-Path: <linux-fsdevel+bounces-15393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DCF88DD08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 13:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9A7B21EF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 12:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530F912CD98;
	Wed, 27 Mar 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/F3Z3Vv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B204312BEA0;
	Wed, 27 Mar 2024 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540871; cv=none; b=Gclzl3piGiJZS1SLzI53dF4m9aZtQE3o768dc7nA3Uxu9DfR5495z/i5VjwGFmxdRGJC9BNyLAz2TznB9tWCzUoxgWxdXozAMeHKC+7KlX4XqbWewXiTGhVYe+jN67rSWC9HYoKfT3UszVBHElwvljcMHf7ApWGyr96ref5EkaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540871; c=relaxed/simple;
	bh=05DlvcN6hxaPe1d6B3GmNcfk54T45nmDC3R6/0xzCow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRE34lsGMN3hENKFnTh4E9W/fT+RLkgnEhjlIOSzv7QfCLxKguWglsvGFpd6xJeGnmCO2PBkDbMtPEAEhTREGsRuyVmvTBa7mxC9N0FsdbDH9QneAYRat7O9eF1Wz8Ln/sCjKHhb++U+xnATewO4GQ/aL1NAwCiE2yvZTd1pUUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/F3Z3Vv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3A2C433F1;
	Wed, 27 Mar 2024 12:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711540870;
	bh=05DlvcN6hxaPe1d6B3GmNcfk54T45nmDC3R6/0xzCow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/F3Z3VvLKELHyNKDs6pmwZoPMz7xZ3yoI6ctZ/7fuJ4V6T4SZU7VzVsZMxZqPsIb
	 CWtg9aX42zRGw7MQhmMdSY/ymVYgg0hOIrQiFAt6gvzvNTRHP3Dtf3ULiM8udQFDhx
	 /IMRfZsiSOgBju7Qyaf0Q5L8RKokG4vdw/IesRLX0Xfc+vlMYYBs+W1DiPKGKo+lta
	 NPPU10D7lbohT03395DY4Y5Blyqa5BGsd6kYOFR68cFzR590Ldtw+WxGpXcO8zrx6s
	 kTk2jNDdp6YQKJpYnfmcN/WfjxgMAxFac5HZ5NxK9o4vdf4zv1xJMW8+08al3suoZV
	 z/jy3s1xoXpmQ==
From: Christian Brauner <brauner@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fs,block: yield devices early
Date: Wed, 27 Mar 2024 13:00:55 +0100
Message-ID: <20240327-desorientiert-validieren-88b2582491f7@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326-vfs-bdev-end_holder-v1-1-20af85202918@kernel.org>
References: <20240326-vfs-bdev-end_holder-v1-1-20af85202918@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; i=brauner@kernel.org; h=from:subject:message-id; bh=05DlvcN6hxaPe1d6B3GmNcfk54T45nmDC3R6/0xzCow=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSxcDXsvHn0mvo5paAU55SlNzrdzu8Lc7U61JM59c+GK x/1fynIdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzknzrDX7G8pdoTV2zmL7+7 QGWOHdPr49Jbreee0lxoZO/sHG/oIM7IsPTHy9/sx+bdkJC7mFwizffpvKSl95G/jw9/Or/wh4n QPV4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 26 Mar 2024 13:47:22 +0100, Christian Brauner wrote:
> Currently a device is only really released once the umount returns to
> userspace due to how file closing works. That ultimately could cause
> an old umount assumption to be violated that concurrent umount and mount
> don't fail. So an exclusively held device with a temporary holder should
> be yielded before the filesystem is gone. Add a helper that allows
> callers to do that. This also allows us to remove the two holder ops
> that Linus wasn't excited about.
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

[1/1] fs,block: yield devices early
      https://git.kernel.org/vfs/vfs/c/482496f606a1

