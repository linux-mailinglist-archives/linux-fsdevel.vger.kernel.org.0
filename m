Return-Path: <linux-fsdevel+bounces-49239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 152F2AB9A71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D036D1BC519D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73B0235076;
	Fri, 16 May 2025 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ez9ZDUix";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zanfp+N7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ez9ZDUix";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zanfp+N7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983C216E24
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747392541; cv=none; b=R36+v23fMQ0Psk1ZKerXUZMgJyOBgzeAW3h10jNQWm8Qi1JM+xR+F524hsOuTkzCUhJy7Sg2QD+ffQ/p6a1daQyXW735urtqr6d4xSO8YIf++zXbW4PKAtCKIF/UUA2/NSnAAPdIK7YkECi34XNU1qXBFy+YlYL+FlzA4SQY/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747392541; c=relaxed/simple;
	bh=jtSQOtiBkRadjEHGnGW8RamryfImQf2toeem0y47AMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmqZdlYzCKWm5hwwFIXBC6NPm0+Yr6UjkLSERHYlrbMhHsfZjxEsqPt0hylZ++ZbjKchI2Clgn0VjD8GlL3FWcP+mCL9SMsUZ4roNnsxdEGrltIFsqBbPz38HaVQP97dRsx+jqELlTmpnbrR43Q4XjSht8zg/k/bhc+VXxdCM7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ez9ZDUix; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zanfp+N7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ez9ZDUix; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zanfp+N7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 221EF21157;
	Fri, 16 May 2025 10:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747392537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbmbiYOGSWRWflc6yo7eC7zTr1id3DCSc9ugruKhpO8=;
	b=ez9ZDUixSMrVTALNNlixTbx5Snbsi0PEG+vdGAFllzQPa+9f7UyFutCI4fEm2W0d0Lb3+m
	oN1Fcp3O+zE/Pdcl6NjGsxd1jZAUm5SKP6r08BqPleRZp85kpYuEYXI4dAu0P/m6QImXwo
	6omAD3uVakoKfVFAhcBozXnGU2zddiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747392537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbmbiYOGSWRWflc6yo7eC7zTr1id3DCSc9ugruKhpO8=;
	b=Zanfp+N7sCmfoVbW9yT4oEpstlU7IAPH0uLUPseuMPHBAq/hTqe48nckvkFT9BEqwn8vXw
	4NNY7fp/UGo9a4Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ez9ZDUix;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Zanfp+N7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747392537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbmbiYOGSWRWflc6yo7eC7zTr1id3DCSc9ugruKhpO8=;
	b=ez9ZDUixSMrVTALNNlixTbx5Snbsi0PEG+vdGAFllzQPa+9f7UyFutCI4fEm2W0d0Lb3+m
	oN1Fcp3O+zE/Pdcl6NjGsxd1jZAUm5SKP6r08BqPleRZp85kpYuEYXI4dAu0P/m6QImXwo
	6omAD3uVakoKfVFAhcBozXnGU2zddiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747392537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbmbiYOGSWRWflc6yo7eC7zTr1id3DCSc9ugruKhpO8=;
	b=Zanfp+N7sCmfoVbW9yT4oEpstlU7IAPH0uLUPseuMPHBAq/hTqe48nckvkFT9BEqwn8vXw
	4NNY7fp/UGo9a4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08BBC13411;
	Fri, 16 May 2025 10:48:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6m3YARkYJ2gPCAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 16 May 2025 10:48:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B5148A09DD; Fri, 16 May 2025 12:48:56 +0200 (CEST)
Date: Fri, 16 May 2025 12:48:56 +0200
From: Jan Kara <jack@suse.cz>
To: Alejandro Colomar <alx@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: close(2) with EINTR has been changed by POSIX.1-2024
Message-ID: <ddqmhjc2rpzk2jjvunbt3l3eukcn4xzkocqzdg3j4msihdhzko@fizekvxndg2d>
References: <fskxqmcszalz6dmoak6de4c7bxt4juvc5zrpboae4dqw4y6aih@lskezjrbnsws>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fskxqmcszalz6dmoak6de4c7bxt4juvc5zrpboae4dqw4y6aih@lskezjrbnsws>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 221EF21157
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim]
X-Spam-Score: -4.01

Hi!

On Thu 15-05-25 23:33:22, Alejandro Colomar wrote:
> I'm updating the manual pages for POSIX.1-2024, and have some doubts
> about close(2).  The manual page for close(2) says (conforming to
> POSIX.1-2008):
> 
>        The EINTR error is a somewhat special case.  Regarding the EINTR
>        error, POSIX.1‐2008 says:
> 
>               If close() is interrupted by  a  signal  that  is  to  be
>               caught,  it  shall  return -1 with errno set to EINTR and
>               the state of fildes is unspecified.
> 
>        This permits the behavior that occurs on Linux  and  many  other
>        implementations,  where,  as  with  other errors that may be re‐
>        ported by close(), the  file  descriptor  is  guaranteed  to  be
>        closed.   However, it also permits another possibility: that the
>        implementation returns an EINTR error and  keeps  the  file  de‐
>        scriptor open.  (According to its documentation, HP‐UX’s close()
>        does this.)  The caller must then once more use close() to close
>        the  file  descriptor, to avoid file descriptor leaks.  This di‐
>        vergence in implementation behaviors provides a difficult hurdle
>        for  portable  applications,  since  on  many   implementations,
>        close() must not be called again after an EINTR error, and on at
>        least one, close() must be called again.  There are plans to ad‐
>        dress  this  conundrum for the next major release of the POSIX.1
>        standard.
> 
> TL;DR: close(2) with EINTR is allowed to either leave the fd open or
> closed, and Linux leaves it closed, while others (HP-UX only?) leaves it
> open.
> 
> Now, POSIX.1-2024 says:
> 
> 	If close() is interrupted by a signal that is to be caught, then
> 	it is unspecified whether it returns -1 with errno set to
> 	[EINTR] and fildes remaining open, or returns -1 with errno set
> 	to [EINPROGRESS] and fildes being closed, or returns 0 to
> 	indicate successful completion; [...]
> 
> <https://pubs.opengroup.org/onlinepubs/9799919799/functions/close.html>
> 
> Which seems to bless HP-UX and screw all the others, requiring them to
> report EINPROGRESS.
> 
> Was there any discussion about what to do in the Linux kernel?

I'm not aware of any discussions but indeed we are returning EINTR while
closing the fd. Frankly, changing the error code we return in that case is
really asking for userspace regressions so I'm of the opinion we just
ignore the standard as in my opinion it goes against a long established
reality.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

