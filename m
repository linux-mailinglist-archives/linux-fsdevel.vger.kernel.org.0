Return-Path: <linux-fsdevel+bounces-3353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505DE7F3E56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 07:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EBD281B3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 06:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1462154B3;
	Wed, 22 Nov 2023 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E0tFtqMS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B518C19D;
	Tue, 21 Nov 2023 22:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cA2Q4f+X/ZRKmAJlXbSlP30H8vlF/XZ2uQeO8VuY2pY=; b=E0tFtqMSauHu032M485YbQVBB5
	bneFh/fXzbvWqzmcCcCMQX6eEHmpsFDi30aTv8xpkU3KGSEZbcL6Z7Zvu2JjCMiTzTe14+TTp3Zv4
	U56KdVndiSmnHxUuYzUW8Fg9+7xOx/K/v1BJegzjjST7+X9dhu+cAbavaUCsT/j05YedAha5P0nPy
	dlRxazPEVG3Okax0u1pqqTNERRq267nbhyRTQKIYgEuuCkSCKjKRON1p8INbM96a8ZlTfh8GwP0ni
	qX2H6qzqtRWsDOtsAdRVH3nd1jprX9oCqRw4F9mdUTdXqy0VEJ7qcQ0FnSrO9ge4EI2F2rcDORORn
	3kORGsxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5h5C-000rOf-14;
	Wed, 22 Nov 2023 06:51:34 +0000
Date: Tue, 21 Nov 2023 22:51:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 1/3] ext2: Fix ki_pos update for DIO buffered-io fallback
 case
Message-ID: <ZV2k9pR13SbXitRT@infradead.org>
References: <ZVw0gJ8uqzsdGABV@infradead.org>
 <877cmby8ei.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cmby8ei.fsf@doe.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 21, 2023 at 11:06:53AM +0530, Ritesh Harjani wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > On Tue, Nov 21, 2023 at 12:35:19AM +0530, Ritesh Harjani (IBM) wrote:
> >> Commit "filemap: update ki_pos in generic_perform_write", made updating
> >> of ki_pos into common code in generic_perform_write() function.
> >> This also causes generic/091 to fail.
> >> 
> >> Fixes: 182c25e9c157 ("filemap: update ki_pos in generic_perform_write")
> >
> > Looks like this really was an in-flight collision with:
> > fb5de4358e1a ("ext2: Move direct-io to use iomap").  How did we manage
> > to not notice the failure for months, though?
> 
> Yes, it was due to in-flight collision. I found it during this conversion and
> also noticed that generic/091 fails on upstream kernel.

Maybe ammend the commit message with that information and then it off
for inclusion into 6.7-rc and -stable ASAP?


