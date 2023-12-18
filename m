Return-Path: <linux-fsdevel+bounces-6367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD7581756A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EF21F24B9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CA949884;
	Mon, 18 Dec 2023 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hr8byNok"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6A3D557;
	Mon, 18 Dec 2023 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=RI7QSWqpW/rXOSRWmDYPC2oSmh16kWQUwrhbSyLEfQE=; b=hr8byNokwE2STMeHvc1D6nVSD7
	HY4KMjQkEHSA6KKAYU3EMbGbDd61EizaOitfi2q47tbqkHkCXMJvKKra6kGOwnE6FM5JWNNqwb7Wq
	sKxXqwePDIeAq75ju43zRv8/f3XKuI4OYwY2uv35FyDQAeWHR/ARBjgHp0xeqFbBYVSJvxGwoBOto
	uJli+WJtw1f+u3NbdclmwVazKFxCxW3XAg6xP9rMED7G49LKm8WOzb6GSpqF3n651wQwRgz8sd0Yq
	XfrTinM8CzSi1KYt0hMdjpIKESyAB/6MGND/n4Ivl1V7dYFG5swW0Fbhf1i9YRJEy0dhZxLVpvmOF
	yzYTtEww==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFes-00BEFW-2N;
	Mon, 18 Dec 2023 15:35:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Convert write_cache_pages() to an iterator v3
Date: Mon, 18 Dec 2023 16:35:36 +0100
Message-Id: <20231218153553.807799-1-hch@lst.de>
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

this is basically a evolution of the series Matthew Wilcox originally
set in June.  Based on comments from Jan a Brian this now actually
untangles some of the more confusing conditional in the writeback code
before refactoring it into the iterator.  Because of that all the
later patches need a fair amount of rebasing and I've not carried any
reviewed-by over.

The original cover letter is below:

Dave Howells doesn't like the indirect function call imposed by
write_cache_pages(), so refactor it into an iterator.  I took the
opportunity to add the ability to iterate a folio_batch without having
an external variable.

This is against next-20230623.  If you try to apply it on top of a tree
which doesn't include the pagevec removal series, IT WILL CRASH because
it won't reinitialise folio_batch->i and the iteration will index out
of bounds.

I have a feeling the 'done' parameter could have a better name, but I
can't think what it might be.

Diffstat:
 include/linux/pagevec.h   |   18 ++
 include/linux/writeback.h |   19 ++
 mm/page-writeback.c       |  333 +++++++++++++++++++++++++---------------------
 3 files changed, 220 insertions(+), 150 deletions(-)

