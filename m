Return-Path: <linux-fsdevel+bounces-6690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D5B81B69E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FA51C258C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3520760BA;
	Thu, 21 Dec 2023 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aYX+PUDP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TcqsSQgI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R2BZ7hn9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IeTNXrpA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97246EB7D;
	Thu, 21 Dec 2023 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D365A1FB78;
	Thu, 21 Dec 2023 12:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703162985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YrZXyGOsYC5rUgIHJCnybFxlYBJ8I6rwZ24IXGRHk8Q=;
	b=aYX+PUDPiwPLsdWsA+khamFscBRGLYSeY2ILdRkuRaT+VMnlDcWacb39h/mQ04j4rgN2kS
	dI5BMx+amHviopWzU9OUhGZI4Fi59fHc59sqfLYGdTmy8iEHHLaRkcdExM2Z0vNquSa6jv
	BtP//v/31gvqjI5sCo6U6pq0gaPFyF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703162985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YrZXyGOsYC5rUgIHJCnybFxlYBJ8I6rwZ24IXGRHk8Q=;
	b=TcqsSQgI6gNLghVXuqEBEEfO6TwRlB54fakTWjutN0ME3H058JRkzVMgpbzKEEyY1VCa3q
	OVGy/iQfjje5boAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703162984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YrZXyGOsYC5rUgIHJCnybFxlYBJ8I6rwZ24IXGRHk8Q=;
	b=R2BZ7hn9rGUWBx2CTeCrlKkG9Ca9/rixh8nfX1cdLu7O8tJy/yueJn64JkWVGzRFAcTZ39
	nRJApmL6heGZZrxCcIHdMwaAim7+N+L8ticcZrwdVcgmfOakXFFl5l61UpLnnJtHV/Na5p
	g9x3V3H3LpZRZGKjvKspETmBdNSClcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703162984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YrZXyGOsYC5rUgIHJCnybFxlYBJ8I6rwZ24IXGRHk8Q=;
	b=IeTNXrpALi0+LKw3oaohZfnCYSaTGl1QZW/fr57jSMu9SiNDgVexIU4nN/Q1lorKPkKTkz
	YFf3lQruumC6VUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C908813AB5;
	Thu, 21 Dec 2023 12:49:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tccNMWg0hGX/dgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 12:49:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 859EAA07E3; Thu, 21 Dec 2023 13:49:36 +0100 (CET)
Date: Thu, 21 Dec 2023 13:49:36 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/17] writeback: Add for_each_writeback_folio()
Message-ID: <20231221124936.vmm2tjujoy6roxs4@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-16-hch@lst.de>
 <20231221115149.ke74ddapwb7q6fdz@quack3>
 <20231221122910.GF17956@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221122910.GF17956@lst.de>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,infradead.org:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R2BZ7hn9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IeTNXrpA
X-Spam-Score: -2.81
X-Rspamd-Queue-Id: D365A1FB78

On Thu 21-12-23 13:29:10, Christoph Hellwig wrote:
> On Thu, Dec 21, 2023 at 12:51:49PM +0100, Jan Kara wrote:
> > On Mon 18-12-23 16:35:51, Christoph Hellwig wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > Wrap up the iterator with a nice bit of syntactic sugar.  Now the
> > > caller doesn't need to know about wbc->err and can just return error,
> > > not knowing that the iterator took care of storing errors correctly.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Not sure if the trick with 'error' variable isn't a bit too clever for us
> > ;) We'll see how many bugs it will cause in the future...
> 
> It's a bit too much syntactic sugar for my taste, but if we want a magic
> for macro I can't really see a good way around it.  I personally wouldn't

Agreed. The macro is kind of neat but a magic like this tends to bite us in
surprising ways. E.g. if someone breaks out of the loop, things will go
really wrong (missing writeback_finish() call). That would be actually a
good usecase for the cleanup handlers PeterZ has been promoting - we could
make sure writeback_finish() is called whenever we exit the loop block.

> mind a version where the writeback_get_folio moves out of
> writeback_iter_init and the pattern would look more like:
> 
> 	writeback_iter_init(mapping, wbc);
> 	while ((folio = writeback_iter_next(mapping, wbc, folio))) {
> 		wbc->err = <do something>
> 	}
> 
> 	return wbc->err;

That would work for me as well. But I don't feel to strongly about this
either way.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

