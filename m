Return-Path: <linux-fsdevel+bounces-24236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8201C93BF59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 11:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E809B21933
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9122D13C3DD;
	Thu, 25 Jul 2024 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="THNAsLDN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VBguy6DJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="THNAsLDN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VBguy6DJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611613BC3D;
	Thu, 25 Jul 2024 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900888; cv=none; b=YTTNMQXKkqmpYe7gL1QpPuiygjnGkfiwFIgQgiLOpU8UBnmknT5Qa2FLi137eXFkIDPFhwtCdl/Z8d0vc3JsehXnd0+FU2CQFaLr5KZ1yAq4vQ0S89Ty+gxPn3DFwksb0Kd6BAQyc2ateXTr35smIxGFNpXc5sjvis6zndX8tHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900888; c=relaxed/simple;
	bh=5wggwBQsW0pIfGbJ70JBF5Vd/5UgTjPCBJLNzOnc29E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSHZPdw1zbRcpJXBa65YjxYtzWietVz0+Pjbt4Nlb1tUOGTEfXSmBpPlqewgKqwyBqg+6oD2z0jY7NIlbWpx/poVajlepSxpXchvr07FjggqpM6RhXtHilg0KGIamok8aAoSmYAoZ/JHT4GiZOEZdH6dHIr2UelKEXE1EeAMEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=THNAsLDN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VBguy6DJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=THNAsLDN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VBguy6DJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 308A61F7EB;
	Thu, 25 Jul 2024 09:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721900884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuyF32rp6Kjocy/ertr/PhV83euRJZA/Fmh4YzsdV+Q=;
	b=THNAsLDN7X9bvvm5494WZ72d5VokNw+EED3N+XV4V57J1EhnmaMnNKPak0FXBLfCBT0awc
	WdWy7aQu9tAjgV78xGEBfT9dyhNAdNG2BtdBNCYQlYnTWYvN0KRnsHTSS9H6M2fgn+nkoN
	5+4gi212JKuUQ9TeU6se2zG8E6vHCIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721900884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuyF32rp6Kjocy/ertr/PhV83euRJZA/Fmh4YzsdV+Q=;
	b=VBguy6DJgf02pdZ9UX4HHJCdP70sRE5Al7cc5kPeDQ1gKrzjo/vTsJ5HMsSGN6mW41L/HN
	1T268tux0nYRl6Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=THNAsLDN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VBguy6DJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721900884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuyF32rp6Kjocy/ertr/PhV83euRJZA/Fmh4YzsdV+Q=;
	b=THNAsLDN7X9bvvm5494WZ72d5VokNw+EED3N+XV4V57J1EhnmaMnNKPak0FXBLfCBT0awc
	WdWy7aQu9tAjgV78xGEBfT9dyhNAdNG2BtdBNCYQlYnTWYvN0KRnsHTSS9H6M2fgn+nkoN
	5+4gi212JKuUQ9TeU6se2zG8E6vHCIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721900884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuyF32rp6Kjocy/ertr/PhV83euRJZA/Fmh4YzsdV+Q=;
	b=VBguy6DJgf02pdZ9UX4HHJCdP70sRE5Al7cc5kPeDQ1gKrzjo/vTsJ5HMsSGN6mW41L/HN
	1T268tux0nYRl6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20D841368A;
	Thu, 25 Jul 2024 09:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9Q4ACFQfomYFPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 09:48:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C7B09A0996; Thu, 25 Jul 2024 11:48:03 +0200 (CEST)
Date: Thu, 25 Jul 2024 11:48:03 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, masahiroy@kernel.org,
	akpm@linux-foundation.org, n.schier@avm.de, ojeda@kernel.org,
	djwong@kernel.org, kvalo@kernel.org
Subject: Re: [PATCH] scripts: reduce false positives in the macro_checker
 script.
Message-ID: <20240725094803.vvq7nvgjaupu5vjg@quack3>
References: <20240725075830.63585-1-sunjunchao2870@gmail.com>
 <20240725085156.dezpnf44cilt46su@quack3>
 <CAHB1NagCqP4k9XvmAoyZ8NaRb0Y-bT1unnnOsmnt-mE6_k=8Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB1NagCqP4k9XvmAoyZ8NaRb0Y-bT1unnnOsmnt-mE6_k=8Rg@mail.gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 308A61F7EB
X-Spam-Score: -3.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sjc:email]

On Thu 25-07-24 05:15:34, Julian Sun wrote:
> Jan Kara <jack@suse.cz> 于2024年7月25日周四 04:52写道：
> >
> > On Thu 25-07-24 03:58:30, Julian Sun wrote:
> > > Reduce false positives in the macro_checker
> > > in the following scenarios:
> > >   1. Conditional compilation
> > >   2. Macro definitions with only a single character
> > >   3. Macro definitions as (0) and (1)
> > >
> > > Before this patch:
> > >       sjc@sjc:linux$ ./scripts/macro_checker.py  fs | wc -l
> > >       99
> > >
> > > After this patch:
> > >       sjc@sjc:linux$ ./scripts/macro_checker.py  fs | wc -l
> > >       11
> > >
> > > Most of the current warnings are valid now.
> > >
> > > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > ...
> > >  def file_check_macro(file_path, report):
> > > +    # number of conditional compiling
> > > +    cond_compile = 0
> > >      # only check .c and .h file
> > >      if not file_path.endswith(".c") and not file_path.endswith(".h"):
> > >          return
> > > @@ -57,7 +72,14 @@ def file_check_macro(file_path, report):
> > >          while True:
> > >              line = f.readline()
> > >              if not line:
> > > -                return
> > > +                break
> > > +            line = line.strip()
> > > +            if line.startswith(cond_compile_mark):
> > > +                cond_compile += 1
> > > +                continue
> > > +            if line.startswith(cond_compile_end):
> > > +                cond_compile -= 1
> > > +                continue
> > >
> > >              macro = re.match(macro_pattern, line)
> > >              if macro:
> > > @@ -67,6 +89,11 @@ def file_check_macro(file_path, report):
> > >                      macro = macro.strip()
> > >                      macro += f.readline()
> > >                      macro = macro_strip(macro)
> > > +                if file_path.endswith(".c")  and cond_compile != 0:
> > > +                    continue
> > > +                # 1 is for #ifdef xxx at the beginning of the header file
> > > +                if file_path.endswith(".h") and cond_compile != 1:
> > > +                    continue
> > >                  check_macro(macro, report)
> > >
> > >  def get_correct_macros(path):
> >
> >
> > > So I don't think this is right. As far as I understand this skips any macros
> > > that are conditionally defined? Why? There is a lot of them and checking
> > > them is beneficial... The patterns you have added should be dealing with
> > > most of the conditional defines anyway.
> Yes, this skips all checks for conditional macro. This is because I
> observed that almost all false positives come from conditional
> compilation. Testing showed that skipping them does not cause the
> genuine warnings to disappear.
> Also as you said, it may still lead to skipping checks for genuinely
> problematic macro definitions. Perhaps we could provide an option that
> allows users to control whether or not to check macros under
> conditional compilation?

Yes, that could be useful.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

