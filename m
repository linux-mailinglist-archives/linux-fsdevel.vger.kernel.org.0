Return-Path: <linux-fsdevel+bounces-78736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FUwHdm4oWkYwAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:31:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E667C1B9D14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02F43309F091
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3293603DD;
	Fri, 27 Feb 2026 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dr07HTs4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0vIiX17I";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dr07HTs4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0vIiX17I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017533F074C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205971; cv=none; b=ZZYW8O4Nkya5z+0splOyxAWvDmMC6ZYCyVk5/W18rJuSgc2diNtkdEm2CZNviaUhvvFpUPCpIkBn+N8n3onEBiSOt3FiAjHOPZO3+X0OHxDdemilIBtNUmbMR7pfIp9e3y8JMGBE5BUgV7G0w0pIIuKUPb/NZJP/vp/LvLyoeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205971; c=relaxed/simple;
	bh=DYYts9fWhHCY5zabQ1vce14IqqniK1fk4fguYyST7lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5RlkIVSArPnH2cH1uRPL3vefbsRuM2YHQvnJySBfFAR6A77ZBmJ+LgYKjQyHz7Pphwj6+zI984jAJqdLH6eQb+g5SlPjQjhIixfhsYsG1Vi3qvfkfsOq4cqxWBMyai8es/K8pU6SYKFuTXKfFHyWHlobcTp7uIPtU7ZmGloheY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dr07HTs4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0vIiX17I; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dr07HTs4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0vIiX17I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41E9A5C1A7;
	Fri, 27 Feb 2026 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772205968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qc5kTPIg0SUn5GOy2ONe2+Zsp5R+gcLDDp/mn1CBSQk=;
	b=dr07HTs49SWh49lnsTVU/D1W1XQ+NDgzMo4yRr73NScjW1jcD9+lT2CGdh9n4STFj1Twfk
	eEYeomyzXckJL5DnCF4EXmemOXro+O+K/ESSH/4FciOGhl7OY4U75AOJePTdiyTFb+wEFv
	VMsHS5eS5NGXxv1shnbGbcLBNwhL3bU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772205968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qc5kTPIg0SUn5GOy2ONe2+Zsp5R+gcLDDp/mn1CBSQk=;
	b=0vIiX17Iyqw56xfSOzDLF2z6K+4GopLa4Hz9GmNCHeQS8CqXOSbnJtcepw2CkTQ6hVGJO4
	kDUc9gOhmozmWhDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772205968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qc5kTPIg0SUn5GOy2ONe2+Zsp5R+gcLDDp/mn1CBSQk=;
	b=dr07HTs49SWh49lnsTVU/D1W1XQ+NDgzMo4yRr73NScjW1jcD9+lT2CGdh9n4STFj1Twfk
	eEYeomyzXckJL5DnCF4EXmemOXro+O+K/ESSH/4FciOGhl7OY4U75AOJePTdiyTFb+wEFv
	VMsHS5eS5NGXxv1shnbGbcLBNwhL3bU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772205968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qc5kTPIg0SUn5GOy2ONe2+Zsp5R+gcLDDp/mn1CBSQk=;
	b=0vIiX17Iyqw56xfSOzDLF2z6K+4GopLa4Hz9GmNCHeQS8CqXOSbnJtcepw2CkTQ6hVGJO4
	kDUc9gOhmozmWhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 393A33EA69;
	Fri, 27 Feb 2026 15:26:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J6D2DZC3oWmrJgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 15:26:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 05E25A06D4; Fri, 27 Feb 2026 16:26:08 +0100 (CET)
Date: Fri, 27 Feb 2026 16:26:07 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 11/14] xattr: support extended attributes on sockets
Message-ID: <hy7vat2udvtkkgggofdj2z7hdwlky4ehpyuhpzdzrwdz43snyp@km35qarriknf>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-11-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-11-c2efa4f74cb7@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78736-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E667C1B9D14
X-Rspamd-Action: no action

On Mon 16-02-26 14:32:07, Christian Brauner wrote:
> Allow user.* extended attributes on sockets by adding S_IFSOCK to the
> xattr_permission() switch statement. Previously user.* xattrs were only
> permitted on regular files and directories. Symlinks and special files
> including sockets were rejected with -EPERM.
> 
> Path-based AF_UNIX sockets have their inodes on the underlying
> filesystem (e.g. tmpfs) which already supports user.* xattrs through
> simple_xattrs. So for these the permission check was the only thing
> missing.
> 
> For sockets in sockfs - everything created via socket() including
> abstract namespace AF_UNIX sockets - the preceding patch added
> simple_xattr storage with per-inode limits. With the permission check
> lifted here these sockets can now store user.* xattrs as well.
> 
> This enables services to associate metadata with their sockets. For
> example, a service using Varlink for IPC can label its socket with
> user.varlink=1 allowing eBPF programs to selectively capture traffic
> and tools to discover IPC entrypoints by enumerating bound sockets via
> netlink. Similarly, protocol negotiation can be performed through xattrs
> such as indicating RFC 5424 structured syslog support on /dev/log.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

OK. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/xattr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 5e559b1c651f..09ecbaaa1660 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -163,6 +163,8 @@ xattr_permission(struct mnt_idmap *idmap, struct inode *inode,
>  			if (inode_owner_or_capable(idmap, inode))
>  				break;
>  			return -EPERM;
> +		case S_IFSOCK:
> +			break;
>  		default:
>  			return xattr_permission_error(mask);
>  		}
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

