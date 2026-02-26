Return-Path: <linux-fsdevel+bounces-78432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EYWBUG2n2mKdQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 03:56:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEE41A03B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 03:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D68DB306E629
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 02:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F103815D8;
	Thu, 26 Feb 2026 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lT4z/kxJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B693451CF;
	Thu, 26 Feb 2026 02:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772074539; cv=none; b=OptAEXjK0biR9zPz31TD3uNb3ngZ6MxprxAaa2NrFZGA6UxI3lIC2gH/mfbL4cyFXFZX1KSvZJV1rSJMSzrWJuOWEEIXQUFlGgKhfsdmvxGGXjeyjBUskgdVrhqcayN99h9gqNbLp3sfgjP3hehVmGhcfxefZSjRedDG6q2L2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772074539; c=relaxed/simple;
	bh=C4NznxqjcoVcyOiI3PHdefTOI5IbbnZt/ta8EjHjsBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsZBrju4oM1OjwPbH3OwVJiPaycywOiydaFCgcVDQXoHfxjmz2TeQQ4HGxxsqLL7T/W0Fy2/8oQ18mgSp3cQ5JmfpfyFwNIFAz0nmjP/soHbQH79cm9S8pg+9niqA6pS3EucMzBuP+3g3jKvsRvnB5VxMntO9unAVsQ23JslR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lT4z/kxJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YhcyepidlpHsmGgGlbRMBKJer3APQ37SWyjKz6GiydU=; b=lT4z/kxJOpRr2y8PL3itayYgJ3
	i7ZwoiMb1z2uyIxU40ivVgqHH9trh+os4979z2Zqho9027f2XMpjQwXu4WrFWsVhiC7TPeJPMFiWA
	gY5Nx0DUj/IlPs4LB5T3TQX9JwzlCZKXG/qNd44L3nFJxmZwkUt/c5d4yVFzQMVrqTMgiAckXiQQv
	VXSOgWR4lM/M5fbsc7o8/LNO/njgdgbDcnsTUTjWfa2X7I1OeE/KtKZWKBd50xC/8qWXOdJrRtHxa
	bjHSfDSEJawaj9ug3LKsibAnOPgnzmVmc7GOT2cW8fy/u0uTmIAJ5HciOQcjzplM+oJiP/C0Gl3mu
	rjc+CEBg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvRX9-000000024RA-1i48;
	Thu, 26 Feb 2026 02:55:23 +0000
Date: Thu, 26 Feb 2026 02:55:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tal Zussman <tz2294@columbia.edu>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Dave Kleikamp <shaggy@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Bob Copeland <me@bobcopeland.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
	ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net,
	linux-mm@kvack.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [PATCH RFC v2 1/2] filemap: defer dropbehind invalidation from
 IRQ context
Message-ID: <aZ-2G_6lDZePLSyx@casper.infradead.org>
References: <20260225-blk-dontcache-v2-0-70e7ac4f7108@columbia.edu>
 <20260225-blk-dontcache-v2-1-70e7ac4f7108@columbia.edu>
 <c8078a80-f801-4f8a-b3cd-e2ccbfca1def@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8078a80-f801-4f8a-b3cd-e2ccbfca1def@kernel.dk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78432-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[columbia.edu,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,samsung.com,sony.com,dubeyko.com,paragon-software.com,bobcopeland.com,linux-foundation.org,vger.kernel.org,lists.sourceforge.net,lists.linux.dev,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Queue-Id: 8CEE41A03B8
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 03:52:41PM -0700, Jens Axboe wrote:
> How well does this scale? I did a patch basically the same as this, but
> not using a folio batch though. But the main sticking point was
> dropbehind_lock contention, to the point where I left it alone and
> thought "ok maybe we just do this when we're done with the awful
> buffer_head stuff". What happens if you have N threads doing IO at the
> same time to N block devices? I suspect it'll look absolutely terrible,
> as each thread will be banging on that dropbehind_lock.
> 
> One solution could potentially be to use per-cpu lists for this. If you
> have N threads working on separate block devices, they will tend to be
> sticky to their CPU anyway.

Back in 2021, I had Vishal look at switching the page cache from using
hardirq-disabling locks to softirq-disabling locks [1].  Some of the
feedback (which doesn't seem to be entirely findable on the lists ...)
was that we'd be better off punting writeback completion from interrupt
context to task context and going from spin_lock_irq() to spin_lock()
rather than going to spin_lock_bh().

I recently saw something (possibly XFS?) promoting this idea again.
And now there's this.  Perhaps the time has come to process all
write-completions in task context, rather than everyone coming up with
their own workqueues to solve their little piece of the problem?

[1] https://lore.kernel.org/linux-block/20210730213630.44891-1-vishal.moola@gmail.com/

