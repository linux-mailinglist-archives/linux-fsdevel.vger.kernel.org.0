Return-Path: <linux-fsdevel+bounces-13298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E18186E4A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 16:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5DB1C22C05
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B247F70CBB;
	Fri,  1 Mar 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZUYjZh2B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Njz2vMVw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZUYjZh2B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Njz2vMVw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8571241A92;
	Fri,  1 Mar 2024 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308063; cv=none; b=V0MPvh6ZjLTluoNvyIh/bk7NqysHSzGzffjAmIOFe5ajhnUlrHebbbWLl4ZiBWUdShVNJcvnNS0T0/hIgWFfQ/TVF1g1piwq5432xf6iizRaabdh13862IBcquRJTrNEiMLn9AaNWVJvH+/Voh/8IbKVdfkwJQbw42Qd6UV60L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308063; c=relaxed/simple;
	bh=UbKKEL1rphpwXYNJhxPqYWQmsVIuTy1Je/zhOiQE+rg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XgqNCvHhIBSDlOhDt71LbtBiUiYlgTGUqMdpslAatpe200XsutdNORtWsTjBMkYVeCbmdG2zPh8uj9coeUvK5QXRWUIAwLJMfKvcZqmMI7NP9oKM1egoJxoJcCsbr5rgUGKk5so1UE1jBnIN0lHWuzFHVovq/Q0U13qt851OLQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZUYjZh2B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Njz2vMVw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZUYjZh2B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Njz2vMVw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1AA6333C1D;
	Fri,  1 Mar 2024 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709308059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52/83A0/AWTduQELOCqefhOgT0I/R+gHx6/VTGttMF0=;
	b=ZUYjZh2BNJSW5AkzZ3ZlouuZvUyfyvNHSf76o50yzJGSqAgYF7/jAqx0HgvRnOtkGurRqy
	Cj/eKp67j8S4yh++P4XCMAzf8yyxUkhYZrWfnG6i9e21vJRufqmD9qLH5pcp2/vxuoUTNx
	Y2fDfdTErUhz8BhkDvgOaJqif3ZbX2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709308059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52/83A0/AWTduQELOCqefhOgT0I/R+gHx6/VTGttMF0=;
	b=Njz2vMVwxy+5Ywh8aIY6fbVt941PiO8oEpQSFaXtp5Ano/7yQ/49L3FMQ/U3v8gLtL+8ZL
	jheXYJCjYGR271AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709308059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52/83A0/AWTduQELOCqefhOgT0I/R+gHx6/VTGttMF0=;
	b=ZUYjZh2BNJSW5AkzZ3ZlouuZvUyfyvNHSf76o50yzJGSqAgYF7/jAqx0HgvRnOtkGurRqy
	Cj/eKp67j8S4yh++P4XCMAzf8yyxUkhYZrWfnG6i9e21vJRufqmD9qLH5pcp2/vxuoUTNx
	Y2fDfdTErUhz8BhkDvgOaJqif3ZbX2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709308059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52/83A0/AWTduQELOCqefhOgT0I/R+gHx6/VTGttMF0=;
	b=Njz2vMVwxy+5Ywh8aIY6fbVt941PiO8oEpQSFaXtp5Ano/7yQ/49L3FMQ/U3v8gLtL+8ZL
	jheXYJCjYGR271AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 504D513A80;
	Fri,  1 Mar 2024 15:47:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kmlFEJr44WUbBAAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Fri, 01 Mar 2024 15:47:38 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id f956f462;
	Fri, 1 Mar 2024 15:47:37 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger
 <adilger.kernel@dilger.ca>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Jan Kara <jack@suse.cz>,  Miklos Szeredi <miklos@szeredi.hu>,  Amir
 Goldstein <amir73il@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-unionfs@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ext4: fix mount parameters check for empty values
In-Reply-To: <20240301-spalten-impfschutz-4118b8fcf5b3@brauner> (Christian
	Brauner's message of "Fri, 1 Mar 2024 14:36:55 +0100")
References: <20240229163011.16248-1-lhenriques@suse.de>
	<20240229163011.16248-3-lhenriques@suse.de>
	<20240301-spalten-impfschutz-4118b8fcf5b3@brauner>
Date: Fri, 01 Mar 2024 15:47:37 +0000
Message-ID: <87edcu9co6.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZUYjZh2B;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Njz2vMVw
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 FREEMAIL_CC(0.00)[mit.edu,dilger.ca,zeniv.linux.org.uk,suse.cz,szeredi.hu,gmail.com,vger.kernel.org];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -6.51
X-Rspamd-Queue-Id: 1AA6333C1D
X-Spam-Flag: NO

Christian Brauner <brauner@kernel.org> writes:

> On Thu, Feb 29, 2024 at 04:30:09PM +0000, Luis Henriques wrote:
>> Now that parameters that have the flag 'fs_param_can_be_empty' set and
>> their value is NULL are handled as 'flag' type, we need to properly check
>> for empty (NULL) values.
>>=20
>> Signed-off-by: Luis Henriques <lhenriques@suse.de>
>> ---
>>  fs/ext4/super.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 0f931d0c227d..44ba2212dfb3 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -2183,12 +2183,12 @@ static int ext4_parse_param(struct fs_context *f=
c, struct fs_parameter *param)
>>  	switch (token) {
>>  #ifdef CONFIG_QUOTA
>>  	case Opt_usrjquota:
>> -		if (!*param->string)
>> +		if (!param->string)
>>  			return unnote_qf_name(fc, USRQUOTA);
>
> I fail to understand how that can happen. Currently both of these
> options are parsed as strings via:
>
> #define fsparam_string_empty(NAME, OPT) \
>         __fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, N=
ULL)
>
>
> So if someone sets fsconfig(..., FSCONFIG_SET_STRING, "usrquota", NULL, .=
..)
> we give an immediate
>
>         case FSCONFIG_SET_STRING:
>                 if (!_key || !_value || aux) return -EINVAL;
>
> from fsconfig() so we know that param->string cannot be NULL. If that
> were the case we'd NULL deref in fs_param_is_string():
>
> int fs_param_is_string(struct p_log *log, const struct fs_parameter_spec =
*p,
>                        struct fs_parameter *param, struct fs_parse_result=
 *result)
> {
>         if (param->type !=3D fs_value_is_string ||
>             (!*param->string && !(p->flags & fs_param_can_be_empty)))
>
> So you're check above seems wrong. If I'm mistaken, please explain, how
> this can happen in detail.

I hope my reply to the previous patch helps clarifying this issue (which
is quite confusing, and I'm probably  the confused one!).  To summarize,
fsconfig() will (or can) get this parameter as a flag, not as string.

Cheers,
--=20
Lu=C3=ADs

