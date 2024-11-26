Return-Path: <linux-fsdevel+bounces-35940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66219D9F08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 22:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BD2165E4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192F51DFE04;
	Tue, 26 Nov 2024 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XGh6OLvY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H44sR6X+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XGh6OLvY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H44sR6X+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9A21DF963;
	Tue, 26 Nov 2024 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657983; cv=none; b=hNcLXEDWCrUcNjbCdU0GKKe88gRQ4kWJSVLw72K20jSUYk1ekD2RqQzDiaukafKbYRllecPHf7ga9nSJ6sLtR/JcADc0KSkUABQPUiFoWwr9UEJfZXp6XXzaus4P+j44UyuBNkXruI+UNTHfc6T3RKaerU7GGjgmrhJyWh1lo0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657983; c=relaxed/simple;
	bh=69DPGXRRD6vnJLCIbhUorKtysrQega8K0jloXx4xx5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKMxNgozuqzsQgmBmg5oeeCfVjIum+JPYP+O6oAZx/tjTAsKqPmtd7XNkmpGzb2//E99aqZVreXxtMELImL2/0IZjHVV50ZO8dgTTV1mbHgFKICHYUrNvpG5F3FfhXAZ11cmQjWo7tRhfzuZCUo1AcZvoN5ynStW/0/vdApJgF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XGh6OLvY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H44sR6X+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XGh6OLvY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H44sR6X+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C1721F74C;
	Tue, 26 Nov 2024 21:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732657979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rUwnW+riNOlPcoIf5dTIXLLyN6QLQwQ56rLHFvxfGJE=;
	b=XGh6OLvY83bNwtrgfeYifzBtlsll5XYGLZx9JGykkfnp+wTlxS17OJXqu15ES7MOY2J/kD
	n3pWaeKVkIe7Uao2B6QSsbUgFzJvnryulEBb3ubh87j39fIXpIwIbJQm6kAFUZtVq5aahk
	tjxpjtW/QJD1f92yfcQrL0MihSa1DD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732657979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rUwnW+riNOlPcoIf5dTIXLLyN6QLQwQ56rLHFvxfGJE=;
	b=H44sR6X+PyFxEgWia7pkNehDcty+Nlx4zGjCW2MYXtlgKH8CR9Mp41/F70j9YTaFbAZLWF
	yJs/L2cYGwHrmSDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732657979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rUwnW+riNOlPcoIf5dTIXLLyN6QLQwQ56rLHFvxfGJE=;
	b=XGh6OLvY83bNwtrgfeYifzBtlsll5XYGLZx9JGykkfnp+wTlxS17OJXqu15ES7MOY2J/kD
	n3pWaeKVkIe7Uao2B6QSsbUgFzJvnryulEBb3ubh87j39fIXpIwIbJQm6kAFUZtVq5aahk
	tjxpjtW/QJD1f92yfcQrL0MihSa1DD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732657979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rUwnW+riNOlPcoIf5dTIXLLyN6QLQwQ56rLHFvxfGJE=;
	b=H44sR6X+PyFxEgWia7pkNehDcty+Nlx4zGjCW2MYXtlgKH8CR9Mp41/F70j9YTaFbAZLWF
	yJs/L2cYGwHrmSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C6E913890;
	Tue, 26 Nov 2024 21:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QfGLFjtDRmfbfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 26 Nov 2024 21:52:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 014AAA08CA; Tue, 26 Nov 2024 22:52:54 +0100 (CET)
Date: Tue, 26 Nov 2024 22:52:54 +0100
From: Jan Kara <jack@suse.cz>
To: Leo Stone <leocstone@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com,
	brauner@kernel.org, quic_jjohnson@quicinc.com,
	viro@zeniv.linux.org.uk, sandeen@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, shuah@kernel.org,
	anupnewsmail@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] hfs: Sanity check the root record
Message-ID: <20241126215254.aw7l7k3tgx2tawzu@quack3>
References: <67400d16.050a0220.363a1b.0132.GAE@google.com>
 <20241123194949.9243-1-leocstone@gmail.com>
 <20241126093313.2t7nu67e6cjvbe7b@quack3>
 <wzxs6mjqlpf2eszoaw2ozvocqg3lpaqx7mzog4tygxexugrbsu@3pxs2vthfagb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wzxs6mjqlpf2eszoaw2ozvocqg3lpaqx7mzog4tygxexugrbsu@3pxs2vthfagb>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[2db3c7526ba68f4ea776];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,syzkaller.appspotmail.com,kernel.org,quicinc.com,zeniv.linux.org.uk,redhat.com,vger.kernel.org,googlegroups.com,gmail.com,lists.linuxfoundation.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Tue 26-11-24 09:21:50, Leo Stone wrote:
> Hello,
> 
> On Tue, Nov 26, 2024 at 10:33:13AM +0100, Jan Kara wrote:
> > 
> > This certainly won't hurt but shouldn't we also add some stricter checks
> > for entry length so that we know we've loaded enough data to have full info
> > about the root dir?
> 
> Yes, that would be a good idea. Do we want to keep the existing checks
> and just make sure we have at least enough to initialize the struct:
> 
> if (fd.entrylength > sizeof(rec) || fd.entrylength < 0 ||
>     fd.entrylength < sizeof(rec.dir)) {
> 	res = -EIO;
> 	goto bail_hfs_find;
> }
> 
> Or be even stricter and only accept the exact length:
> 
> if (fd.entrylength != sizeof(rec.dir)) {
> 	res = -EIO;
> 	goto bail_hfs_find;
> }

Yes, this strict check would make sense to me. I just don't know HFS good
enough whether this is a safe assumption to make so it would be good to
test with some HFS filesystem.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

