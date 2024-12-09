Return-Path: <linux-fsdevel+bounces-36793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 838B09E96AE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC75283DFF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4681A23A9;
	Mon,  9 Dec 2024 13:26:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F104233152;
	Mon,  9 Dec 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750761; cv=none; b=JKjyYySKaPEqsba9esCeWLFdSmIhMLjKE0C5v7/KIPfdv1Ilo4NkK+J65f1pXDq0iqOkMD28Zq0ZXDqjf6ubw7EVuoSOp/Ml3XeLCYKXon5l5syCBOOIbrtkNyBeykKsLfCc+LFxDhalcFf03HDmzD+GQpkvNLClHKmhVMkrZto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750761; c=relaxed/simple;
	bh=U7WT2680bhjBwC4CY3sluauSMaxZkMQj3tjTpWWnu0k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k28nXVFffvM8rTGx912IdswOpJ1KT4R8uf7ht2ie3GI88MsOHbtCouuFRXoQXznXWiQp09ujDHje95LuJPI0p+I0jLYAnZ8UdIHAXN2+7kdH3D9WDflf9sSM/ytdwStiqJ1/ho0jYXM6vq2IAwOpRnuSvk856sCUKdGHY+glcF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y6Mx80YRbz1V5xd;
	Mon,  9 Dec 2024 21:22:52 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AF9C140FEC;
	Mon,  9 Dec 2024 21:25:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Dec
 2024 21:25:51 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<akpm@linux-foundation.org>, <Liam.Howlett@Oracle.com>,
	<lokeshgidra@google.com>, <lorenzo.stoakes@oracle.com>, <rppt@kernel.org>,
	<aarcange@redhat.com>, <ruanjinjie@huawei.com>, <Jason@zx2c4.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
Subject: [PATCH 0/2] userfaultfd: handle few NULL check inline
Date: Mon, 9 Dec 2024 21:25:47 +0800
Message-ID: <20241209132549.2878604-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200008.china.huawei.com (7.202.181.35)

Handle dup_userfaultfd() and anon_vma_fork() NULL check inline to
save some function call overhead. The Unixbench single core process
create has 1% improve with these patches.

Jinjie Ruan (2):
  userfaultfd: handle dup_userfaultfd() NULL check inline
  mm, rmap: handle anon_vma_fork() NULL check inline

 fs/userfaultfd.c              |  5 +----
 include/linux/rmap.h          | 12 +++++++++++-
 include/linux/userfaultfd_k.h | 11 ++++++++++-
 mm/rmap.c                     |  6 +-----
 4 files changed, 23 insertions(+), 11 deletions(-)

-- 
2.34.1


