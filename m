Return-Path: <linux-fsdevel+bounces-27100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6F595E9D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF971F22451
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8765126F2A;
	Mon, 26 Aug 2024 07:02:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65036AF2;
	Mon, 26 Aug 2024 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655766; cv=none; b=VfrgIVoyEhTZwxFOXg/pMwmgDfOytV4+wgPvlpraHJle3OGnsHC5tvCy/CIHQcy5IXXv044Y0lNebxSfTQhJ7Ytjemyyc2AT9GDhryotjzpboBy20jnF+3iDBo2ZhRMxtqrnsWCL0F9ncdeHwtLBceQy7/Z/x1GORsprUvqvYro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655766; c=relaxed/simple;
	bh=2GFGvv7bakK5iEy/5k9XPggr1oDBjfo/z+tdbDsog48=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qSx8Fx0xCiWP6dJVByQccEBJ91+9ugD92LhNJmYyWJ2P2bgtf0VAoDaWMT3jwvLmXuWwMRIkUL11mWL42uQ4+KiE2ziTrRk54orrv6gDofnXhDW+yl8cYNFBn4nxvBcPwG9gao8yY52xiFe1IKvIVXUqeO2Aujx2Oo6jRnArPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WshS40Z41z14G42;
	Mon, 26 Aug 2024 15:01:56 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 647F21800A5;
	Mon, 26 Aug 2024 15:02:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 26 Aug
 2024 15:02:40 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<willy@infradead.org>, <akpm@linux-foundation.org>
CC: <lizetao1@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [RFC PATCH -next 0/3] fs: Introduce the scope-based resource management for folio_lock/unlock
Date: Mon, 26 Aug 2024 15:10:33 +0800
Message-ID: <20240826071036.2445717-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi, all

Currently, multiple kernel subsystems are switching to folio, and the
page API is gradually being phased out. When using folio, due to the
need to consider competition, folio needs to be locked, but
folio_lock/unlock is used directly. Developers need to be careful about
releasing the lock at the appropriate location. By using compiler
features, the kernel has implemented scope-based resource access.
Applying these features to folio can mitigate the risk of forgetting to
release folio lock, and at the same time, can remove some of the
controversial goto unlock code.

Some interfaces are currently not suitable for using scope-based
resource management mechanisms, such as iomap_page_mkwrite. This
interface only needs to release the lock when an error occurs, and needs
to hold the folio lock when it succeeds. Maybe we can intervene in the
compiler's automatic cleanup behavior in a certain scenario like
implementing no_free_ptr.

This patchset has been tested by fsstress for a long time, and no
problems were found.

Thanks,
Li Zetao.

Li Zetao (3):
  mm: Support scope-based resource management for folio_lock/unlock
  buffer: Using scope-based resource instead of folio_lock/unlock
  splice: Using scope-based resource instead of folio_lock/unlock

 fs/buffer.c             |  6 ++----
 fs/splice.c             | 21 +++++----------------
 include/linux/pagemap.h |  4 ++++
 3 files changed, 11 insertions(+), 20 deletions(-)

-- 
2.34.1


