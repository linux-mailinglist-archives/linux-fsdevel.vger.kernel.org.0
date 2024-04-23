Return-Path: <linux-fsdevel+bounces-17542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67838AF640
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 20:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827A8294713
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 18:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1408E13FD60;
	Tue, 23 Apr 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tYWlahpr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC7E13D8BB;
	Tue, 23 Apr 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895520; cv=none; b=CCaNF5cJeCLv3k0TwVC/g/94celIfI7mRKaOTg9VAKbzHwO8tvEAu2MEsV1n1Z7w2WNLeZ93nAMVUj6O+1DRCmzJT/Fk8HYYYRAhYCx80RVLM5RyRmglbLWq/rP6Xpr5L43QjHbqgllLp5bSxuvz98W8xG+v95wr2W95dh02ozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895520; c=relaxed/simple;
	bh=csbBsLOK9aN1YY14VJhgNaSPYMZmkMYSj4EsvEhArm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNFThpsNAPN4PMQ289g19+n7C2t5m9A4SzLMfRCX4DYRFY198dFr96O9wbBztak2wMM3CNwXggicqfapVlzEaWfZKcM4f0YAAFPv1SnBy92qQP2NrhM/1ZeMM+Y05sE3qRilyuBcnk2PxzY0YP0P7GigBsOo4K4KD9iIXN60n8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tYWlahpr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=x5XbG1JjCYNvoxcYQVRjX4l6Fw6ilVYPinQm4/OHRBI=; b=tYWlahprIb/r9CmNbSKQsIiUt1
	DoB/kydDfe2VqIoT5GWk2EL7C7AhVj2QqUUNuzRj6C3HQ4XBcDDLAW10mST9zh3of+/Kpfct6kCcA
	cPNJUM2oFvm6nbro+8Uk7Ai/EXEvUtGz8kwxX71lMD//1c23DrTsD16/UK2w+YG7Mx2CvaKRSWeQH
	IPSdoAgoaN1dnVScwV0/q4EXqtbWHUt3oeAooG9irIVzJcx62vK3H+2fY10+6MNRtLyfY4bcbhVCL
	wdSAE+dOlSSEjUAv+B0qSalL2nSryomZrN6GcYZpo4GIO/Dm+qQgLx3Ki9nWcqTB4/EnTZSG2PkLS
	PU2UWhBw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzKW5-000000014oY-25p8;
	Tue, 23 Apr 2024 18:05:17 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	Liam.Howlett@oracle.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	david@fromorbit.com,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 0/2] test_xarray: couple of fixes for v6-9-rc6
Date: Tue, 23 Apr 2024 11:05:14 -0700
Message-ID: <20240423180517.256812-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Andrew,

Provided there are no issues by folks with these two patches, here are a couple
of fixes which should be merged into the queue for v6.9-rc6.  The first one was
reported by Liam, after fixing that I noticed an issue which a test, and a fix
for that is on the second patch.

I wasn't even aware that you can test xarray in userspace, cool beans.

Luis Chamberlain (2):
  tools: fix userspace compilation with new test_xarray changes
  lib/test_xarray.c: fix error assumptions on
    check_xa_multi_store_adv_add()

 lib/test_xarray.c                       | 13 +++++++++----
 tools/testing/radix-tree/linux/kernel.h |  2 ++
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.43.0


