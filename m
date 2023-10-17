Return-Path: <linux-fsdevel+bounces-510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F6F7CBA79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 08:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D41F281768
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 06:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A05C8C8;
	Tue, 17 Oct 2023 06:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rZpBase/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B81C2CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 06:01:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C221A2;
	Mon, 16 Oct 2023 23:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4bEHl2/EkI0ra4f4Wh8/YbcmlifE4mAAH5TzvuP3FPs=; b=rZpBase/H9lCbb7wClp5H+3hqK
	svNmCn/GuNUzHIhElX68yOPUxts5EB4vtiYchsy7PJR04VNYXr0DAIipgVNwWx/rejJ1oFW/KQ513
	e3gFgJNVzQhDJ4irHVzV/0JS+kPq+EEy1L16Bs++d02yXGM01EwFP4nCoMBMYEtkPJ9gAWn5tVfEO
	88RRvfVfLR8xICaUHj+7V+9YVphPsmLAOi5NPTGcM9MwCqqaoT78WBhHofPSYnX12zCHbWlKfoaap
	ECpWX8e+7ksNEFGamQMrVHIL3XUA8v5hr9umGTlA8p4WnUh6/lHW3kvEusLg2vYKgLKZEWQssGSnr
	mBcAjUEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qsd8h-00BLVN-28;
	Tue, 17 Oct 2023 06:01:11 +0000
Date: Mon, 16 Oct 2023 23:01:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	david@fromorbit.com, dchinner@redhat.com
Subject: Re: [PATCH v3 07/28] fsverity: always use bitmap to track verified
 status
Message-ID: <ZS4jJ/3VxSoEVYxl@infradead.org>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-8-aalbersh@redhat.com>
 <20231011031543.GB1185@sol.localdomain>
 <q75t2etmyq2zjskkquikatp4yg7k2yoyt4oab4grhlg7yu4wyi@6eax4ysvavyk>
 <20231012072746.GA2100@sol.localdomain>
 <20231013031209.GS21298@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013031209.GS21298@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 08:12:09PM -0700, Darrick J. Wong wrote:
> I frankly have been asking myself why /this/ patchset adds so much extra
> code and flags and whatnot to XFS and fs/verity.  From what I can tell,
> the xfs buffer cache has been extended to allocate double the memory so
> that xattr contents can be shadowed.  getxattr for merkle tree contents
> then pins the buffer, shadows the contents, and hands both back to the
> caller (aka xfs_read_merkle_tree_block).   The shadow memory is then
> handed to fs/verity to do its magic; following that, fsverity releases
> the reference and we can eventually drop the xfs_buf reference.
> 
> But this seems way overcomplicated to me.  ->read_merkle_tree_page hands
> us a pgoff_t and a suggestion for page readahead, and wants us to return
> an uptodate locked page, right?

It does.  That beeing said I really much prefer the block based
interface from Andrey.  It is a lot cleaner and without weird page
cache internals, although it can still be implemented very nicely
by file systems that store the tree in the page cache.

> The only thing I can't quite figure out is how to get memory reclaim to
> scan the extra address_space when it wants to try to reclaim pages.
> That part ext4 and f2fs got for free because they stuffed the merkle
> tree in the posteof space.

Except for th magic swapper_spaces, and address_space without an
inode is not a thing, so you need to allocate an extra inode anyway,
which is what reclaim works on.


