Return-Path: <linux-fsdevel+bounces-17131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E12F8A83B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3771C2197F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABA513DDAE;
	Wed, 17 Apr 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="d+7QRUts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE113D8AE;
	Wed, 17 Apr 2024 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359036; cv=none; b=s1puPf5UqbepNDQswzp0qBl7GCDrLGCVe+SjVgS8y7tvU7cVQFTeTEwSo0neie6LpXkr4y+JWpUE3CMFHpDA8xFTEgSXq+dISMH4cSWAaMvsnbUNFYGYE4ebnnW/p6Yx7b/60Q9CWCHKW+HxWaUu/3P5R6IxGF+t86s+THF3x44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359036; c=relaxed/simple;
	bh=8gplQGGfmFM+nIKfLuzQ8IZxoY79NhOT3F9p99nimdg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=jl7LES3lQGDexo9dQvFbZOHsNJW4kz0oRVC+9yLWLIcQSwYw7Li4rBOie6XJUDFiZFWDl0JTEmOzfnigDwFsu1dMRK/AkQTe+1dSOBBeraL8FL75Q2BEgGPRg+X3WpZ3lmF+T2fB38G6YHGAV560TEi6fesvcB/dVd6lfQo4LXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=d+7QRUts; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id A68912126;
	Wed, 17 Apr 2024 12:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713358578;
	bh=2GxTIfUltIPOHXFXPdRM4ZL7g5Y55q9YrnZAYAYOdAk=;
	h=Date:To:From:Subject;
	b=d+7QRUtsrIHmaXVR418KWEQdbFRm6LjIE2iAT7SCbUGyXwZ55dvuRqq4BaJBxiH78
	 rSPuIfEFIxVsNBvSe3JGDOez93JrdngWh/IXb1TpreMdsPtHugoApPfvHIzT4U/xJd
	 +SXZZLcmQsaCytcMlILuxwjX280dv5hTSyzLxVdI=
Received: from [192.168.211.39] (192.168.211.39) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 Apr 2024 16:03:47 +0300
Message-ID: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Date: Wed, 17 Apr 2024 16:03:46 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <ntfs3@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 00/11] Bugfix and refactoring
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

This series contains various fixes and refactoring for ntfs3.
Fixed problem with incorrect link counting for files with DOS names.

Konstantin Komarov (11):
   fs/ntfs3: Remove max link count info display during driver init
   fs/ntfs3: Missed le32_to_cpu conversion
   fs/ntfs3: Mark volume as dirty if xattr is broken
   fs/ntfs3: Use variable length array instead of fixed size
   fs/ntfs3: Use 64 bit variable to avoid 32 bit overflow
   fs/ntfs3: Redesign ntfs_create_inode to return error code instead of
     inode
   fs/ntfs3: Check 'folio' pointer for NULL
   fs/ntfs3: Always make file nonresident if fallocate (xfstest 438)
   fs/ntfs3: Optimize to store sorted attribute definition table
   fs/ntfs3: Remove cached label from sbi
   fs/ntfs3: Taking DOS names into account during link counting

  fs/ntfs3/attrib.c  | 103 ++++++++++++++++++++++++++++++++
  fs/ntfs3/file.c    |   9 +++
  fs/ntfs3/fslog.c   |   5 +-
  fs/ntfs3/fsntfs.c  |  77 ++++++++++++++++++++----
  fs/ntfs3/inode.c   |  76 ++++++++++++-----------
  fs/ntfs3/namei.c   |  31 +++-------
  fs/ntfs3/ntfs.h    |   6 +-
  fs/ntfs3/ntfs_fs.h |  77 +++++++++++++++---------
  fs/ntfs3/record.c  |  11 +---
  fs/ntfs3/super.c   | 146 +++++++++++++++++++--------------------------
  fs/ntfs3/xattr.c   |  23 ++++---
  11 files changed, 355 insertions(+), 209 deletions(-)

-- 
2.34.1


