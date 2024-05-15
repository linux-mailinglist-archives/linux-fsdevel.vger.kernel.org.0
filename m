Return-Path: <linux-fsdevel+bounces-19531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64E38C6793
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 15:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154A31C21D31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5919813B5B0;
	Wed, 15 May 2024 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YVQgYek5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FSE1eyv6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YVQgYek5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FSE1eyv6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3257B13AD25
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780444; cv=none; b=XhI2P0ploXoQiT2kkni2rDcYWq6p+n/bG//FYNLmVgjewh0YDw1C5j/wK7MlRdwsHbSTHrv5RDE1gHjpMckMgF2ID9by5UQmSCmcfRIiS5dbD8FUtSuer3gNRPrSvd44n9QKB4wo8xKDMCF+OogzwbqT/3pTew+304unQ6Yprno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780444; c=relaxed/simple;
	bh=LXHV+k0luFqx1OlitKKx+1HYfdXuTUZJmE5vMPNtxsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ/+phWYBibk94PSGmuiKR6aT4RIy3KMgqrOxCeLyY0vUKLTta6cQ45rB60dOBIfj0vUhVVv4rdQc4kE5d6zUgIfPxB+tbwhGyn1LJfXK6ksnwBbhgahP+wenSTl9NJ9zmTP60Pcn8IkzxmdxK2zbrWsD5ARfh/lZ8Cgxs5mzKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YVQgYek5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FSE1eyv6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YVQgYek5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FSE1eyv6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2182720717;
	Wed, 15 May 2024 13:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715780432;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLGJev3FA7v3vsYQEjnEowkK3iUYOP0SL3+sW0TN5YI=;
	b=YVQgYek5HqXmJnE9tcJCykuLrzO9PN2sfMpFunCbmyVy/TxBLs/4EVrvMCA3Ho1MeeeUpn
	HcTxYXF61ir/CCnp7E7I52Jsfmeuw/XaTKfMIUNw9yvz2m0l9GHcnAO75p3ujoWNQI/bN5
	LjlK2EbVHtE0z9KavwMByHNmZj8sCR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715780432;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLGJev3FA7v3vsYQEjnEowkK3iUYOP0SL3+sW0TN5YI=;
	b=FSE1eyv6Hs3uvUmst4Re4bPPCHocjTNEe6AGCgx8EDcaBxl87s7i0IR/iW9BNScUWaLDj8
	9ulRrg6UdfQZzpDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715780432;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLGJev3FA7v3vsYQEjnEowkK3iUYOP0SL3+sW0TN5YI=;
	b=YVQgYek5HqXmJnE9tcJCykuLrzO9PN2sfMpFunCbmyVy/TxBLs/4EVrvMCA3Ho1MeeeUpn
	HcTxYXF61ir/CCnp7E7I52Jsfmeuw/XaTKfMIUNw9yvz2m0l9GHcnAO75p3ujoWNQI/bN5
	LjlK2EbVHtE0z9KavwMByHNmZj8sCR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715780432;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLGJev3FA7v3vsYQEjnEowkK3iUYOP0SL3+sW0TN5YI=;
	b=FSE1eyv6Hs3uvUmst4Re4bPPCHocjTNEe6AGCgx8EDcaBxl87s7i0IR/iW9BNScUWaLDj8
	9ulRrg6UdfQZzpDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 531451372E;
	Wed, 15 May 2024 13:40:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IP4XEE+7RGbuGwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 15 May 2024 13:40:31 +0000
Date: Wed, 15 May 2024 15:40:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Lee Jones <lee@kernel.org>
Cc: Murphy Zhou <jencce.kernel@gmail.com>, ltp@lists.linux.it,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [LTP] [PATCH] readahead01: pass on pidfd
Message-ID: <20240515134025.GA225100@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240423070643.38577-1-jencce.kernel@gmail.com>
 <20240515132151.GA557949@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515132151.GA557949@google.com>
X-Spam-Flag: NO
X-Spam-Score: -6.00
X-Spam-Level: 
X-Spamd-Result: default: False [-6.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.it,linux-foundation.org,kvack.org,vger.kernel.org,infradead.org,suse.cz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]

Hi Lee,

> On Tue, 23 Apr 2024, Murphy Zhou wrote:

> > Linux kernel added pidfs via commit b5683a37c881 in v6.9-rc1
> > release. This patchset ignores readahead request instead of
> > returning EINVAL, so mark the test pass.

> > https://lkml.iu.edu/hypermail/linux/kernel/2403.2/00762.html

> > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > ---
> >  testcases/kernel/syscalls/readahead/readahead01.c | 1 +
> >  1 file changed, 1 insertion(+)

> > diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
> > index d4b3f306f..aed8e7f31 100644
> > --- a/testcases/kernel/syscalls/readahead/readahead01.c
> > +++ b/testcases/kernel/syscalls/readahead/readahead01.c
> > @@ -53,6 +53,7 @@ static void test_invalid_fd(struct tst_fd *fd)
> >  	case TST_FD_MEMFD:
> >  	case TST_FD_MEMFD_SECRET:
> >  	case TST_FD_PROC_MAPS:
> > +	case TST_FD_PIDFD:
> >  		return;
> >  	default:
> >  		break;

> Any movement on this?

Back to Christian Brauner discussing with Cyril Hrubis [1]

	> Wouldn't it make more sense to actually return EINVAL instead of
	> ignoring the request if readahead() is not implemented?

	It would change the return value for a whole bunch of stuff. I'm not
	sure that wouldn't cause regressions but is in any case a question for
	the readahead maintainers. For now I'd just remove that test for pidfds
	imho.

That's why I would like to get ack / oppinion of the readahead maintainers.
I already asked them under this patch.

@Andrew gently ping.

Kind regards,
Petr

[1] https://lore.kernel.org/lkml/20240318-fegen-bezaubern-57b0a9c6f78b@brauner/

Below the patch I have asked kernel maintainers to ack if 

> Android pre-submit CI testing is failing due to the new unconditional
> enable of PIDFD.  I believe this patch is required in order to bring it
> back to a passing state.

