Return-Path: <linux-fsdevel+bounces-22419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A6B916F96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 19:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECD41F22FD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463C61779B1;
	Tue, 25 Jun 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AxyY+edZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACCF4437A;
	Tue, 25 Jun 2024 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337919; cv=none; b=TtD08h3Nt1UO5GlhZ+gdeLpUTb6gOcqzExO6P/HGydKpfywW6X7UBItRsl+YfgDev5zWx4SJELKDW4gTbW5rrveGaeu6JDtK9Ch+pnR/kLQDz7lDzX20htU0APdOa4QJnMx97jLmCHzbafpSMSQzoltqVoP/D1RNhE80GR6tkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337919; c=relaxed/simple;
	bh=Q3I/DJtp9NDVkqs+20MrQgr7hwwyZDKKO8eL+lYNdlg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mgXchYAr+vMWjUIQRFze4Sez7C+m/JSrBFwlBVhDF5Hh2P0+pMbXlxanhIMMAAeyZeBNf27IOGaL5692waTeP4dtEfdMyQooZbBxGwPx9w0RMx0PkFGKlp6lnt1qQkMO3OTAM8vBF8rWd60fg00mNc+iVjnrxbODajIGzlHMET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AxyY+edZ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mGekqOl4DEHyJGZJHQjAmkGp/lL8oAzm7NpLKvz5LoE=; b=AxyY+edZxqjYXu6wQusE3cnwut
	RTtl+04ITa3JIfFfN44D+gLCIA83xgFVNzZ2gaPdU/D4dKFtv6e9dDoE6aD1K8Nnx+P4RcrJ4Lc8U
	gZuf8q1uSsSscVef8hfmomKtzIF33AndgUbHB1RQEbV0UWUeBnHO35AoZkO0firMWgVzSiWiHjc2I
	yCxXxPUcsbpcV7eSHVOrTGAYV0vI7IYKBqSE4DAZMUMc/vrphNQJXmll+bQR2rZ1dPR0BjododCpf
	T6mFhx5GPBp9qSRuyHLzfz3ZQ3O/zVqcsNwC38TO1f0jULRGhb2r8LLqBeuEBy/iFHnkcEAJwHX40
	I3kwm1xg==;
Received: from 179-125-70-190-dinamico.pombonet.net.br ([179.125.70.190] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sMAKa-007Oa3-Kq; Tue, 25 Jun 2024 19:51:49 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-fsdevel@vger.kernel.org
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>,
	dlunev@chromium.org,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH v2 0/2] fat: add support for directories without . and .. entries
Date: Tue, 25 Jun 2024 14:51:31 -0300
Message-Id: <20240625175133.922758-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some FAT filesystems do not have . and .. entries in some directories.
Currently, such filesystems are not mounted because such directories will
have no links. They are also corrupted as inodes are evicted and that leads
to such directories clusters being marked as freed. Later mounts will then
error out when finding such clusters.

These two commits allow those filesystems to be mounted and . and .. to
still appear when listing such directories.

v2:
- Also ignore the absence of . directory and always have at least two links.
- Add a second commit to always emit . and .. at readdir.

Thadeu Lima de Souza Cascardo (2):
  fat: ignore . and .. subdirs and always add links to dirs
  fat: always use dir_emit_dots and ignore . and .. entries

 fs/fat/dir.c   | 28 ++++++++++++----------------
 fs/fat/inode.c |  2 +-
 2 files changed, 13 insertions(+), 17 deletions(-)

-- 
2.34.1


