Return-Path: <linux-fsdevel+bounces-43411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A881AA56201
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 08:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051B21896996
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 07:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA001A9B3E;
	Fri,  7 Mar 2025 07:49:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0961A3162;
	Fri,  7 Mar 2025 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741333777; cv=none; b=a0Hf0EA0lp73xmDpz+KwmKKY3hLwmmPEx9qx5X+SGCTbAlq0+2rwvRmgoYfoHV1ZKMdxU5SsOJurzI3dSSYeYn6WqtA0d8MvgnKMI4nfhPKQ5+IUZxs4i4oRULTNN5PeBuQwIC6gXWXB0m0LBp613GWhKZMRe9oiKCR3veHzHzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741333777; c=relaxed/simple;
	bh=e4b+fg10IcozqcfdM2KBPWzq3EXrk64Clu2Pv7/NkTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtYxUIdLmhliSWVAA9ELDL1KcEtIlTDYG2Eyb7eefrrxYoafTIfN/u4MNAkpY6h5vpfVyXRo2zQ4NZa0CYJsmMswTsv8lQbcWJyP9Ly7VjxVx37DwqjXGy9EaaTUY7cBb7sVitkjtLxuz7dXBqlCx5BjPOXY8TSyKHG895YVeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z8Hrl2m3Rz1f0Cq;
	Fri,  7 Mar 2025 15:25:59 +0800 (CST)
Received: from kwepemo200002.china.huawei.com (unknown [7.202.195.209])
	by mail.maildlp.com (Postfix) with ESMTPS id E8AA01402CE;
	Fri,  7 Mar 2025 15:30:14 +0800 (CST)
Received: from huawei.com (10.175.124.71) by kwepemo200002.china.huawei.com
 (7.202.195.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 7 Mar
 2025 15:30:14 +0800
From: Jinjiang Tu <tujinjiang@huawei.com>
To: <jimsiak@cslab.ece.ntua.gr>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<viro@zeniv.linux.org.uk>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <tujinjiang@huawei.com>
Subject: Re: Using userfaultfd with KVM's async page fault handling causes processes to hung waiting for mmap_lock to be released
Date: Fri, 7 Mar 2025 15:21:33 +0800
Message-ID: <20250307072133.3522652-1-tujinjiang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr>
References: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemo200002.china.huawei.com (7.202.195.209)

Hi,

I encountered the same issue too. In my scenario, GUP is called by mlockall()
syscall.

Is there a solution to fix it?

Thanks.


