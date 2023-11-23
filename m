Return-Path: <linux-fsdevel+bounces-3505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FCA7F58C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 08:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DF5281842
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 07:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638E91401F;
	Thu, 23 Nov 2023 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vPYSXaRA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47FE91;
	Wed, 22 Nov 2023 23:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wGp8wkm1UDcmb84ZHwflLaHhqE+fC1a0uk/PE7zSUac=; b=vPYSXaRALrc/Uz1cQO2Sq51v8I
	TS2Lzn2E+ZJpBPpkCKccvCz/HQ4y3E2VDGpjaffHXmho0yEteK2TSeMDi+EY05egavpeCk9WBky9Z
	RYXMrzDICyh444lnHviZf9DzcZv9czI1pLQWUQ4D5Z0vYUmFqqBv0MGltYbGfdcZnYIFgFchc4j79
	Ioz7b1XA5yq3bMUvWHnlK8UfqZ87JlSC+G6DZiHHlvHeuRMTR0oaxkfQYDar0OPsGphLTfFYKv3jB
	AAt/eK4j6kDzkt/rAhHTUhCpkF5NzkaRho1EQgiAi7azLW7Xpsasev88kZSetEb4bHcNkAXOiTNOw
	0OZI+4aQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r63ir-003yVI-0J;
	Thu, 23 Nov 2023 07:02:01 +0000
Date: Wed, 22 Nov 2023 23:02:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <ZV746epxvXHbdivA@infradead.org>
References: <cover.1700506526.git.ritesh.list@gmail.com>
 <f5e84d3a63de30def2f3800f534d14389f6ba137.1700506526.git.ritesh.list@gmail.com>
 <20231122122946.wg3jqvem6fkg3tgw@quack3>
 <ZV399sCMq+p57Yh3@infradead.org>
 <ZV6AJHd0jJ14unJn@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV6AJHd0jJ14unJn@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 23, 2023 at 09:26:44AM +1100, Dave Chinner wrote:
> I think that was me

No, it was Darrick.  We talkd about a lot of things, but not this :)

> , as part of aligning the writeback path with
> the ->iomap_valid() checks in the write path after we lock the folio
> we instantiated for the write.
> 
> It's basically the same thing - once we have a locked folio, we have
> to check that the cached iomap is still valid before we use it for
> anything.

Yes.  Currently we do that in the wb ops ->map_blocks.  This can get
called multiple times per folio, which is a bit silly.  With the series
I just posted the link to we at least stop doing that if the folio
is mapped contiguously, which solves all practical cases, as the
sequence check is almost free compared to the actual block mapping.

For steps beyond that I'll reply to Darrick's mail.

