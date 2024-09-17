Return-Path: <linux-fsdevel+bounces-29583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6D897B025
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 14:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D221F23ECE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 12:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB8B167D98;
	Tue, 17 Sep 2024 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QqEoQXGP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2s1rSC4W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1tQfwrlQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dL0+Rdv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58E5258
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726576405; cv=none; b=BDvcbVm1CDelSyV1vPC575mKOjGQ/apSTDJe9Zrj80FLwnTDOWYILmAyi4IsMdwdEfs77ABH8N86rM9sWlCsi30N8zDa5hCdPpAfcRSEDDzVHOTTcf9TQ55STaCjoyiEiPT85/2oUnooQ+c8hFkrELH0v1BJKO2gmXNDTSxFvOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726576405; c=relaxed/simple;
	bh=qFcQ76MNuBzK+/1shdisgc/BkPlurG00JJG70b/Ju/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLoXDTk4EG5r9CyQlb54SpO4QjgKY2ipOSNxUhTxH6tMaf8G+nN+7/63v0rdOAMxNDVum+rncH1NhB9EMqQGYgXrNZ+dJ4Rg9D+wjpM8Mxku8b+iG3sdovDf1YplyNrBDUtaJt9MSSxUzm0KZgpgyQXpWfQ5Bck1P/uEF4FuJ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QqEoQXGP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2s1rSC4W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1tQfwrlQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dL0+Rdv/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EAED720059;
	Tue, 17 Sep 2024 12:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726576401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1913SFImmFPxuHxF7bcmzHAt7WDMX6OKrlHP+l7Gos=;
	b=QqEoQXGPvV5g2wOQfO+g00RLIVEzS0kgAazkQj/ac5ZWCyrPiWGwKK6XtsDRK4d3Gc4Tb1
	+ZWURzOG8TWi3Bw5VGqlw4jzfXFxbVkx93uSgnJ3HmRH/X44No5XhIAOm1NKBtwwKwxzoN
	Wf/L7a0Nux8gvZxjqyx+ummNj9ncyog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726576401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1913SFImmFPxuHxF7bcmzHAt7WDMX6OKrlHP+l7Gos=;
	b=2s1rSC4WyVDyPgVVZXPDZKVgI2RRxrTDgU2bDrwjpyIfw4aC/QTS+ohe1OKXjOkZKGVXbB
	9LRqNCBkNjr0sbBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1tQfwrlQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="dL0+Rdv/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726576400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1913SFImmFPxuHxF7bcmzHAt7WDMX6OKrlHP+l7Gos=;
	b=1tQfwrlQbn1nMNYvivnsioXmvukYMBP8z5w2m3Ut3OL/zC0F/hCfLaWYAQD2YS2+qK5yF6
	imDqQRqfC7CV20ijVf5fLIntkc6amv037SokeBi4WfExnHg7vj6r3kRlwcOUw2mM2be0uV
	xTMLjPI2xCIuEw6ZrF53X+InRCkH9FY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726576400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1913SFImmFPxuHxF7bcmzHAt7WDMX6OKrlHP+l7Gos=;
	b=dL0+Rdv/EZBNi76cVqhPPRvim6J45Q0by4cXoigOLxKbCuJ0gKn+h3C+nHyCIWSUmww0iP
	QAuosOIBU1+OPkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D25CA13AB6;
	Tue, 17 Sep 2024 12:33:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +2kSMxB36WaXHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Sep 2024 12:33:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 38C24A08B3; Tue, 17 Sep 2024 13:58:10 +0200 (CEST)
Date: Tue, 17 Sep 2024 13:58:10 +0200
From: Jan Kara <jack@suse.cz>
To: Josh Marshall <joshua.r.marshall.1991@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Is this a fanotify_init() bug manifesting in fanotify_mark()?
Message-ID: <20240917115810.erpufxchwffsx7yb@quack3>
References: <CAFkJGRdhJrhb3-k28oX3WkqqDCTw7egQCJhX42-XXxGXbnnc0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkJGRdhJrhb3-k28oX3WkqqDCTw7egQCJhX42-XXxGXbnnc0w@mail.gmail.com>
X-Rspamd-Queue-Id: EAED720059
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi!

I was going through some old email and noticed this question. Probably
you've already figured out yourself but just in case:

On Tue 02-04-24 20:27:03, Josh Marshall wrote:
> I am making an event driven free space monitoring utility.  The core
> idea of the design is to use fanotify to listen for the existence of
> events which can increase space consumption, and when this happens
> check the remaining free space.  Extra functionality to make this not
> face meltingly stupid are planned before I suggest anyone use it,
> don't worry.
> 
> I am using the documentation here:
> https://man7.org/linux/man-pages/man7/fanotify.7.html
> https://man7.org/linux/man-pages/man2/fanotify_init.2.html
> https://man7.org/linux/man-pages/man2/fanotify_mark.2.html
> 
> ```Causes problem
>   int f_notify = fanotify_init(FAN_CLASS_NOTIF, 0);
> ```
> ```No problem
>   int f_notify = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME, 0);
> ```
> ```Where it manifests
>   if( fanotify_mark(f_notify, FAN_MARK_ADD | FAN_MARK_ONLYDIR,
> FAN_CREATE , AT_FDCWD, mnt) == -1 ){...}
> ```

FAN_CREATE event is so called directory event and as such it requires the
notification group to be in "FID mode" - i.e., reporting fsid + fhandle
instead of open file descriptor to file generating the event. So you need
at least FAN_REPORT_FID flag to fanotify_init(2) to be able to use
FAN_CREATE event.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

