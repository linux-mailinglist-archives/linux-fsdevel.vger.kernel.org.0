Return-Path: <linux-fsdevel+bounces-36221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6238C9DF9C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 05:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B21F16222B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 04:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C569A38DE9;
	Mon,  2 Dec 2024 04:04:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pinero.vault24.org (pinero.vault24.org [69.164.212.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66C8EC4
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 04:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.212.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733112262; cv=none; b=q2hMvL7BQX3t1nCU8sl+LAdSFmtlp33ELsTre+eygFS1RK4N8dSEaGI2rPg/NUHhcxJbTQdciymAJCSu+n9jVdbarFzU+H1NAXUjHIOCmlgh/muOnXj5USKMYm5EZAt2ZWZdN7GuIB5lBkBiTWFxhza6HAgKdp8WF5y/NEvGWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733112262; c=relaxed/simple;
	bh=zmSjiBu17QssDLVOHMVjNPv/mHxJyJGQWS5XVrzO3Ck=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oMefoRTXTl97S/hyhCr7TSYmi6cfjVdZ1t2mRG45BEgqpq3wEou4CL3DaF4Pk/B9xynHXhOT7jrZSBfttJKMd3HPpRSsYaKtkkpFrkmKNZVPn8GY5JR+zZ6EwdeKpVMs0YpGW+h9wBczyBIZZybf4prfGuCeKdywmlG54UqdmsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vault24.org; spf=pass smtp.mailfrom=vault24.org; arc=none smtp.client-ip=69.164.212.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vault24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vault24.org
Received: from feynman.vault24.org (unknown [76.20.183.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by pinero.vault24.org (Postfix) with ESMTPS id F15B760B1
	for <linux-fsdevel@vger.kernel.org>; Sun, 01 Dec 2024 22:57:59 -0500 (EST)
Received: by feynman.vault24.org (Postfix, from userid 1000)
	id 3FF0A6D5EF; Sun, 01 Dec 2024 22:57:59 -0500 (EST)
Date: Sun, 1 Dec 2024 22:57:59 -0500
From: Jon DeVree <nuxi@vault24.org>
To: linux-fsdevel@vger.kernel.org
Subject: [BUG] 2038 warning is not printed with new mount API
Message-ID: <Z00wR_eFKZvxFJFW@feynman.vault24.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

When using the old mount API, the linux kernel displays a warning for
filesystems that lack support for timestamps after 2038. This same
warning does not display when using the new mount API
(fsopen/fsconfig/fsmount)

util-linux 2.39 and higher use the new mount API when available which
means the warning is effectively invisible for distributions with the
newer util-linux.

I noticed this after upgrading a box from Debian Bookworm to Trixie, but
its also reproducible with stock upstream kernels.

From a box running a vanilla 6.1 kernel:

With util-linux 2.38.1 (old mount API)
[11526.615241] loop0: detected capacity change from 0 to 6291456
[11526.618049] XFS (loop0): Mounting V5 Filesystem
[11526.621376] XFS (loop0): Ending clean mount
[11526.621600] xfs filesystem being mounted at /mnt supports timestamps until 2038 (0x7fffffff)
[11530.275460] XFS (loop0): Unmounting Filesystem

With util-linux 2.39.4 (new mount API)
[11544.063381] loop0: detected capacity change from 0 to 6291456
[11544.066295] XFS (loop0): Mounting V5 Filesystem
[11544.069596] XFS (loop0): Ending clean mount
[11545.527687] XFS (loop0): Unmounting Filesystem

With util-linux 2.40.2 (new mount API)
[11550.718647] loop0: detected capacity change from 0 to 6291456
[11550.722105] XFS (loop0): Mounting V5 Filesystem
[11550.725297] XFS (loop0): Ending clean mount
[11552.009042] XFS (loop0): Unmounting Filesystem

All of them were mounting the same filesystem image that was created
with: mkfs.xfs -m bigtime=0

If play games with seccomp to hide the new mount APIs from util-linux,
it will fall back to the old mount API and the warning prints again.
-- 
Jon
Doge Wrangler
X(7): A program for managing terminal windows. See also screen(1) and tmux(1).

