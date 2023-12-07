Return-Path: <linux-fsdevel+bounces-5156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3841F808ABC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 15:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C27F2817FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDABE44370
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UPh8c4t6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8C9D5E
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 05:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ivhe9DC/n0w5JVpBZIBNHCwAubZch0gSLFHhE52rGQg=; b=UPh8c4t6hFH1wgDykavB5B/jFA
	0cTu3HsmwTBTS3DeHVrB+B1/de6DSldY52ut6U6Ekq7orAQA9vsQkPflvdHl1AezAYgmYWoQPRyDP
	XZVtRAy8CmEufirR4mJGbC8ZpBCA66BeZ6fizDlJKzoNM034/jeHgk20JpTvA3tQNoGsIIwupjl0y
	HKRU3u8RBPr1Flt2Xsajh2ex56098uHkiB4RbyKVMY46lurc1lrQDmhmXuFodT28vYq7dr6xkot4U
	H4xPU6GaNLqpcxwbVeBOyrxF6XBEsWklzYJ+Grq8JNz12nF5kuoT9onO/OUr4esp+gWqHywpPj6GS
	PwbOEXkw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBEKJ-003v9I-Se; Thu, 07 Dec 2023 13:22:03 +0000
Date: Thu, 7 Dec 2023 13:22:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] freevxfs: Convert vxfs_immed_read_folio to the new folio
 APIs
Message-ID: <ZXHG+/aAiaDvLBxr@casper.infradead.org>
References: <20231206204629.771797-1-willy@infradead.org>
 <ZXFW8yGT3uuGgObF@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXFW8yGT3uuGgObF@infradead.org>

On Wed, Dec 06, 2023 at 09:24:03PM -0800, Christoph Hellwig wrote:
> On Wed, Dec 06, 2023 at 08:46:29PM +0000, Matthew Wilcox (Oracle) wrote:
> > Use folio_fill_tail() and folio_end_read() instead of open-coding them.
> > Add a sanity check in case a folio is allocated above index 0.
> 
> Where do these helpers come from?  Can't find them in Linus' tree.

Is your tree out of date?

0b237047d5a7 for folio_end_read()
$ git describe --contains 0b237047d5a7
v6.7-rc1~90^2~161

folio_fill_tail() appears to only be in akpm's tree for now.  Looks like
it's still in the 'unstable' part for now, so no sha1 for that.

