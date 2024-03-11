Return-Path: <linux-fsdevel+bounces-14086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C782877945
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 01:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225D7280F72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 00:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7A9653;
	Mon, 11 Mar 2024 00:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4RSUq/3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DB9382
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710115349; cv=none; b=r/k3aaU/i0oFICHMRmwckMAwOhBqSYmqCtKmkf4PoN6BDFXyrBog+m1p7P/KqxnHkPp/4C67NwdEw6kzD/hEPobaZXXvacXYKGEcsHskvQYVJWRrXxQ24Kp62EsJLr/Mu1Q+GpnOf6BstrGfmgpnNMVlLmVGOo4cLWE80T33ulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710115349; c=relaxed/simple;
	bh=lhwlKEEaUvkNR4TvTRknjKGX8UnoG+Tw5UXacuGlCCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/ztPmMRELyixOVpOFqVCLZMNoRMTriSaySTYzP3xNM1hNiMcFb92uKt2CMfCBNu7svzNPRoP7aNHKyLuwcG+V+i5msCoZReeAfl/XxmiJs57N2f7z6B5TmgIsiQdFswZZlBh+pnBElxlnPShBiFcQF0w8+X2D+kt1bJz7ffrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4RSUq/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58255C433F1;
	Mon, 11 Mar 2024 00:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710115348;
	bh=lhwlKEEaUvkNR4TvTRknjKGX8UnoG+Tw5UXacuGlCCY=;
	h=From:To:Cc:Subject:Date:From;
	b=P4RSUq/3T8cLxnEztfpXBaXapxHzOqc05FTEL3ppRdTOT+Kz3UWa987QFIYme2yAe
	 EZHJlHgbHc2ZBW1PHo4l8IVJuiI1D2iOWir4IKcyaXvLAhl8lbYtRxN2x/U4vIk11i
	 KwoJZxelbt3UxBJN7iMiubf7jspsKUGzE1feUuadhEMIQu/DEZWUI9sssRUZRS19O1
	 djwRZLiLeNDh512hJaWyFAFdfTHDdQN6EHC7C+Gy73vA/8VMKW10RuIKtmbTZSRzk6
	 hqFtuAQuOTkCKZFZSBv23z11UsIriTatHr+0rMCheIBa7cnWqO5aPY89LgozCjRXmQ
	 5p0JLNQ3tdcMA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs changes for 6.9-rc1
Date: Mon, 11 Mar 2024 09:02:25 +0900
Message-ID: <20240311000225.40819-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Linus,

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.9-rc1

for you to fetch changes up to 567e629fd296561aacd04547a603b163de3dabbe:

  zonefs: convert zonefs to use the new mount api (2024-02-14 15:09:20 +0900)

----------------------------------------------------------------
zonefs changes for 6.9.0-rc1

 - A single change for this cycle to convert zonefs to use the new
   mount API.

----------------------------------------------------------------
Bill O'Donnell (1):
      zonefs: convert zonefs to use the new mount api

 fs/zonefs/super.c | 167 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 95 insertions(+), 72 deletions(-)

