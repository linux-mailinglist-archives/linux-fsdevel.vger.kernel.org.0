Return-Path: <linux-fsdevel+bounces-59745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF24AB3DC41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 10:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC79189CD94
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 08:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF472F3618;
	Mon,  1 Sep 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QEZuqizp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4gSHy4hN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lIcLqprB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TIOtsifw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464B32676C9
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714945; cv=none; b=eZeHJQoWzzNEQVISyBfvSb3z4yohM91ST+XVgosYox0ag6K2iHt6wRFyVaOIy4HKW6jfBuP8Ac0xKKgou/ZeGjSfdaPtxiBAvmMmVFwqQbdfZxeKiZ0lyDD9rGqBtGUnwY0Fr7m93S6SuKlmPeA6gnlWcwCT4X0SfppCTmOIL18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714945; c=relaxed/simple;
	bh=XRUDSgtxTTxuWhDNa4in4GjAvQGAPT/sjCzdg09WsHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlbQVEr91Z/c5G8mXnwStkn8WdxpPRZ6mTiULdTGe/lw83lgNTxFfYCo2upkr6DsaXcDl6P4yZ70ZcT/pjCEWxGJmkyqM62wWXaGTCNANu9JFTwYODr8fdCndYBrjTObjswhwF9Miu976n28HsjmzD2IbqVRzNk3oTboA52fpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QEZuqizp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4gSHy4hN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lIcLqprB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TIOtsifw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53CD21F385;
	Mon,  1 Sep 2025 08:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756714942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jc93DC8/518ttB14IHOBnsZbVgcaKhtkLkqQaq8m83k=;
	b=QEZuqizpIcE4TC+ff3N9YgCIMEsRBtQwT5LVST64p4EI78oKEETSL9Z5nNxCFkmyKE3M86
	W5BbMSmD6S8n7fWlcOz91M0mZDuEUpKDsHq7Rp5B6UstnKIjtstLmrc3CMMKmx1QBOoBME
	fYXwufHEB58/mlHkMzCRULjnZOiaxkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756714942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jc93DC8/518ttB14IHOBnsZbVgcaKhtkLkqQaq8m83k=;
	b=4gSHy4hN3MhiXGkITdWBGz0NvxkYZxVOg366H0Wiuut6f30nbgHdmNYb872MP5Q8suEcEa
	SDOz27al+gckA0CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756714941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jc93DC8/518ttB14IHOBnsZbVgcaKhtkLkqQaq8m83k=;
	b=lIcLqprBcVFIOm/B3oKmFS/3vU+91bkO7Z0U6t7OSg0CYQaBm3tXe0IdJcDRYaMt6pIMNc
	9FBY0konTIBXGO967QU7CyAwKRD07yzKwEN7U+l0OQPErPScnqL3EjbweMvxSfXt/JOhYG
	bsMRrsFnTGpAgTXjcYqjiHirlLP/KUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756714941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jc93DC8/518ttB14IHOBnsZbVgcaKhtkLkqQaq8m83k=;
	b=TIOtsifw1J2K+sP/znkwM5n23x+zz4eZc1xem3Esnm3k/+5WKgusFEUkGgsu695M17u6tM
	zSh+0wZZfMf70ZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42E72136ED;
	Mon,  1 Sep 2025 08:22:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4u9NEL1XtWh8WQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Sep 2025 08:22:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DB15EA099B; Mon,  1 Sep 2025 10:22:20 +0200 (CEST)
Date: Mon, 1 Sep 2025 10:22:20 +0200
From: Jan Kara <jack@suse.cz>
To: Keith Busch <kbusch@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk, 
	dw@davidwei.uk, brauner@kernel.org, hch@lst.de, martin.petersen@oracle.com, 
	djwong@kernel.org, linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk, 
	Jan Kara <jack@suse.com>, Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCHv3 0/8] direct-io: even more flexible io vectors
Message-ID: <bqfazli7us3afm5opm5c6ntrblw2tekshd7ohf7nqagyoauwd7@6biytmjbkqgz>
References: <20250819164922.640964-1-kbusch@meta.com>
 <87a53ra3mb.fsf@gmail.com>
 <g35u5ugmyldqao7evqfeb3hfcbn3xddvpssawttqzljpigy7u4@k3hehh3grecq>
 <aKx485EMthHfBWef@kbusch-mbp>
 <87cy8ir835.fsf@gmail.com>
 <ua7ib34kk5s6yfthqkgy3m2pnbk33a34g7prezmwl7hfwv6lwq@fljhjaogd6gq>
 <aK9amCpLYsxIweMk@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK9amCpLYsxIweMk@kbusch-mbp>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,meta.com,vger.kernel.org,kernel.org,kernel.dk,davidwei.uk,lst.de,oracle.com,zeniv.linux.org.uk,suse.com,redhat.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Wed 27-08-25 13:20:56, Keith Busch wrote:
> On Wed, Aug 27, 2025 at 05:20:53PM +0200, Jan Kara wrote:
> > Now both the old and new behavior make some sense so I won't argue that the
> > new iomap_iter() behavior is wrong. But I think we should change ext4 back
> > to the old behavior of failing unaligned dio writes instead of them falling
> > back to buffered IO. I think something like the attached patch should do
> > the trick - it makes unaligned dio writes fail again while writes to holes
> > of indirect-block mapped files still correctly fall back to buffered IO.
> > Once fstests run completes, I'll do a proper submission...
> 
> Your suggestion looks all well and good, but I have a general question
> about fstests. I've written up some to test this series, and I have
> filesystem specific expectations for what should error or succeed. If
> you modify ext4 to fail direct-io as described, my test will have to be
> kernel version specific too. Is there a best practice in fstests for
> handling such scenarios?

Well, I'd just expect EINVAL for ext4 in the test. Certain kernel versions
(since February or so) will fail but that's just an indication you should
backport the fix if you care...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

