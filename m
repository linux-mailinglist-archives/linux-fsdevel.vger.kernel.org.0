Return-Path: <linux-fsdevel+bounces-66756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A5BC2B920
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BABF3A8786
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA63C3090EE;
	Mon,  3 Nov 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cv/cLHUM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="st5v/Ay/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vh5lDIW0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OW0rNYfa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3672EE5FE
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171588; cv=none; b=f8PDOqKYr5h6rb+JZeChZuuZOrVqVp6Dcc2ilW865ox3zZIeMPAwPa/QuNip5zDyWG8BggPE4qQfNFht0A1S5OU8ogUxoK9Wb9zq5z7yuhpchlp24/g77f/CqwkaI9ukowOSB5d4OWzKxQPnURztIN6L+oxxUo2tJWJING8M3Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171588; c=relaxed/simple;
	bh=HmZCakxtcpbQUGmbx8+NwoKvRMv15ND/xeWTNP3ZjUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qy/6AWjULhRJEAa+2mEdItv/MIkHHyVm9dpdvRgKKd9r2Nawnwnyzq3zBXeDpSs0VkmD1YESq5wo6mqygQnxLwRarseB37HSuPgUUlhqsCvLY9Fc5v7DrFBh/nEPGiNuSnuHCB9QYkPzqsPzHVD5V1dln9ZTeHdS2sVecQFnIww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cv/cLHUM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=st5v/Ay/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vh5lDIW0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OW0rNYfa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A47A71F7C4;
	Mon,  3 Nov 2025 12:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762171584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LGrj5NeWeCS1WPf08wDOoAadnbJSF3shnFudQ5a2o/M=;
	b=cv/cLHUMe1TJ2RaxZFjtzBt8dSACKy1tvGCXT06jUwCvmCAMA/94EEjO5Qmp9daELonVMI
	xLGM8eIw4M1sLJIZFHEwkEsLWPK99YH4sOFVDmEByLPNrkWL0ewIWcXHRcVjCyyQzdnrjW
	4aDj2qDaQFJn2PKua4rUwedM6DuPTjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762171584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LGrj5NeWeCS1WPf08wDOoAadnbJSF3shnFudQ5a2o/M=;
	b=st5v/Ay/b5ZiMfnn8ZeBX171JHct1MQZla4VDR9SLFgPTv00fd3nd/Q4UNfQQBn16z8SE6
	f+PAs3cFAEkCP7Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762171583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LGrj5NeWeCS1WPf08wDOoAadnbJSF3shnFudQ5a2o/M=;
	b=Vh5lDIW0iYPZU7/Ms07eWC2II11fwejuMzeBzuAbbhwmIf71LX3z8ggC5FWcBNHAfBI8yX
	WEI+4emGxWIN1X0+eRvyAdtFaz2uIjEZaOLzMCzPutL1OJPyG+1tdGq1sGhcmMUWZNx6tj
	P0GzxFpYM5RFKc27YFncrpW4Xby4Skc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762171583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LGrj5NeWeCS1WPf08wDOoAadnbJSF3shnFudQ5a2o/M=;
	b=OW0rNYfa7r5eu9zsk+cLauXw3uye4OvO1nRSYd5MOtTJ41T1CUnzlzg4/HHdFhHdpzLLX+
	AzR6cTr18npgCOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9482C1364F;
	Mon,  3 Nov 2025 12:06:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ss45JL+aCGmMRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 12:06:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F370EA281D; Mon,  3 Nov 2025 13:06:22 +0100 (CET)
Date: Mon, 3 Nov 2025 13:06:22 +0100
From: Jan Kara <jack@suse.cz>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] init: Replace simple_strtoul() with kstrtouint() in
 root_delay_setup()
Message-ID: <jmagyxklgr5fpjgiaefmwwqroykzrjkhbl67fdzrtf5m5ukuqi@534a23y66am7>
References: <20251103080627.1844645-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103080627.1844645-1-kaushlendra.kumar@intel.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 03-11-25 13:36:27, Kaushlendra Kumar wrote:
> Replace deprecated simple_strtoul() with kstrtouint() for better error
> handling and input validation. Return 0 on parsing failure to indicate
> invalid parameter, maintaining existing behavior for valid inputs.
> 
> The simple_strtoul() function is deprecated in favor of kstrtoint()
> family functions which provide better error handling and are recommended
> for new code and replacements.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  init/do_mounts.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 3c5fd993bc7e..3284226f7a2a 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -120,7 +120,8 @@ static int __init fs_names_setup(char *str)
>  static unsigned int __initdata root_delay;
>  static int __init root_delay_setup(char *str)
>  {
> -	root_delay = simple_strtoul(str, NULL, 0);
> +	if (kstrtouint(str, 0, &root_delay))
> +		return 0;
>  	return 1;
>  }
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

