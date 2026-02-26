Return-Path: <linux-fsdevel+bounces-78642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJB+NR+4oGnClwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 22:16:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 827591AF97A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 22:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C39E301AA43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035C646AF0C;
	Thu, 26 Feb 2026 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lgkspXoZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397393A1E82;
	Thu, 26 Feb 2026 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140345; cv=none; b=Z3d5vS9JQOeS1xtl7n8viGXhI6FlwrjDBRCpCNH2sfeIH3LdzrT5dqVclsibosdYvYGZrJB3X/ci4vXM6hue8XaxTE/IP53kvo/9Wq9PhyE/p4w6HeBB/2xalftpC2cYj/8IJHYLQ0dXV6iQAOj2gIkNtScGGBlKbXTd9HCvm+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140345; c=relaxed/simple;
	bh=h/eCq6uk34O9sRVEPL6UJ9Eruk+vrXSzn2fekqThhV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZHnnEtPDQbk9Q4PaKb/IjzJDhEVKNM8A4v6IE04aBVWmBD/u/6wvA3H2Czdr64Gxz3VGMlZTZyRFIA4tg3OoB+RvMUMK2TZnKDLlQ57gc8fEspn7k/SzTIlj5IV/wTj2fUe0K2J5Ks0F9E9kaZtgrfPa1iMvzAJfynvwCsmyp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lgkspXoZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cxjFK2I1rFqs+rF+S3xFy7UtO9xYKfa9VhNCsIXi0UM=; b=lgkspXoZtskd+nEFTO7IHEtKtY
	QTWQeCvLBoCUJsiEPlwCe6SWhlX4OpH4sfIcf973/D/KHKtxmL7cdhI6EVPhq+88YezeXjnYeF9/k
	lTBC4JUAHiw0PjPxqQDKyXesl0LB4Vk4iaFTKfzl2Tl3I2RHXTu5RqbQRomZRKajicLkxk1Zc3Cgl
	EA9AE9Aq8Dj+/BUR9USybQncuYrIbgeNeLca3LgZvkDQDBJlBeBiGdrYoUnF5XrvaNGooNpTfJR43
	oaTeNczWoFDSM88QQWW6khDtS0804E+RmfZTXk4WzycI+T/ry+ky6kMNEO4z3lOlB81Jk2mHVpBQg
	Mtjq8aOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vviec-00000003Sxg-0gjd;
	Thu, 26 Feb 2026 21:12:14 +0000
Date: Thu, 26 Feb 2026 21:12:13 +0000
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
Message-ID: <aaC3LUFa1Jz2ahk3@casper.infradead.org>
References: <20260225-blk-dontcache-v2-0-70e7ac4f7108@columbia.edu>
 <20260225-blk-dontcache-v2-1-70e7ac4f7108@columbia.edu>
 <c8078a80-f801-4f8a-b3cd-e2ccbfca1def@kernel.dk>
 <aZ-2G_6lDZePLSyx@casper.infradead.org>
 <44e3e9ea-350b-4357-ba50-726e506feab5@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e3e9ea-350b-4357-ba50-726e506feab5@kernel.dk>
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
	TAGGED_FROM(0.00)[bounces-78642-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[columbia.edu,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,samsung.com,sony.com,dubeyko.com,paragon-software.com,bobcopeland.com,linux-foundation.org,vger.kernel.org,lists.sourceforge.net,lists.linux.dev,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[casper.infradead.org:mid,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 827591AF97A
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 08:15:28PM -0700, Jens Axboe wrote:
> On 2/25/26 7:55 PM, Matthew Wilcox wrote:
> > I recently saw something (possibly XFS?) promoting this idea again.
> > And now there's this.  Perhaps the time has come to process all
> > write-completions in task context, rather than everyone coming up with
> > their own workqueues to solve their little piece of the problem?
> 
> Perhaps, even though the punting tends to suck... One idea I toyed with
> but had to abandon due to fs freezeing was letting callers that process
> completions in task context anyway just do the necessary work at that
> time. There's literally nothing worse than having part of a completion
> happen in IRQ, then punt parts of that to a worker, and need to wait for
> the worker to finish whatever it needs to do - only to then wake the
> target task. We can trivially do this in io_uring, as the actual
> completion is posted from the task itself anyway. We just need to have
> the task do the bottom half of the completion as well, rather than some
> unrelated kthread worker.
> 
> I'd be worried a generic solution would be the worst of all worlds, as
> it prevents optimizations that happen in eg iomap and other spots, where
> only completions that absolutely need to happen in task context get
> punted. There's a big difference between handling a completion inline vs
> needing a round-trip to some worker to do it.

I spoke a little hastily when I said "all write completions".  What I
really meant was something like:

+++ b/block/bio.c
@@ -1788,7 +1788,9 @@ void bio_endio(struct bio *bio)
        }
 #endif

-       if (bio->bi_end_io)
+       if (!in_task() && bio_flagged(bio, BIO_COMPLETE_IN_TASK_CONTEXT))
+               bio_queue_completion(bio);
+       else if (bio->bi_end_io)
                bio->bi_end_io(bio);
 }
 EXPORT_SYMBOL(bio_endio);

and then the submitter (ie writeback) would choose to set
BIO_COMPLETE_IN_TASK_CONTEXT.  And maybe others (eg fscrypt) would
want to do the same.

