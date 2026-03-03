Return-Path: <linux-fsdevel+bounces-79250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO/TDHL5pmk7bgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 16:08:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9AE1F20ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 16:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F012530391CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589223D5651;
	Tue,  3 Mar 2026 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X8mUOnY0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD23A6F05;
	Tue,  3 Mar 2026 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550239; cv=none; b=U+wRv52Z0/1Or/EXNtYOx2wjQKqOWYKhtav4pRXvTKZDsa8B5jDkDdtK/9Cho5cQnn2hOLi18CmPpdLIfxNsBM08nFPacUeW6IlNGwVD2xzaDDqlrJHLXTv7q9AWirwIgctG0SsU6NUXwH45CH9m6RDvfyojxrGJZrO4SyVqEKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550239; c=relaxed/simple;
	bh=xQ4MwwBTyv6ir42l8C/d8Ouhrf7Z+TViTi/BKlBMQJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7IisKqKFiM2/yOHtVFD7FdL5HHOPAyaAr1Pl+OXSTCEOaSKTBtC2Y6Hk1wajJvgYYxCVLt3yM38kcP8z8haIbNUD9maCYFQCzoMvxUvo3JEjEI3+N0KsoQ5YliHH35GrBcGyMDKmHMruFz/2DhUk4he+Cxhx30EDTPQ/982Pe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X8mUOnY0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TnBSg1RQiukxiIiBxgvGRyLSQP15gIjOttwNVAHtB6w=; b=X8mUOnY0LU6sUwkF54gNY28ZLa
	X7ZndnWMBHMu6NBc+I1pfXD6WJV8eoA/v9PNz96ial20jCXTnvXbHApcpLxxjVczP1xP+2zwTShso
	6rzWonkvJHADxN4/zHhc6g8n8ymlHgiNfZZ5cmHVUUp8RUZ/mZBP5jwX5tQFUOX6QJinDa03NzHBl
	U1fzP2Hpt4JN1oP/6615e1WvBkpXJeM2Aw6xfXM07aEBChslhghjz4tAcms/5wc5w68VQg916vE+/
	w3qQvBkmhCu2AauFH6rXT7OhpOtSp0VT79xrfxg6H+JEfexEfwIog6MAYCM8yqhREo/1mMRZf8vb/
	KAd0AZ9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxRHx-0000000FNc7-33xC;
	Tue, 03 Mar 2026 15:03:57 +0000
Date: Tue, 3 Mar 2026 07:03:57 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC DRAFT POC 10/11] tree-wide: make all kthread path
 lookups to use LOOKUP_IN_INIT
Message-ID: <aab4XVXC-sKqFwI-@infradead.org>
References: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
 <20260303-work-kthread-nullfs-v1-10-87e559b94375@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-work-kthread-nullfs-v1-10-87e559b94375@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: CA9AE1F20ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79250-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 02:49:21PM +0100, Christian Brauner wrote:
> In preparation to isolate all kthreads in nullfs convert all lookups
> performed from kthread context to use LOOKUP_IN_INIT. This will make
> them all perform the relevant lookup operation in init's filesystem
> state.
> 
> This should be switched to individual commits for easy bisectability but

Not just for bisectability, but also to explain how we end up calling
these from thread context.  I suspect in many cases by just undestanding
that we could get rid of it entirely with a bit of work.


