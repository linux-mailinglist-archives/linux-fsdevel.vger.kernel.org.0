Return-Path: <linux-fsdevel+bounces-53504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEBBAEF9BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4173B99DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFFF274659;
	Tue,  1 Jul 2025 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EdGMfebH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3x0vMWhi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="geOJrmOA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s+W8pYUV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CB8274657
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375194; cv=none; b=LcegiRaIc84qVIhKjIC5YhKZEvBAPI4B2ZD+lUDeLYYW8EmgFUdnBE0Ild9vwG+4F2X3xxnisQk0s+h0fXcGT5oybPloFqkZBPOsvC0DIeFa39l+HbsB0+RwxA+XpYBetLMOcDFPmaZesHoKMIL81wQl3AZZ5ZLnUb98X416Avc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375194; c=relaxed/simple;
	bh=W7rUKWuRShXYZWdR3lbH69HaoFiUBNiFvvaqP4xwyDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImpUppFQCnQg8CohEucM5ISiYo17lQDGx1hA4HV7TlF8AH0xR8SaTHWXuc1X3xnoYFAbbcETyVh1ZKc7AQeGLrpPe+mBxH4FASCURfY8D7LB0/wyiVBcUN9FHktNAcRrxvBYWUz9JxY6HA8ClqfkxfSpTiW9JFvllO2l1Euv4d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EdGMfebH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3x0vMWhi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=geOJrmOA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s+W8pYUV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEBD921170;
	Tue,  1 Jul 2025 13:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751375191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STYBJ6/y5eb9NB4ntQPCGfmPLPuwaWN8f9mtVL8NvMg=;
	b=EdGMfebH3HfaMC+wTG450iQ0AqNqkQK2x3LTfqHIyaxGakrWaElBk4jiFb97QC9greGvMb
	1Q2xk36efRgz/+u2VPFudK5v7WktCIB9TXWbVU365dA5CFyyKqqsG+TyhF/PK4noIgvbFU
	gIIzt/wLiRG3tHbJ1PPlyZ5aIaaVLxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751375191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STYBJ6/y5eb9NB4ntQPCGfmPLPuwaWN8f9mtVL8NvMg=;
	b=3x0vMWhikqcewo3C3hWxU5aK+XA0gmHYzYUMtbcyo3XMMzkUPN7HqeYjuDVGotgUH/7nT9
	WYjfVnf+l+7+BJCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=geOJrmOA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=s+W8pYUV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751375190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STYBJ6/y5eb9NB4ntQPCGfmPLPuwaWN8f9mtVL8NvMg=;
	b=geOJrmOArR76ltL85cdfmNDlnZRQboQgEh3JdADE3BE/XoMASiodgc85nEO2poaahBsTbR
	6TsOO8XPpj6vjLQHTWNcFVeCs7b5FZ0tkAqM1GvV9KdlGUymKy0OSwq8t3ZtuhJb81ixdw
	zZiMmjTn702bFgTQhDHKwvYearwVEeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751375190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STYBJ6/y5eb9NB4ntQPCGfmPLPuwaWN8f9mtVL8NvMg=;
	b=s+W8pYUVnV1//Tnb9TCUTjf1HZWDSft6YUh3W+enyBIkfmUOKmDP+dAP18U6L/rk9PkBuq
	wyFZaxtYgN+DunCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE9E613890;
	Tue,  1 Jul 2025 13:06:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 66CeKlbdY2j4dAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Jul 2025 13:06:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C3A14A0A23; Tue,  1 Jul 2025 15:06:25 +0200 (CEST)
Date: Tue, 1 Jul 2025 15:06:25 +0200
From: Jan Kara <jack@suse.cz>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 5/6] fs: prepare for extending file_get/setattr()
Message-ID: <kxl5mwdql2f7i6mlvgitmquhci6oab5dluihc22x5w7y3cko4h@fig54f3dyidj>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-5-c4e3bc35227b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250630-xattrat-syscall-v6-5-c4e3bc35227b@kernel.org>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BEBD921170
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,arndb.de,schaufler-ca.com,kernel.org,suse.cz,paul-moore.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 30-06-25 18:20:15, Andrey Albershteyn wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> We intend to add support for more xflags to selective filesystems and
> We cannot rely on copy_struct_from_user() to detect this extension.
> 
> In preparation of extending the API, do not allow setting xflags unknown
> by this kernel version.
> 
> Also do not pass the read-only flags and read-only field fsx_nextents to
> filesystem.
> 
> These changes should not affect existing chattr programs that use the
> ioctl to get fsxattr before setting the new values.
> 
> Link: https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@kernel.org/
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Andrey Albershteyn <aalbersh@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I'd just note that:

> @@ -118,11 +119,16 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
>  				  struct fsxattr __user *ufa)
>  {
>  	struct fsxattr xfa;
> +	__u32 mask = FS_XFLAGS_MASK;
>  
>  	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
>  		return -EFAULT;
>  
> +	if (xfa.fsx_xflags & ~mask)
> +		return -EINVAL;
> +
>  	fileattr_fill_xflags(fa, xfa.fsx_xflags);
> +	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;

This means that the two flags in FS_XFLAG_RDONLY_MASK cannot easily become
writeable in the future due to this. I think it is a sensible compromise
but I wanted to mention it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

