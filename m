Return-Path: <linux-fsdevel+bounces-75516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ7vK/W9d2l8kgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:18:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E3B8C791
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFFAA3032F47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 19:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0FD27B34F;
	Mon, 26 Jan 2026 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n21P7Beg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588541DE3DC;
	Mon, 26 Jan 2026 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455016; cv=none; b=KlYUcgCfEHB+R1FXJ2bAF9zVj61PpiLsAWMJtzhD5mxOJvhnlgy+R4yu04jw/9J6TCBZUTjYLHzNBgCTyIf8+qsIPAXYT8PB983No7mvuPrW/b4H6AGQ+FBXUCrNgvngFS+WHBlp/OG3TKrXKv0JfuY0hppHmObbNR41tS7csFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455016; c=relaxed/simple;
	bh=YCY0ffj1SdQo4GMFAbxGXa4s96vFKDUPsIOH/Mkrh9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p17SxhLE/xcJ3Aj82+Cl48SIPo0aXGSrsBNa0jJnMaXTgBrbSTtnpVawXfagww37+jG3MNJrn8u+XQebKhZTqw3QHrdKqLGHA1bFwxiof+vx9/6xL9FS301ssolBEgPCpn3AuB+aoYwW2u025BLV64sMtr8eqNu97uJRTsXOkMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n21P7Beg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rMO2xX5xP28Q60xOnHu+vXD5aA6ESMshNUI0W1W6UHw=; b=n21P7BegJ2WRIBtQlJooTVh9Lv
	9qFMD4jFHFi5XLAdogjd7y5b9kzy5uKXUh1V4E8B8NVyixXLt5FOfj8pWW2wO0SmvIdmWs0pPzVSa
	CvtXf9tIrxNjnIoXVBdgqmGh61ymkcIqIV9sdQToF3R3UqFSitcK0SB9nnWVkSo8I+UcBwA+k8L/j
	Ed09wbguCxvSghmXBEHmM0N366SuB1gGgbEEd7xGC1KOMSgGwHJf869Eg7m/nKrf0Gf+SeTKDg27T
	gYWcl/t8UXdtRkf9prJF8CFP6hxeiO3uMG5GhTFobCui0ibGRs/vHCucAUcbSwW0XDA1dpmVslQdf
	BgugbjAw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkS4s-00000006MVP-1o4U;
	Mon, 26 Jan 2026 19:16:46 +0000
Date: Mon, 26 Jan 2026 19:16:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Cong Wang <cwang@multikernel.io>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	multikernel@lists.linux.dev
Subject: Re: [ANNOUNCE] DAXFS: A zero-copy, dmabuf-friendly filesystem for
 shared memory
Message-ID: <aXe9nhAsK2lzOoxY@casper.infradead.org>
References: <CAGHCLaREA4xzP7CkJrpqu4C=PKw_3GppOUPWZKn0Fxom_3Z9Qw@mail.gmail.com>
 <55e3d9f6-50d2-48c0-b7e3-fb1c144cf3e8@linux.alibaba.com>
 <CAGHCLaQbr2Q1KwEJhsZGuaFV=m6WEkxsgurg30+pjSQ4dHQ_1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGHCLaQbr2Q1KwEJhsZGuaFV=m6WEkxsgurg30+pjSQ4dHQ_1Q@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75516-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,vger.kernel.org,gmail.com,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07E3B8C791
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 09:38:23AM -0800, Cong Wang wrote:
> If you are interested in adding multikernel support to EROFS, here is
> the codebase you could start with:
> https://github.com/multikernel/linux. PR is always welcome.

I think the onus is rather the other way around.  Adding a new filesystem
to Linux has a high bar to clear because it becomes a maintenance burden
to the rest of us.  Convince us that what you're doing here *can't*
be done better by modifying erofs.

Before I saw the email from Gao Xiang, I was also going to suggest that
using erofs would be a better idea than supporting your own filesystem.
Writing a new filesystem is a lot of fun.  Supporting a new filesystem
and making it production-quality is a whole lot of pain.  It's much
better if you can leverage other people's work.  That's why DAX is a
support layer for filesystems rather than its own filesystem.

