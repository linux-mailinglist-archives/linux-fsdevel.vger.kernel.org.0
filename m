Return-Path: <linux-fsdevel+bounces-44456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C38A69470
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 17:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3A817B1BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11841E0DE6;
	Wed, 19 Mar 2025 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IdDeYMF5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rEFOIyg0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IdDeYMF5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rEFOIyg0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BFA1DF75D
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400693; cv=none; b=gzEdp29lEh2qB5wydkQWc1xE6Cj3dQLjMpTi9Dm6Oh+H7jrk2MuTft7CZtuJ5JJMg5sLIg+epx98lnSzvibapwW6SDGXm3P7rymrRALPrdrS67M9SPlL5Zjacm8156R0SSWhUE0Ejgc4EjghrPQmVTXtREktspJECCDgeN7FWC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400693; c=relaxed/simple;
	bh=HxXeFi5acaSNx0MfdZcTxvpnNDvZCQvX1nx0iU7NeGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puhYnfum2hFezkeE5MpyBU2mxrl+n5yFYEdQBEKssCtQncaLMW+P2B5RhGNE0ohs5rzVLd5MrgidC5rkhg2EopNKtG3WeQfSK6hy1e2TbPI31OQX79C3uySXXZYt1Q2DRjEzvGcUtakz/BWzo0gHBY0755l13Lka1ISrtF7F3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IdDeYMF5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rEFOIyg0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IdDeYMF5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rEFOIyg0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 844CF21FB8;
	Wed, 19 Mar 2025 16:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742400689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t38FJ9pOxUaqmS3N5jNBSr31fg0PwAlFwVydojs5Pac=;
	b=IdDeYMF5HI9QqCoW1o4WBl8Hj8iepK5KkiKF9ouZ5vmcXD2SkFybBF0Zvl3P1tQKQSty19
	o0AzuKbafyzjwqRYhNyt/Go+FE36lC+leWzgGr70ILSh9y8Cv0HI0HLvV1lDI74/77lrdT
	pni1QuT+22owY3LjcKNbxOuSPyNpIcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742400689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t38FJ9pOxUaqmS3N5jNBSr31fg0PwAlFwVydojs5Pac=;
	b=rEFOIyg0bEUjg+Pj4/2F4e8DSn/TuhUuEEmPxnnLCErG2ngYJ4CGXkob3Vjb3yhJeAujsn
	DlMx2m+fBziHXQAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742400689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t38FJ9pOxUaqmS3N5jNBSr31fg0PwAlFwVydojs5Pac=;
	b=IdDeYMF5HI9QqCoW1o4WBl8Hj8iepK5KkiKF9ouZ5vmcXD2SkFybBF0Zvl3P1tQKQSty19
	o0AzuKbafyzjwqRYhNyt/Go+FE36lC+leWzgGr70ILSh9y8Cv0HI0HLvV1lDI74/77lrdT
	pni1QuT+22owY3LjcKNbxOuSPyNpIcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742400689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t38FJ9pOxUaqmS3N5jNBSr31fg0PwAlFwVydojs5Pac=;
	b=rEFOIyg0bEUjg+Pj4/2F4e8DSn/TuhUuEEmPxnnLCErG2ngYJ4CGXkob3Vjb3yhJeAujsn
	DlMx2m+fBziHXQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73A5A13726;
	Wed, 19 Mar 2025 16:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3N4yHLHs2meMVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 19 Mar 2025 16:11:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 14B18A08D2; Wed, 19 Mar 2025 17:11:25 +0100 (CET)
Date: Wed, 19 Mar 2025 17:11:25 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: load the ->i_sb pointer once in
 inode_sb_list_{add,del}
Message-ID: <nb5g34ehva6wmjusa3tin3wbsr26gm6shvuxfspzkwpor6edxk@ncx2um24ipwq>
References: <20250319004635.1820589-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319004635.1820589-1-mjguzik@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 19-03-25 01:46:35, Mateusz Guzik wrote:
> While this may sound like a pedantic clean up, it does in fact impact
> code generation -- the patched add routine is slightly smaller.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

