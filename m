Return-Path: <linux-fsdevel+bounces-8844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A2283BC74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5232887C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 08:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3841BC5A;
	Thu, 25 Jan 2024 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="owPlqsT3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D36E1B97F;
	Thu, 25 Jan 2024 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173096; cv=none; b=aUfZ67VQgPGjRiQUOQu5DWFqE+/WqV63mT5M6VltV9yq7tP4+ts0bytOjUmfPRJSfknVYn4rd+En8O9N7ZFQspy2o2esyEPgoiZOQlTeqVRDpTtYc1ZkPxgEvrF5lNwsm6f2yi5L6n9oTeD7XHUInlY9F8jm3l3NLCSF4m5Sb9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173096; c=relaxed/simple;
	bh=drBwOfH1AGu+6d7cxyokt4683yCqbVSYcXM7b20ryMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sKIxI+IDxOielC3ASUVDg5XGD7sC7IRlvO5PmjVbraD00uAyJGYnSpL6iFgs9f1mc7723CxTfRGqjv5b4Azf258anUFoo7cmu8ywRzyNbnRVGF/qv/UhgBlm90ggevxm8UuDV4FHwLsamew6g501XitXBzAv+ArGiFXHZGNUqQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=owPlqsT3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=RA8V8EA4rA8rQA73Mc1Vf6KwiS+UOimfzJVh7CVG65w=; b=owPlqsT3O9aPf7GsLEuOhaWwm/
	F9fZByMek3weUp/Tn0B8XXcEI1wGTaRNwTk4Q5g1m39aJRSzh+QjHw6MhVjTHQfLNcBTJctkAKYe0
	fQRrtpUOkrQ0NC4qEMFs6YLIlolfim1wli9+T5fD6qtr0K4gd4ls2gsB2r8qmxRPtVStH0GFiWVsU
	w9f7GF4ablqHIgutdPXZXXEBxj3A2KgTuKuOqDtEd3QwvSadVyl1eVwA+pV3lbqJW2D20pbo92l8C
	acymCgyBnto3PtRrJ7SF435WyfTNpO3CAHrIbAf8Qu0178Yes/Bo4PRiKFUD12O7GJJhDT0vXGSDz
	Tsovl5GA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvYi-007Q75-03;
	Thu, 25 Jan 2024 08:58:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Convert write_cache_pages() to an iterator v5
Date: Thu, 25 Jan 2024 09:57:39 +0100
Message-Id: <20240125085758.2393327-1-hch@lst.de>
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
2023.  Based on comments from Jan and Brian this now actually untangles
some of the more confusing conditional in the writeback code before
refactoring it into the iterator.

This version also adds a new RFC patch at the end that totally changes
the API again to a while loop, based on commnts from Jan and some of
my idea.  Let me know if that is a good idea or not, and if yes I'll
fold the changes into the earlier patches.

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
 fs/iomap/buffered-io.c    |   10 -
 include/linux/pagevec.h   |   18 ++
 include/linux/writeback.h |   12 +
 mm/page-writeback.c       |  344 ++++++++++++++++++++++++++--------------------
 4 files changed, 231 insertions(+), 153 deletions(-)

