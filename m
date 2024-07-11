Return-Path: <linux-fsdevel+bounces-23543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8E492E0E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 09:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106A7281AD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 07:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D707614885D;
	Thu, 11 Jul 2024 07:32:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A296F4EB55;
	Thu, 11 Jul 2024 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720683167; cv=none; b=UQZKvLB7GkkJP6bFIAAPXgQEiOQC9XbBr7asy/2kzY+zQDSsvBirgnCQv952zU6wgYn3IQnJnOR0ZsSRvtcCWv82lvJDkkGxl1zop3Eht4wfgNQMPT+InOwEvkZ0NqL0Zn3q+//EDhosNSbDmm4bYg152Wzh62AF4VhbN3JwK4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720683167; c=relaxed/simple;
	bh=fuJAsQsRkEem7fZrBaxWoGbiwy379NR+NAQW+4jp+BY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCqGdz4bjQFZbYzGi2Bk+HlyOiMBJFiX6mv3NUEVQIukUQoUVLsSRK2Y/KkeNWsOFErHYwwRfNRf6awEWyQ1XTYD0ITBpC8KtgPJyUH088OkQqkLggl/oyO5RiiU+0ujjqN3yodDOBtO7+agdLPzdEmN50M4UfnBlVQzakMv+lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 2CE9C2F20257; Thu, 11 Jul 2024 07:32:42 +0000 (UTC)
X-Spam-Level: 
Received: from localhost.localdomain (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 784562F2023E;
	Thu, 11 Jul 2024 07:32:41 +0000 (UTC)
From: kovalev@altlinux.org
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aivazian.tigran@gmail.com,
	stable@vger.kernel.org
Cc: lvc-patches@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org,
	Markus.Elfring@web.de
Subject: [PATCHv2 fs/bfs 0/2] bfs: fix null-ptr-deref and possible warning in bfs_move_block() func
Date: Thu, 11 Jul 2024 10:32:36 +0300
Message-Id: <20240711073238.44399-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

https://syzkaller.appspot.com/bug?extid=d98fd19acd08b36ff422

[PATCHv2 fs/bfs 1/2] bfs: prevent null pointer dereference in bfs_move_block()
---
v2: corrected the commit message and explicitly initialized
the return variable with zero (Markus Elfring)
---
[PATCHv2 fs/bfs 2/2] bfs: add buffer_uptodate check before mark_buffer_dirty
---
v2: renamed the return variable  err -> ret (Markus Elfring)
---


