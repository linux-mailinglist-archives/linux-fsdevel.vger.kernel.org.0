Return-Path: <linux-fsdevel+bounces-3282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7957F24E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 05:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B611C218CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 04:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A1D8BEF;
	Tue, 21 Nov 2023 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jQfcYKsP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66693DC;
	Mon, 20 Nov 2023 20:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bTJJPadAeJVnTikEqzzM+h8zjE6rG0xXKqndLgJTXvw=; b=jQfcYKsPwpTWa7v/kaXGCzm+ff
	7taxF0s3zGT4ROV5MxGt5w6BxRNbCyDUi3ZAoKczroeB4DSOzJbOayORz3iArrAfPlh2j1cJc6aRT
	dn1yL/sKZw2TVgppkBeO9kw4rBVJDAB2PQBvp1DEr4ragN1rNsExR9cF3JiT7xdj+9oNPxaK1GX/d
	qlNL2NsAGExG1YcFb76Hv+zAc3VDSLZlEzbFvToKTayUO0MSVbNEg8pv5z6sD705dE7cfvzV2obDi
	YqmSD7QSrCpn96RdAUCZK9u5F8BbatrqJ6s+RGifuIBWThQVHHQV0QRL1B9I4G+ui9Sm0HAFgA+wv
	Ggca/7Aw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5IXo-00Fbn9-2Z;
	Tue, 21 Nov 2023 04:39:28 +0000
Date: Mon, 20 Nov 2023 20:39:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 1/3] ext2: Fix ki_pos update for DIO buffered-io fallback
 case
Message-ID: <ZVw0gJ8uqzsdGABV@infradead.org>
References: <cover.1700506526.git.ritesh.list@gmail.com>
 <9cdd449fc1d63cf2dba17cfa2fa7fb29b8f96a46.1700506526.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cdd449fc1d63cf2dba17cfa2fa7fb29b8f96a46.1700506526.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 21, 2023 at 12:35:19AM +0530, Ritesh Harjani (IBM) wrote:
> Commit "filemap: update ki_pos in generic_perform_write", made updating
> of ki_pos into common code in generic_perform_write() function.
> This also causes generic/091 to fail.
> 
> Fixes: 182c25e9c157 ("filemap: update ki_pos in generic_perform_write")

Looks like this really was an in-flight collision with:
fb5de4358e1a ("ext2: Move direct-io to use iomap").  How did we manage
to not notice the failure for months, though?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

