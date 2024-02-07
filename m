Return-Path: <linux-fsdevel+bounces-10593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D0284C91E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 12:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280B31C2440E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 11:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A8A17C7F;
	Wed,  7 Feb 2024 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LGf89IfT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TYvli/OI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LGf89IfT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TYvli/OI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCB017BCB;
	Wed,  7 Feb 2024 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303648; cv=none; b=FbmB6Eh426Q7hjprX1wJqxgqLWEwER89AG4W9hhOa7zCkrY8x/n0fFB6JgA9YL8PLAVVzNt5iTwn+R+pmO+iB3Xzm0eXVgcPKioCAp+ifJCxKZbvnSbIfXG6p/G/Q3rRu1VQ8GGBN41SzXWZOp4HdLbk0N8nEFDksTAfzeeP2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303648; c=relaxed/simple;
	bh=FFSAnBd5Se93bT02HPMvL2EH82+uilSJf/jAlwQuULE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTUCHyYiaFbgxufYSBNdpNBFOYo2pn3kBAhtI/D8o0Qd3eO9ircNs8s/nhyN5riorUXrnNOS9Xm0zQiZ0sTWJlOubmuP9cX1szZYCJa6vig0NUmg5ZHSLJz69o23tZGQZH1cZvbskHTw2UU5miA63fdhMqi9PWFNFBI3935qd4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LGf89IfT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TYvli/OI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LGf89IfT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TYvli/OI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDFE51F74D;
	Wed,  7 Feb 2024 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707303644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eyUiwpFluA7WcMFlIVSpAKe54wAT0z8+m/oRT7nE+0Q=;
	b=LGf89IfTA4RVcerXsbYRkgZvIaDnx484T5e21bRXDAxjPZ1Rj5njN4gOw2gf3Q/1Ma0Z/B
	lcgkvOTxmn5AATSG3UusBAqGNblM+oJQoUPtkBYhDWwU9z3NATXxFmfJNro1hx3k+oE7xm
	fhv76d0M5AAparRnA4c4TKnB/z9/0AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707303644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eyUiwpFluA7WcMFlIVSpAKe54wAT0z8+m/oRT7nE+0Q=;
	b=TYvli/OIyXnEaUcCET9zbyUu8hu+WhCALgJU8+TvZEJSTslC16szgwtHE/P0B90QfwfBmK
	0HCbcgpDxcRq80DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707303644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eyUiwpFluA7WcMFlIVSpAKe54wAT0z8+m/oRT7nE+0Q=;
	b=LGf89IfTA4RVcerXsbYRkgZvIaDnx484T5e21bRXDAxjPZ1Rj5njN4gOw2gf3Q/1Ma0Z/B
	lcgkvOTxmn5AATSG3UusBAqGNblM+oJQoUPtkBYhDWwU9z3NATXxFmfJNro1hx3k+oE7xm
	fhv76d0M5AAparRnA4c4TKnB/z9/0AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707303644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eyUiwpFluA7WcMFlIVSpAKe54wAT0z8+m/oRT7nE+0Q=;
	b=TYvli/OIyXnEaUcCET9zbyUu8hu+WhCALgJU8+TvZEJSTslC16szgwtHE/P0B90QfwfBmK
	0HCbcgpDxcRq80DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B29C0139D8;
	Wed,  7 Feb 2024 11:00:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oz2TK9xiw2UscQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Feb 2024 11:00:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BBE1EA0809; Wed,  7 Feb 2024 12:00:41 +0100 (CET)
Date: Wed, 7 Feb 2024 12:00:41 +0100
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] tracing the source of errors
Message-ID: <20240207110041.fwypjtzsgrcdhalv@quack3>
References: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.82
X-Spamd-Result: default: False [-0.82 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[53.73%]
X-Spam-Flag: NO

On Wed 07-02-24 10:54:34, Miklos Szeredi via Lsf-pc wrote:
> [I'm not planning to attend LSF this year, but I thought this topic
> might be of interest to those who will.]
> 
> The errno thing is really ancient and yet quite usable.  But when
> trying to find out where a particular EINVAL is coming from, that's
> often mission impossible.
> 
> Would it make sense to add infrastructure to allow tracing the source
> of errors?  E.g.
> 
> strace --errno-trace ls -l foo
> ...
> statx(AT_FDCWD, "foo", ...) = -1 ENOENT [fs/namei.c:1852]
> ...
> 
> Don't know about others, but this issue comes up quite often for me.

Yes, having this available would be really useful at times. Sometimes I
had to resort to kprobes or good old printks.

> I would implement this with macros that record the place where a
> particular error has originated, and some way to query the last one
> (which wouldn't be 100% accurate, but good enough I guess).

The problem always has been how to implement this functionality in a
transparent way so the code does not become a mess. So if you have some
idea, I'd say go for it :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

