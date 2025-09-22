Return-Path: <linux-fsdevel+bounces-62381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1410EB8FF78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 12:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEBB189B954
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF0C27A139;
	Mon, 22 Sep 2025 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XkOsV0fZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WQYkSi8b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pC0EFtnr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g44kVPrl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5900222422A
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536356; cv=none; b=en6NnRCoCu1HM4BwE8hDPGtaiiIeYuRlZMeKm+EtVJXmdWVMa9Q+49BT7YcCC7ZlJe7dfV/89QIMcSrP5AhVMG/2w8C2r4Jtm24kuxZO6P8w9nzxdF0gIKdROw9onUrG0ofrbojlOlnoEqvFFuhnUOKy5H+qoFwYPsX/6eqCbUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536356; c=relaxed/simple;
	bh=rFQKAqQVDYJQsbAaQKZHWT0W2q8BcuXgJnasZlk1l0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSkC9ZGegqqECYYUF7yM/EjgzQaFKTm5A3cgHTFQD3arLgrnbVKZ090l41lT9SVfuLblZ+GH5wvfytXDJztfrrRpOl5bbdftdh44ynyies3K4kfnB2hJfyvySJfiWN+TICf9bIiyzVHopucyaF/3SmhExjFIoopQuKU+6aF9wmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XkOsV0fZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WQYkSi8b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pC0EFtnr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g44kVPrl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9AC091FDBA;
	Mon, 22 Sep 2025 10:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758536352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9H+XoRxP3hfVmy7DRmnmX11iPxbEZgAYWR7pZVGL0c=;
	b=XkOsV0fZkxaCMZWiJYluz9sT9Vd7kKp3c5l+UUq2WXDcs8aZp6yyGLlwCNh+ShWlkGVSH6
	GnR9XnJ7Nb16rUoMS5iq1F/laiRekCrobI5yOfc9/03UPaG0ys/xhbRz/l8vGKOAA/6SW5
	EYftJSVmno4IlFCI7ZyGh2cJyB6kuDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758536352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9H+XoRxP3hfVmy7DRmnmX11iPxbEZgAYWR7pZVGL0c=;
	b=WQYkSi8b0eHFzs1z5JGmDCpb2xmEQq4yfNA/es1YV9C3uek7vyW/g8yJTEmGE1yB853j/7
	ocbTQ0wOkm1YHZCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pC0EFtnr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g44kVPrl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758536351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9H+XoRxP3hfVmy7DRmnmX11iPxbEZgAYWR7pZVGL0c=;
	b=pC0EFtnr7YhDNxF61riyl9YpXaB+fzrhnr+WRkSK//NK1bh5KQA/8bJIRxfvH4EOe4ouJB
	jIMVI/w/hsbOmYZAlZFTB4NwGWv5/xCY4Uke/cz/fIhMo70b5nLX/pBZfVjW6kGNu/f/+2
	fwCsDk5DOCny7nFw2EeThYcdqgoCJdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758536351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9H+XoRxP3hfVmy7DRmnmX11iPxbEZgAYWR7pZVGL0c=;
	b=g44kVPrl1L/xtgDgNnaGbavGEkULaOqezIRaIfVELVoj80kDdj5lFljIX2GAflfFQ73Hhq
	YW0irUYmFHGNFKCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EDDC13A63;
	Mon, 22 Sep 2025 10:19:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YYPcIp8i0WgmOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Sep 2025 10:19:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 50DEFA07C4; Mon, 22 Sep 2025 12:19:11 +0200 (CEST)
Date: Mon, 22 Sep 2025 12:19:11 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/9] mnt: expose pointer to init_mnt_ns
Message-ID: <b4mb3kj3v453gduhebg5epbsfvoxcldpj3al7kjxnn64cvgi57@77pqiolvgqgt>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-2-1b3bda8ef8f2@kernel.org>
 <oqtggwqink4kthsxiv6tv6q6l7tgykosz3tenek2vejqfiuqzl@drczxzwwucfi>
 <20250919-sense-evaluieren-eade772e2e6c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-sense-evaluieren-eade772e2e6c@brauner>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,cmpxchg.org,suse.com,linutronix.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 9AC091FDBA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Fri 19-09-25 12:05:16, Christian Brauner wrote:
> On Wed, Sep 17, 2025 at 06:28:37PM +0200, Jan Kara wrote:
> > On Wed 17-09-25 12:28:01, Christian Brauner wrote:
> > > There's various scenarios where we need to know whether we are in the
> > > initial set of namespaces or not to e.g., shortcut permission checking.
> > > All namespaces expose that information. Let's do that too.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> I've changed this so it behaves exactly like all the other init
> namespaces. See appended.

Yeah, looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

(although I can see you've kept my Reviewed-by in the patch).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

