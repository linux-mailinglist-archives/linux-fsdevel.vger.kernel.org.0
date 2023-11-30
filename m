Return-Path: <linux-fsdevel+bounces-4322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 894807FE857
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 05:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5E4B20CF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 04:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB831DA26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cQF0DvTO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5107110DB;
	Wed, 29 Nov 2023 20:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3eVTSPU/wHc1JxPlc9sW5c1lU34h67IEdzpeTekuaiM=; b=cQF0DvTO/vJOPZ8a3h7bZqdMwc
	EV94pQnXknE9uCAeBH8zeE4XdgstKhhm0A8asG7CVIXLyyMrnR236UIdc1FNqbnflOrx6HZlMdCQC
	Q2S9isiopWOoyjVoMTcoBpf75VkovSU5UvKHL8l/Bq6UGl3HQG5Cky7WnC1420ztJHtfP28oOFEdV
	pwBFTSlmf/0teUV68i7lBlvSVhfyQkieE8ElftYYVOE256hVpaK2oHzR2JbK4DCkvnnwxhU9rWFLL
	krG2CL9qwaafRCi2IL12zlHI8hP9VTg5nqEDDe8fVEUSrXNziGTaf2fsa/G7KPlW0tOm2jNmb/w4r
	rbhrsomg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r8YZh-00E4tj-J3; Thu, 30 Nov 2023 04:22:53 +0000
Date: Thu, 30 Nov 2023 04:22:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <ZWgOHWyUW+bJWTkQ@casper.infradead.org>
References: <87msv5r0uq.fsf@doe.com>
 <8734wnj53k.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734wnj53k.fsf@doe.com>

On Thu, Nov 30, 2023 at 08:54:31AM +0530, Ritesh Harjani wrote:
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index 677a9ad45dcb..882c14d20183 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -663,6 +663,7 @@ struct ext2_inode_info {
>  	struct rw_semaphore xattr_sem;
>  #endif
>  	rwlock_t i_meta_lock;
> +	unsigned int ib_seq;

Surely i_blkseq?  Almost everything in this struct is prefixed i_.


