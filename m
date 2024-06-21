Return-Path: <linux-fsdevel+bounces-22162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2614912ED5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 22:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979961F22FAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 20:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC33017C201;
	Fri, 21 Jun 2024 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAve3cmy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C1156F2E;
	Fri, 21 Jun 2024 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003047; cv=none; b=HcJPcAvMmUIlDM2F4xH5SmSVaZslHHR9r32pgOGEd+GnPLi6SDaNtn2GEgAOBqkzKp2zGpVs5elGlGenmNSCgbikJsC54DY+79oU28iwX7DOIGhl5Og/Wn24cwVBfMoziz31JF/GR6RkHZpKAEjpywq8/MsF9o5eO4WUYh5Bek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003047; c=relaxed/simple;
	bh=zHqrm6LL14pN7J1jPUokZ61GJ0sIujqExqHulesYufY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W8ntWdnEz8lMnS6RcNR4j0od+m1wZvoqU42sQLaeYEwigk3xywH4TYBbyfaEbDdTARzCNnIVXH8w+AocOnGo8w9dp9DRHeWxH8tVs1A2KUKVKApXB+Obwv5I6jFt235Zo3lqwOJsXBF+QcgdIZIEJRt6RfwLN2WBse2xfImiDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAve3cmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC28C32789;
	Fri, 21 Jun 2024 20:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719003046;
	bh=zHqrm6LL14pN7J1jPUokZ61GJ0sIujqExqHulesYufY=;
	h=From:To:Cc:Subject:Date:From;
	b=SAve3cmy5p6v3u6W23zkp6N5P7Zdim1KxMhtleXv1qc7zUJI6hRPGLiX2F9y/4Vwv
	 hL1YERb7sBSgwHGOIBvKEy0x+x3Ox0gs0WYdOlrfAhKMeZQn/VxH+rsHBpgYpH4QZt
	 LCQC4+YiHsoXNSSB9SMz3fEedx2BfAjbYP/M/BXmD8JxAjxLOw0KIKINUUC0C3KUld
	 eRwGrjcgSEnaANo4EpfU2uhJa+el0gq91npAlfpLF88LC9Y6YGt5exhPDcb7LmrSqV
	 pdFc19/VpqBtqMdXSIVxpK4WAWQ9Erq5NBGDuljncaao8jBZcLS44VDjL7pBoRzSyt
	 X+ukufO/bgjPQ==
From: Kees Cook <kees@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kees Cook <kees@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] exec: Avoid pathological argc, envc, and bprm->p values
Date: Fri, 21 Jun 2024 13:50:42 -0700
Message-Id: <20240621204729.it.434-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=kees@kernel.org; h=from:subject:message-id; bh=zHqrm6LL14pN7J1jPUokZ61GJ0sIujqExqHulesYufY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmdeekF5ynV+ysPDMpgOdN67QrunEd2yLM61lDt iaaLnVb092JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnXnpAAKCRCJcvTf3G3A JrRYEACJcwXSeETPWX0azPcrjVE+k6pOKsR5cASZRppf73qGPz3sjtne2MfnPOSPHl3lGdu3pZa cHvqfcCZwciotGUh2dfRbyGs9LHlNGJz9Un31oYqiq+wvX2x6sNCNa8jG8FO+cu4cPn8lqISJHt V9QKDv9AKKj+s3qTSLVdRveg4xcuJHTV+A8R882GHLqMo12QMgA3G/CM/VZIofhKj7WTHs2LsfQ l679COtEFu5FSHOzlchAl0f86zhtYq2E6pTNsCLPNKY0NbhMtWuv1PIjJbS2SvkjSb2NMPBhsDJ KLTstbfZ9Ja+57aQRoZdereYMKSNFylYAZHI/7UDoBaCCsDNKnu6T2mcWsksKFMXfsr7AfaqR6v kuOR5Ibj3cJmS4PFE2ShtlsCzypdV7m+gQNqyTK8FMyQzMFeWseRGkbSbQYrbptfAdJqKrgdzs1 sP502r4NtJCvjIrTjWQjUnoGJ0fLXlaSBezY005UpCudsJfOjFe3Pv7CzocvGhDm5z7XQ3IIyhl Sf7S5D/Yh4E5xIvzlvmxQCjMFmOAEiDXJ46bZTztybyI3afN87kEYNj27D6GMxzrQs+x2n2SDIC B/fYFnoA542S0/X5lJBtOWl8I2GUAu6hNXhTCOExcFmT68jQ8YijBC1r+nymoYSfuMG5/bN11SZ wjC829Q5mJWK0Z
 g==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This pair of patches replaces the last patch in this[1] series.

Perform bprm argument overflow checking but only do argmin checks for MMU
systems. To avoid tripping over this again, argmin is explicitly defined
only for CONFIG_MMU. Thank you to Guenter Roeck for finding this issue
(again)!

-Kees

[1] https://lore.kernel.org/all/20240520021337.work.198-kees@kernel.org/

Kees Cook (2):
  execve: Keep bprm->argmin behind CONFIG_MMU
  exec: Avoid pathological argc, envc, and bprm->p values

 fs/exec.c               | 36 +++++++++++++++++++++++++++++-------
 fs/exec_test.c          | 30 +++++++++++++++++++++++++++++-
 include/linux/binfmts.h |  2 +-
 3 files changed, 59 insertions(+), 9 deletions(-)

-- 
2.34.1


