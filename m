Return-Path: <linux-fsdevel+bounces-24299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBCE93CFB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 10:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363D81F21F89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 08:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91FD178365;
	Fri, 26 Jul 2024 08:38:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AA92C6B6;
	Fri, 26 Jul 2024 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983086; cv=none; b=djUFJDeAGWGgCco7xNRKfx+waKSKkxvh+YYw+1JcD2RIr1rn9V5EkPytle0IY+XZzJ4TjpSiWtid2qogaztVO+941oNmxtBzMxUAN6J5DeVI9aR463UejsECCJsplUmf6R9Tttr5uWt8fvywPcKLfHs50A4RbSvIsw7Xjpzw0h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983086; c=relaxed/simple;
	bh=k4wbfYrnJTzMEsDvBUn4TfPEOFP7XubpzrPpTCm0ics=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SHdMFAOwxN7JY/7ju/XttjvL9Emo6oqPw2s/1vO5YbevDL+IJ6ALHdvdyxTf4c9Su7rsbkVUBGHwtwacUHn+36mx619fJRy1OmG0z+EHCedeAHc619YRTTPdoLPY4q9SqjnvW8FadFC1Fgy0MkrK9tIYa+PfJY9kaCKqhL+0yjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WVgy03qkFz2Cl4T;
	Fri, 26 Jul 2024 16:33:28 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id E6C661404F5;
	Fri, 26 Jul 2024 16:37:55 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Jul
 2024 16:37:55 +0800
From: yangyun <yangyun50@huawei.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] fuse: add no forget support
Date: Fri, 26 Jul 2024 16:37:50 +0800
Message-ID: <20240726083752.302301-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100024.china.huawei.com (7.221.188.41)

FUSE_FORGET requests are not used in some cases but have an impact on the
system. So add no forget support.

Patch 1 simplifies the queueing process of FUSE_FORGET request when error happens, 
which Patch 2 depends on.

Patch 2 does the actual work about the no forget support.  

yangyun (2):
  fuse: replace fuse_queue_forget with fuse_force_forget if error
  fuse: add support for no forget requests

 fs/fuse/dev.c             | 25 ++++++++++++++++
 fs/fuse/dir.c             | 63 +++++++++------------------------------
 fs/fuse/fuse_i.h          | 26 ++++++++++++++++
 fs/fuse/inode.c           | 10 +++----
 fs/fuse/readdir.c         | 37 +++++------------------
 include/uapi/linux/fuse.h |  3 ++
 6 files changed, 81 insertions(+), 83 deletions(-)

-- 
2.33.0


