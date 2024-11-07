Return-Path: <linux-fsdevel+bounces-33881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 417D59C0153
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 10:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B835D1F22BE2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F281E25F6;
	Thu,  7 Nov 2024 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0SAGYnEL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="deeMevBn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0SAGYnEL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="deeMevBn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8E01D79BB;
	Thu,  7 Nov 2024 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972444; cv=none; b=N2ECkEFhcLQRqGMpdbLcc4/7J4pGtokGF13eR3L5b0zUC3EkqOpQjKlT3PVkyrEZWHYVwpIdrgc8EIsb8kFERSq1WFWbCGkoklsu3DOyoKhYkJyYrQ/TcXawe/x3Gp/Yeh4FPMkTPaiNTPBoB7GEaITYY/wLEtW5kvRMCRIz8s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972444; c=relaxed/simple;
	bh=cQ7+E9wE9oPZkBrWC40qBHj5F/WnrP2dolgWrrMIO4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3IJ6Q8Pxh+7dns1qQ3NkEdrNAy08FLX12dmsOHeS2Mizm28MEBxemKIsnvgTXIHGVLK3KCGfHMVcRDGeol7WDEab2DRLExbYzNPZSI7d5SRWqqjd0C2U0igY4xrlt3YrCtCRXEnKLHAoBqvrea9ob7kyj2cVgjafdirpJOwPJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0SAGYnEL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=deeMevBn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0SAGYnEL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=deeMevBn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ADD9921BC2;
	Thu,  7 Nov 2024 09:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730972440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhVyyo5JGxlVGXlp6VoYKjgmSm3GnU0oOYcZRfTeVls=;
	b=0SAGYnELBskamWnC1+iL6Jw3ZT1YhrW74LQH+M1yptKZe4fDRtrisVKJYMoWZSdCjj1eUV
	7d0sIDfd35n32BjtV5aahb68UFEt3ZIVkjQcscBYDOeqsGXFUEQlyqN7ZGz9aUAClKY4hU
	wtE8I/QYdae6NC+PmPSWcjZ7YF3GSW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730972440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhVyyo5JGxlVGXlp6VoYKjgmSm3GnU0oOYcZRfTeVls=;
	b=deeMevBnDgOQ8KIkUC9NBX7gHCJCFKXUnGeumSOOz1LniH28iFMkuBDfmGy/dIAky86DHb
	bmMjmky0ctuvJYCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0SAGYnEL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=deeMevBn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730972440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhVyyo5JGxlVGXlp6VoYKjgmSm3GnU0oOYcZRfTeVls=;
	b=0SAGYnELBskamWnC1+iL6Jw3ZT1YhrW74LQH+M1yptKZe4fDRtrisVKJYMoWZSdCjj1eUV
	7d0sIDfd35n32BjtV5aahb68UFEt3ZIVkjQcscBYDOeqsGXFUEQlyqN7ZGz9aUAClKY4hU
	wtE8I/QYdae6NC+PmPSWcjZ7YF3GSW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730972440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhVyyo5JGxlVGXlp6VoYKjgmSm3GnU0oOYcZRfTeVls=;
	b=deeMevBnDgOQ8KIkUC9NBX7gHCJCFKXUnGeumSOOz1LniH28iFMkuBDfmGy/dIAky86DHb
	bmMjmky0ctuvJYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4495139B3;
	Thu,  7 Nov 2024 09:40:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lb4WKBiLLGfMeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 07 Nov 2024 09:40:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 64F14A0AF4; Thu,  7 Nov 2024 10:40:40 +0100 (CET)
Date: Thu, 7 Nov 2024 10:40:40 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fs: add the ability for statmount() to report the
 mount devicename
Message-ID: <20241107094040.2gcshh466b7zslva@quack3>
References: <20241106-statmount-v2-0-93ba2aad38d1@kernel.org>
 <20241106-statmount-v2-2-93ba2aad38d1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-statmount-v2-2-93ba2aad38d1@kernel.org>
X-Rspamd-Queue-Id: ADD9921BC2
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 06-11-24 14:53:06, Jeff Layton wrote:
> /proc/self/mountinfo displays the devicename for the mount, but
> statmount() doesn't yet have a way to return it. Add a new
> STATMOUNT_MNT_DEVNAME flag, claim the 32-bit __spare1 field to hold the
> offset into the str[] array. STATMOUNT_MNT_DEVNAME will only be set in
> the return mask if there is a device string.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Just one question below:

> @@ -5078,6 +5091,12 @@ static int statmount_string(struct kstatmount *s, u64 flag)
>  		if (seq->count == sm->fs_subtype)
>  			return 0;
>  		break;
> +	case STATMOUNT_MNT_DEVNAME:
> +		sm->mnt_devname = seq->count;
> +		ret = statmount_mnt_devname(s, seq);
> +		if (seq->count == sm->mnt_devname)

Why this odd check? Why don't you rather do:
		if (ret)
?

> +			return ret;
> +		break;
>  	default:
>  		WARN_ON_ONCE(true);
>  		return -EINVAL;

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

