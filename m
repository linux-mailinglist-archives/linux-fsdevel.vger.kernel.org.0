Return-Path: <linux-fsdevel+bounces-33486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABE59B95B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 17:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937B91C21F27
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 16:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA281C9DFE;
	Fri,  1 Nov 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UbaFMRZc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283AF1487E3;
	Fri,  1 Nov 2024 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479410; cv=none; b=S6Nqjyy37gfRoykq7vp4An5Y6NeUzua4V3ZYh1zAaAyx1Bj1nRU8qDWwvDx/Kn091lCIWoqgh884BRHkI8Wh2oU7nQDVLQpJAuNYEgCbkZtgveXXCxf7AQSvkRh8gC4Ds4B2rGbMpYltBjp4a4mS9YwEgH13LrysIxsHFQsBByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479410; c=relaxed/simple;
	bh=HpK1o9AVJPjL2XnjX21gGBHaJq0A2t72vXagbHLbC9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JixfjJXcN7rk/L11O6cKF3fIBOTsNrSkwZmOQuxWkP1reNLGKB2K+eEBnQ6FaByGl3eXzVTjPLVq3GW5SN2HLeM5aLUDmWZo/zwFHMTDw2R26+xYYPns+G6rXFXCNANcVORJiAD+wYVXXNTZrqrjlXCtaNRmk27snKJyWagHvys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UbaFMRZc; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oYAANeUfChayQjZoNc7TQiQKCEOVpsJxqghz8y/Jtcc=; b=UbaFMRZcDD89BDu78ngPT1o5AT
	hBqHDujzhaLa4DGlptiNSpjxhS0L6O4HmpPnFdpMk1pXjhHV8DY2da6l+xf4SWMgNtwSORDgpn+YT
	M4wwqbYC4qlSxY+uTgqkO/D9OWtCnbvkqxQjxUnD4DrkC9odQl3CF+yK9+X+5h2lCAwNfkGRRvJ12
	xwTj7/0P7+9/W0F2UqTE2Jm897HjjD2rselDsxbp8pElfeqe+12q9Iy1THd2ofelYT3F7NPZ4l4wR
	bQZaNWtY1ALx3YRFPaoLIV5uBpPYfw6PdWdivHumQyvf54ASKjnttaQPWPpkYII5GVPbgqsj6z17h
	EsqgbDRw==;
Received: from [189.78.222.89] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6ujy-000V2F-IW; Fri, 01 Nov 2024 17:43:15 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Nathan Chancellor <nathan@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 0/3] tmpfs: Casefold fixes
Date: Fri,  1 Nov 2024 13:42:48 -0300
Message-ID: <20241101164251.327884-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After casefold support for tmpfs was merged into vfs tree, two warnings
were reported and I also found a small fix in the code.

Thanks Nathan Chancellor and Stephen Rothwell!

Changelog:
- Fixed ifdef guard for tmpfs_sysfs_init()
v1: https://lore.kernel.org/lkml/20241101013741.295792-1-andrealmeid@igalia.com/

André Almeida (3):
  libfs: Fix kernel-doc warning in generic_ci_validate_strict_name
  tmpfs: Fix type for sysfs' casefold attribute
  tmpfs: Initialize sysfs during tmpfs init

 include/linux/fs.h |  10 ++---
 mm/shmem.c         | 105 +++++++++++++++++++++++++++++----------------
 2 files changed, 73 insertions(+), 42 deletions(-)

-- 
2.47.0


