Return-Path: <linux-fsdevel+bounces-23515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170F692D8CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 21:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06EDB23FA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 19:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CA7197A8F;
	Wed, 10 Jul 2024 19:11:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A4194C7D;
	Wed, 10 Jul 2024 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638692; cv=none; b=CmUArm94jRxrH5w8BTDUyQ9KH/jacS2LUGjS3+C/+mWgY/k4sJUcw9BLxt8laffZ87dJHORYKohp+Jbst+WJ4ttxfg/Ac+ngDXtiqprOn3NMXgY8Alck1gGa9KwO/KnDFzdhHYAK6nSj4Ha2gj/GielImyloZ67WguHWChqcSqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638692; c=relaxed/simple;
	bh=udMFJU1CjhDmxkndAbPKumIsAujpt4qC9jQ19HN2IRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NwY6HUfe+1k+Nl3vblnuiPmCu30F8uouRa4oZC82063UH7uWhhWIXp7L3mbTMA+JaZc1fL7v3KZ1F2vSvJGJ3uOP83gTT0Rf+LRzu1kQIXWvm5chgBOeeC7w/bDqoymn9KaaRZdgEibnZDuk5cC5LYdByJky5Sqi3jv+RmIKc/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 335822F20254; Wed, 10 Jul 2024 19:11:22 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 8A6802F20250;
	Wed, 10 Jul 2024 19:11:21 +0000 (UTC)
From: kovalev@altlinux.org
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aivazian.tigran@gmail.com,
	stable@vger.kernel.org
Cc: lvc-patches@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org
Subject: [PATCH fs/bfs 0/2] bfs: fix null-ptr-deref and possible warning in bfs_move_block() func
Date: Wed, 10 Jul 2024 22:11:16 +0300
Message-Id: <20240710191118.40431-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

https://syzkaller.appspot.com/bug?extid=d98fd19acd08b36ff422

[PATCH fs/bfs 1/2] bfs: fix null-ptr-deref in bfs_move_block
[PATCH fs/bfs 2/2] bfs: add buffer_uptodate check before mark_buffer_dirty


