Return-Path: <linux-fsdevel+bounces-20330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C28D1834
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 12:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4271C22B9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 10:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA2216ABC0;
	Tue, 28 May 2024 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QPvj0P87";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TKTC01+L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QPvj0P87";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TKTC01+L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC617E8F4;
	Tue, 28 May 2024 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891123; cv=none; b=WYByCfCiH1kvsTiYAbd4hL0btgSnpX45Jb9PVj/+CCskzrmS1sy3ZKCkCHN706fJoyFVES5kr53MBItuDsSU1+RRpCAlCJn2q+ntQm22gYI3FZz98bYcolT3RAGhL8nQXXffZY4LHF1SufEEB8tBS2JOu1qpUxFvcmix0g07SxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891123; c=relaxed/simple;
	bh=6ww0aWOR9HDUfIV67S+8vHtHtSWfUePyxXgSYSgpox8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qa9ohIL+TsdXpRkXIeKq8HB6K6n3RMPrAeftWglcIF+CsXeCMEhfmj/bviq6C0ImWgFi3aMmqP3WVG8c1afhJepo0F4IRIAuqjk7lBCf82ctPrbrfrodlqXcZnlRCjXRaXR3ZNO5G+nlj90ct545k5RREyjkYJjwt0bm5eH4TNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QPvj0P87; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TKTC01+L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QPvj0P87; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TKTC01+L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65F8222749;
	Tue, 28 May 2024 10:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716891117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExYjX0uos6DCU6GHCyPg9wwFspVknw4CNT/cnsm3P7A=;
	b=QPvj0P87mJKpCsarWj7GQrCEnpob5RUz/1yS00zF70fdA31q8vQJ2Bq1VC7PoMWnAMHvDQ
	55Igr36s4pWfYVXubCEO4dMM6xVrR8U9ZRn1jdUe+fmI01pzM98O303rNjVSlzm2GHpCly
	5M0J2K+ObPIRsX6lChXMRqtNP82jrHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716891117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExYjX0uos6DCU6GHCyPg9wwFspVknw4CNT/cnsm3P7A=;
	b=TKTC01+LLoOSgAj7Bx3pa6bsQY5wO1AaewNQ2UA2FPcZpvX5+9mHvKjmyFOasscmHgxFp5
	ssuPNfrLaoAJssCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716891117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExYjX0uos6DCU6GHCyPg9wwFspVknw4CNT/cnsm3P7A=;
	b=QPvj0P87mJKpCsarWj7GQrCEnpob5RUz/1yS00zF70fdA31q8vQJ2Bq1VC7PoMWnAMHvDQ
	55Igr36s4pWfYVXubCEO4dMM6xVrR8U9ZRn1jdUe+fmI01pzM98O303rNjVSlzm2GHpCly
	5M0J2K+ObPIRsX6lChXMRqtNP82jrHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716891117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExYjX0uos6DCU6GHCyPg9wwFspVknw4CNT/cnsm3P7A=;
	b=TKTC01+LLoOSgAj7Bx3pa6bsQY5wO1AaewNQ2UA2FPcZpvX5+9mHvKjmyFOasscmHgxFp5
	ssuPNfrLaoAJssCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5482913A5D;
	Tue, 28 May 2024 10:11:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a4lYFO2tVWbRZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 28 May 2024 10:11:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EDCB1A07D0; Tue, 28 May 2024 12:11:52 +0200 (CEST)
Date: Tue, 28 May 2024 12:11:52 +0200
From: Jan Kara <jack@suse.cz>
To: "hch@infradead.org" <hch@infradead.org>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
	"jack@suse.cz" <jack@suse.cz>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alex.aring@gmail.com" <alex.aring@gmail.com>,
	"cyphar@cyphar.com" <cyphar@cyphar.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240528101152.kyvtx623djnxwonm@quack3>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <30137c868039a3ae17f4ae74d07383099bfa4db8.camel@hammerspace.com>
 <ZlRzNquWNalhYtux@infradead.org>
 <86065f6a4f3d2f3d78f39e7a276a2d6e25bfbc9d.camel@hammerspace.com>
 <ZlS0_DWzGk24GYZA@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlS0_DWzGk24GYZA@infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[hammerspace.com,suse.cz,oracle.com,vger.kernel.org,kernel.org,gmail.com,cyphar.com,zeniv.linux.org.uk];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,infradead.org:email,suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Mon 27-05-24 09:29:48, hch@infradead.org wrote:
> On Mon, May 27, 2024 at 03:38:40PM +0000, Trond Myklebust wrote:
> > If your use case isn't NFS servers, then what use case are you
> > targeting, and how do you expect those applications to use this API?
> 
> The main user of the open by handle syscalls seems to be fanotify
> magic.

So some fanotify users may use open_by_handle_at() and name_to_handle_at()
but we specifically designed fanotify to not depend on this mount id
feature of the API (because it wasn't really usable couple of years ago
when we were designing this with Amir). fanotify returns fsid + fhandle in
its events and userspace is expected to build a mapping of fsid ->
"whatever it needs to identify a filesystem" when placing fanotify marks.
If it wants to open file / directory where events happened, then this
usually means keeping fsid -> "some open fd on fs" mapping so that it can
then use open_by_handle_at() for opening.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

