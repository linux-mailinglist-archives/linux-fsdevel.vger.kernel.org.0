Return-Path: <linux-fsdevel+bounces-57531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F75B22DE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 18:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4901506FAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE1F2FA0F2;
	Tue, 12 Aug 2025 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lEDDhL5Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1F52F8BE1
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016401; cv=none; b=iJm3EAiGi2eL8EY1Z4g+3EeXNcyTaDclKQnTnWbs0LUo6A8Rlrb1Cc+vQkE20a+amPRDVJiPJfG4sVSDmumG0w11wHy3vCYGYAVuWgAjoenoWkhP1STrhCf0oAs1nJ6IYuhLYHIGDJ+7AO9oSq6/stn/B8wH4e+cQhYNyBMmU/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016401; c=relaxed/simple;
	bh=x22tYifRMzWRfOPwuCf3rtODvgZdZOtHYxuYDF6ysLE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PnOaOLccufM4D7UUmXPFQjhYaHYG6VrrzEN8vCzGzpwSuaftwWUrbRoPo5sDaJJLgCDRW4hWwhSo7TRRNuO4myQSKQxqkzphdPsvwfRmo+EmU3jBkUsi5nRIHM+V0CnWcsxmpM5dXRY3/+SUN4qQQje+yNco2Z0dPPuDrDPX2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lEDDhL5Z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=g/ZoFTGPYWyIc6gI9ssLd15fPuZgaz7P82YO3/Wzg88=; b=lEDDhL5ZqU32bn9OzEsfcjgdCl
	ZohBEpQtz+1vdhN3g5uKKvx381Sutkv2hB68Qjd3wcjDCOsmRkjQPaNsA6NIa0pmvzCtREfpDUeFM
	SxUgQxv26RGlG8yvEWW0V+hVOy4CECHfa0Skfnr0IIZE+7PDbkW+qHI8QXvNoVP6AfDhaljdbJWmm
	cB3INMA1nzbYbCKct7KVmB0h16mix71OUGbHlsoCgj5kz6IIvL9h0EL+APO9x4l+HORPeBn6bQNBM
	uZFuMS9+cBRYqotMf19zYowBcP5EoXZe6v4fZBwTCA19ENrKkkM3LlhKI2bunbWYXYaY3tIZIKEJA
	cv1sO+KA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulrw4-0000000GxJ7-187u;
	Tue, 12 Aug 2025 16:33:16 +0000
Date: Tue, 12 Aug 2025 17:33:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] fix for descriptor table misuse (habanalabs)
Message-ID: <20250812163316.GV222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[sat in -next since the beginning of August]
The following changes since commit d7b8f8e20813f0179d8ef519541a3527e7661d3a:

  Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 33927f3d0ecdcff06326d6e4edb6166aed42811c:

  habanalabs: fix UAF in export_dmabuf() (2025-07-12 01:11:14 -0400)

----------------------------------------------------------------
YAUAFFix due to dma_buf_fd() misuse

----------------------------------------------------------------
Al Viro (1):
      habanalabs: fix UAF in export_dmabuf()

 drivers/accel/habanalabs/common/memory.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

