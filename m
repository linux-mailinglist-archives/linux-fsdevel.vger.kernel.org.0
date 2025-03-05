Return-Path: <linux-fsdevel+bounces-43296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09538A50CB9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 21:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE5D189308A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5FD2571A1;
	Wed,  5 Mar 2025 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AipBW1p9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACACA252912
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207660; cv=none; b=Yg3M+oAsHE+STDIs34PIY5Uim0PcjxJVSISSmFwuNJQ/d5p7QnODOiX+P44nEZoGnjDyIHyRIeKFyQQa/Vfxxf5IsviukP9QC+sJKANsusDGZOMII4ZFN8yfKr3TnWX0QCIX1Ie4wEAlZDt06b6KGFgP29JkB7KaRMPoC2Zqk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207660; c=relaxed/simple;
	bh=ShsOyCUUBkZroxrZD9cixPV7XdY1Dds17gkhH2V4+1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I8oDjvGyy8BRW9cZK1qIqmYfutjY1bvKcSxsSygMD2VuoTQsQAAN5bcAtZCioYkQPySQZsSJxHlReNUkORxlM1Cuw4T9mfuDTtZldZmmMwrfXX6FyRJmS07xlDW4n6GdP5rF7hMGemTxRo5zu88tLROjI/kKFZ/RLpi7MtAYWkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AipBW1p9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=KGnqv7nCx6zfFSnopihPPSx+5SywUjQW1/rYadbbBPk=; b=AipBW1p9Z9kcbXAIhXDLvW0hHs
	VsMG1aawmqPzEx1zqZN42zJO9BQH02zV+TZ7cOeHR1c5y0nca7Y4tTs6TrNriyYLVU6VcCdAzbd74
	868pGOFxoOjoHa2Vdlz3+Al0bGcZUA8sNlkr6GO3IJUm6V12c6r0TdhlJmLWE64Y4A9pSgIdcqzGX
	Yh4Vwcnnjpx8pQ8DvK7F5ubFDeXOdO0wmhCqULQb3gx4GYgYL+V21WQnhPFEbVmMZTZReC8V8nX3x
	2uIkbX3ci5O71Bl4F+GwP7iLAtyc27Eld99KO6+SqVRB/ebYvyYADf8GRfrggN07cIuM2l13Xp0W/
	3j99BOfg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpveS-00000006Bmr-1OmL;
	Wed, 05 Mar 2025 20:47:36 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/9] Orangefs fixes for 6.15
Date: Wed,  5 Mar 2025 20:47:24 +0000
Message-ID: <20250305204734.1475264-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The start of this was the removal of orangefs_writepage(), but it quickly
spiralled into a more comprehensive cleanup.  The first patch is an
actual bug fix.  I haven't tagged it for backport, as I don't think we
really care about 32-bit systems any more, but feel free to add a cc to
stable if you disagree.

Patches 2 and 3 are compilation fixes for warnings which aren't enabled
by default.

Patches 4-9 are improvements which simplify orangefs or convert it
from pages to folios.  There is still a little use of 'struct page'
in orangefs, but it's not in the areas that deal with the page cache.

Matthew Wilcox (Oracle) (9):
  orangefs: Do not truncate file size
  orangefs: Move s_kmod_keyword_mask_map to orangefs-debugfs.c
  orangefs: make open_for_read and open_for_write boolean
  orangefs: Remove orangefs_writepage()
  orangefs: Convert orangefs_writepage_locked() to take a folio
  orangefs: Pass mapping to orangefs_writepages_work()
  orangefs: Unify error & success paths in orangefs_writepages_work()
  orangefs: Simplify bvec setup in orangefs_writepages_work()
  orangefs: Convert orangefs_writepages to contain an array of folios

 fs/orangefs/file.c             |   4 +-
 fs/orangefs/inode.c            | 149 ++++++++++++++-------------------
 fs/orangefs/orangefs-debug.h   |  43 ----------
 fs/orangefs/orangefs-debugfs.c |  43 ++++++++++
 4 files changed, 109 insertions(+), 130 deletions(-)

-- 
2.47.2


