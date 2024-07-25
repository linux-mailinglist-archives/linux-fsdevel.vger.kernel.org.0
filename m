Return-Path: <linux-fsdevel+bounces-24233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B31893BE35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 10:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2B71C20A43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 08:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD066196D9A;
	Thu, 25 Jul 2024 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GfGZTkxN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BOSzqu0U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GfGZTkxN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BOSzqu0U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E41741E1;
	Thu, 25 Jul 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721897536; cv=none; b=FBvKbzkEAAubBdGjzDLbUmXDgDkBZx+grQywF1wcZGPFTnnLt0UKyRCvpP5BAIXlH+i3FDJd67MRdF1MWx3fvQE2AhvQ2zuthFVdoD6uOAQEqKT8lLoP7WT2PdGG175v4FH6QWRl7yz+5S4+b1i1RC+w7DksCyJFNMeYtdExSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721897536; c=relaxed/simple;
	bh=U5ZDTXxkRIk/3JvEIigcQBdT7eXHTE8XK4nJqoJsIaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox3RdYu8M00ro6mw7qurIM2IBpRG448dmXs/q29Nhp88kooKmSmeEe7E7WUhAorfE5CDRAgTX5C9r4Jay/Rc3KqmzBxU7EWZn/w2kQl8Hiq0Qtk/tPa3Q3CdNECoeXCsltxJ4+1kH10EAM9eXnGmfsJalfcYWjrCEIGkFy1U4Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GfGZTkxN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BOSzqu0U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GfGZTkxN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BOSzqu0U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 370061F7F4;
	Thu, 25 Jul 2024 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721897532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SdDBGL0PW1vSYsbzX8BUuhklGP+FwaGFOQ2ZOZ0yRg=;
	b=GfGZTkxNcBivGaF3zRgTUF7QcgcYTA83aYDuXbALtiLv7RW9xy0RE/voPkpON8cdd34BME
	grcEZOTFCCCn2JPOMfgzVqeNzzwakOAtAvGxtiAUsk7g0udkMw+ADwtTTH/ZfPMgTPryD1
	q529o/b911SaIl3D0SSP8Wn7fmRlBmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721897532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SdDBGL0PW1vSYsbzX8BUuhklGP+FwaGFOQ2ZOZ0yRg=;
	b=BOSzqu0UvIOTSm1+eTUzlPRjUjFYTzyAqoWp6YhaEXaNz3FmcMMWfEMAaAln2GZTL52Quy
	yEfbug76xpuQM+Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GfGZTkxN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BOSzqu0U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721897532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SdDBGL0PW1vSYsbzX8BUuhklGP+FwaGFOQ2ZOZ0yRg=;
	b=GfGZTkxNcBivGaF3zRgTUF7QcgcYTA83aYDuXbALtiLv7RW9xy0RE/voPkpON8cdd34BME
	grcEZOTFCCCn2JPOMfgzVqeNzzwakOAtAvGxtiAUsk7g0udkMw+ADwtTTH/ZfPMgTPryD1
	q529o/b911SaIl3D0SSP8Wn7fmRlBmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721897532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SdDBGL0PW1vSYsbzX8BUuhklGP+FwaGFOQ2ZOZ0yRg=;
	b=BOSzqu0UvIOTSm1+eTUzlPRjUjFYTzyAqoWp6YhaEXaNz3FmcMMWfEMAaAln2GZTL52Quy
	yEfbug76xpuQM+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C34513874;
	Thu, 25 Jul 2024 08:52:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id je6YBjwSomZxLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 08:52:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BAD3FA08F2; Thu, 25 Jul 2024 10:51:56 +0200 (CEST)
Date: Thu, 25 Jul 2024 10:51:56 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk,
	masahiroy@kernel.org, akpm@linux-foundation.org, n.schier@avm.de,
	ojeda@kernel.org, djwong@kernel.org, kvalo@kernel.org
Subject: Re: [PATCH] scripts: reduce false positives in the macro_checker
 script.
Message-ID: <20240725085156.dezpnf44cilt46su@quack3>
References: <20240725075830.63585-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725075830.63585-1-sunjunchao2870@gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 370061F7F4
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
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]

On Thu 25-07-24 03:58:30, Julian Sun wrote:
> Reduce false positives in the macro_checker
> in the following scenarios:
>   1. Conditional compilation
>   2. Macro definitions with only a single character
>   3. Macro definitions as (0) and (1)
> 
> Before this patch:
> 	sjc@sjc:linux$ ./scripts/macro_checker.py  fs | wc -l
> 	99
> 
> After this patch:
> 	sjc@sjc:linux$ ./scripts/macro_checker.py  fs | wc -l
> 	11
> 
> Most of the current warnings are valid now.
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
...
>  def file_check_macro(file_path, report):
> +    # number of conditional compiling
> +    cond_compile = 0
>      # only check .c and .h file
>      if not file_path.endswith(".c") and not file_path.endswith(".h"):
>          return
> @@ -57,7 +72,14 @@ def file_check_macro(file_path, report):
>          while True:
>              line = f.readline()
>              if not line:
> -                return
> +                break
> +            line = line.strip()
> +            if line.startswith(cond_compile_mark):
> +                cond_compile += 1
> +                continue
> +            if line.startswith(cond_compile_end):
> +                cond_compile -= 1
> +                continue
>  
>              macro = re.match(macro_pattern, line)
>              if macro:
> @@ -67,6 +89,11 @@ def file_check_macro(file_path, report):
>                      macro = macro.strip()
>                      macro += f.readline()
>                      macro = macro_strip(macro)
> +                if file_path.endswith(".c")  and cond_compile != 0:
> +                    continue
> +                # 1 is for #ifdef xxx at the beginning of the header file
> +                if file_path.endswith(".h") and cond_compile != 1:
> +                    continue
>                  check_macro(macro, report)
>  
>  def get_correct_macros(path):

So I don't think this is right. As far as I understand this skips any macros
that are conditionally defined? Why? There is a lot of them and checking
them is beneficial... The patterns you have added should be dealing with
most of the conditional defines anyway.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

