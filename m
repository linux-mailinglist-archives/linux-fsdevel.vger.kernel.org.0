Return-Path: <linux-fsdevel+bounces-23493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76D892D597
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F51A1C22A11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 16:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931C9194AF0;
	Wed, 10 Jul 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hOKncLHx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4D194A5D
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627192; cv=none; b=mlMmy7zx3hzWrxx4I02RLbMMT9X+EIYocHUAZPPAu2xBIkC/VMGPM8gwO9J2kzNxkCHBGlFF1d7xmKWCx/d5iXY8ynxBgdMBj9QooY28YmdgVJQE/IZR7w4ryd8XZTIDKHXm6zVGE0BeKP4Bn0vAqiqUkIkw3ZkoRYySBBwe2bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627192; c=relaxed/simple;
	bh=Qs23BYMqcnPlT5ZNTqdO1GPllBAC3yvJ0abhxMtvwM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+INCwckH1QEpHeegqWnBOs7JE5mmE2U25bEpbVpoO8AVxRFNQ5ByMBsVwsZQ4bVQHV5BBJe1/I5iyHKJXr5YXqcCYoWT+Xmw3K3E3GEo5il44c51eYrE1jKXEwueVsSll+3jlS+ekwyh8+RgKTLco7TNNi3NOzJlwCIM0bzZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hOKncLHx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=4DCQACVYtb7xbmMH6ivQ46vMv+UEOAZTRUjD4eXBx2U=; b=hOKncLHx2UbP4HPSsYp3B9PbtO
	uDIjxIyvRPta9n2sUx4sNbNwJRXsMh9Xl3iThT/tigDDkdqx88Nu6hiZw36UtaKZhvHjhkvSFT5di
	m2YiJNZcrm3+EfxX8RmoA8Xwjgiy4M/Ef04v64cBKCNebyV1iHusG0lVnx0PMgQUBdj0SUvoxpVt1
	7v5kZofBWXSALZP6wcoTLfNdn5wLEoZOS3HCBmhOymS8MlKoUWW8bUYR0s+RBWx3M4BFGjdyVxJ6X
	bp+/cODF5Mfq/V1+k+0Zz+GK48884aza6xzzLnTRIgaJOP0QXRrRSojKbZ3wwn9kPIop06yoH7xUI
	UZnctCFg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRZjQ-00000009TEE-3MPy;
	Wed, 10 Jul 2024 15:59:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 0/6] Convert qnx6 directory handling to folios
Date: Wed, 10 Jul 2024 16:59:38 +0100
Message-ID: <20240710155946.2257293-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series mirrors the changes to ext2 directory handling.
COmpile tested only.

Matthew Wilcox (Oracle) (6):
  qnx6: Convert qnx6_get_page() to qnx6_get_folio()
  qnx6: Convert qnx6_find_entry() to qnx6_find_ino()
  qnx6: Convert qnx6_longname() to take a folio
  qnx6: Convert qnx6_checkroot() to use a folio
  qnx6: Convert qnx6_iget() to use a folio
  qnx6: Convert directory handling to use kmap_local

 fs/qnx6/dir.c   | 88 ++++++++++++++++++++++++-------------------------
 fs/qnx6/inode.c | 25 +++++++-------
 fs/qnx6/namei.c |  4 +--
 fs/qnx6/qnx6.h  |  9 +----
 4 files changed, 58 insertions(+), 68 deletions(-)

-- 
2.43.0