I'm surprised it matters for the compiler but as Christian wrote, why not.
Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Below is disasm before/after. I did not want to pull this into the
> commit message because of the total length vs long term usefulness ratio.
> 
> can be moved up into the commit message no problem if someone insists on
> it:
> 
> (gdb) disassemble inode_sb_list_add
> before:
>  <+0>:     endbr64
>  <+4>:     call   0xffffffff8130e9b0 <__fentry__>
>  <+9>:     push   %rbx
>  <+10>:    mov    0x28(%rdi),%rax
>  <+14>:    mov    %rdi,%rbx
>  <+17>:    lea    0x540(%rax),%rdi
>  <+24>:    call   0xffffffff8225cf20 <_raw_spin_lock>
>  <+29>:    mov    0x28(%rbx),%rax
>  <+33>:    lea    0x110(%rbx),%rdx
>  <+40>:    mov    0x548(%rax),%rcx
>  <+47>:    mov    %rdx,0x8(%rcx)
>  <+51>:    mov    %rcx,0x110(%rbx)
>  <+58>:    lea    0x548(%rax),%rcx
>  <+65>:    mov    %rcx,0x118(%rbx)
>  <+72>:    mov    %rdx,0x548(%rax)
>  <+79>:    mov    0x28(%rbx),%rdi
>  <+83>:    pop    %rbx
>  <+84>:    add    $0x540,%rdi
>  <+91>:    jmp    0xffffffff8225d020 <_raw_spin_unlock>
> 
> after:
>  <+0>:     endbr64
>  <+4>:     call   0xffffffff8130e9b0 <__fentry__>
>  <+9>:     push   %r12
>  <+11>:    push   %rbp
>  <+12>:    push   %rbx
>  <+13>:    mov    0x28(%rdi),%rbp
>  <+17>:    mov    %rdi,%rbx
>  <+20>:    lea    0x540(%rbp),%r12
>  <+27>:    mov    %r12,%rdi
>  <+30>:    call   0xffffffff8225cf20 <_raw_spin_lock>
>  <+35>:    mov    0x548(%rbp),%rdx
>  <+42>:    lea    0x110(%rbx),%rax
>  <+49>:    mov    %r12,%rdi
>  <+52>:    mov    %rax,0x8(%rdx)
>  <+56>:    mov    %rdx,0x110(%rbx)
>  <+63>:    lea    0x548(%rbp),%rdx
>  <+70>:    mov    %rdx,0x118(%rbx)
>  <+77>:    mov    %rax,0x548(%rbp)
>  <+84>:    pop    %rbx
>  <+85>:    pop    %rbp
>  <+86>:    pop    %r12
>  <+88>:    jmp    0xffffffff8225d020 <_raw_spin_unlock>
> 
>  fs/inode.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 10121fc7b87e..e188bb1eb07a 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -623,18 +623,22 @@ static void inode_wait_for_lru_isolating(struct inode *inode)
>   */
>  void inode_sb_list_add(struct inode *inode)
>  {
> -	spin_lock(&inode->i_sb->s_inode_list_lock);
> -	list_add(&inode->i_sb_list, &inode->i_sb->s_inodes);
> -	spin_unlock(&inode->i_sb->s_inode_list_lock);
> +	struct super_block *sb = inode->i_sb;
> +
> +	spin_lock(&sb->s_inode_list_lock);
> +	list_add(&inode->i_sb_list, &sb->s_inodes);
> +	spin_unlock(&sb->s_inode_list_lock);
>  }
>  EXPORT_SYMBOL_GPL(inode_sb_list_add);
>  
>  static inline void inode_sb_list_del(struct inode *inode)
>  {
> +	struct super_block *sb = inode->i_sb;
> +
>  	if (!list_empty(&inode->i_sb_list)) {
> -		spin_lock(&inode->i_sb->s_inode_list_lock);
> +		spin_lock(&sb->s_inode_list_lock);
>  		list_del_init(&inode->i_sb_list);
> -		spin_unlock(&inode->i_sb->s_inode_list_lock);
> +		spin_unlock(&sb->s_inode_list_lock);
>  	}
>  }
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

