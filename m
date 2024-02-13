Return-Path: <linux-fsdevel+bounces-11362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2765A8530E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 13:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B20C1C220FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 12:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19B943ADC;
	Tue, 13 Feb 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UwyOLhTg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cdzcLpil";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UwyOLhTg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cdzcLpil"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89F43AC8
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828578; cv=none; b=pFsCwHpLOkoK/Z+gaCOxZ8l2Wj+eHPVbbGTS70o5X78u5FsVrq9bVCIDhLO8GAGL3osFvEnHFREX8837HVQ68P21jMeApagqDSMEdzA5524h8MyDJQJ9vLAYPBnM8Z64xwQ1oyXUfhsBtWtIydcxEBSbcZWgeZfUhBlWvgPDN/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828578; c=relaxed/simple;
	bh=SkdT9ZPYWE+j04E++FYeSc/wN1HiHgSpI3w6ph4LVCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5j6hNPz3UP0pgKFQzDOFyO5TW59+lX9FpeBHgBJPMYL2l8Xt98e5mKn6htH6IGcK02WP4NydBnXSosXSh2A6SCjgnLPRWxcwGN7mk8YBMEemfhKaHEbuxysj7ixDchxnBPojBXLiTq1Y3ktOLqH5+kchYS28jyXJDQwtTwv/6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UwyOLhTg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cdzcLpil; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UwyOLhTg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cdzcLpil; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3901221A33;
	Tue, 13 Feb 2024 12:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707828574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1vGX3Qw4kyZciPZJoA2a0olYEA6p0qlsWrGUfxV5754=;
	b=UwyOLhTgyetygFN+58nOr9HhkVmsRavAIzPhxEgEJxNvyaj0bCj5FAeazombqOY+noYsrT
	OcixVre22rCUnNWFcE2kfeEXhlkUt0+RSovxlrnO+Gia7ZETlhEIAfhRsIwJK8AsYgdBxU
	VOketRb2sPlOEU4bTgZnOSrWpQ5Tr/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707828574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1vGX3Qw4kyZciPZJoA2a0olYEA6p0qlsWrGUfxV5754=;
	b=cdzcLpilTdJCEA5fjitgPnm9sSht139+PQ99MEmlupsaKfGqXCxpjOd2gDUB/Ir3N/sE5R
	UEt+tIuGU865x5Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707828574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1vGX3Qw4kyZciPZJoA2a0olYEA6p0qlsWrGUfxV5754=;
	b=UwyOLhTgyetygFN+58nOr9HhkVmsRavAIzPhxEgEJxNvyaj0bCj5FAeazombqOY+noYsrT
	OcixVre22rCUnNWFcE2kfeEXhlkUt0+RSovxlrnO+Gia7ZETlhEIAfhRsIwJK8AsYgdBxU
	VOketRb2sPlOEU4bTgZnOSrWpQ5Tr/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707828574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1vGX3Qw4kyZciPZJoA2a0olYEA6p0qlsWrGUfxV5754=;
	b=cdzcLpilTdJCEA5fjitgPnm9sSht139+PQ99MEmlupsaKfGqXCxpjOd2gDUB/Ir3N/sE5R
	UEt+tIuGU865x5Ag==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E2BB13A0E;
	Tue, 13 Feb 2024 12:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8489C15ly2W1VgAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 13 Feb 2024 12:49:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D2F10A0809; Tue, 13 Feb 2024 13:49:33 +0100 (CET)
Date: Tue, 13 Feb 2024 13:49:33 +0100
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Bill O'Donnell <billodo@redhat.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] udf: convert to new mount API
Message-ID: <20240213124933.ftbnf3inbfbp77g4@quack3>
References: <739fe39a-0401-4f5d-aef7-759ef82b36bd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <739fe39a-0401-4f5d-aef7-759ef82b36bd@redhat.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UwyOLhTg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cdzcLpil
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -5.51
X-Rspamd-Queue-Id: 3901221A33
X-Spam-Flag: NO

On Fri 09-02-24 13:43:09, Eric Sandeen wrote:
> Convert the UDF filesystem to the new mount API.
> 
> UDF is slightly unique in that it always preserves prior mount
> options across a remount, so that's handled by udf_init_options().

Well, ext4 does this as well AFAICT. See e.g. ext4_apply_options() and how
it does:

        sbi->s_mount_opt &= ~ctx->mask_s_mount_opt;
        sbi->s_mount_opt |= ctx->vals_s_mount_opt;
        sbi->s_mount_opt2 &= ~ctx->mask_s_mount_opt2;
        sbi->s_mount_opt2 |= ctx->vals_s_mount_opt2;
        sb->s_flags &= ~ctx->mask_s_flags;
        sb->s_flags |= ctx->vals_s_flags;

so it really modifies the current superblock state, not overwrites it.

> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> Tested by running through xfstests, as well as some targeted testing of
> remount behavior.
> 
> NB: I did not convert i.e any udf_err() to errorf(fc, ) because the former
> does some nice formatting, not sure how or if you'd like to handle that, Jan?

Which one would you like to convert? I didn't find any obvious
candidates... Or do you mean the messages in udf_fill_super() when we find
on-disk inconsistencies or similar? I guess we can leave that for later
because propagating 'fc' into all the validation functions will be a lot of
churn.

