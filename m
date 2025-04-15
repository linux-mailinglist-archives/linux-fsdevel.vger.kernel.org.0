Return-Path: <linux-fsdevel+bounces-46500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A724BA8A452
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458AA3B43A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C36297A61;
	Tue, 15 Apr 2025 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E8mTthGg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0srrylJd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E8mTthGg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0srrylJd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B84268C79
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735173; cv=none; b=k522mWof0e1RrpBdDvAaHDsZsPUUwXkZIgjPJxHgNMJA1mw10wrAr1gTfTyp2e3fCPxDYGLQs4uka35YMOaD4sskCj6JwdihAnHcZXF6YvHmToCbGNMeo8edr+5JjaLCW6vNdDiQmhAntrtQaB4OlL4ul32IjOA/k+sG+hnK3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735173; c=relaxed/simple;
	bh=umglHO8ELCNI+pwbSFZBAO7wScfh515zNasUvVJgH2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrKc7cH9OPh4KJbFx+Dh/hq48qMrw+It2Tj1VS6rSexNQhRvqunNgozHWomxFqtKoPNjW5Qru/odxPlB0h4y1g/pD4AK2/EB9pRejlcF4jqgXCUsNQbCFDaBqbYbbKmbJ+Eqps/U97XR7v4itn4f4GJdeCgTHSTwW1OGHyRBe6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E8mTthGg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0srrylJd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E8mTthGg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0srrylJd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99EF021197;
	Tue, 15 Apr 2025 16:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744735169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SpibbH30ypgFRpbHIfECRmRgrL+8PXZO5sscOBZo3p8=;
	b=E8mTthGgxPrV7PX2/qB0+1g9qK3oN9PEy7Oq0ZxA7M0BogzST4PCnn9axfsLs+QlZlqRFI
	2gulfvXETIuZOE6CjUhWVgxWLRO8KScNf/YKQJ8w3H834hpuaxsF4VOflo84I93jedWL1J
	IbbUNBkuQf0PiuQ1VG8LLq/ojogrDc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744735169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SpibbH30ypgFRpbHIfECRmRgrL+8PXZO5sscOBZo3p8=;
	b=0srrylJdVSvVECnnIRauRxEy8SvL9ITJ6bBsbBp4x5nyxBxXqsszGENkBhwu1WAQoQWQhz
	LwZNc6XhFXNLdUDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=E8mTthGg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0srrylJd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744735169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SpibbH30ypgFRpbHIfECRmRgrL+8PXZO5sscOBZo3p8=;
	b=E8mTthGgxPrV7PX2/qB0+1g9qK3oN9PEy7Oq0ZxA7M0BogzST4PCnn9axfsLs+QlZlqRFI
	2gulfvXETIuZOE6CjUhWVgxWLRO8KScNf/YKQJ8w3H834hpuaxsF4VOflo84I93jedWL1J
	IbbUNBkuQf0PiuQ1VG8LLq/ojogrDc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744735169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SpibbH30ypgFRpbHIfECRmRgrL+8PXZO5sscOBZo3p8=;
	b=0srrylJdVSvVECnnIRauRxEy8SvL9ITJ6bBsbBp4x5nyxBxXqsszGENkBhwu1WAQoQWQhz
	LwZNc6XhFXNLdUDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87FFF137A5;
	Tue, 15 Apr 2025 16:39:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fCkxIcGL/mdrZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Apr 2025 16:39:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1DF7DA0947; Tue, 15 Apr 2025 18:39:29 +0200 (CEST)
Date: Tue, 15 Apr 2025 18:39:29 +0200
From: Jan Kara <jack@suse.cz>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v4] fs/fs_parse: Remove unused and problematic
 validate_constant_table()
