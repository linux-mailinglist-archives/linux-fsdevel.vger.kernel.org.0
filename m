Return-Path: <linux-fsdevel+bounces-10831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDF584E9C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6881C22D7F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 20:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EB84C605;
	Thu,  8 Feb 2024 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jkn4QKrv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c+x/UOeb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m9Kfn/XA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7H+itk1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4DB4C3A9;
	Thu,  8 Feb 2024 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424755; cv=none; b=hEp2405WUxwjAHm7GRY8Y88p0sf9WEC9p7RlyzBGyx7NUHa4wL9s19eNjJTWpdXBvCauRvT0t8Gn2rvg/u++uX/l5z6aOcxhBe6SQ3M5cv1oGTcDdaPMj0eIix91zj/qTF8K43TVjRB7nTtK29PI7AHBorJQop3BzS/j+9V+kOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424755; c=relaxed/simple;
	bh=aTilR6slG6VGdQOqK8gUXQ9ropuqXn8Mw4GgGViuaCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KBn0ngp//ErEfebUfnY1u1b7X5vjsg74J/9flAkligTTN/nmD/NHzG2djdxwpPqWXaSKMMeQuWiS0QTNaYpz4AeyvjN8ruZmQ3VyjIPfngy1lEn/OSCIz3Nch8mXem41Aj70jwIHW0rX5Xw9AZpNa2LchpN0sngCjA5oNWUdVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jkn4QKrv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c+x/UOeb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m9Kfn/XA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7H+itk1I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE0D522134;
	Thu,  8 Feb 2024 20:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707424751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKsChhPyarVzSpE7Z4EC7jjYR4S1uWKED1/tuMhFbkA=;
	b=Jkn4QKrvzkZhL+oyxQAAPLppQT8wp1OJ1CoXKdpjMql3SyXHWk3g0zoxEuCerpGt/z+1BO
	hcgkXaf8iYpLNA/FWshLdjwNZKoGnOljWHO51BhenG5p4DhE88GPPCThT9KO7keanfcHTi
	01VMWXKqB1r6DsMQjQyKkPERTmASxBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707424751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKsChhPyarVzSpE7Z4EC7jjYR4S1uWKED1/tuMhFbkA=;
	b=c+x/UOebNHqSYy98f8lgouX4mr57EWhOrl9++EQ5r3N0ToEQjGZQUWQwhAHfdi7XpqgogP
	JjVcZ6KLry8T/8Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707424750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKsChhPyarVzSpE7Z4EC7jjYR4S1uWKED1/tuMhFbkA=;
	b=m9Kfn/XA7vo2KxxMS3nPo17Cuf5SOeiG2HRfAwxnXUU03cmeo/Y6NnjGQ4wX6t6rkixJl3
	wWTjxyrGeDXxFFIyXX67sWG7SZgvd+dut0gZIBu6eEDJ/Ll4//3z5ty8d0QSE8tVOXzv5r
	0rQqrIsfCmD9Po3iUQPGj2/zHyYqgdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707424750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKsChhPyarVzSpE7Z4EC7jjYR4S1uWKED1/tuMhFbkA=;
	b=7H+itk1ILV8FGUPlp+1qUVPZXirdSw1huhQgRoICqxiaxxiH/6OmJOGPRhQLfLmkgALSU0
	mUn2DqraDJ4X1BAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB8081326D;
	Thu,  8 Feb 2024 20:39:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VZ7TI+47xWXHUAAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 08 Feb 2024 20:39:10 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  lsf-pc
 <lsf-pc@lists.linux-foundation.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] tracing the source of errors
In-Reply-To: <20240207110041.fwypjtzsgrcdhalv@quack3> (Jan Kara's message of
	"Wed, 7 Feb 2024 12:00:41 +0100")
References: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
	<20240207110041.fwypjtzsgrcdhalv@quack3>
Date: Thu, 08 Feb 2024 15:39:09 -0500
Message-ID: <875xyyvggi.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="m9Kfn/XA";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7H+itk1I
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.08)[63.28%]
X-Spam-Score: -3.59
X-Rspamd-Queue-Id: EE0D522134
X-Spam-Flag: NO

Jan Kara <jack@suse.cz> writes:

> On Wed 07-02-24 10:54:34, Miklos Szeredi via Lsf-pc wrote:
>> [I'm not planning to attend LSF this year, but I thought this topic
>> might be of interest to those who will.]
>> 
>> The errno thing is really ancient and yet quite usable.  But when
>> trying to find out where a particular EINVAL is coming from, that's
>> often mission impossible.
>> 
>> Would it make sense to add infrastructure to allow tracing the source
>> of errors?  E.g.
>> 
>> strace --errno-trace ls -l foo
>> ...
>> statx(AT_FDCWD, "foo", ...) = -1 ENOENT [fs/namei.c:1852]
>> ...
>> 
>> Don't know about others, but this issue comes up quite often for me.
>
> Yes, having this available would be really useful at times. Sometimes I
> had to resort to kprobes or good old printks.
>
>> I would implement this with macros that record the place where a
>> particular error has originated, and some way to query the last one
>> (which wouldn't be 100% accurate, but good enough I guess).
>
> The problem always has been how to implement this functionality in a
> transparent way so the code does not become a mess. So if you have some
> idea, I'd say go for it :)

I had a proposal to provide the LoC of filesystem errors as part of an
extended record of the FAN_FS_ERROR messages (fanotify interface).  It
might be a sensible interface to expose this information if not
prohibitively expensive.

One might record the position with a macro and do the fsnotify_sb_error
from a safer context.

-- 
Gabriel Krisman Bertazi

