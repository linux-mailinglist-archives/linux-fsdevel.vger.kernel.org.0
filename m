Return-Path: <linux-fsdevel+bounces-61041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D082EB54A62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBED3AB74C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA622FE56A;
	Fri, 12 Sep 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hNJyfojN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KExZYwIt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hNJyfojN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KExZYwIt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99162FE04B
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674234; cv=none; b=RyuYZeB16spHYnoRZp054ypHLZFmkGP5fB9jXMQpAZ9FcS2FEm9l3K1ePCE6m2BqfSycS0ZPuxtIluODQAZnUU5/E+3ik1Br+MrWI6fiTMYAyfTKlk4S6w5diy18Ja9FXF+HPHQMjIpAgqS9tYVZA8vj3iz/7RMH21nhGIBpYaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674234; c=relaxed/simple;
	bh=YStn0Wir+doDuXHO/1o+5BXfU8keY9vtxvZuC05N6wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvXqLB5px3V8vqSLahHD8S5u+t0NagTX/Fn24Xnuawszep7YlMQJgBzBQsh2QO/iE2kEtzqumE9uUk2sC129CHIEP81EYaWZu0MajsgpbzYYuruxQk+WiK2s1hZdCcG8M/RZfB5+6Ut8r+w1HngDix8y6UsZOPkyKJgtw5N8QvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hNJyfojN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KExZYwIt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hNJyfojN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KExZYwIt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D2C95D557;
	Fri, 12 Sep 2025 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757674230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EwgQshy229J95WlSypc5DlbRhNhUQbr2g887V/Qu+xQ=;
	b=hNJyfojN2AIfTqIJedtzAFG44obuLXysOtGoBUkVapogebS9MWZ2a8oKDixwMu4Amuw9LA
	sPz0ERBhYcKIEQOiJvLKQ6lUSJDTMFbH9YJUaDnHAz9QAT4eIXCEPjUdmKDv4hYeQ6mKcl
	qdlhi1QSPZgXgPCmM71rwpijQjJsRtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757674230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EwgQshy229J95WlSypc5DlbRhNhUQbr2g887V/Qu+xQ=;
	b=KExZYwItLkm/RN9CnsDL0awjEWhXWFOCworVncRLaFXpK0Ry8fhu3dYVtzOOalzlvqh2Lo
	2EbQ6XuaqyDgFcAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757674230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EwgQshy229J95WlSypc5DlbRhNhUQbr2g887V/Qu+xQ=;
	b=hNJyfojN2AIfTqIJedtzAFG44obuLXysOtGoBUkVapogebS9MWZ2a8oKDixwMu4Amuw9LA
	sPz0ERBhYcKIEQOiJvLKQ6lUSJDTMFbH9YJUaDnHAz9QAT4eIXCEPjUdmKDv4hYeQ6mKcl
	qdlhi1QSPZgXgPCmM71rwpijQjJsRtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757674230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EwgQshy229J95WlSypc5DlbRhNhUQbr2g887V/Qu+xQ=;
	b=KExZYwItLkm/RN9CnsDL0awjEWhXWFOCworVncRLaFXpK0Ry8fhu3dYVtzOOalzlvqh2Lo
	2EbQ6XuaqyDgFcAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42BB713869;
	Fri, 12 Sep 2025 10:50:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fbVEEPb6w2jfWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Sep 2025 10:50:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 543DBA098E; Fri, 12 Sep 2025 12:50:25 +0200 (CEST)
Date: Fri, 12 Sep 2025 12:50:25 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initrd: Use str_plural() in rd_load_image()
Message-ID: <wq74que2nuy3gv623ddjptknqqyumae4uyvhvc7fhk6evin4sp@fyefkea25njh>
References: <20250912074651.1487588-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912074651.1487588-2-thorsten.blum@linux.dev>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri 12-09-25 09:46:52, Thorsten Blum wrote:
> Add the local variable 'nr_disks' and replace the manual ternary "s"
> pluralization with the standardized str_plural() helper function.
> 
> Use pr_notice() instead of printk(KERN_NOTICE) to silence a checkpatch
> warning.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  init/do_mounts_rd.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
> index ac021ae6e6fa..b8fccc7ffb7d 100644
> --- a/init/do_mounts_rd.c
> +++ b/init/do_mounts_rd.c
> @@ -7,6 +7,7 @@
>  #include <uapi/linux/cramfs_fs.h>
>  #include <linux/initrd.h>
>  #include <linux/string.h>
> +#include <linux/string_choices.h>
>  #include <linux/slab.h>
>  
>  #include "do_mounts.h"
> @@ -186,7 +187,7 @@ static unsigned long nr_blocks(struct file *file)
>  int __init rd_load_image(char *from)
>  {
>  	int res = 0;
> -	unsigned long rd_blocks, devblocks;
> +	unsigned long rd_blocks, devblocks, nr_disks;
>  	int nblocks, i;
>  	char *buf = NULL;
>  	unsigned short rotate = 0;
> @@ -244,8 +245,9 @@ int __init rd_load_image(char *from)
>  		goto done;
>  	}
>  
> -	printk(KERN_NOTICE "RAMDISK: Loading %dKiB [%ld disk%s] into ram disk... ",
> -		nblocks, ((nblocks-1)/devblocks)+1, nblocks>devblocks ? "s" : "");
> +	nr_disks = (nblocks - 1) / devblocks + 1;
> +	pr_notice("RAMDISK: Loading %dKiB [%ld disk%s] into ram disk... ",
> +		  nblocks, nr_disks, str_plural(nr_disks));
>  	for (i = 0; i < nblocks; i++) {
>  		if (i && (i % devblocks == 0)) {
>  			pr_cont("done disk #1.\n");
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

