Return-Path: <linux-fsdevel+bounces-67903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBF2C4D340
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 549F84FA230
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4198C350D5A;
	Tue, 11 Nov 2025 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="knwCUupI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w05KIqed";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="knwCUupI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w05KIqed"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57214350A09
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858092; cv=none; b=pk5zUbD4ebrkBtdhq1/ygSlA3iJV5NdtkfgtFPUwCCTqpniiINfEWZWNwP2oHOuVwx8C/dAdnWYE0KlrJ6r21F4zumO9wCbiN2iRd3+Px+LB13k+dT5oHZZDC4+Jn8Pr2KGXa3RjyOXrkUKRTjF75hAP2+N68UC/uAFN16aiVQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858092; c=relaxed/simple;
	bh=rgQ7F2thuGDbBuXypMUAa8Acq8VtWBZYD7mKAcNFois=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fn4MBCij1IIATqn1seljdDR6dnHxSp9b/gqISV01+wB8E3dNAE1Xtc5WbbZptUtqukzPmT9MQ/gDW7VlTA7wrBRsJsS2l1OUB4KNLoAM2mr4qDvKPIlJ7NEdxMt4ifTwrB1Np+YA9sTHK5xilaNVnipxzYnQ9U45BxKIiR78+L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=knwCUupI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w05KIqed; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=knwCUupI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w05KIqed; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7148C21E4B;
	Tue, 11 Nov 2025 10:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762858088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4iMLUEIFp+KFnCBMrOHfoCV2tmUed7YGGquhX1HYzE=;
	b=knwCUupIdDxL+kXwq5eH6u8/SWHWDOdg72AoaBHLq8FllViMvp9KCbtFMp0mglQr3V7dnj
	39R6eQGkz9soUG1Ivoqc0XBYGO31n0uCXyoeqekV/fyx4czgBP/skMFDTCLB+Og1aeOKCC
	81S6KO3lywIj6HUDo2mTbtDsFSRjVYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762858088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4iMLUEIFp+KFnCBMrOHfoCV2tmUed7YGGquhX1HYzE=;
	b=w05KIqedIeW2ibbg67OTG8PygRxA4MK6nk2TZ4uU5WZGCe1JGnO+kGkt8oTLDFDkEsxodC
	75OBHS0M3F0aqPDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762858088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4iMLUEIFp+KFnCBMrOHfoCV2tmUed7YGGquhX1HYzE=;
	b=knwCUupIdDxL+kXwq5eH6u8/SWHWDOdg72AoaBHLq8FllViMvp9KCbtFMp0mglQr3V7dnj
	39R6eQGkz9soUG1Ivoqc0XBYGO31n0uCXyoeqekV/fyx4czgBP/skMFDTCLB+Og1aeOKCC
	81S6KO3lywIj6HUDo2mTbtDsFSRjVYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762858088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4iMLUEIFp+KFnCBMrOHfoCV2tmUed7YGGquhX1HYzE=;
	b=w05KIqedIeW2ibbg67OTG8PygRxA4MK6nk2TZ4uU5WZGCe1JGnO+kGkt8oTLDFDkEsxodC
	75OBHS0M3F0aqPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60D71148FB;
	Tue, 11 Nov 2025 10:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xPGdF2gUE2nYPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Nov 2025 10:48:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1F726A28C8; Tue, 11 Nov 2025 11:48:08 +0100 (CET)
Date: Tue, 11 Nov 2025 11:48:08 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Howells <dhowells@redhat.com>, 
	Tyler Hicks <code@tyhicks.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 17/17] vfs: expose delegation support to userland
Message-ID: <tcpo34clqby633deon2qnccih24xor2mz6jm4fzh2zj7o24sjc@s5c25qgpgmv2>
References: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
 <20251105-dir-deleg-ro-v5-17-7ebc168a88ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-dir-deleg-ro-v5-17-7ebc168a88ac@kernel.org>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RL63fqwwx8ot6gmekemcs76f9d)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,manguebit.org,microsoft.com,talpey.com,linuxfoundation.org,redhat.com,tyhicks.com,brown.name,chromium.org,google.com,davemloft.net,vger.kernel.org,lists.samba.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Wed 05-11-25 11:54:03, Jeff Layton wrote:
> Now that support for recallable directory delegations is available,
> expose this functionality to userland with new F_SETDELEG and F_GETDELEG
> commands for fcntl().
> 
> Note that this also allows userland to request a FL_DELEG type lease on
> files too. Userland applications that do will get signalled when there
> are metadata changes in addition to just data changes (which is a
> limitation of FL_LEASE leases).
> 
> These commands accept a new "struct delegation" argument that contains a
> flags field for future expansion.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

For new apis CCing linux-api is a good practice ;)

...

> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 3741ea1b73d8500061567b6590ccf5fb4c6770f0..8123fe70e03cfb1ba9ce1b5e20d61b62e462a7ea 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -79,6 +79,16 @@
>   */
>  #define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
>  
> +/* Set/Get delegations */
> +#define F_GETDELEG		(F_LINUX_SPECIFIC_BASE + 15)
> +#define F_SETDELEG		(F_LINUX_SPECIFIC_BASE + 16)
> +
> +/* Argument structure for F_GETDELEG and F_SETDELEG */
> +struct delegation {
> +	unsigned int	d_flags;	/* Must be 0 */
> +	short		d_type;		/* F_RDLCK, F_WRLCK, F_UNLCK */
> +};
> +

I think it would make sense for d_type to be unsigned since it's more or
less enum. Also struct delegation is going to have a hole in it at the end
which is always a concern with uAPI structures (passing around
uninitialized stuff). I think it would be good to put an explicit padding
there and enforce it is zeroed out.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