Message-ID: <glkpfryvrfdac4l5kumamww4epzes2nsiwexxjzn5p5k4kkwmp@2eiw7nk4kyxm>
References: <20250415-fix_fs-v4-1-5d575124a3ff@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415-fix_fs-v4-1-5d575124a3ff@quicinc.com>
X-Rspamd-Queue-Id: 99EF021197
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[icloud.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 15-04-25 20:25:00, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Remove validate_constant_table() since:
> 
> - It has no caller.
> 
> - It has below 3 bugs for good constant table array array[] which must
>   end with a empty entry, and take below invocation for explaination:
>   validate_constant_table(array, ARRAY_SIZE(array), ...)
> 
>   - Always return wrong value due to the last empty entry.
>   - Imprecise error message for missorted case.
>   - Potential NULL pointer dereference since the last pr_err() may use
>     @tbl[i].name NULL pointer to print the last empty entry's name.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v4:
> - Rebase on vfs-6.16.misc branch to fix merge conflict.
> - Link to v3: https://lore.kernel.org/r/20250415-fix_fs-v3-1-0c378cc5ce35@quicinc.com
> 
> Changes in v3:
> - Remove validate_constant_table() instead of fixing it
> - Link to v2: https://lore.kernel.org/r/20250411-fix_fs-v2-2-5d3395c102e4@quicinc.com
> 
> Changes in v2:
> - Remove fixes tag for remaining patches
> - Add more comment for the NULL pointer dereference issue
> - Link to v1: https://lore.kernel.org/r/20250410-fix_fs-v1-3-7c14ccc8ebaa@quicinc.com
> ---
>  Documentation/filesystems/mount_api.rst | 15 ----------
>  fs/fs_parser.c                          | 49 ---------------------------------
>  include/linux/fs_parser.h               |  5 ----
>  3 files changed, 69 deletions(-)
> 
> diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
> index 47dafbb7427e6a829989a815e4d034e48fdbe7a2..e149b89118c885c377a17b95adcdbcb594b34e00 100644
> --- a/Documentation/filesystems/mount_api.rst
> +++ b/Documentation/filesystems/mount_api.rst
> @@ -752,21 +752,6 @@ process the parameters it is given.
>       If a match is found, the corresponding value is returned.  If a match
>       isn't found, the not_found value is returned instead.
>  
> -   * ::
> -
> -       bool validate_constant_table(const struct constant_table *tbl,
> -				    size_t tbl_size,
> -				    int low, int high, int special);
> -
> -     Validate a constant table.  Checks that all the elements are appropriately
> -     ordered, that there are no duplicates and that the values are between low
> -     and high inclusive, though provision is made for one allowable special
> -     value outside of that range.  If no special value is required, special
> -     should just be set to lie inside the low-to-high range.
> -
> -     If all is good, true is returned.  If the table is invalid, errors are
> -     logged to the kernel log buffer and false is returned.
> -
>     * ::
>  
>         bool fs_validate_description(const char *name,
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index c5cb19788f74771a945801ceedeec69efed0e40a..c092a9f79e324bacbd950165a0eb66632cae9e03 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -379,55 +379,6 @@ int fs_param_is_path(struct p_log *log, const struct fs_parameter_spec *p,
>  EXPORT_SYMBOL(fs_param_is_path);
>  
>  #ifdef CONFIG_VALIDATE_FS_PARSER
> -/**
> - * validate_constant_table - Validate a constant table
> - * @tbl: The constant table to validate.
> - * @tbl_size: The size of the table.
> - * @low: The lowest permissible value.
> - * @high: The highest permissible value.
> - * @special: One special permissible value outside of the range.
> - */
> -bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
> -			     int low, int high, int special)
> -{
> -	size_t i;
> -	bool good = true;
> -
> -	if (tbl_size == 0) {
> -		pr_warn("VALIDATE C-TBL: Empty\n");
> -		return true;
> -	}
> -
> -	for (i = 0; i < tbl_size; i++) {
> -		if (!tbl[i].name) {
> -			pr_err("VALIDATE C-TBL[%zu]: Null\n", i);
> -			good = false;
> -		} else if (i > 0 && tbl[i - 1].name) {
> -			int c = strcmp(tbl[i-1].name, tbl[i].name);
> -
> -			if (c == 0) {
> -				pr_err("VALIDATE C-TBL[%zu]: Duplicate %s\n",
> -				       i, tbl[i].name);
> -				good = false;
> -			}
> -			if (c > 0) {
> -				pr_err("VALIDATE C-TBL[%zu]: Missorted %s>=%s\n",
> -				       i, tbl[i-1].name, tbl[i].name);
> -				good = false;
> -			}
> -		}
> -
> -		if (tbl[i].value != special &&
> -		    (tbl[i].value < low || tbl[i].value > high)) {
> -			pr_err("VALIDATE C-TBL[%zu]: %s->%d const out of range (%d-%d)\n",
> -			       i, tbl[i].name, tbl[i].value, low, high);
> -			good = false;
> -		}
> -	}
> -
> -	return good;
> -}
> -
>  /**
>   * fs_validate_description - Validate a parameter specification array
>   * @name: Owner name of the parameter specification array
> diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
> index 5057faf4f09182fa6e7ddd03fb17b066efd7e58b..5a0e897cae807bbf5472645735027883a6593e91 100644
> --- a/include/linux/fs_parser.h
> +++ b/include/linux/fs_parser.h
> @@ -87,14 +87,9 @@ extern int lookup_constant(const struct constant_table tbl[], const char *name,
>  extern const struct constant_table bool_names[];
>  
>  #ifdef CONFIG_VALIDATE_FS_PARSER
> -extern bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
> -				    int low, int high, int special);
>  extern bool fs_validate_description(const char *name,
>  				    const struct fs_parameter_spec *desc);
>  #else
> -static inline bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
> -					   int low, int high, int special)
> -{ return true; }
>  static inline bool fs_validate_description(const char *name,
>  					   const struct fs_parameter_spec *desc)
>  { return true; }
> 
> ---
> base-commit: 8cc42084abd926e3f005d7f5c23694c598b29cee
> change-id: 20250410-fix_fs-6e0a97c4e59f
> 
> Best regards,
> -- 
> Zijun Hu <quic_zijuhu@quicinc.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

