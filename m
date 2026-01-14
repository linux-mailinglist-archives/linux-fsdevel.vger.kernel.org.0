Return-Path: <linux-fsdevel+bounces-73650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 607ADD1D9D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DAFF3024597
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 09:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BFB38944F;
	Wed, 14 Jan 2026 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SuW8rI32";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I30ihIpg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SuW8rI32";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I30ihIpg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59120199D8
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768383573; cv=none; b=q3C/iSqBVL1PhIDBGoiQoi7d36dapvkI7DIBugvxp1CM+IFcUzl6ycA1rYRh5+lz6Cq1IvbPlwk13F7f6jC2/ZX5dY/xH44TVCG2GKfTS1uewOkMLnX6467U8rdaKF1EGio5Oy6xDqDWiM22yghOSO1C6B/HuuE2y2gTylDQgYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768383573; c=relaxed/simple;
	bh=cYxbapg/YMhOyoLNJzPJcKbRyAB4G7LmFIPpL0hAOCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT/DO8FZwiwpeuJyhel3Tl8DhzXiRf7LAGmU8z+puLumXKeUerKMnD/fRJcncFAhHrYX8X0Heczv51VebjvAjdX4I96nokHAb0z1oInXIcYOapzdHEA09T1TY6j4gYO0hc1L/Cvc/snKWqyH5l5ebfegPIis3x/XrHFPcXfh/MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SuW8rI32; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I30ihIpg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SuW8rI32; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I30ihIpg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C0385C06F;
	Wed, 14 Jan 2026 09:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768383570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Een1KJjpb6oQyGGausabj4o6lIakkKKgNl583lemC/o=;
	b=SuW8rI32QMkPgSeYMPzsrg5hu+POx+rGjvF+lqGb1eiBlDTZrxvBdQbuKhNkmvoacRRXeI
	fr4z7q9ZJvSg2VEz+MId/RjCU6eduwigGD91gdMiP0SNLNQ4zJBEfG1dDQbFInoIxCGbel
	8LGPpfbqjGNhRVJFuIdeWvpQt0K/6p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768383570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Een1KJjpb6oQyGGausabj4o6lIakkKKgNl583lemC/o=;
	b=I30ihIpgQpm5EDRlNHTVnJeud/RiiL+nyZaleHF0gGQiR0x/gMj6Wjcq58uVD0+IAIeXbF
	yAZ2g1hqU6CaHwBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768383570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Een1KJjpb6oQyGGausabj4o6lIakkKKgNl583lemC/o=;
	b=SuW8rI32QMkPgSeYMPzsrg5hu+POx+rGjvF+lqGb1eiBlDTZrxvBdQbuKhNkmvoacRRXeI
	fr4z7q9ZJvSg2VEz+MId/RjCU6eduwigGD91gdMiP0SNLNQ4zJBEfG1dDQbFInoIxCGbel
	8LGPpfbqjGNhRVJFuIdeWvpQt0K/6p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768383570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Een1KJjpb6oQyGGausabj4o6lIakkKKgNl583lemC/o=;
	b=I30ihIpgQpm5EDRlNHTVnJeud/RiiL+nyZaleHF0gGQiR0x/gMj6Wjcq58uVD0+IAIeXbF
	yAZ2g1hqU6CaHwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C4483EA63;
	Wed, 14 Jan 2026 09:39:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sveLLFFkZ2lHGAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 14 Jan 2026 09:39:29 +0000
Date: Wed, 14 Jan 2026 10:40:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: ltp@lists.linux.it, linux-fsdevel@vger.kernel.org
Subject: Re: [LTP] [PATCH] lack of ENAMETOOLONG testcases for pathnames
 longer than PATH_MAX
Message-ID: <aWdkmzC8pdtqVqk3@yuki.lan>
References: <20260113194936.GQ3634291@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113194936.GQ3634291@ZenIV>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,linux.org.uk:email,yuki.lan:mid];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -8.30
X-Spam-Level: 

Hi!
> 	There are different causes of ENAMETOOLONG.  It might come from
> filesystem rejecting an excessively long pathname component, but there's
> also "pathname is longer than PATH_MAX bytes, including terminating NUL"
> and that doesn't get checked anywhere.

We do have a couple of tests that checks that names over PATH_MAX are
rejected, there is no reason to add these kind of tests, however I do
not think that we tests that check that names that are just under the
limit work fine, that needs to be added.

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/testcases/kernel/syscalls/chdir/chdir04.c b/testcases/kernel/syscalls/chdir/chdir04.c
> index 6e53b7fef..e8dd5121d 100644
> --- a/testcases/kernel/syscalls/chdir/chdir04.c
> +++ b/testcases/kernel/syscalls/chdir/chdir04.c
> @@ -11,6 +11,8 @@
>  #include "tst_test.h"
>  
>  static char long_dir[] = "abcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
> +static char long_path[PATH_MAX+1];
> +static char shorter_path[PATH_MAX];
>  static char noexist_dir[] = "noexistdir";
>  
>  static struct tcase {
> @@ -20,16 +22,23 @@ static struct tcase {
>  	{long_dir, ENAMETOOLONG},
>  	{noexist_dir, ENOENT},
>  	{0, EFAULT}, // bad_addr
> +	{long_path, ENAMETOOLONG},

This test already exists in the form of long_dir just three lines above.

> +	{shorter_path, 0},

What about we add a separate test (chdir02.c) for paths that shouldn't
be rejected. Something as:

char path[PATH_MAX];
int i;

...
	for (i = 1; i < PATH_MAX; i++) {
		memset(path, 0, sizeof(path));
		memset(path, '/', i);
		TST_EXP_PASS(chdir(path), "chdir() len=%i", i);
	}
...


That would make sure that all lenghts of paths that are valid are
accepted.

-- 
Cyril Hrubis
chrubis@suse.cz

