Return-Path: <linux-fsdevel+bounces-3431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75AE7F4766
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 14:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B302B20E05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1294D592;
	Wed, 22 Nov 2023 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v86cmPCG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD65E193;
	Wed, 22 Nov 2023 05:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O9oHYEGAsBYsLtvmTaKA7FT2Xc3nhsN3tRuqsnNUyXw=; b=v86cmPCGyJdVriNiyDRPZ8/Nec
	qkyMDRWSfoiMNMtTWuHka7jqm82Mwfk+oYaoZkqEOfXcrBMXFlP1SlX9lfC0C0r8SzwV4CwEeaFxn
	g5QU6EA64QZTM3a6x5/KfCZ7d991XHjDMPckS18F1A2/ZU3FL7agQ5IomttUw7wwEUg7b1bKLVfYy
	27D5wOWNtYn48fcrpDCCrvIoCKio01Qk9BD4rXwkzaMG0KlovJc6Xx8kIzjtoqcLLyAPz68er0PKX
	WYJR+S7LfSbStGLFgVERAbx0d5GmlJKpzLex4ltdXJNW5fAd5Q4nur1i6dxH+LaPHfbB+M/SuXNu0
	9NVzdjxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5n0g-001ubH-38;
	Wed, 22 Nov 2023 13:11:18 +0000
Date: Wed, 22 Nov 2023 05:11:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <ZV399sCMq+p57Yh3@infradead.org>
References: <cover.1700506526.git.ritesh.list@gmail.com>
 <f5e84d3a63de30def2f3800f534d14389f6ba137.1700506526.git.ritesh.list@gmail.com>
 <20231122122946.wg3jqvem6fkg3tgw@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122946.wg3jqvem6fkg3tgw@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 22, 2023 at 01:29:46PM +0100, Jan Kara wrote:
> writeback bit set. XFS plays the revalidation sequence counter games
> because of this so we'd have to do something similar for ext2. Not that I'd
> care as much about ext2 writeback performance but it should not be that
> hard and we'll definitely need some similar solution for ext4 anyway. Can
> you give that a try (as a followup "performance improvement" patch).

Darrick has mentioned that he is looking into lifting more of the
validation sequence counter validation into iomap.

In the meantime I have a series here that at least maps multiple blocks
inside a folio in a single go, which might be worth trying with ext2 as
well:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/iomap-map-multiple-blocks

