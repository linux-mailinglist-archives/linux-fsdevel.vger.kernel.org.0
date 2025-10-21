Return-Path: <linux-fsdevel+bounces-64919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA25BF6898
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC06D421C08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9DD332EBA;
	Tue, 21 Oct 2025 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izAzexJh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B747D3C465;
	Tue, 21 Oct 2025 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050953; cv=none; b=fEmbHDaeweMiHs2PzPNhgOBQlHS2DA7693+qK8GZzmL8No4c/QhuXKbiE5WyuHLEACKLQjbJSJkDrrEDIiJdEKCF3HtvBdD2YchOP/hSjPbAZDrSiz4vr+GPlhzd/J1710XLL+InrsQjYaScAKI5vhRQvqCm3ku5ganSbywGsps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050953; c=relaxed/simple;
	bh=Szcu56TTRNZm1ym9VAcT0s8t5GDHDmrpmE1+1BNZu94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTrjLrV7S/St65SzoITHek+c1/DJ5rBSY0//y1sn0afSkI+j2shPqL2mLfDYMbnxP9Atv8SJletlAR8s4PAyQPq8J5Wwpl33DQOsbGTS0LU9xjVTMhdCGoG+gEHMfDlZRu/DV/snVzzyUneQBV4D0UrVB/jrbG6XFCSuu+OIpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izAzexJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6184CC4CEF1;
	Tue, 21 Oct 2025 12:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761050951;
	bh=Szcu56TTRNZm1ym9VAcT0s8t5GDHDmrpmE1+1BNZu94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=izAzexJhzqagmLXK5wRcMQWyZRAJf8XSK8aavQnVP25v/QKGRBV10F+i9zze6WJy7
	 vC9qCFdAVDpHfZA+ZdHaGMzvXB3EVR1Z5y+s/U6SAErS9ayy7zE5qtYj31YNOi+kNz
	 4BOZaq3thw0ubJhm3s6wR3dXZEPJo2hel4LizT8DOwmJt2fCrRuA6GZ9hv8J8vk4eF
	 qhKPrKvnGDrqKroN/vFhaMugTk1OfB8nd17ait1WG8vghpDBGnk/FV7zfRon5dZFF6
	 u8Rz6TNvE4l1qMQsWiQ7E+R1I1fTCHyVE+QcfbBTRwdMRVbcmPYxUZt+wNpb9ut4nW
	 8hGaFhHltycnA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: rework I_NEW handling to operate without fences
Date: Tue, 21 Oct 2025 14:49:00 +0200
Message-ID: <20251021-staudamm-letztendlich-2100c3b719ec@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010221737.1403539-1-mjguzik@gmail.com>
References: <20251010221737.1403539-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=brauner@kernel.org; h=from:subject:message-id; bh=Szcu56TTRNZm1ym9VAcT0s8t5GDHDmrpmE1+1BNZu94=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8b7S7xxWTdVWKsekMR8Dz5LKV/adV/1zcPUWvgqVon 5nDgU+bOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay2pvhrwT/St7/wo/Nojb4 cX0+GB25R7K/4pa8Ssje6Jh3GcK2Ugx/eG1DPuTVFMssl5m1fp1WpFvFW+eAECcFp5feff+nKYi yAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 11 Oct 2025 00:17:36 +0200, Mateusz Guzik wrote:
> In the inode hash code grab the state while ->i_lock is held. If found
> to be set, synchronize the sleep once more with the lock held.
> 
> In the real world the flag is not set most of the time.
> 
> Apart from being simpler to reason about, it comes with a minor speed up
> as now clearing the flag does not require the smp_mb() fence.
> 
> [...]

Applied to the vfs-6.19.inode branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.inode branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.inode

[1/1] fs: rework I_NEW handling to operate without fences
      https://git.kernel.org/vfs/vfs/c/f5608fff035a

