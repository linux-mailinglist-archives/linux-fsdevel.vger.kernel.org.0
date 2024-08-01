Return-Path: <linux-fsdevel+bounces-24824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B92C294514F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 19:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20108284EBF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B371E1B3F39;
	Thu,  1 Aug 2024 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kahc4mu9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qoKrSZK5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kahc4mu9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qoKrSZK5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCAE3A1DA
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722532178; cv=none; b=ldxjVOB/2akyKfsNuw2GaVr1bXbYiogw2peKgMmootbC4IlAWq4pob009iD/qDrnK+irqziIV1oQpKiOAzFihE5ut34haQoZPOcOjSxWDTgehMzf9GQqbjNh1LtqORs+XLKtTzaKapDq5paNCPQWwOrL1zwNW8r/ERsrvqpvjL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722532178; c=relaxed/simple;
	bh=XTluDcbd5LT8hIZRDgU+xtNUus6NL8jzo71W/mXyOig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUey/vAququhoPvxobe5TMJQGqAJqdUnj2Mst5U8HetMAcMFy2KSamM8dBCE1htFQpHGIC2fMtWJgHpD1j9vE8EWSSBRuxIxqi8S19xHpfH+uca5HrM3YedrWV+2fnEM79+2lSKADtJSgNPVR8ifxBtWHlc4LWkEv+AChr33u2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kahc4mu9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qoKrSZK5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kahc4mu9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qoKrSZK5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 655BE21A03;
	Thu,  1 Aug 2024 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722532174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8IjeD2uqKWlKXbLBLXumxbaHagV5geKQ15MlwGC3q+U=;
	b=kahc4mu9sbO7z7S527JDygKgjh/J/deHTU7R77gv57EVGhGSY71lEUjgKBjmeaEMaKyIJ7
	AQXGRuw8m7EOn9k/WiZHX5Gb/jHET8m1RRizcPiwsg9xlPeegCm/zNTVE01pTdYePByi5t
	JXh18ZZTTH6qfSZKpNeVesck6CD6mX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722532174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8IjeD2uqKWlKXbLBLXumxbaHagV5geKQ15MlwGC3q+U=;
	b=qoKrSZK5dRInS1GXTJZv7MeeTHZKpFj7xCxhuFZVowrTEsxIEC72fQhcnD63q1X2AeJ33Q
	27K+shHmykAQqkDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kahc4mu9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qoKrSZK5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722532174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8IjeD2uqKWlKXbLBLXumxbaHagV5geKQ15MlwGC3q+U=;
	b=kahc4mu9sbO7z7S527JDygKgjh/J/deHTU7R77gv57EVGhGSY71lEUjgKBjmeaEMaKyIJ7
	AQXGRuw8m7EOn9k/WiZHX5Gb/jHET8m1RRizcPiwsg9xlPeegCm/zNTVE01pTdYePByi5t
	JXh18ZZTTH6qfSZKpNeVesck6CD6mX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722532174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8IjeD2uqKWlKXbLBLXumxbaHagV5geKQ15MlwGC3q+U=;
	b=qoKrSZK5dRInS1GXTJZv7MeeTHZKpFj7xCxhuFZVowrTEsxIEC72fQhcnD63q1X2AeJ33Q
	27K+shHmykAQqkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A592136CF;
	Thu,  1 Aug 2024 17:09:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JiIKFk7Bq2aEMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Aug 2024 17:09:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D1995A08CB; Thu,  1 Aug 2024 19:09:33 +0200 (CEST)
Date: Thu, 1 Aug 2024 19:09:33 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 05/10] fanotify: introduce FAN_PRE_MODIFY permission event
Message-ID: <20240801170933.yqabftb5qphscyol@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <e58775009d8df15b5513fab5ac112f0dac53e427.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e58775009d8df15b5513fab5ac112f0dac53e427.1721931241.git.josef@toxicpanda.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 655BE21A03
X-Spam-Score: -3.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]

On Thu 25-07-24 14:19:42, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> Generate FAN_PRE_MODIFY permission event from fsnotify_file_perm()
> pre-write hook to notify fanotify listeners on an intent to make
> modification to a file.
> 
> Like FAN_PRE_ACCESS, it is only allowed with FAN_CLASS_PRE_CONTENT
> and unlike FAN_MODIFY, it is only allowed on regular files.
> 
> Like FAN_PRE_ACCESS, it is generated without sb_start_write() held,
> so it is safe for to perform filesystem modifications in the the
		^^^ seems superfluous			   ^^^ twice "the"

> context of event handler.
...
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 5c811baf44d2..ae6cb2688d52 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -92,7 +92,8 @@
>  #define FANOTIFY_CONTENT_PERM_EVENTS (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
>  				      FAN_ACCESS_PERM)
>  /* Pre-content events can be used to fill file content */
> -#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS)
> +#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS | FAN_PRE_MODIFY)
> +#define FANOTIFY_PRE_MODIFY_EVENTS   (FAN_PRE_MODIFY)

I didn't find FANOTIFY_PRE_MODIFY_EVENTS used anywhere?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

