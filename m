Return-Path: <linux-fsdevel+bounces-10833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB67684E9D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065001C2126C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 20:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA7C4C605;
	Thu,  8 Feb 2024 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gt1M55oz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PtdZev2i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SYpV4XDJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MohuNapO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25D4C3AF;
	Thu,  8 Feb 2024 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425273; cv=none; b=IXNO9RAUx8oJ3wer8sv7ORiJRWr/43U5EingG5xpwsN/+y7iB7IQKdBC2ffdlMFw5sp8lZpR56eJXAS38Vye5fsRjsFJ1K8A10ESFsX6PliZip9ZiVNtQfDThjTD3JhwjMHUd4xNGK/eqKR2Yt9fHgoZKVBNeV9ufEsyIv9CCZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425273; c=relaxed/simple;
	bh=Edoq6qlCuEE8lhkVt0dBMDKtW3Gi9GyrTEQ52bDIJn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cW3PrwImmMJMGcwmf9FBs0w6M1zCM2LAzXlsvDq156/HJKNjuJ/aBOHxgzaOZQPn3OWdR15mcB/E/pGQrIdCt+iIU/tNSQ7SeWl0XfTOz9xE4dASGpqJhV/fnbi0NPIacrKwA7KwIRygoZ1peOMCnNJZ5D4mZnWwAWUZsYX+nC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gt1M55oz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PtdZev2i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SYpV4XDJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MohuNapO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9273F1FD0A;
	Thu,  8 Feb 2024 20:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707425269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rE8RUdn/aeq63WE6iVzbD2tDvcz4pM7Qsls3FAl7II0=;
	b=gt1M55ozaQcVtcd2AymPxq3Oq218g2iD1/8MLGcgtK9yQ6YLKOlJXHVde2EbMvMJYMjLgG
	RWZ9fmXiMbQbLIf/CRx1FCl8a3CKWjDR8Htan38VwNDflPDscsCyoKg1UCvoylDpYiDGwq
	kznorajoik9CSZwkuEeAeIOOuWgYMUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707425269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rE8RUdn/aeq63WE6iVzbD2tDvcz4pM7Qsls3FAl7II0=;
	b=PtdZev2ixGKkZYUWbADShB6LZecRG/Jr2CXWCEcY/kNRV5yWXpcPz4QVh/8ItFYiyHe2B9
	hQj6hhGAqJruWuBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707425267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rE8RUdn/aeq63WE6iVzbD2tDvcz4pM7Qsls3FAl7II0=;
	b=SYpV4XDJ60eOky7gycfe9sH6VsmLhrQ0pW53bIyzFMccfvSgqJtBvucJ4uxFYL2bzViGBC
	2DtFCwBxfAaJmJUR8OQS8D8WncWqDXpxrAp/jrz7KRbcfR7KKA4UfMtGV0GVYW+pmOYs6B
	gzs7Pvx6KIMHLeKkqCNT228ECqBqhoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707425267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rE8RUdn/aeq63WE6iVzbD2tDvcz4pM7Qsls3FAl7II0=;
	b=MohuNapO357Yir7Nsu2JcYL3ktRCiYj62ovkoUmiCRDjxd3+tY4G4QlwaWd5aXoseSRBDv
	sFERAKAYqABzJIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D50A1326D;
	Thu,  8 Feb 2024 20:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WiuaDPM9xWXZUgAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 08 Feb 2024 20:47:47 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Jan Kara <jack@suse.cz>,  lsf-pc
 <lsf-pc@lists.linux-foundation.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] tracing the source of errors
In-Reply-To: <ZcNw-ek8s3AHxxCB@casper.infradead.org> (Matthew Wilcox's message
	of "Wed, 7 Feb 2024 12:00:57 +0000")
References: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
	<20240207110041.fwypjtzsgrcdhalv@quack3>
	<CAJfpegvkP5dic7CXB=ZtwTF4ZhRth1xyUY36svoM9c1pcx=f+A@mail.gmail.com>
	<ZcNw-ek8s3AHxxCB@casper.infradead.org>
Date: Thu, 08 Feb 2024 15:47:38 -0500
Message-ID: <871q9mvg2d.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.52 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.42)[78.19%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.52

Matthew Wilcox <willy@infradead.org> writes:

> Option (b)
>
> -#define EINVAL		22
> +#define E_INVAL	22
> +#define EINVAL		ERR(E_INVAL)

Note there will surely be cases where EINVAL is used as a soft failure
and the kernel will just try something else, instead of propagating the
error up the stack.  In this case, there is no point in logging the
first case of error, as it will just be expected behavior.

So there's really no way around explicitly annotating (ERR (EINVAL))
in place where it really matters, instead of changing the definition
of -EINVAL itself or automatically converting check sites.

>
> and then change all code that does something like:
>
> 	if (err == -EINVAL)
> to
> 	if (err == -E_INVAL)
>
> Or have I misunderstood?



-- 
Gabriel Krisman Bertazi

