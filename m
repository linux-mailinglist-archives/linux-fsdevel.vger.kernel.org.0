Return-Path: <linux-fsdevel+bounces-51118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5ADAD2F58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 09:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9951713D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 07:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E0F28001A;
	Tue, 10 Jun 2025 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g5SxXac/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NuACWvpd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g5SxXac/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NuACWvpd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E5F27FD7A
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749542367; cv=none; b=scZ5UonjtXx1QZP/lakih//hBalLsHjdNLXO/JVu/XOZ2ENOcPjTIWMnUKglXwHa/tihcA26CMBck/hL/65TCkCAawX0qFjEk3UDEiF1B+ENdHWOzg7fswG3/GB6h/sifL7hnngwNao9ARN7N4uY7yr8eb7vEfdTG4HzmoYfq0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749542367; c=relaxed/simple;
	bh=zmkhM0Z06NE7uqn4NnAmDUNk03/whM4kbqWCYYltHVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXOzVEovUXWntIPDjz3slLzZvKcCHonBnun5KdT4jRQjDlZfxBwaZ2gmNosnFw6EUkEJDZQzV19nJ7Bz19nB3CQbyceAxnG1ZNKlvqaCw3VwQjO4BTBxp/eeOh6F34fr7qR3M/VefSAv4cwEp44XbPJaSIfWti/25Tlku8XNRqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g5SxXac/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NuACWvpd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g5SxXac/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NuACWvpd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E47981F45A;
	Tue, 10 Jun 2025 07:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749542362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jbMSIU7EVX+J2XdZO+ASS01ov216EaiT+rrndfaPCo=;
	b=g5SxXac/M/M0m3bhfVw0y+S0sUXTGAQ1Segni9flIkvz7sv8ulxLKqUW0gx4FaMZAA/dcs
	qHRknZaMlN+CKlZVsOaq+A0HmLTuGTk8SQ1bUDAv5ULGbQ2VToGT7Ra4tLI6xg7bjCnY2c
	j4gSNh11ZlnH+jDLOtJK5pfDDEiW9Ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749542362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jbMSIU7EVX+J2XdZO+ASS01ov216EaiT+rrndfaPCo=;
	b=NuACWvpdO202Rcg2FSLqtcUYwR9oprqDfyDvq2+PH6fGDscgf2nNPAK3FowYNs4cPKSil9
	/Dk2I2UbK759TQAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="g5SxXac/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NuACWvpd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749542362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jbMSIU7EVX+J2XdZO+ASS01ov216EaiT+rrndfaPCo=;
	b=g5SxXac/M/M0m3bhfVw0y+S0sUXTGAQ1Segni9flIkvz7sv8ulxLKqUW0gx4FaMZAA/dcs
	qHRknZaMlN+CKlZVsOaq+A0HmLTuGTk8SQ1bUDAv5ULGbQ2VToGT7Ra4tLI6xg7bjCnY2c
	j4gSNh11ZlnH+jDLOtJK5pfDDEiW9Ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749542362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jbMSIU7EVX+J2XdZO+ASS01ov216EaiT+rrndfaPCo=;
	b=NuACWvpdO202Rcg2FSLqtcUYwR9oprqDfyDvq2+PH6fGDscgf2nNPAK3FowYNs4cPKSil9
	/Dk2I2UbK759TQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9AE0139E2;
	Tue, 10 Jun 2025 07:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2H0eNdrlR2g2DgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Jun 2025 07:59:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 867D8A099E; Tue, 10 Jun 2025 09:59:22 +0200 (CEST)
Date: Tue, 10 Jun 2025 09:59:22 +0200
From: Jan Kara <jack@suse.cz>
To: Kees Cook <kees@kernel.org>
Cc: Pranav Tyagi <pranav.tyagi03@gmail.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] binfmt_elf: use check_mul_overflow() for size calc
Message-ID: <decv7f4drznbeoyjjm7ixlsgmu7ust4fltwwlnbltdjcvmhtbk@5qreij76z7jn>
References: <20250607082844.8779-1-pranav.tyagi03@gmail.com>
 <202506092053.827AD89DC5@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202506092053.827AD89DC5@keescook>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,kvack.org,linuxfoundation.org,lists.linux.dev];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E47981F45A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -2.51

On Mon 09-06-25 21:04:36, Kees Cook wrote:
> On Sat, Jun 07, 2025 at 01:58:44PM +0530, Pranav Tyagi wrote:
> > Use check_mul_overflow() to safely compute the total size of ELF program
> > headers instead of relying on direct multiplication.
> > 
> > Directly multiplying sizeof(struct elf_phdr) with e_phnum risks integer
> > overflow, especially on 32-bit systems or with malformed ELF binaries
> > crafted to trigger wrap-around. If an overflow occurs, kmalloc() could
> > allocate insufficient memory, potentially leading to out-of-bound
> > accesses, memory corruption or security vulnerabilities.
> > 
> > Using check_mul_overflow() ensures the multiplication is performed
> > safely and detects overflows before memory allocation. This change makes
> > the function more robust when handling untrusted or corrupted binaries.
> > 
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > Link: https://github.com/KSPP/linux/issues/92
> > ---
> >  fs/binfmt_elf.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index a43363d593e5..774e705798b8 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -518,7 +518,10 @@ static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
> >  
> >  	/* Sanity check the number of program headers... */
> >  	/* ...and their total size. */
> > -	size = sizeof(struct elf_phdr) * elf_ex->e_phnum;
> 
> size is unsigned int, which has a maximum value of 4,294,967,295.
> 
> elf_ex->e_phnum is a u16 (2 bytes) and will not be changing:
> 
> $ pahole -C elf64_hdr */fs/binfmt_elf.o
> struct elf64_hdr {
> 	...
>         Elf64_Half                 e_phnum;              /*    56     2 */
> 	...

Ah, what confused me was that I somehow thought Elf64_Half is u32 without
checking it's definition which clearly shows its actually u16. Thanks for
checking it! You're right that the patch is pointless then.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