> +static void udf_init_options(struct fs_context *fc, struct udf_options *uopt)
> +{
> +	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
> +		struct super_block *sb = fc->root->d_sb;
> +		struct udf_sb_info *sbi = UDF_SB(sb);
> +
> +		uopt->flags = sbi->s_flags;
> +		uopt->uid   = sbi->s_uid;
> +		uopt->gid   = sbi->s_gid;
> +		uopt->umask = sbi->s_umask;
> +		uopt->fmode = sbi->s_fmode;
> +		uopt->dmode = sbi->s_dmode;
> +		uopt->nls_map = NULL;
> +	} else {
> +		uopt->flags = (1 << UDF_FLAG_USE_AD_IN_ICB) | (1 << UDF_FLAG_STRICT);
> +		/* By default we'll use overflow[ug]id when UDF inode [ug]id == -1 */

Nit: Please wrap these two lines.

> +		uopt->uid = make_kuid(current_user_ns(), overflowuid);
> +		uopt->gid = make_kgid(current_user_ns(), overflowgid);
> +		uopt->umask = 0;
> +		uopt->fmode = UDF_INVALID_MODE;
> +		uopt->dmode = UDF_INVALID_MODE;
> +		uopt->nls_map = NULL;
> +		uopt->session = 0xFFFFFFFF;
> +	}
> +}
> +
> +static int udf_init_fs_context(struct fs_context *fc)
> +{
> +	struct udf_options *uopt;
> +
> +	uopt = kzalloc(sizeof(*uopt), GFP_KERNEL);
> +	if (!uopt)
> +		return -ENOMEM;
> +
> +	udf_init_options(fc, uopt);
> +
> +	fc->fs_private = uopt;
> +	fc->ops = &udf_context_ops;
> +
> +	return 0;
> +}
> +
> +static void udf_free_fc(struct fs_context *fc)
> +{
> +	kfree(fc->fs_private);
> +}

So I think we need to unload uopt->nls_map in case we eventually failed the
mount (which means we also need to zero uopt->nls_map if we copy it to the
sbi).

> +static const struct fs_parameter_spec udf_param_spec[] = {
> +	fsparam_flag	("novrs",		Opt_novrs),
> +	fsparam_flag	("nostrict",		Opt_nostrict),
> +	fsparam_u32	("bs",			Opt_bs),
> +	fsparam_flag	("unhide",		Opt_unhide),
> +	fsparam_flag	("undelete",		Opt_undelete),
> +	fsparam_flag	("noadinicb",		Opt_noadinicb),
> +	fsparam_flag	("adinicb",		Opt_adinicb),

We could actually use the fs_param_neg_with_no for the above. I don't
insist but it's an interesting exercise :)

> +	fsparam_flag	("shortad",		Opt_shortad),
> +	fsparam_flag	("longad",		Opt_longad),
> +	fsparam_string	("gid",			Opt_gid),
> +	fsparam_string	("uid",			Opt_uid),
> +	fsparam_u32	("umask",		Opt_umask),
> +	fsparam_u32	("session",		Opt_session),
> +	fsparam_u32	("lastblock",		Opt_lastblock),
> +	fsparam_u32	("anchor",		Opt_anchor),
> +	fsparam_u32	("volume",		Opt_volume),
> +	fsparam_u32	("partition",		Opt_partition),
> +	fsparam_u32	("fileset",		Opt_fileset),
> +	fsparam_u32	("rootdir",		Opt_rootdir),
> +	fsparam_flag	("utf8",		Opt_utf8),
> +	fsparam_string	("iocharset",		Opt_iocharset),
> +	fsparam_u32	("mode",		Opt_fmode),
> +	fsparam_u32	("dmode",		Opt_dmode),
> +	{}
> + };
> + 
> +static int udf_parse_param(struct fs_context *fc, struct fs_parameter *param)

...

> +	unsigned int n;
> +	struct udf_options *uopt = fc->fs_private;
> +	struct fs_parse_result result;
> +	int token;
> +	bool remount = (fc->purpose & FS_CONTEXT_FOR_RECONFIGURE);
> +
> +	token = fs_parse(fc, udf_param_spec, param, &result);
> +	if (token < 0)
> +		return token;
> +
> +	switch (token) {
> +	case Opt_novrs:
> +		uopt->novrs = 1;

I guess we can make this just an ordinary flag as a prep patch?

> +		break;
> +	case Opt_bs:
> +		n = result.uint_32;;
				  ^^ one is enough ;)

> +		if (n != 512 && n != 1024 && n != 2048 && n != 4096)
> +			return -EINVAL;
> +		uopt->blocksize = n;
> +		uopt->flags |= (1 << UDF_FLAG_BLOCKSIZE_SET);
> +		break;
> +	case Opt_unhide:
> +		uopt->flags |= (1 << UDF_FLAG_UNHIDE);
> +		break;
> +	case Opt_undelete:
> +		uopt->flags |= (1 << UDF_FLAG_UNDELETE);
> +		break;

These two are nops so we should deprecate them and completely ignore them.
I'm writing it here mostly as a reminder to myself as a work item after the
conversion is done :)

> +	case Opt_noadinicb:
> +		uopt->flags &= ~(1 << UDF_FLAG_USE_AD_IN_ICB);
> +		break;
> +	case Opt_adinicb:
> +		uopt->flags |= (1 << UDF_FLAG_USE_AD_IN_ICB);
> +		break;
> +	case Opt_shortad:
> +		uopt->flags |= (1 << UDF_FLAG_USE_SHORT_AD);
> +		break;
> +	case Opt_longad:
> +		uopt->flags &= ~(1 << UDF_FLAG_USE_SHORT_AD);
> +		break;
> +	case Opt_gid:
> +		if (0 == kstrtoint(param->string, 10, &uv)) {
Nit:
		    ^^ I prefer "kstrtoint() == 0"

Otherwise looks good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

