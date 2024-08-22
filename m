Return-Path: <linux-fsdevel+bounces-26811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D09E195BBAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE4A286EC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EC31CDA08;
	Thu, 22 Aug 2024 16:19:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C50A2D03B;
	Thu, 22 Aug 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343578; cv=none; b=d1fBbtIIBdAnx2if0cOf8HhLTjWLRP1V3z94G4Vmf9bi2wBUTdYCwh41TgP7ErF7cQ4uNjV1vlPbtJ4pYO/XjaRIEPwkgGbMtH7FkjsnUeVO/IM9cX6btKyFqL7+m+znnI0SkNQwoMaZ/q5nJB+7P01Y2YbTN5BaieKAdFU9xok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343578; c=relaxed/simple;
	bh=HKnYnEp9SMc1JK+IvT1gCFMlsvvD8dfnpP8W9c6erxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V9Gj5TA8CV/WgmossXJUEZgDYWZy8aizI+y0m1zGVauI+V44fsOmOKjM4sA7Eq39EsWb0H3xpdR2nVkXXUFudD1nnFNHbEwIv3FK7pGWqDLrsG5tznrUSoV5t1kQUUjYKIDvu6o06rDLY3J2UXzZgyOYgr5hGdgKFcMCD7vUKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 3C3202F20249; Thu, 22 Aug 2024 16:12:23 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 0A2E82F20249;
	Thu, 22 Aug 2024 16:12:23 +0000 (UTC)
From: kovalev@altlinux.org
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aivazian.tigran@gmail.com,
	stable@vger.kernel.org
Cc: lvc-patches@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org
Subject: [PATCH v3  0/2] bfs: fix null-ptr-deref and possible warning in bfs_move_block() func
Date: Thu, 22 Aug 2024 19:12:17 +0300
Message-Id: <20240822161219.459054-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

https://syzkaller.appspot.com/bug?extid=d98fd19acd08b36ff422

[PATCH v3 1/2] bfs: prevent null pointer dereference in bfs_move_block()
v3: Changed the error handling

[PATCH v3 2/2] bfs: ensure buffer is marked uptodate before marking it dirty
v3: Replaced the buffer up-to-date check with an error exit by forcefully
setting the buffer as up-to-date before call mark_buffer_dirty()


