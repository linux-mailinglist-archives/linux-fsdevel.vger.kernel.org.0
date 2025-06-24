Return-Path: <linux-fsdevel+bounces-52726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCD2AE6099
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5C2C7B309B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B7727FB1B;
	Tue, 24 Jun 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1lLfsjcj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aHBVmQVQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1lLfsjcj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aHBVmQVQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D260627C872
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756635; cv=none; b=jE0Km2PYGMUbLZ16IHvvXWlukUdwwXuLOk2+Yb23buGaUsnxsq8Yp+qGSxnCKfHMsvj5RKj3Sb1fR8F2Nl/PSzWsHPUBXmXJV93T0qlMOjU7HcavbpAutfOM3WxdhSScNzHbq5KDeDFGaYQvJvUMGb3K3N3RXZ4ZyvMj5BVzF5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756635; c=relaxed/simple;
	bh=wcrA+OkCHYhINFrSg+RcXf32gE0e3Oh9E4ASETsjyOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRs9mpHc+JwJQVcXX5oiIeuTAZIDcMvCS/Mb3w4FAbz/zQWos4tukm85Ff0esFMIBx8D0gItaf1jXcyKDH1EULOUJkam3roPU+D3nJry7qPmC5zw6cSFS6vvLHjaIDdul1VKV3oGvA9oDcODcxyv/QcfgB6ug7I3dGTMNXVHVpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1lLfsjcj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aHBVmQVQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1lLfsjcj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aHBVmQVQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0BD5321186;
	Tue, 24 Jun 2025 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750756632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mf/B7rupv0OyAAV0+VPB8bPpt4bxvb7KWInmHqSJzuE=;
	b=1lLfsjcjUJFIkjTXORqhT2Zb1Q/EjsZ2DxxYTZbnledhkIcc3GFkTCh1pD6iEdMLXSueTp
	w/kJFKN5C7U1pd8rYZ/fJ8TQzezYK3llmFGFLT98q79pc1kWJfoJOFLCht/QHn13FT0yYg
	w/lqizxvyjR1hYBRFu7GUou4GmDC4qU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750756632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mf/B7rupv0OyAAV0+VPB8bPpt4bxvb7KWInmHqSJzuE=;
	b=aHBVmQVQ0FkSKay6dd0KFzYajtYKjb4x5xBPuPEESFgZ+kDVIuTQXSgRYeiVUKeuYYUrlJ
	BqH3ooLekfiAGnAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750756632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mf/B7rupv0OyAAV0+VPB8bPpt4bxvb7KWInmHqSJzuE=;
	b=1lLfsjcjUJFIkjTXORqhT2Zb1Q/EjsZ2DxxYTZbnledhkIcc3GFkTCh1pD6iEdMLXSueTp
	w/kJFKN5C7U1pd8rYZ/fJ8TQzezYK3llmFGFLT98q79pc1kWJfoJOFLCht/QHn13FT0yYg
	w/lqizxvyjR1hYBRFu7GUou4GmDC4qU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750756632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mf/B7rupv0OyAAV0+VPB8bPpt4bxvb7KWInmHqSJzuE=;
	b=aHBVmQVQ0FkSKay6dd0KFzYajtYKjb4x5xBPuPEESFgZ+kDVIuTQXSgRYeiVUKeuYYUrlJ
	BqH3ooLekfiAGnAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 029BF13751;
	Tue, 24 Jun 2025 09:17:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ER6iABhtWmj4GQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Jun 2025 09:17:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BE39AA0A03; Tue, 24 Jun 2025 11:17:11 +0200 (CEST)
Date: Tue, 24 Jun 2025 11:17:11 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 07/11] uapi/fcntl: add FD_INVALID
Message-ID: <kxzcg5lwo57lucrwykperqngpjvjt6e5uzfpwbyhq45cr7b35o@utfuw2my7uuh>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-7-d02a04858fe3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-work-pidfs-fhandle-v2-7-d02a04858fe3@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 

On Tue 24-06-25 10:29:10, Christian Brauner wrote:
> Add a marker for an invalid file descriptor.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/uapi/linux/fcntl.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index ba4a698d2f33..a5bebe7c4400 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -110,6 +110,7 @@
>  #define PIDFD_SELF_THREAD		-10000 /* Current thread. */
>  #define PIDFD_SELF_THREAD_GROUP		-10001 /* Current thread group leader. */
>  
> +#define FD_INVALID			-10009 /* Invalid file descriptor: -10000 - EBADF = -10009 */
>  
>  /* Generic flags for the *at(2) family of syscalls. */
>  
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

