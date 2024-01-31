Return-Path: <linux-fsdevel+bounces-9727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38CE844B48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0215F1C25289
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 22:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E7C3AC2D;
	Wed, 31 Jan 2024 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ac/pjXgl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132363AC08;
	Wed, 31 Jan 2024 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741491; cv=none; b=XWZhNShaNIM6acPD2EMov7sUShoXFoFbI9cTcPKPcAcyhqwjbAKUiletmEsK6WsM4MbCnF7ovQm6iTEURuk1X/y4dFW7M8a9u3n3DVshIfnMmDckqcUEIdbgenskXzd3LWdVRWL7UWcCozW4aYvfT7ZylZO3i0xZYsL4CXTGimU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741491; c=relaxed/simple;
	bh=Nhl2EaTUpODjHQutorpmjkWafAfvZJ01sjJAcSXGm64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m49vbH85FF5mDtG/K9+ftpPUW36UgD/PLnqUtbcbQe1CYojp6nh8tf3BvG1NCsNa7g8X76A5RQskdJdlLoW6Czj1dpS7qNaPbVVg/URXu5Of/DasLzKiQLhZqXeHXnFuKhslmPuGQs0Y2mpNwUlhKNG5Y4HkGLY14vUtK2KqQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ac/pjXgl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=sh+tfibFJrc5fXFRI7nnbRhkgKfoTUKszX9p6+Bo/nI=; b=ac/pjXgl+QMWEfv9zqf6oJE7h4
	lVhGi3Msw4sjocZRLZn/wEkxynhYjuyoyQUdUxHTHyinI52OQ0IS1RMBEbm1iNNDRAfL0C+aPlXhx
	zg3A1NznhWDs05/C6aob7CxHPiGoS0xuVsqYR3MM+q6e/W4gV6sXWI67RJ6F7zJ79gRo92nlHnB9a
	nupx2WkLGdkucxCeyf6/wLOKgOo30hfMNv3yvPnS5hxgIgX8POz5+wnl24blGZwp3Ceeteh6nOt2+
	7mL5b9X9Bcs4K2ytFMNZmHMOjak90zALEvw1/8I888QcHlG2qakGoTnyVjgMGrTLl+f1gevrGAysU
	Nd6mrakw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVJQW-00000005kZA-3md2;
	Wed, 31 Jan 2024 22:51:28 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	hare@suse.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	djwong@kernel.org,
	david@fromorbit.com,
	mcgrof@kernel.org
Subject: [PATCH v2 0/2] test_xarray: advanced API multi-index tests
Date: Wed, 31 Jan 2024 14:51:23 -0800
Message-ID: <20240131225125.1370598-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

This is a respin of the test_xarray multi-index tests [0] which use and
demonstrate the advanced API which is used by the page cache. This should
let folks more easily follow how we use multi-index to support for example
a min order later in the page cache. It also lets us grow the selftests to
mimic more of what we do in the page cache.

Changes since v1:

  - Fixed RCU stall, the issue was the misssing RCU locks when fetching
    an entry, so we now add test_get_entry() which mimics filemap_get_entry() 
  - Provide a bit more comments
  - Check for alignment on the index to the order on
    check_xa_multi_store_adv_add()
  - Use a helper check_xa_multi_store_adv_del_entry() to mimic what
    we do in page_cache_delete()

Changes since RFC:

  - Moved out from tmpfs large folio patches [1] so to keep these patches
    separate
  - Update cmpxchg test to include another entry at 1 << order that
    'keeps' the node around and order information.
  - Update cmpxchg test to verify the entries and order in all tied
    indexes.
  - Drop previous Luis Chamberlain's review as changes are significant
    from the RFC.

[0] https://lkml.kernel.org/r/20231104005747.1389762-1-da.gomez@samsung.com
[1] https://lore.kernel.org/all/20231028211518.3424020-1-da.gomez@samsung.com/

Daniel Gomez (1):
  XArray: add cmpxchg order test

Luis Chamberlain (1):
  test_xarray: add tests for advanced multi-index use

 lib/test_xarray.c | 218 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)

-- 
2.43.0


