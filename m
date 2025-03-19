Return-Path: <linux-fsdevel+bounces-44460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B897A69514
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 17:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0613AFE82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 16:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8901DEFD8;
	Wed, 19 Mar 2025 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y2NNOOmK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z5mPSGux";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y2NNOOmK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z5mPSGux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567971D6199
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402205; cv=none; b=RTiKDN8KFdIvDndei+QbRzkzmgykUsPK94LZuGWsQQIvBxP7/wahG9bhuSu/J5sOjfmF+QCMJ36pshD04ceu12Z3YZbtdpWwUHKJTrnFQGU6cpVgC2qNFNI2vbwWbbQwVLftYnV5f5/OD+awjT4qnyTgbCEyfsVZPFIiGQo8HnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402205; c=relaxed/simple;
	bh=EQCeJ8Xdxpz0dcoe0sSTMHmHFx2vDEAwO6Jmxj7jagc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7VOzWkzB1J4NMogQV9mFH+c30Exa8L9qScXkxpS7a10euV43yT1QihOo22Eg7fuMF5E9q233tODMzkhb308klCiohjlmGmm0aL4PnKQ5Dqs8HWwBMSdcvGI+MlzC2ShAsWd+GvZxwkoXA/wrY1eYFyfrLuEsIXGSgEwOt3ssTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y2NNOOmK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z5mPSGux; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y2NNOOmK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z5mPSGux; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 59FB61FEE5;
	Wed, 19 Mar 2025 16:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742402202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxhN42Ish8TRyLPiq+Hu7kP/o3ejT0WN7NBxRSvFbzw=;
	b=Y2NNOOmKGonRm3Z8DTt/p3MeVPnC8EWfLL1u2OQFkszypKKMNEXsWzwr7f1IRy4sgrgeM7
	ZvPNWiSJu3Z0Xn/vkU9CXueuHBOe+8Bvx4bW1idLf0ctOemZVbl19c0TYrellU+mMnTU7M
	zrsqjf9APlcUu+Hvy16GoF8x9KWOgqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742402202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxhN42Ish8TRyLPiq+Hu7kP/o3ejT0WN7NBxRSvFbzw=;
	b=z5mPSGuxckqARJZlISteXE3k4jFGtsN8dzdvqy0iaGMJ+HlOLc0of7OqqK/MRiG3dTDPvf
	n4Lg9v6atSVNW6DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Y2NNOOmK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=z5mPSGux
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742402202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxhN42Ish8TRyLPiq+Hu7kP/o3ejT0WN7NBxRSvFbzw=;
	b=Y2NNOOmKGonRm3Z8DTt/p3MeVPnC8EWfLL1u2OQFkszypKKMNEXsWzwr7f1IRy4sgrgeM7
	ZvPNWiSJu3Z0Xn/vkU9CXueuHBOe+8Bvx4bW1idLf0ctOemZVbl19c0TYrellU+mMnTU7M
	zrsqjf9APlcUu+Hvy16GoF8x9KWOgqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742402202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxhN42Ish8TRyLPiq+Hu7kP/o3ejT0WN7NBxRSvFbzw=;
	b=z5mPSGuxckqARJZlISteXE3k4jFGtsN8dzdvqy0iaGMJ+HlOLc0of7OqqK/MRiG3dTDPvf
	n4Lg9v6atSVNW6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B33A13A2C;
	Wed, 19 Mar 2025 16:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8I5YEpry2meqYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 19 Mar 2025 16:36:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DE836A08D2; Wed, 19 Mar 2025 17:36:41 +0100 (CET)
Date: Wed, 19 Mar 2025 17:36:41 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: load the ->i_sb pointer once in
 inode_sb_list_{add,del}
Message-ID: <sqtku5kwqvwxngv42zecgsz2a4baxwga2qciwczcmmwjx52x6c@a7uuyhks3ipt>
References: <20250319004635.1820589-1-mjguzik@gmail.com>
 <nb5g34ehva6wmjusa3tin3wbsr26gm6shvuxfspzkwpor6edxk@ncx2um24ipwq>
 <CAGudoHGN8ZKGCQCARU3kxX2XTk=LJE-AVGzPjYcQTjLcbCwqrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGN8ZKGCQCARU3kxX2XTk=LJE-AVGzPjYcQTjLcbCwqrA@mail.gmail.com>
X-Rspamd-Queue-Id: 59FB61FEE5
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 19-03-25 17:16:06, Mateusz Guzik wrote:
> On Wed, Mar 19, 2025 at 5:11 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 19-03-25 01:46:35, Mateusz Guzik wrote:
> > > While this may sound like a pedantic clean up, it does in fact impact
> > > code generation -- the patched add routine is slightly smaller.
> > >
> > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> >
> > I'm surprised it matters for the compiler but as Christian wrote, why not.
> > Feel free to add:
> >
> 
> In stock code the fence in spin_lock forces the compiler to load
> ->i_sb again -- as far as it knows it could have changed.
> 
> On the other this patch forces the compiler to remember the value for
> the same reason, which turns out to produce less code.

I see. Thanks for explanation!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

