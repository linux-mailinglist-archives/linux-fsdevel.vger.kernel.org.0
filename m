Return-Path: <linux-fsdevel+bounces-43441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63337A56AC4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 15:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F252189A2A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C067621C180;
	Fri,  7 Mar 2025 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p89e8Vs2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lRACKNHA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XGzuTsY6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lklopRZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C7208AD
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358853; cv=none; b=IsaPBzohhjeiSsD3ZKSz8S7DZtiQwqQWJqDGFPsqNg4GSjLw5Soz5/ourYz7zwhy4rfHLAeQSbegKGEZkx0ZXyJkHW/IhQBo6RTDPxGCnJ/s13KHr1WnAyYKeIZRMYaDnRKTMVwfJ3VhCBtKjSjhpMhIDZwRPk1HKhg+MLBM0iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358853; c=relaxed/simple;
	bh=Gcw117duv8recEN1dqJRNyL3cWrsr+wn49dHddV6FrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwDkWL8TzH3gu2vep+VwGdFEXB1XLQYPgUBe9xqJyMKiMoBVlPaJFzHSeihJhbi8Bisy477ex99R94JVHZFYONIsy/Ho/qpU+sRWHRRHKmZXKa29r/LfhRS3zg/ocZ10yxU4uBiv3ld3cHjzXqgfzkfl9+CEov2z/bsOI00gW94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p89e8Vs2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lRACKNHA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XGzuTsY6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lklopRZF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9AC941F395;
	Fri,  7 Mar 2025 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741358849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3e0QAGzyMycCbFd6B+5fqZyw6K7Uq5wm7ushJR/f5Y=;
	b=p89e8Vs2POw8H9ao/jx5slB/pophAmIlhL0naiE+25jguenqZ1HJ7gk3Jm5u35pDoK5w8C
	gl7VRA1BkBiJrHWBP+GxEq2Dx2ItTY7PbQo86wNzhGwsutkyjixbNImHFODVV8fii+ax9n
	EyAuQMVPzO4VT3zQxNoCT1a3/dtekgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741358849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3e0QAGzyMycCbFd6B+5fqZyw6K7Uq5wm7ushJR/f5Y=;
	b=lRACKNHAPTpgQRNsvSrf2xEFztkZlnxGBAVAjWT8IvgJRoFRsNEsPaYGl6HktpkdaA6K0V
	pW7PykZgAieHEKAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741358848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3e0QAGzyMycCbFd6B+5fqZyw6K7Uq5wm7ushJR/f5Y=;
	b=XGzuTsY6IWmI3NXFw1cZKSnsmuzD+QWzn7L+njmbTru81fvRqSF4eWoJxwTPBvYFz8rJhC
	ISZbq18iXWSsGhweQz6jqL0QoKclmtmlYNDklaqaoFML/nOLDFaHqBcBecffgLZRScfJun
	ceOrsojuttOxFr+p5OZUqaVL3iAp1Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741358848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3e0QAGzyMycCbFd6B+5fqZyw6K7Uq5wm7ushJR/f5Y=;
	b=lklopRZFtsxRfgj0e23BtpElXr6wU5nRUP8gVcFqh1+eBoWJWgDm0UjTANTtXRDFOKWJa/
	Dl39lJX4UoewqPBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FEAC13939;
	Fri,  7 Mar 2025 14:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /VoGIwAHy2cxMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 07 Mar 2025 14:47:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 570B0A089C; Fri,  7 Mar 2025 15:47:28 +0100 (CET)
Date: Fri, 7 Mar 2025 15:47:28 +0100
From: Jan Kara <jack@suse.cz>
To: sunliming@linux.dev
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	kees@kernel.org, ebiederm@xmission.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, sunliming@kylinos.cn, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fs: binfmt_elf_efpic: fix variable set but not used
 warning
Message-ID: <a555rynwidxdyj7s3oswpmcnkqu57jv3wsk5qwfg5zz6m55na3@n53ssiekfch4>
References: <20250307061128.2999222-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307061128.2999222-1-sunliming@linux.dev>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,intel.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 07-03-25 14:11:28, sunliming@linux.dev wrote:
> From: sunliming <sunliming@kylinos.cn>
> 
> Fix below kernel warning:
> fs/binfmt_elf_fdpic.c:1024:52: warning: variable 'excess1' set but not
> used [-Wunused-but-set-variable]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>

The extra ifdef is not pretty but I guess it's better. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/binfmt_elf_fdpic.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index e3cf2801cd64..bed13ee8bfec 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -1024,8 +1024,11 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>  	/* deal with each load segment separately */
>  	phdr = params->phdrs;
>  	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
> -		unsigned long maddr, disp, excess, excess1;
> +		unsigned long maddr, disp, excess;
>  		int prot = 0, flags;
> +#ifdef CONFIG_MMU
> +		unsigned long excess1;
> +#endif
>  
>  		if (phdr->p_type != PT_LOAD)
>  			continue;
> @@ -1120,9 +1123,9 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>  		 *   extant in the file
>  		 */
>  		excess = phdr->p_memsz - phdr->p_filesz;
> -		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
>  
>  #ifdef CONFIG_MMU
> +		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
>  		if (excess > excess1) {
>  			unsigned long xaddr = maddr + phdr->p_filesz + excess1;
>  			unsigned long xmaddr;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

