Return-Path: <linux-fsdevel+bounces-4414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E697FF267
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E261C206FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B595100B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EcxO0yOL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HFhoU+4q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090EE19F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 06:25:46 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83F9B1FCEE;
	Thu, 30 Nov 2023 14:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701354344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/PgcoP0LDtbM572w05qOKvKaad05A1aFH8Svgqws/VE=;
	b=EcxO0yOLyEdsmR6L/W8yqNevNLoL6ApoUZekyoJDgfflpqE8Uwl4/TFoTpVdlMgLgLBEn1
	U5VYrcOQJGRF6JjnA2lyOuVGSIY9Np6CvMNo2xLQ/XKZ3/ZpoQ8us/LmM/0ZZs7d1JCQQ7
	fsdAM5ZQKyqcCKYCn4mhUyZxmrhiEAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701354344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/PgcoP0LDtbM572w05qOKvKaad05A1aFH8Svgqws/VE=;
	b=HFhoU+4qebyyCaZcVuR60bruXqYhnkkfF5Fy1RzdRxstZHN3h6vFXsyB6UkqIXtuPN5o8L
	C1NSlhWoY010HMDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7080513A5C;
	Thu, 30 Nov 2023 14:25:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ipYtG2ibaGW9bwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 14:25:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BB6D0A07DB; Thu, 30 Nov 2023 15:25:39 +0100 (CET)
Date: Thu, 30 Nov 2023 15:25:39 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fanotify: store fsid in mark instead of in connector
Message-ID: <20231130142539.g4hhcsk4hk2oimdv@quack3>
References: <20231118183018.2069899-1-amir73il@gmail.com>
 <20231118183018.2069899-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118183018.2069899-2-amir73il@gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.41)[97.27%]

On Sat 18-11-23 20:30:17, Amir Goldstein wrote:
> Some filesystems like fuse and nfs have zero or non-unique fsid.
> We would like to avoid reporting ambiguous fsid in events, so we need
> to avoid marking objects with same fsid and different sb.
> 
> To make this easier to enforce, store the fsid in the marks of the group
> instead of in the shared conenctor.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Very nice! I like the result. Just a few nits below.

> +static inline __kernel_fsid_t *fanotify_mark_fsid(struct fsnotify_mark *mark)
> +{
> +	return &FANOTIFY_MARK(mark)->fsid;
> +}

I guess, there's no big win in using this helper compared to using
FANOTIFY_MARK(mark)->fsid so I'd just drop this helper.

> @@ -530,6 +528,7 @@ struct fsnotify_mark {
>  #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x0100
>  #define FSNOTIFY_MARK_FLAG_NO_IREF		0x0200
>  #define FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS	0x0400
> +#define FSNOTIFY_MARK_FLAG_HAS_FSID		0x0800
>  	unsigned int flags;		/* flags [mark->lock] */
>  };

So this flag is in fact private to fanotify notification framework. Either
we could just drop this flag and use

  FANOTIFY_MARK(mark)->fsid[0] != 0 || FANOTIFY_MARK(mark)->fsid[1] != 0

instead or we could at least add a comment that this flags is in fact
private to fanotify?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

