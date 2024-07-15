Return-Path: <linux-fsdevel+bounces-23727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C62B0931D56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 00:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE10D1F228BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 22:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9D613D244;
	Mon, 15 Jul 2024 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPEVDfpT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83DC3BBC2
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721083990; cv=none; b=ANSptda1UACAOMz36cO3IbyCbVgQzGN+XWwVTnZD8M8vg8ZX8EFZifIoOZZOb3hvzujJS/Hk8X/ZYPfdwkU+Y38lkToDDz8WSOAHBUfHkyf+plyIWsqKNBPYUZYOZ2mjVUJ4e0qLxwbAKY1nU4cZrbTP3NCt/ngC//0slwPwoV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721083990; c=relaxed/simple;
	bh=u0jfQ1mmhh67s/eur9tb9e7l0Y/o72DmzvN3RCOS6Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8I+QblY1NkoJyF3k6Bjf9lyK83RHxsUhes8YwiyonXF34tGZsLe3FqdTEMr3QSbTZvDpviZx6pAYutBc9bCDDScDqgfaoeT+gIH9IgohPSky3wtMDDBOxqeXoDf68D/Rgs4cIMm5zIzE84zdw/aOF1CfMkGb192Lg6pjKqdm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPEVDfpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1F7C32782;
	Mon, 15 Jul 2024 22:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721083990;
	bh=u0jfQ1mmhh67s/eur9tb9e7l0Y/o72DmzvN3RCOS6Rk=;
	h=From:To:Cc:Subject:Date:From;
	b=hPEVDfpTvnMdcVzIspmVELXCKefCMK4WiHpIT1j2pcil4x9XTH+tx3lv9/ozHMJdG
	 uOV/lkSj2tyzvWjQakt9Bin/0irfqep7CvJoL0XQWJt616gPQXmPTbgM8hKz9G0fvv
	 Qu0tvkI9CXm/+UE+fkLQMLIQJn6dFHwkWzEzcL5HPnvUtI/TeL9o8orcWyc7p6Y2Z2
	 QVQdO4EBJVpi1jBt+gMsSrsHyonWSJ7bvx64oy65S5cm6YZDjPnefcpxSCHJxHAh+T
	 LuFZE8erxEvCp9hoJI7HiSa5iHSUuM3jwjnu1GpTQt68KDEbouLpjtyYVhRHfNoKv/
	 /6pAw7jhIYOsg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs changes for 6.11-rc1
Date: Tue, 16 Jul 2024 07:53:06 +0900
Message-ID: <20240715225306.43445-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Linus,

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.11-rc1

for you to fetch changes up to df2f9708ff1f23afdf6804bb16199e1903550582:

  zonefs: enable support for large folios (2024-06-11 11:22:57 +0900)

----------------------------------------------------------------
zonefs changes for 6.11

A single change for 6.11, to enable support for large folios (from
Johannes).

----------------------------------------------------------------
Johannes Thumshirn (1):
      zonefs: enable support for large folios

 fs/zonefs/super.c | 1 +
 1 file changed, 1 insertion(+)

