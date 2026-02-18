Return-Path: <linux-fsdevel+bounces-77478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF5nAzcHlWn1KAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 01:26:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F1815243B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 01:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 387623019B89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6577248F6A;
	Wed, 18 Feb 2026 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCov9miZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74866487BE;
	Wed, 18 Feb 2026 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771374381; cv=none; b=FZb8Im/egwNrC6zUEmClZ0ne6NF0qwuyULF2nf+tbvNyxP6rj3bCwbKTlI/iTdKzgr4sTVDtn6qT9jydSa8McEbEfIQjsMkkurD6DErSfxZApiR1gTVzY8QXCmU/S45g9SEYgDKOaG8SIQMDY2rFj4eWrf1Egsxg/Q5wNlcsnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771374381; c=relaxed/simple;
	bh=JboHkTUEpFKhTIugWR55+L+mSXwfGGmx5RWx7rWQmO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OovlkIFIxAle6dI60lYH6AU8XSD1arSwGtGtY4AAHcHhruDtfL4S1FjvX5R5XGrkjRQHvQzB3+1sFSu3SHP4NGqolzqS6bsPFKoePIha1VTInnA/AGVX9ZaTtWfFV07xWrKzBeIBZ4CWa1D+Wj7+h/vQdKuWrMuzYiHsv4t1oF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCov9miZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5C5C4CEF7;
	Wed, 18 Feb 2026 00:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771374381;
	bh=JboHkTUEpFKhTIugWR55+L+mSXwfGGmx5RWx7rWQmO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bCov9miZG+BJgHwbaa9A/3mI2mNgqV5H6jiwKBjZMR4s7Uc4HRs/90W0cHyCt0wUC
	 oJaKTwSbz0hKsm9K2C4/MXkajHdGBSHPNkW8zbFktAyK2CG7PAUj93YVPMYh4v8hd2
	 utrss9Pqt1DSCEKS/ExNIFOQQoQwPDD0haApo1qj3RSKlR78YxiaJCMoLFYJZG1EdV
	 JwsxKbSMRUNwEQjuuf6JuUH3H9+WjQ4jcTnwgwaKNWTDjaqaL/Eud2sm5ySWqZLeqz
	 ibmbwEPJDCD/GCVzzKSCPvkO78Nmt5bT6MxLg7ZFjQ8oIb1TQzd5XB8bCgs7MKcf72
	 GOexS+YBTVKkw==
Date: Wed, 18 Feb 2026 11:26:06 +1100
From: Dave Chinner <dgc@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>, Pankaj Raghav <pankaj.raghav@linux.dev>,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	Andres Freund <andres@anarazel.de>, djwong@kernel.org,
	john.g.garry@oracle.com, willy@infradead.org, hch@lst.de,
	ritesh.list@gmail.com, Luis Chamberlain <mcgrof@kernel.org>,
	dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>,
	gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com,
	vi.shah@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <aZUHHvNl6cQr-uwd@dread>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <w3vwdaygcz3prsxwv43blo4co666mragpdwaxihbirt5stl4vr@agyz4mnaxghj>
 <aZS18m1eIxjDmyBa@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZS18m1eIxjDmyBa@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77478-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dgc@kernel.org,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.cz,linux.dev,vger.kernel.org,kvack.org,lists.linux-foundation.org,anarazel.de,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6F1815243B
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:09:46AM +0530, Ojaswin Mujoo wrote:
> On Mon, Feb 16, 2026 at 12:38:59PM +0100, Jan Kara wrote:
> > Hi!
> > 
> > On Fri 13-02-26 19:02:39, Ojaswin Mujoo wrote:
> > > Another thing that came up is to consider using write through semantics 
> > > for buffered atomic writes, where we are able to transition page to
> > > writeback state immediately after the write and avoid any other users to
> > > modify the data till writeback completes. This might affect performance
> > > since we won't be able to batch similar atomic IOs but maybe
> > > applications like postgres would not mind this too much. If we go with
> > > this approach, we will be able to avoid worrying too much about other
> > > users changing atomic data underneath us. 
> > > 
> > > An argument against this however is that it is user's responsibility to
> > > not do non atomic IO over an atomic range and this shall be considered a
> > > userspace usage error. This is similar to how there are ways users can
> > > tear a dio if they perform overlapping writes. [1]. 
> > 
> > Yes, I was wondering whether the write-through semantics would make sense
> > as well. Intuitively it should make things simpler because you could
> > practially reuse the atomic DIO write path. Only that you'd first copy
> > data into the page cache and issue dio write from those folios. No need for
> > special tracking of which folios actually belong together in atomic write,
> > no need for cluttering standard folio writeback path, in case atomic write
> > cannot happen (e.g. because you cannot allocate appropriately aligned
> > blocks) you get the error back rightaway, ...
> 
> This is an interesting idea Jan and also saves a lot of tracking of
> atomic extents etc.

ISTR mentioning that we should be doing exactly this (grab page
cache pages, fill them and submit them through the DIO path) for
O_DSYNC buffered writethrough IO a long time again. The context was
optimising buffered O_DSYNC to use the FUA optimisations in the
iomap DIO write path.

I suggested it again when discussing how RWF_DONTCACHE should be
implemented, because the async DIO write completion path invalidates
the page cache over the IO range. i.e. it would avoid the need to
use folio flags to track pages that needed invalidation at IO
completion...

I have a vague recollection of mentioning this early in the buffered
RWF_ATOMIC discussions, too, though that may have just been the
voices in my head.

Regardless, we are here again with proposals for RWF_ATOMIC and
RWF_WRITETHROUGH and a suggestion that maybe we should vector
buffered writethrough via the DIO path.....

Perhaps it's time to do this?

FWIW, the other thing that write-through via the DIO path enables is
true async O_DSYNC buffered IO. Right now O_DSYNC buffered writes
block waiting on IO completion through generic_sync_write() ->
vfs_fsync_range(), even when issued through AIO paths.  Vectoring it
through the DIO path avoids the blocking fsync path in IO submission
as it runs in the async DIO completion path if it is needed....

-Dave.
-- 
Dave Chinner
dgc@kernel.org

