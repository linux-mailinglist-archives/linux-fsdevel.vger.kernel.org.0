Return-Path: <linux-fsdevel+bounces-38264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545809FE3F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 09:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361221882848
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 08:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FBE1A239E;
	Mon, 30 Dec 2024 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="LNgymyLA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351E1A0B15;
	Mon, 30 Dec 2024 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549098; cv=none; b=mgUKg2KVRGWy+F5p7D6RaH1ZR4qddqN9kfv1lw58ZUUycLoYbXOp5l4pYJf1wMwfUYIEg5+HnTJZ/3pWopItmhtkDQGHiDnjQrshIiku/TiYJGD1NI4heoEx+2bidNJ/uNk60IWGE/IrDIan/Uv/i3wrpPHNO1vwd+WSE2NmI2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549098; c=relaxed/simple;
	bh=L22T5DseIeZQjbrLVR8yXi6g0/E5E/D9sHkgBTjbrs4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DT3qMRprRIlt0exDd2fEOLw02v5bc3nVE6yXMFZn0ByO0EP1aWpWCU0N8saZ4sFLtro+zBWuqhZm6MAjj2hWIHQi6UXLbC/AuZs38s/GzS16elz/+hFOZh2+Tze7wxDZJUt70Cv8roC02fXZuuifSAxq9HEyJIFhiLLhcFnqCLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=LNgymyLA; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 9147D1DF9;
	Mon, 30 Dec 2024 08:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1735548658;
	bh=Nb8VVTBl4RckyQGOejpiAU40Wlmd8yl4wX5oKYo29ZM=;
	h=From:To:CC:Subject:Date;
	b=LNgymyLA6aIYJROXsu9OYE7hHnDiqcVIuiah+DaQv3+5TIZh2ZmrGlHOpsWAo51Gz
	 IXSztmVEpuGj3lrBH/tkkzSGeT9vKQvuc+mPk5q8DMDMeqWNKeHlPSB0nIiFlJqesy
	 EFkvNHI7rxGLZu506uquOOkY7zo3yes+PaALwLnk=
Received: from ntfs3vm.paragon-software.com (192.168.211.75) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 30 Dec 2024 11:51:24 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/2] Bad inode handling
Date: Mon, 30 Dec 2024 11:51:14 +0300
Message-ID: <20241230085116.322824-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

The changes unify inode corruption marking and mark them as bad
immediately upon detection of an error in attribute enumeration.

Konstantin Komarov (2):
  fs/ntfs3: Mark inode as bad as soon as error detected in
    mi_enum_attr()
  fs/ntfs3: Unify inode corruption marking with _ntfs_bad_inode()

 fs/ntfs3/attrib.c  | 15 +++++----
 fs/ntfs3/dir.c     |  2 +-
 fs/ntfs3/frecord.c | 71 ++++++++++++++++++++++-------------------
 fs/ntfs3/fsntfs.c  |  6 +++-
 fs/ntfs3/index.c   |  6 ++--
 fs/ntfs3/inode.c   |  3 ++
 fs/ntfs3/ntfs_fs.h | 21 ++++++------
 fs/ntfs3/record.c  | 79 ++++++++++++++++++++++++----------------------
 8 files changed, 110 insertions(+), 93 deletions(-)

-- 
2.34.1


