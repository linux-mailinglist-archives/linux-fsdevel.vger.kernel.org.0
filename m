Return-Path: <linux-fsdevel+bounces-31427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97A99965AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 11:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F201C23C7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 09:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB94D18BC26;
	Wed,  9 Oct 2024 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iYwmvcrX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pTBLoKKU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iYwmvcrX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pTBLoKKU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE8218BBAE;
	Wed,  9 Oct 2024 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466839; cv=none; b=OAvSVmW4J6nTpWif4dle0iPdH/X/olLfuWe/iM3tvjXTSP2tECh4CrKK1LZHn7eYORvbw1rBqz0faLs0jfOWc6y5IcqZjJ+IrINGXaI5/03K1lpOcIws8L/2JeTc1bP5hJOr3Nq2FDTZcvOblOcTtRVL7meLwfGjYxSPuQKzOi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466839; c=relaxed/simple;
	bh=uR8VAP6tl/ILDhGZcdKBR+RZip67KNyv534M0e/6Log=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpAbA0kjBguOdiB1guJ2PkchiQ0mqHx6Lh9DY7RoWSc4dmRCyyfPuujw2j+vqCssAkl1i1pQrfhkXPNjb08x0Y4LkxIP7GpQWrDQvCZvwFRbbogCtXFm+khcoyw8iOcdYBU+OPXeby1FUAJ4Ecr7+VnnwggkG+kfg20GK4PgWyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iYwmvcrX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pTBLoKKU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iYwmvcrX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pTBLoKKU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 281D621E7F;
	Wed,  9 Oct 2024 09:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728466835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MC+XGwFr4dz5nS5NDRH+sEXp/J7wjtSsBD/7FC5N+zI=;
	b=iYwmvcrXQtTTmKs/PSHnm5h6uzwWSeYnSjM0QQSBzCCswh+3FEq0j2+6gXlo+5NEzELFle
	PVnNv3YTYYe1vVXzSbY070j+qzX49j7n/ZtGPinerfFo0j7ILO9Y3Po39iYWammEPAYFQu
	nEyvBbxn7TtySxCA5+Zw5xBgI9tiX10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728466835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MC+XGwFr4dz5nS5NDRH+sEXp/J7wjtSsBD/7FC5N+zI=;
	b=pTBLoKKUBJw/QYPdigI4MHxk5Qjy3QGfqVtyCE9R+R8AgsUB2bAsywttlyDq8d38rFXvM/
	KKE9mDs33kInLqCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iYwmvcrX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pTBLoKKU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728466835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MC+XGwFr4dz5nS5NDRH+sEXp/J7wjtSsBD/7FC5N+zI=;
	b=iYwmvcrXQtTTmKs/PSHnm5h6uzwWSeYnSjM0QQSBzCCswh+3FEq0j2+6gXlo+5NEzELFle
	PVnNv3YTYYe1vVXzSbY070j+qzX49j7n/ZtGPinerfFo0j7ILO9Y3Po39iYWammEPAYFQu
	nEyvBbxn7TtySxCA5+Zw5xBgI9tiX10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728466835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MC+XGwFr4dz5nS5NDRH+sEXp/J7wjtSsBD/7FC5N+zI=;
	b=pTBLoKKUBJw/QYPdigI4MHxk5Qjy3QGfqVtyCE9R+R8AgsUB2bAsywttlyDq8d38rFXvM/
	KKE9mDs33kInLqCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17FE313A58;
	Wed,  9 Oct 2024 09:40:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4ziVBZNPBmcmZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Oct 2024 09:40:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AE2BCA0851; Wed,  9 Oct 2024 11:40:34 +0200 (CEST)
Date: Wed, 9 Oct 2024 11:40:34 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 0/2] API for exporting connectable file handles to
 userspace
Message-ID: <20241009094034.xgcw2inu2tun4qrq@quack3>
References: <20240923082829.1910210-1-amir73il@gmail.com>
 <20240925-seeufer-atheismus-6f7e6ab4965f@brauner>
 <CAOQ4uxiBwtEs_weg67MHP4TOsXN7hVi0bDCUe_C7b2tHqohtAQ@mail.gmail.com>
 <021d3f9acf33ff74bfde7aadd6a9a01a8ee64248.camel@kernel.org>
 <CAOQ4uxht3A7Rx5eu=DX=Zn2PNyQnj5BkCLMi36Gftt0ej8KhdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxht3A7Rx5eu=DX=Zn2PNyQnj5BkCLMi36Gftt0ej8KhdA@mail.gmail.com>
X-Rspamd-Queue-Id: 281D621E7F
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 08-10-24 15:11:39, Amir Goldstein wrote:
> On Tue, Oct 8, 2024 at 1:07 PM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Mon, 2024-10-07 at 17:26 +0200, Amir Goldstein wrote:
> > > On Wed, Sep 25, 2024 at 11:14 AM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > > open_by_handle_at(2) does not have AT_ flags argument, but also, I find
> > > > > it more useful API that encoding a connectable file handle can mandate
> > > > > the resolving of a connected fd, without having to opt-in for a
> > > > > connected fd independently.
> > > >
> > > > This seems the best option to me too if this api is to be added.
> > >
> > > Thanks.
> > >
> > > Jeff, Chuck,
> > >
> > > Any thoughts on this?
> > >
> >
> > Sorry for the delay. I think encoding the new flag into the fh itself
> > is a reasonable approach.
> >
> 
> Adding Jan.
> Sorry I forgot to CC you on the patches, but struct file_handle is officially
> a part of fanotify ABI, so your ACK is also needed on this change.

Thanks. I've actually seen this series on list, went "eww bitfields, let's
sleep to this" and never got back to it.

> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 96b62e502f71..3e60bac74fa3 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -159,8 +159,17 @@ struct fid {
>  #define EXPORT_FH_CONNECTABLE  0x1 /* Encode file handle with parent */
>  #define EXPORT_FH_FID          0x2 /* File handle may be non-decodeable */
>  #define EXPORT_FH_DIR_ONLY     0x4 /* Only decode file handle for a
> directory */
> -/* Flags allowed in encoded handle_flags that is exported to user */
> -#define EXPORT_FH_USER_FLAGS   (EXPORT_FH_CONNECTABLE | EXPORT_FH_DIR_ONLY)
> +
> +/* Flags supported in encoded handle_type that is exported to user */
> +#define FILEID_USER_FLAGS_MASK 0xffff0000
> +#define FILEID_USER_FLAGS(type) ((type) & FILEID_USER_FLAGS_MASK)
> +
> +#define FILEID_IS_CONNECTABLE  0x10000
> +#define FILEID_IS_DIR          0x40000
> +#define FILEID_VALID_USER_FLAGS        (FILEID_IS_CONNECTABLE | FILEID_IS_DIR)

FWIW I prefer this variant much over bitfields as their binary format
depends on the compiler which leads to unpleasant surprises sooner rather
than later.

> +#define FILEID_USER_TYPE_IS_VALID(type) \
> +       (FILEID_USER_FLAGS(type) & ~FILEID_VALID_USER_FLAGS)

The macro name is confusing because it speaks about type but actually
checks flags. Frankly, I'd just fold this in the single call site to make
things obvious.

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index cca7e575d1f8..6329fec40872 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1071,8 +1071,7 @@ struct file {
> 
>  struct file_handle {
>         __u32 handle_bytes;
> -       int handle_type:16;
> -       int handle_flags:16;
> +       int handle_type;

Maybe you want to make handle_type unsigned when you treat it (partially)
as flags? Otherwise some constructs can lead to surprises with sign
extension etc...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

