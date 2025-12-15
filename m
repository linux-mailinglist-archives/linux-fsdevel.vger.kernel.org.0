Return-Path: <linux-fsdevel+bounces-71301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD33CBD1C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 10:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05AB0300AC64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 09:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D21E329E7A;
	Mon, 15 Dec 2025 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pT/OFaPb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GiZq8MPj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pT/OFaPb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GiZq8MPj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9F29B216
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790138; cv=none; b=THcD72QCs41LIccIr213sJhk1VC2nmd4uIzzmmddBBd4/hxrsA2/FsH6dGPGuV7n0bYBmembqqMKnPoxrF8EelbUTbFD/WNbfnu0BiDK7pr6YG1ufaXDhyXA6OWdFHqVqlJRAg+bKtS7MHHdWWNGEZWK/zR4Kvcnlpl9wXr2AgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790138; c=relaxed/simple;
	bh=AXjLWul7dR/QWaiEDWRG67Uq1PBLvjTEi1+JjRo2zgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Idj+68MOT/pj/O7kWhIem2yzs6qctw5QBed7dgv67vMOWbBnEoTxWdYg25kVoYVsZF/AJh9c6T1ScumSagXzOrN8P6wOyHf4M9nDhFTaTGfVszsQCMSz5lbMLo+lBzHHSmSX7raJMewp9Nmb1r8mpm70cP/OXBnygCAFw8ua/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pT/OFaPb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GiZq8MPj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pT/OFaPb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GiZq8MPj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F41F5BD16;
	Mon, 15 Dec 2025 09:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765790133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2AJB7aCL86TBfYZYcuXOAXnbF8+zMX2mmODBz+UMhmE=;
	b=pT/OFaPbd9xrZlVrHxdjZCszq29KB6v8pOw0JxLeAOfgDdQHLqdxtJMnLqCbG3FJkQQmCp
	7B4u7s9ikwVQtCYebLYcZlUFEqrT2J1fopd3UE0kPFBSVsWAGP1oqzatP60KbjNJ5SrKH7
	cQUwqJ1iUdAf9fb9JMzHvkvPlM6azWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765790133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2AJB7aCL86TBfYZYcuXOAXnbF8+zMX2mmODBz+UMhmE=;
	b=GiZq8MPjoliO+gLSOPnvnx4HdrRaZ5WYE0wPfvuLO1NSkrW7ygG16RTAs91PtegGPAvEjV
	qKbg2vqAvjBcc9DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="pT/OFaPb";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GiZq8MPj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765790133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2AJB7aCL86TBfYZYcuXOAXnbF8+zMX2mmODBz+UMhmE=;
	b=pT/OFaPbd9xrZlVrHxdjZCszq29KB6v8pOw0JxLeAOfgDdQHLqdxtJMnLqCbG3FJkQQmCp
	7B4u7s9ikwVQtCYebLYcZlUFEqrT2J1fopd3UE0kPFBSVsWAGP1oqzatP60KbjNJ5SrKH7
	cQUwqJ1iUdAf9fb9JMzHvkvPlM6azWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765790133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2AJB7aCL86TBfYZYcuXOAXnbF8+zMX2mmODBz+UMhmE=;
	b=GiZq8MPjoliO+gLSOPnvnx4HdrRaZ5WYE0wPfvuLO1NSkrW7ygG16RTAs91PtegGPAvEjV
	qKbg2vqAvjBcc9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 204D73EA63;
	Mon, 15 Dec 2025 09:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oIOJB7XRP2maAQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Dec 2025 09:15:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C7721A09B4; Mon, 15 Dec 2025 10:15:32 +0100 (CET)
Date: Mon, 15 Dec 2025 10:15:32 +0100
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] namespace: Replace simple_strtoul with kstrtoul to parse
 boot params
Message-ID: <3hnvigpwa2jomy6wimsdkkz4da64x7nsk4ffoko47ocpokqbou@fqymwie5damt>
References: <20251214153141.218953-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214153141.218953-2-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 2F41F5BD16
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Sun 14-12-25 16:31:42, Thorsten Blum wrote:
> Replace simple_strtoul() with the recommended kstrtoul() for parsing the
> 'mhash_entries=' and 'mphash_entries=' boot parameters.
> 
> Check the return value of kstrtoul() and reject invalid values. This
> adds error handling while preserving behavior for existing values, and
> removes use of the deprecated simple_strtoul() helper.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

...

> @@ -49,20 +49,14 @@ static unsigned int mp_hash_shift __ro_after_init;
>  static __initdata unsigned long mhash_entries;
>  static int __init set_mhash_entries(char *str)
>  {
> -	if (!str)
> -		return 0;
> -	mhash_entries = simple_strtoul(str, &str, 0);
> -	return 1;
> +	return kstrtoul(str, 0, &mhash_entries) == 0;
>  }
>  __setup("mhash_entries=", set_mhash_entries);

I'm not very experienced with the cmdline option parsing but AFAICT the
'str' argument can be indeed NULL and kstrtoul() will not be happy with
that?

>  static __initdata unsigned long mphash_entries;
>  static int __init set_mphash_entries(char *str)
>  {
> -	if (!str)
> -		return 0;
> -	mphash_entries = simple_strtoul(str, &str, 0);
> -	return 1;
> +	return kstrtoul(str, 0, &mphash_entries) == 0;
>  }
>  __setup("mphash_entries=", set_mphash_entries);

Similar here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

