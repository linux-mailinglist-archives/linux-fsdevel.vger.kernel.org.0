Return-Path: <linux-fsdevel+bounces-6059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B638681315F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 14:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE1C2831C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 13:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCBE55C29;
	Thu, 14 Dec 2023 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="msTwUCdv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFA210F;
	Thu, 14 Dec 2023 05:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=LREzFOiIV3fjDw34Jpih46a+FLwDl5jbzLHg7aSD75g=; b=msTwUCdvMHb/A7UZZVc4eJcwh8
	Rg0CdLaGQkHv71MLerQ3i16FSDMF/Ai6tyMaxiCaM5BEDwKP4Gqll992eRMuqwt71Jx8zumA+UG4O
	JcRee4RYP9MvyVu4ZEgNZ52P7eIGxvmrnZgzl5zQL79PU85dZ+JTD4ri0YY0nucSK6oyPoHGgBDHe
	Fi5FyVjmUg0asyhaG4lC3vY7TYdptWnvjCi3QFK+FR+q1HfAv8mZ19y8gi+rC/v4buCm9w4OEg1J1
	W5R6hAHk/WC+auX7wcV5GzH24haPOpXdrd/Z3lxW80kvt9ULJoV0bolRfcORbOf69ppwCN5PwrrUe
	3SpeRZiQ==;
Received: from [88.128.88.27] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDlil-000N0X-2K;
	Thu, 14 Dec 2023 13:25:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>
Subject: Convert write_cache_pages() to an iterator v2
Date: Thu, 14 Dec 2023 14:25:33 +0100
Message-Id: <20231214132544.376574-1-hch@lst.de>
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

this is basically a report of willy's series of the same name for June.
I picked the lastest version from his (now apparently defunct) git tree,
rebased it to mainline (no coflict, neither for linux-next), reordered
the new fields in struct writeback_control to document what is interface
vs internal, and temporarily dropped the iomap patch due to a conflict
in the VFS tree.

willy: let me know if me reposting it like this is fine, or if you
want me to stop.  I'd just really like to see it merged :)
Note that patch 4 is missing your signoff, so we'd need that before
proceeding anyway.

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
 include/linux/writeback.h |   24 +++
 mm/page-writeback.c       |  313 +++++++++++++++++++++++++---------------------
 3 files changed, 211 insertions(+), 144 deletions(-)

