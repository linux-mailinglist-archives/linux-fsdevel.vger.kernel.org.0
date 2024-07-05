Return-Path: <linux-fsdevel+bounces-23183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BF7928203
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 08:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D8D1F248D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 06:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157B1448F2;
	Fri,  5 Jul 2024 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SH43FUj8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93C8143C75;
	Fri,  5 Jul 2024 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160815; cv=none; b=fMRAxx8P55hz0tYT7Vde3h1BcWEcYjM/v+DFI5vniOTaw5AqPI7kN4C2ZoVUjC0YXmwadSxxRyjzU/NE38pCsrlXCHDrwubew/9AGX6O40UpWSzVuUOzib5FA2ZRAYEN1jSt/ss7E947ccIQSTtmyxGknesfZZiAcIGaf4P3gu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160815; c=relaxed/simple;
	bh=EMdvsRtHPHQyGahTe0wLT9ajkOMWh7BnJ8WxOakQ/54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hJvDCfFq0h4ODkYjpav/QadAVbTmJOk8o/qlpkENWDBsIm6R/sg0TzumIuXS6rEylTN+X778zzQ5YBYUqfyXM1+ahOs8yjIKEPuflq890BB+QXnvMUHNssoKA1BF9IajRTbnhvfxMUUIUTnNM2n5DQA/uVN4/+8I75cLWJykLnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SH43FUj8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720160812;
	bh=EMdvsRtHPHQyGahTe0wLT9ajkOMWh7BnJ8WxOakQ/54=;
	h=From:To:Cc:Subject:Date:From;
	b=SH43FUj8/X+MQs5YQH/C5zbdIlujSz6/TZrnNxvKvr6qz8T9yqWSN0SyicD18qN/j
	 7dMWfFpQoP93RhHzB5TRqMK2XaLArMul5DnXEFZatm1wgNvaW8NgxL13rQzTxfmQ96
	 mXOGEVNrZdbQxJzL/PoYsBzJ4g5V3SGMHwREDMDM3K5FLCHg47UN+8BohXLCh7LMha
	 vnC1eIpCavROJ4+or9a5w2Fqn66O8ZRb21kVmNLZugUNC2bPsFJ5IvsIbX3d65Ft1L
	 LSTq1/EzdhK8Swizc33kQEP7onT7LujmPuXuFtyZikL8r3im2LI2ujkRp92XJklv1u
	 adzlgnr0nSIrg==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5F14437820FE;
	Fri,  5 Jul 2024 06:26:51 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	tytso@mit.edu,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	adilger.kernel@dilger.ca,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	krisman@suse.de,
	kernel@collabora.com,
	shreeya.patel@collabora.com,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH 0/2] fs/dcache: fix cache inconsistency on case-insensitive lookups
Date: Fri,  5 Jul 2024 09:26:19 +0300
Message-Id: <20240705062621.630604-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is an attempt to go back to this old patch series here :

https://lore.kernel.org/lkml/cover.1632909358.git.shreeya.patel@collabora.com/

First patch fixes a possible hang when d_add_ci is called from a filesystem's
lookup function (like xfs is doing)
d_alloc_parallel -> lookup -> d_add_ci -> d_alloc_parallel

Second patch solves the issue of having the dcache saving the entry with
the same case as it's being looked up instead of saving the real file name
from the storage.
Please check above thread for motivation on why this should be changed.

Some further old discussions here as well:
https://patchwork.ozlabs.org/project/linux-ext4/patch/20180924215655.3676-20-krisman@collabora.co.uk/

I am not sure whether this is the right way to fix this, but I think
I have considered all cases discussed in previous threads.

Thank you for your review and consideration,
Eugen


Eugen Hristev (2):
  fs/dcache: introduce d_alloc_parallel_check_existing
  ext4: in lookup call d_add_ci if there is a case mismatch

 fs/dcache.c            | 29 +++++++++++++++++++++++------
 fs/ext4/namei.c        | 13 +++++++++++++
 include/linux/dcache.h |  4 ++++
 3 files changed, 40 insertions(+), 6 deletions(-)

-- 
2.34.1


