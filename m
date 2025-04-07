Return-Path: <linux-fsdevel+bounces-45877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B78A7E0AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F295B16944C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F31B1C54A6;
	Mon,  7 Apr 2025 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vpFKjQfc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M5TtnRZd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YGYvAcfi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sq8RZ5WG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6461C5D4D
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034779; cv=none; b=ciyCAz88UdS1mvTrTDtaQrYub8PFmDFW7hcbAWCDj3com7xAvO9B3PMqd2ipm2ae5k473y3qZRV20VkWVsX7ogTWr2xQxVIofDnxo5vA+WXgkZPqhhokDWGrdstE+eqK5M0AhQAIN7wwPyu0QQlDxpjphtpOQAadRc7YGaara9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034779; c=relaxed/simple;
	bh=+VWw9zxv2C+EX+TfnxGHR3oqvvrDaIm7Jxt4vb7EOJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ/IM8C38BRZkYJUoLW1gQcK55DJ+6pD0vV8jHGA9g+4+tWVMiTrx1gPyG30BiUs4GS2MfJPg4CUDYT4jc2yPI2Ay5JWYqVDywn9fILRY+uAlkLtYTrjQXRGgLlJJ55GMpdz+/m0X8Yln25lfMsnKHgAMnGUZZf2ybaujQToysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vpFKjQfc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M5TtnRZd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YGYvAcfi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sq8RZ5WG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C88021193;
	Mon,  7 Apr 2025 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2e0SR+nx+I3Bw4DVdLonknXDxENPoptCQwoVxvJRXw=;
	b=vpFKjQfc2p4siGwXQkGkIo1HYR68vZJWQGNSsqC4O9kD/wtLWju0sYFq1nrYuBmMD8UGbz
	sIIuh9eFkgyZVfJIwjLb1XUduXUaz34zsjX1hNLx5WdTXsP49Huuo0U7GxxqRlZvuqK8XC
	WxXVkVQxsEsRGp+kCJEfnJ/twRMASSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2e0SR+nx+I3Bw4DVdLonknXDxENPoptCQwoVxvJRXw=;
	b=M5TtnRZd5KWPlbpbiseFbkSWtREGfIhUuMLmGfBxw19m4oN4oq3OKUrN69ma2xn/ZGd4CS
	OxOD6kNIPjYWIfDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2e0SR+nx+I3Bw4DVdLonknXDxENPoptCQwoVxvJRXw=;
	b=YGYvAcfiv5ie2125Q8nihwH/aXJaHhB51Zlv1u7da3wA3epSS7Yj31IN7wBUKg8qv90Neh
	bcceMXVJbiRS5v5P2nl/QCA7tvNaB1MupD4Be5W+vQP8ofYaO7LYieMCzcJYJg52SUX2Z0
	4s8dScp+L55Bliujw19atMH5EVcy6K8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2e0SR+nx+I3Bw4DVdLonknXDxENPoptCQwoVxvJRXw=;
	b=sq8RZ5WGgV9t0v/V4BDTxcPQ0+IlkpddlNqEZ98sQYSuRTbZNcF2iJCh1bcwdlufVs35s9
	hfdSR3WiYRu9SDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E08713A4B;
	Mon,  7 Apr 2025 14:06:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8PA6C9Xb82eNIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Apr 2025 14:06:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ED9FBA08D2; Mon,  7 Apr 2025 16:06:12 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:06:12 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Subject: Re: [PATCH 4/9] pidfs: use anon_inode_setattr()
Message-ID: <lkyn5etyrbsjxgpvwjzu7enr45kctqhtvqo4p3nu6jwzb57ald@tvjdlbkjd4by>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-4-53a44c20d44e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-work-anon_inode-v1-4-53a44c20d44e@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[5d8e79d323a13aa0b248];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,gmail.com,zeniv.linux.org.uk,suse.cz,kernel.org,toxicpanda.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Mon 07-04-25 11:54:18, Christian Brauner wrote:
> So far pidfs did use it's own version. Just use the generic version.
> We use our own wrappers because we're going to be implementing
> properties soon.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

OK. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/pidfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 809c3393b6a3..10b4ee454cca 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -569,7 +569,7 @@ static struct vfsmount *pidfs_mnt __ro_after_init;
>  static int pidfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  			 struct iattr *attr)
>  {
> -	return -EOPNOTSUPP;
> +	return anon_inode_setattr(idmap, dentry, attr);
>  }
>  
>  static int pidfs_getattr(struct mnt_idmap *idmap, const struct path *path,
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

