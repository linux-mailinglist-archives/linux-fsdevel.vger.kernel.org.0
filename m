Return-Path: <linux-fsdevel+bounces-77351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCywOWI9lGmTAwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 11:05:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B8D14AA97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 11:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C902300CFF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20FC320A0D;
	Tue, 17 Feb 2026 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AyGLa9rD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Zs1AxM1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AyGLa9rD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Zs1AxM1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2CA2DAFBB
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771322717; cv=none; b=mxFAwgCZLmjuolGeY0788lD80OC2sHDGGpA/M2/LhTPapQSgke38Be0kPYj+LQeWch0DP9UCjLiibGqnuVi8bSxoOWQf3DSczRZHN5oHQe+zxWeoZt6YVzOax5xkZtDjSDUT/5zNRyCDwZ1xTzfQ5MkOQfngy5jMeB2criLOBH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771322717; c=relaxed/simple;
	bh=TNWDcyA0w8euaXo0wg8tWtTZzf6r8CfNuRPPrw50vMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ha3i2toNw81nfLje7Owpo5bsrag7Dmcl+RnLwv6OCCuBHYPqWPFNbNh1+ZoO5wYIlDW6wi6nvABqm06UN78Yyq2NWy51mZY+4WGQLTdnu87AxkaueC1BdMqJwLz1TqOCWTN54csC0jp4lxSzWqKLVlmiBQ1bMjRiV2RLTardWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AyGLa9rD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9Zs1AxM1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AyGLa9rD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9Zs1AxM1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 179573E84F;
	Tue, 17 Feb 2026 10:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771322714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OWqvH0YA3VUZZU+/ouggA8jap3yQxgZ/Rg5ctO74aU=;
	b=AyGLa9rD1s0Ln1YPiXkAj9iHkutQvpkmlCRcoVdxyThZMFXQCdaNKlTMZn4S8llSU79PSy
	W10w9YT3lQX5uAU058gYZ9s6Ln4aOikZDhawdSZ4QrY0fI9GJRJuLQaFG8pnuFBQqQx5Rd
	YeMOVYy+9kuixY8+JWMs6iSf9iWTubU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771322714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OWqvH0YA3VUZZU+/ouggA8jap3yQxgZ/Rg5ctO74aU=;
	b=9Zs1AxM1FzjMrfzyEsGHeGXAhS1K0T5LnXMYdz8zxmKg6h25wOj3M64kNRhvzONs+L+v3n
	iiKB48ZtSvwFDfBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AyGLa9rD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9Zs1AxM1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771322714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OWqvH0YA3VUZZU+/ouggA8jap3yQxgZ/Rg5ctO74aU=;
	b=AyGLa9rD1s0Ln1YPiXkAj9iHkutQvpkmlCRcoVdxyThZMFXQCdaNKlTMZn4S8llSU79PSy
	W10w9YT3lQX5uAU058gYZ9s6Ln4aOikZDhawdSZ4QrY0fI9GJRJuLQaFG8pnuFBQqQx5Rd
	YeMOVYy+9kuixY8+JWMs6iSf9iWTubU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771322714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OWqvH0YA3VUZZU+/ouggA8jap3yQxgZ/Rg5ctO74aU=;
	b=9Zs1AxM1FzjMrfzyEsGHeGXAhS1K0T5LnXMYdz8zxmKg6h25wOj3M64kNRhvzONs+L+v3n
	iiKB48ZtSvwFDfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D30D73EA65;
	Tue, 17 Feb 2026 10:05:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qxB7M1k9lGnbQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Feb 2026 10:05:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C8E89A08CF; Tue, 17 Feb 2026 11:05:02 +0100 (CET)
Date: Tue, 17 Feb 2026 11:05:02 +0100
From: Jan Kara <jack@suse.cz>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	anuj20.g@samsung.com, hch@lst.de, jack@suse.cz, djwong@kernel.org, david@fromorbit.com, 
	amir73il@gmail.com, brauner@kernel.org, clm@meta.com, axboe@kernel.dk, 
	willy@infradead.org, gost.dev@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com, 
	mcgrof@kernel.org, pankaj.raghav@linux.dev, ritesh.list@gmail.com
Subject: Re: [LSF/MM/BPF TOPIC] Parallel writeback: design directions and
 sharding models
Message-ID: <hfmkns7hgz4ufmsvh5wxf6rz3qznmygmd2gutdrwqfzr3gdrjj@x3obfcpzbway>
References: <CGME20260216100437epcas5p415590b08bb19d887bc065f5feba8346a@epcas5p4.samsung.com>
 <20260216095852.4611-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216095852.4611-1-kundan.kumar@samsung.com>
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77351-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,samsung.com,lst.de,suse.cz,kernel.org,fromorbit.com,gmail.com,meta.com,kernel.dk,infradead.org,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 50B8D14AA97
X-Rspamd-Action: no action

Hello!

On Mon 16-02-26 15:28:52, Kundan Kumar wrote:
> Parallel writeback was discussed last year at LSF/MM[1], and since then
> me and Anuj have posted three iterations exploring different design
> directions and sharding approaches:
> 
> v1 – Inode affined writeback contexts, introducing high-level parallelism
> by mapping inodes to independent writeback contexts.
> https://lore.kernel.org/all/20250529111504.89912-1-kundan.kumar@samsung.com/
> 
> v2 – Threads affined to XFS allocation groups (AGs), reducing cross-AG
> contention by routing writeback work to AG local workers.
> https://lore.kernel.org/all/20251014120845.2361-1-kundan.kumar@samsung.com/
> 
> v3 – XFS AG aware writeback using folio level tagging for more precise
> geometry-based routing.
> https://lore.kernel.org/all/20260116100818.7576-1-kundan.kumar@samsung.com/
> 
> Multiple approaches have been explored and the design continues to
> evolve. In v3, folio level AG tagging improved scalability and routing
> precision, but it also increased implementation complexity and expanded
> MM filesystem interaction beyond traditional boundaries.
> 
> Following v3, Christoph suggested a stream ID based approach[2], where
> per inode streams guide writeback routing and allocation decisions.
> This transition adopts a sharding model by modifying the XFS allocation
> policy, helping to reduce contention and achieve a more balanced
> distribution.
> 
> Anuj and I would like to gather feedback on overall design direction and
> appropriate sharding models for scalable writeback.

Thanks for working on this! I'm definitely interested in the discussion on
this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

