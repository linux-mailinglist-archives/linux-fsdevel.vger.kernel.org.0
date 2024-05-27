Return-Path: <linux-fsdevel+bounces-20217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B7A8CFDF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 12:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B191C20DF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 10:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0CA13AD1C;
	Mon, 27 May 2024 10:15:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.cecloud.com (unknown [1.203.97.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7A913AD34;
	Mon, 27 May 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804909; cv=none; b=utJbKqmwmbGZyNcA+1anEXKtmnf7hZIC/mMOLH99/WifiYqCP0vmS2TjDxIp09SiFwMTBUybe+RTTtgIOJd/e0dE7eSoBsgBMMw1ENwVVTU9iD8eNka9uEZRpJt7G4Vb2fIG28xDzUNXC64UqUQDXQ7Ug41oEDfmP6czUjowwcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804909; c=relaxed/simple;
	bh=t4855T7zRAAyXJTGdNBnjyzLLE/1b84BjFAew89mgrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiX0C7q/8CJOoNw8dP7WxVoCCSCCam3JmO6RJcPJCetcZbrCmtbPAhgy11uhQFvQ9ioBaOfg7pPdIvf3HLzMYCHMbt5iA7ybzpZbbJsN4SfXOUq0FsCf6GBWI7hT7tqNCQZ7vIzBEvQKoIUtdLF8bHSC7lGGDHwFGSyYqf0JsRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 24381900112;
	Mon, 27 May 2024 18:09:10 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-ANTISPAM-LEVEL:2
X-ABS-CHECKED:0
Received: from localhost.localdomain (unknown [111.48.58.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P894637T281473226436976S1716804548742756_;
	Mon, 27 May 2024 18:09:10 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:liuwei09@cestc.cn
X-SENDER:liuwei09@cestc.cn
X-LOGIN-NAME:liuwei09@cestc.cn
X-FST-TO:axboe@kernel.dk
X-RCPT-COUNT:9
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:111.48.58.12
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<acfc3dfd82f899d0dbff6eb8768ac03f>
X-System-Flag:0
From: Liu Wei <liuwei09@cestc.cn>
To: axboe@kernel.dk
Cc: akpm@linux-foundation.org,
	hch@lst.de,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuwei09@cestc.cn,
	rgoldwyn@suse.com,
	willy@infradead.org
Subject: Re: [PATCH] mm/filemap: invalidating pages is still necessary when io with IOCB_NOWAIT
Date: Mon, 27 May 2024 18:09:08 +0800
Message-ID: <20240527100908.49913-1-liuwei09@cestc.cn>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <024b9a30-ad3b-4063-b5c8-e6c948ad6b2e@kernel.dk>
References: <024b9a30-ad3b-4063-b5c8-e6c948ad6b2e@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am a newer, thanks for the reminder.

> 
> >> when we issuing AIO with direct I/O and IOCB_NOWAIT on a block device, the
> >> process context will not be blocked.
> >>
> >> However, if the device already has page cache in memory, EAGAIN will be
> >> returned. And even when trying to reissue the AIO with direct I/O and
> >> IOCB_NOWAIT again, we consistently receive EAGAIN.
> 
> -EAGAIN doesn't mean "just try again and it'll work".
> 
> >> Maybe a better way to deal with it: filemap_fdatawrite_range dirty pages
> >> with WB_SYNC_NONE flag, and invalidate_mapping_pages unmapped pages at
> >> the same time.
> >>
> >> Signed-off-by: Liu Wei <liuwei09@cestc.cn>
> >> ---
> >>  mm/filemap.c | 9 ++++++++-
> >>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mm/filemap.c b/mm/filemap.c
> >> index 30de18c4fd28..1852a00caf31 100644
> >> --- a/mm/filemap.c
> >> +++ b/mm/filemap.c
> >> @@ -2697,8 +2697,15 @@ int kiocb_invalidate_pages(struct kiocb *iocb, size_t count)
> >>  
> >>  	if (iocb->ki_flags & IOCB_NOWAIT) {
> >>  		/* we could block if there are any pages in the range */
> >> -		if (filemap_range_has_page(mapping, pos, end))
> >> +		if (filemap_range_has_page(mapping, pos, end)) {
> >> +			if (mapping_needs_writeback(mapping)) {
> >> +				__filemap_fdatawrite_range(mapping,
> >> +						pos, end, WB_SYNC_NONE);
> >> +			}
> 
> I don't think WB_SYNC_NONE tells it not to block, it just says not to
> wait for it... So this won't work as-is.

Yes, but I think an asynchronous writex-back is better than simply return EAGAIN.
By using __filemap_fdatawrite_range to trigger a writeback, subsequent retries
may have a higher chance of success. 

> 
> >> +			invalidate_mapping_pages(mapping,
> >> +					pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> >>  			return -EAGAIN;
> >> +		}
> >>  	} else {
> >>  		ret = filemap_write_and_wait_range(mapping, pos, end);
> >>  		if (ret)
> >> -- 
> >> 2.42.1
> >>
> >>
> >>



