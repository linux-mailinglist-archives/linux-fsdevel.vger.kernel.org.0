Return-Path: <linux-fsdevel+bounces-77270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGI3J+YBk2lr0wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 12:39:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5631430FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 12:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B27953015721
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 11:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2A127055D;
	Mon, 16 Feb 2026 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p3JyA8bh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kkqgt47f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p3JyA8bh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kkqgt47f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCE1199920
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771241949; cv=none; b=DCWPQWs3W+TngPVVHbdFvQ8OI4sClmuR8k/VMlczjn+fFmwbU+WRiZkm1olkXn9rP/mPuDokz72YAHs61ek6j77Xe7f0aSMljMxpUWdgXr2rAJDxZDxUOoXB0krwO6gCknif5+NRrxbQjCDNBWRPsCore6CccpAGKsn+6nlLTII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771241949; c=relaxed/simple;
	bh=DFaxVuRr1B79U0qpSHXpHCJ0FoZyaFK+FSI+fGDLEPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsuVek9Q/xrmdGM3mt5jo0HdxPFFy4FSDntEOLRX0bvk0hcDABMqqEVsM/vPmNg/Qy4j9QXiCX71SWbf4AoMJN8xYXHzKnZoKfBEb4+gG+HQTaAvvXLz0/jRzrY9rxRqiEIqze2+Jq69UG3nZX6qQEr1A5RCxdtRqI76sCgCy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p3JyA8bh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kkqgt47f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p3JyA8bh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kkqgt47f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5335A5BCFF;
	Mon, 16 Feb 2026 11:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771241946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QbjZPXjREGbAx7ntC8vD9Ig1U2Ql4S/pSKRXVeCyDvA=;
	b=p3JyA8bhdFyL0ld1P4fNn1Yxp5LdNpmiePmfuryjOTXjs4oG5Fea2Hh/W3IQd4aAqE9ayu
	ZST1PeI61pQYkbuqAVRLluJwsDwVtJA/+LhPU96uQ/YW0t+siQ8WuD1J+u8GNjwx9lUJ8t
	+Mg1n/h+US/VYCIJJtenyOXn7suQsRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771241946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QbjZPXjREGbAx7ntC8vD9Ig1U2Ql4S/pSKRXVeCyDvA=;
	b=Kkqgt47f3D2hLb+DbYsty7+TKZ782vebLzWVOZFX+iakm22PNqoIcQ1lHzRH1rpoInDryC
	9LJSVBf/Oj5WH1Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771241946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QbjZPXjREGbAx7ntC8vD9Ig1U2Ql4S/pSKRXVeCyDvA=;
	b=p3JyA8bhdFyL0ld1P4fNn1Yxp5LdNpmiePmfuryjOTXjs4oG5Fea2Hh/W3IQd4aAqE9ayu
	ZST1PeI61pQYkbuqAVRLluJwsDwVtJA/+LhPU96uQ/YW0t+siQ8WuD1J+u8GNjwx9lUJ8t
	+Mg1n/h+US/VYCIJJtenyOXn7suQsRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771241946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QbjZPXjREGbAx7ntC8vD9Ig1U2Ql4S/pSKRXVeCyDvA=;
	b=Kkqgt47f3D2hLb+DbYsty7+TKZ782vebLzWVOZFX+iakm22PNqoIcQ1lHzRH1rpoInDryC
	9LJSVBf/Oj5WH1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B98A3EA62;
	Mon, 16 Feb 2026 11:39:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hj/sAtoBk2nxfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Feb 2026 11:39:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D646FA0AA5; Mon, 16 Feb 2026 12:38:59 +0100 (CET)
Date: Mon, 16 Feb 2026 12:38:59 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Pankaj Raghav <pankaj.raghav@linux.dev>, linux-xfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	Andres Freund <andres@anarazel.de>, djwong@kernel.org, john.g.garry@oracle.com, willy@infradead.org, 
	hch@lst.de, ritesh.list@gmail.com, jack@suse.cz, 
	Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>, 
	gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <w3vwdaygcz3prsxwv43blo4co666mragpdwaxihbirt5stl4vr@agyz4mnaxghj>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77270-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,kvack.org,lists.linux-foundation.org,anarazel.de,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,suse.cz,redhat.com,samsung.com,mit.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3C5631430FD
X-Rspamd-Action: no action

Hi!

On Fri 13-02-26 19:02:39, Ojaswin Mujoo wrote:
> Another thing that came up is to consider using write through semantics 
> for buffered atomic writes, where we are able to transition page to
> writeback state immediately after the write and avoid any other users to
> modify the data till writeback completes. This might affect performance
> since we won't be able to batch similar atomic IOs but maybe
> applications like postgres would not mind this too much. If we go with
> this approach, we will be able to avoid worrying too much about other
> users changing atomic data underneath us. 
> 
> An argument against this however is that it is user's responsibility to
> not do non atomic IO over an atomic range and this shall be considered a
> userspace usage error. This is similar to how there are ways users can
> tear a dio if they perform overlapping writes. [1]. 

Yes, I was wondering whether the write-through semantics would make sense
as well. Intuitively it should make things simpler because you could
practially reuse the atomic DIO write path. Only that you'd first copy
data into the page cache and issue dio write from those folios. No need for
special tracking of which folios actually belong together in atomic write,
no need for cluttering standard folio writeback path, in case atomic write
cannot happen (e.g. because you cannot allocate appropriately aligned
blocks) you get the error back rightaway, ...

Of course this all depends on whether such semantics would be actually
useful for users such as PostgreSQL.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

