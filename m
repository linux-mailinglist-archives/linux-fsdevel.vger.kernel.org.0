Return-Path: <linux-fsdevel+bounces-19203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2168C1270
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 18:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8821C20A6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453EE16F844;
	Thu,  9 May 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cab7YjQw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VdRal7e0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cab7YjQw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VdRal7e0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E0316F295;
	Thu,  9 May 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271051; cv=none; b=B+qkzKxglXoA1hL839FoD91aGfuALm9gPVi9/cWSneJyQLoq+8ghILvo+y6qU5gW2EUQEexyWkfDPco1JfEadQll7RB8OAmPwQo7ZBva8tAu+2ndm88zldPW0rJ8XqGmm4I+TdO3rNx4+j2Uh0R5PvZigahVD5gJfQXlY0xXIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271051; c=relaxed/simple;
	bh=qmj559/SpP6HjuomjajSCDse6k9r51/VK4xz7OWMtnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP2zsV1dX8JNhNbI27qOMNrD63Li5bBjc0cCopOjFv+WpIT+SW4fxtPjYhBJv8kVC5Ew6sMdmDHHwuspiaf2e6ZAQP47O8L8GwoES+h/xnqoYVCrs1V2vXgXZo89vRUIaBbLtfGERmFdNXlk6AHYiRSar18So9TU7YvhAIMaN9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cab7YjQw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VdRal7e0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cab7YjQw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VdRal7e0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02936388EF;
	Thu,  9 May 2024 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715271048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vjg2UcAN5fIPVGTTxX1TLrGuAZO8bmRZuqsaPWE+qB0=;
	b=cab7YjQw6jp18ynWm/l1AXIjYbsnHA5TQy6HKhq2+hibZMGWqm/wdEpePKXqf6EvpHTnpD
	6Gxbjs954CyTTIj26NHMYHjI2XaX6ZQyeadcfz+Xfcfkyo74ClN/A+ynAdSuNknO6D9Kxd
	qPQe1LR4fIFibmUFRDPZWUhCzNbu/Uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715271048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vjg2UcAN5fIPVGTTxX1TLrGuAZO8bmRZuqsaPWE+qB0=;
	b=VdRal7e0Na0Q6iZM7ZxBlM76DmXsvwjZtYBgfuV5dYHM1pxXSISps2S8AjFPyoRi8YG5x6
	+aZJ9V5kz9SWSUCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715271048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vjg2UcAN5fIPVGTTxX1TLrGuAZO8bmRZuqsaPWE+qB0=;
	b=cab7YjQw6jp18ynWm/l1AXIjYbsnHA5TQy6HKhq2+hibZMGWqm/wdEpePKXqf6EvpHTnpD
	6Gxbjs954CyTTIj26NHMYHjI2XaX6ZQyeadcfz+Xfcfkyo74ClN/A+ynAdSuNknO6D9Kxd
	qPQe1LR4fIFibmUFRDPZWUhCzNbu/Uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715271048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vjg2UcAN5fIPVGTTxX1TLrGuAZO8bmRZuqsaPWE+qB0=;
	b=VdRal7e0Na0Q6iZM7ZxBlM76DmXsvwjZtYBgfuV5dYHM1pxXSISps2S8AjFPyoRi8YG5x6
	+aZJ9V5kz9SWSUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB64913941;
	Thu,  9 May 2024 16:10:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 11V0OYf1PGbwHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 09 May 2024 16:10:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9E136A0861; Thu,  9 May 2024 18:10:47 +0200 (CEST)
Date: Thu, 9 May 2024 18:10:47 +0200
From: Jan Kara <jack@suse.cz>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v1 1/1] isofs: Use *-y instead of *-objs in Makefile
Message-ID: <20240509161047.osfiapw5bkezqy6b@quack3>
References: <20240508152129.1445372-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508152129.1445372-1-andriy.shevchenko@linux.intel.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email]

On Wed 08-05-24 18:21:11, Andy Shevchenko wrote:
> *-objs suffix is reserved rather for (user-space) host programs while
> usually *-y suffix is used for kernel drivers (although *-objs works
> for that purpose for now).
> 
> Let's correct the old usages of *-objs in Makefiles.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks! Added to my tree.

								Honza

> ---
> 
> Note, the original approach is weirdest from the existing.
> Only a few drivers use this (-objs-y) one most likely by mistake.
> 
>  fs/isofs/Makefile | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/isofs/Makefile b/fs/isofs/Makefile
> index 6498fd2b0f60..b25bc542a22b 100644
> --- a/fs/isofs/Makefile
> +++ b/fs/isofs/Makefile
> @@ -5,7 +5,6 @@
>  
>  obj-$(CONFIG_ISO9660_FS) += isofs.o
>  
> -isofs-objs-y 			:= namei.o inode.o dir.o util.o rock.o export.o
> -isofs-objs-$(CONFIG_JOLIET)	+= joliet.o
> -isofs-objs-$(CONFIG_ZISOFS)	+= compress.o
> -isofs-objs			:= $(isofs-objs-y)
> +isofs-y 		:= namei.o inode.o dir.o util.o rock.o export.o
> +isofs-$(CONFIG_JOLIET)	+= joliet.o
> +isofs-$(CONFIG_ZISOFS)	+= compress.o
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

