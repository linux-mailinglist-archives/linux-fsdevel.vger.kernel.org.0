Return-Path: <linux-fsdevel+bounces-62576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE52B99BD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 14:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D01F7A2C01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 12:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AD42FB63E;
	Wed, 24 Sep 2025 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MKBRckGQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="teG3MG0U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H7hLy4jm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+6DxGoqi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B552D5940
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715441; cv=none; b=p6uV4LPe/dsVPfK2WrJPNmhiJ6eAuB9I8Mjp18m6tSWp76s46YJQA0MTdKcYo46ytK6RI212t6gVma3akH26O0coT1jaQa6y0MptkUlh4gBKfwwKJSKjCkV2FzqfLqrN52YxU2JcnczVclLKsteBf0Q3hJpQFAj7LeomIzPFsKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715441; c=relaxed/simple;
	bh=2NLiZFXlWo0Y86Y2F9wleIpz3DknLOHsE/giu+9xawE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YekToA+hTuKpOg/hH7cE7hkXgt+KecbJEx5aV5kkXpvUBfKPwz8sAEYJnPd1y7kHQyX5ElH6juO6LJqeiB8opFSPB++3zC3krjeJpVpwwyqw1IVAPXBCzweoTORh/gOQZLvdGP0sOr74iE5DU+wCLp66Ypscd//dEn/Wf7CeleI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MKBRckGQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=teG3MG0U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H7hLy4jm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+6DxGoqi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E5148341CF;
	Wed, 24 Sep 2025 12:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758715438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oxI3eN4jDvJdpefp+N4v9VQwkmlDp5choMPQxDHEShI=;
	b=MKBRckGQ6Wp5G9i7SNwaDCY4a3q1xaReKdLWEQr4EUzbuCoFQCF95ZAIKf4+mMCMkv4O88
	ceQ1H6FXPVlORE/SQDsIfYsEifV4YhnRQOZkbZ/lkPsKqG5LdzCNyKlcHJ3Yshabu2ugTu
	1ZGBC+edTqvUFB33ai9dnFIw+241kkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758715438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oxI3eN4jDvJdpefp+N4v9VQwkmlDp5choMPQxDHEShI=;
	b=teG3MG0UNyp+gwAfQ+nCoiN7hW5bt4OkTUXNEMWh3pwouPCeIOOwT1klBpm/5orPHFpWzC
	kR4VnK9iYTYPRfCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H7hLy4jm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+6DxGoqi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758715436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oxI3eN4jDvJdpefp+N4v9VQwkmlDp5choMPQxDHEShI=;
	b=H7hLy4jmv7TijR8S3os29qiVD82igoSgFCqH8v7RQkacBZpShqyyGElAuk2fBUN2MwQ/NU
	jc6luebVZVlj8xbo1Y8690Y80seh1ERggGA/SepVCoo4T8bBdTy9lZwDTN8z2I1p667YqJ
	eIOobeWX4Q7g4da81ziMW8+OSj2vsKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758715436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oxI3eN4jDvJdpefp+N4v9VQwkmlDp5choMPQxDHEShI=;
	b=+6DxGoqi6Xcixmylt4Ifq92bDeG1W7PZI0HoT5F7xdAWMvwzd4t85YFdXDGWPaypX5UkoG
	xpX0ZVwOP32yf/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB68813647;
	Wed, 24 Sep 2025 12:03:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /sSKNSze02hASgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Sep 2025 12:03:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 97336A0A9A; Wed, 24 Sep 2025 14:03:56 +0200 (CEST)
Date: Wed, 24 Sep 2025 14:03:56 +0200
From: Jan Kara <jack@suse.cz>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH Next] copy_mnt_ns(): Remove unnecessary unlock
Message-ID: <mb2bpbjtvci4tywtg5brdjkfl3ylopde3j2ymppvmlapzwnwij@wykkbxztyw2f>
References: <68d3a9d3.a70a0220.4f78.0017.GAE@google.com>
 <tencent_2396E4374C4AA47497768767963CAD360E09@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2396E4374C4AA47497768767963CAD360E09@qq.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[qq.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[0d671007a95cd2835e05];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,appspotmail.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: E5148341CF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Wed 24-09-25 18:29:04, Edward Adam Davis wrote:
> This code segment is already protected by guards, namespace_unlock()
> should not appear here.
> 
> Reported-by: syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0d671007a95cd2835e05
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Indeed. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ac1aedafe05e..c22febeda1ac 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4134,7 +4134,6 @@ struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
>  	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
>  	if (IS_ERR(new)) {
>  		emptied_ns = new_ns;
> -		namespace_unlock();
>  		return ERR_CAST(new);
>  	}
>  	if (user_ns != ns->user_ns) {
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

