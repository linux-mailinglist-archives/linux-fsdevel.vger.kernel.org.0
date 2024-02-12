Return-Path: <linux-fsdevel+bounces-11077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D6F850DBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 08:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9CB1C20D5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 07:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA668747D;
	Mon, 12 Feb 2024 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4aqPVakn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85579F1;
	Mon, 12 Feb 2024 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722041; cv=none; b=LbaI2HOsZQnjo37L/J2zwJkKA6o1YGA8rHgW7L/3zNS6aoGtR3TG7gT4wP0GskbjjBMkefMoZ7ovDnNPUWEYKpqnQGs0WJA9f5tYSYM2LOckFWwOC00tYHn4DKS397tnYQmEKeqhqAmtcukhiZGid1iaAtiWXLh56fJ9a7GLQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722041; c=relaxed/simple;
	bh=aH+LQ+OWUJrSKdONb2E3wcTN0nj8/ltVMlR9ZqYEZzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pWrm4gfz7SAt5Xs0iDA5CKlWewI1oUSqNIu9TchSi+dgekt/w1wzYHjMJa70sNexymXy86l3LOFQUcVOTZQ/hhPyP8aIUZcTGyre85lj/Ims9JhSuXl57EiCT+Ys4QhvhDu5x9aQ14CG71jlGmBSIZ8w55IiFAUd6qQ4Xa+upVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4aqPVakn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=F97bLYKX+BtaQqdKvZ6zCKr5tPLYltyO5pB8VnB7DyA=; b=4aqPVaknlyIJIU/z9Rj2PWIFIR
	gWqDxrfe5riQ85yrUwhbveTBuNTrirZObB9P/jMU7KtJMbKyYUBw6SNKsJqThxbUWHxEpkQxdlq5T
	yHVvpIkL34rbjQYM87m42lQmG7s0YeDzRLOse5XSIULK03Dmork+2CEUhoDf36pDaxjpm0AWVwG0Y
	Q7wwTmh3m18pwDpkodGLUxNCmk1d6CnoSPLx03FGnUHKtKw2rglu9qBDBfJjX66LSyjNDh43ur9ds
	Bzdx+PNRH6p8wrWY4E1MPXuTWnEZ++H+uSunR3UctYA8QJ/xRrhGBMiYUJ8XHfOkESLoaBY96PSqs
	VYA0UW+g==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQVo-00000004Slf-2xag;
	Mon, 12 Feb 2024 07:13:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: convert write_cache_pages() to an iterator v7
Date: Mon, 12 Feb 2024 08:13:34 +0100
Message-Id: <20240212071348.1369918-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this is an evolution of the series Matthew Wilcox originally sent in June
2023, which has changed quite a bit since and now has a while based
iterator.

Note that in this version two patches are so different from the previous
version that I've not kept any Reviews or Acks for them, even if the
final result look almost the same as the previous patches with the
incremental patch on the list.

Changes since v6:
 - don't access folio->index after releasing the folio batch
 - add a new patch to fix a pre-existing bug where a positive value is
   passed to mapping_set_error

Changes since v5:
 - completely reshuffle the series to directly prepare for the
   writeback_iter() style.
 - don't require *error to be initialized on first call
 - improve various comments
 - fix a bisection hazard where write_cache_pages don't return delayed
   error for a few commits
 - fix a whitespace error
 - drop the iomap patch again for now as the iomap map multiple blocks
   series isn't in mainline yet

Changes since v4:
 - added back the (rebased) iomap conversion now that the conflict is in
   mainline
 - add a new patch to change the iterator

Changes since v3:
 - various commit log spelling fixes
 - remove a statement from a commit log that isn't true any more with the
   changes in v3
 - rename a function
 - merge two helpers

Diffstat:
 include/linux/pagevec.h   |   18 ++
 include/linux/writeback.h |   12 +
 mm/page-writeback.c       |  389 ++++++++++++++++++++++++++--------------------
 3 files changed, 249 insertions(+), 170 deletions(-)

