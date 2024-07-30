Return-Path: <linux-fsdevel+bounces-24603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABB2941295
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 14:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97413285E86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 12:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3781A38E4;
	Tue, 30 Jul 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KdaSyy6r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O8E0Gwqa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wTmG4ITT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fcf4Wsae"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE581A38D5
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343851; cv=none; b=HIhjGXQ3Z5AEGkQdHVl+DwzbTkfaDWxVWKYyh6VEWa7dtOi0Sixm6b2gSwVh7jNh/Y3HdNCWyOUZuBCWi/7QzNMqhMRzhj4QVu0BkDdQrGM0Bx/le3FhZApb1McDrujDHpuXFO1/BsVo5V9zMLZpG0/+BjC+aWFrPFUVdB3ZmGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343851; c=relaxed/simple;
	bh=P8CcMVindkNUAg1LIuxyjN50AGPfchedJ8sq48zRReA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEiIg/HofbudZOJ5KEYuRsh+Y+vgcKe5KaUE/mkDQp5xJ3uOEbyUk1JsiJ7i7aWBrD1SEtF8k75e7WphN7WATs9qT5vE8o0bZP3bLlxigGetFt2Ir6eevO9DwyvwXRubdKr0ZgtvT2U7oaVR2UvUkkpSDuv4szcbbuaJah0qykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KdaSyy6r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O8E0Gwqa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wTmG4ITT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fcf4Wsae; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F2CA51F7E2;
	Tue, 30 Jul 2024 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722343848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LawlileaAgVJHH8+EI1K7K/eABKgo1bdR90ew7YEhF0=;
	b=KdaSyy6rKLmjID4uo5DY0Eb1tGDCzsoJDaOQfTmhlJz3uEcyKByQyHKmyacp/1mAWFR65k
	C5ACAkXRFhkS2me3acnVtXGIb8qaoZlGtKsIqsR8MNlFZbC9idyjMinuslxNF7Nl2fiRi1
	idrj3hbiiQZ7iYFmi7pd1LG/JR0Jt6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722343848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LawlileaAgVJHH8+EI1K7K/eABKgo1bdR90ew7YEhF0=;
	b=O8E0GwqadEb2Ojs6o9ZkFsFSglxmC+nNSrwVnM5FyL/6e7jIKbHL1wesyiDCY2H0Z5s6Ox
	qCq++oklvizNzzAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722343847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LawlileaAgVJHH8+EI1K7K/eABKgo1bdR90ew7YEhF0=;
	b=wTmG4ITTflUljCtbdT2Jb77qcbedydxEIS/FsGXARu03Mkf19KpuxS8XVC0do4oa2kTPVH
	IlBPwbnfalytNM5HPj/igyzSDMaF4TcIwKOU5i5ykP0Kr4RQ4LhN3HuXtiUCm17rIhzjFM
	pddQscIhkbcKDUXJxdK3qsYEyIRaJbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722343847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LawlileaAgVJHH8+EI1K7K/eABKgo1bdR90ew7YEhF0=;
	b=fcf4Wsaezu7xljVD300anOE8HgtKqG1HT/YCoYg0XP8HWUA6N5+QxhECQttxpPx/4BmWDg
	BPGQDBAGuCxKllCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E86FD13297;
	Tue, 30 Jul 2024 12:50:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id apm6OKfhqGY0TwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Jul 2024 12:50:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A715FA099C; Tue, 30 Jul 2024 14:50:47 +0200 (CEST)
Date: Tue, 30 Jul 2024 14:50:47 +0200
From: Jan Kara <jack@suse.cz>
To: Pavel Reichl <preichl@redhat.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] quotaio_xfs: Fix memory leak
Message-ID: <20240730125047.mbk3v52qdprzus7t@quack3>
References: <20240729221813.93878-1-preichl@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729221813.93878-1-preichl@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Tue 30-07-24 00:18:13, Pavel Reichl wrote:
> Error: RESOURCE_LEAK (CWE-772):
> quota-4.09/quotaio_xfs.c:162:2: alloc_fn: Storage is returned from allocation function "get_empty_dquot".
> quota-4.09/quotaio_xfs.c:162:2: var_assign: Assigning: "dquot" = storage returned from "get_empty_dquot()".
> quota-4.09/quotaio_xfs.c:180:4: leaked_storage: Variable "dquot" going out of scope leaks the storage it points to.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>

Thanks for the fix! Applied.

								Honza

> ---
>  quotaio_xfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/quotaio_xfs.c b/quotaio_xfs.c
> index 2df27b5..5446bc5 100644
> --- a/quotaio_xfs.c
> +++ b/quotaio_xfs.c
> @@ -174,6 +174,7 @@ static struct dquot *xfs_read_dquot(struct quota_handle *h, qid_t id)
>  		 * zeros. Otherwise return failure.
>  		 */
>  		if (errno != ENOENT) {
> +			free(dquot);
>  			return NULL;
>  		}
>  	}
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

