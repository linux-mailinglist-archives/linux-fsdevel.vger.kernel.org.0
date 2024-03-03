Return-Path: <linux-fsdevel+bounces-13400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4C286F732
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 22:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDEA0280DBC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 21:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A957A711;
	Sun,  3 Mar 2024 21:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x0VH/QCI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FdCxcHou";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x0VH/QCI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FdCxcHou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74399A957;
	Sun,  3 Mar 2024 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709501508; cv=none; b=MtVqK3XBBg/A30n/FNdA2rZOWTRj7terHMcMQKfkQUzv2ZAMgGAS0O8mjGK9/I20qqG50rDEhfymSCia8PfvMSt46XvvYULIp9lC0H6or42RDG76G65VBsMyDROEgpkpLKg9Z8PgeQyXSA6WFAUYRE8EfNja/dNYxnrvLJyIzSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709501508; c=relaxed/simple;
	bh=fY5ztgKOsgp0bspByqQGLWCtfCjV4GI9o1g+MXCzPjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A2uVDCoqv2EbP6zu4ZjS8pKtgGPK0fjZ3fV/xrbwDsx91HVXeukT7ewjEb1NMimEyljdlPcunseHjo8lP+xfj2ZqB4OhGLRRfPrwtF/EVnxEb0ZgN+70mNnaNT4HOoy8CGZts5ZRPcHHNVnkEVpC9zSPY9l2XqFRFJFAC5u2M4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x0VH/QCI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FdCxcHou; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x0VH/QCI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FdCxcHou; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E2FB67297;
	Sun,  3 Mar 2024 21:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709501504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkJiqbiMf74Wd7114p/uE8Bo/v9aDZ036gy7b9V5L6k=;
	b=x0VH/QCIDOOF7JLX5AXM+zZECMk/MIbP+KDGGuy11rScpA5xUiDRG3J/UTzRIQ7uBy1IUL
	hgTphll9//c6DRMkKUvMb4QFd9zhmkKCm4OHIzY8Iz6d21rcXQizx3ylCBVLli3brLG8BT
	v/OQvnPUMiEHFPkIG3nE+iIzXGqBLr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709501504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkJiqbiMf74Wd7114p/uE8Bo/v9aDZ036gy7b9V5L6k=;
	b=FdCxcHoudg8xjjpPRj9+PibyGIvSF/bTRQ+m6AckEhDuYSjc8kTZpGVKdoksXL72ENyDVl
	Xgj/RnChf8FfT8Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709501504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkJiqbiMf74Wd7114p/uE8Bo/v9aDZ036gy7b9V5L6k=;
	b=x0VH/QCIDOOF7JLX5AXM+zZECMk/MIbP+KDGGuy11rScpA5xUiDRG3J/UTzRIQ7uBy1IUL
	hgTphll9//c6DRMkKUvMb4QFd9zhmkKCm4OHIzY8Iz6d21rcXQizx3ylCBVLli3brLG8BT
	v/OQvnPUMiEHFPkIG3nE+iIzXGqBLr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709501504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkJiqbiMf74Wd7114p/uE8Bo/v9aDZ036gy7b9V5L6k=;
	b=FdCxcHoudg8xjjpPRj9+PibyGIvSF/bTRQ+m6AckEhDuYSjc8kTZpGVKdoksXL72ENyDVl
	Xgj/RnChf8FfT8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A17C1379D;
	Sun,  3 Mar 2024 21:31:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aVwVFj/s5GW2VAAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Sun, 03 Mar 2024 21:31:43 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 52a2cebe;
	Sun, 3 Mar 2024 21:31:42 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Sandeen <sandeen@sandeen.net>,  Theodore Ts'o <tytso@mit.edu>,
  Andreas Dilger <adilger.kernel@dilger.ca>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Jan Kara <jack@suse.cz>,  Miklos Szeredi
 <miklos@szeredi.hu>,  Amir Goldstein <amir73il@gmail.com>,
  linux-ext4@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-unionfs@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs_parser: handle parameters that can be empty and
 don't have a value
In-Reply-To: <20240302-lamellen-hauskatze-b36d3207d73d@brauner> (Christian
	Brauner's message of "Sat, 2 Mar 2024 18:56:51 +0100")
References: <20240229163011.16248-1-lhenriques@suse.de>
	<20240229163011.16248-2-lhenriques@suse.de>
	<20240301-gegossen-seestern-683681ea75d1@brauner>
	<87il269crs.fsf@suse.de>
	<20240302-avancieren-sehtest-90eb364bfcd5@brauner>
	<20240302-lamellen-hauskatze-b36d3207d73d@brauner>
Date: Sun, 03 Mar 2024 21:31:42 +0000
Message-ID: <87wmqj80jl.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 FREEMAIL_CC(0.00)[sandeen.net,mit.edu,dilger.ca,zeniv.linux.org.uk,suse.cz,szeredi.hu,gmail.com,vger.kernel.org];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Christian Brauner <brauner@kernel.org> writes:

> On Sat, Mar 02, 2024 at 12:46:41PM +0100, Christian Brauner wrote:
>> On Fri, Mar 01, 2024 at 03:45:27PM +0000, Luis Henriques wrote:
>> > Christian Brauner <brauner@kernel.org> writes:
>> >=20
>> > > On Thu, Feb 29, 2024 at 04:30:08PM +0000, Luis Henriques wrote:
>> > >> Currently, only parameters that have the fs_parameter_spec 'type' s=
et to
>> > >> NULL are handled as 'flag' types.  However, parameters that have the
>> > >> 'fs_param_can_be_empty' flag set and their value is NULL should als=
o be
>> > >> handled as 'flag' type, as their type is set to 'fs_value_is_flag'.
>> > >>=20
>> > >> Signed-off-by: Luis Henriques <lhenriques@suse.de>
>> > >> ---
>> > >>  fs/fs_parser.c | 3 ++-
>> > >>  1 file changed, 2 insertions(+), 1 deletion(-)
>> > >>=20
>> > >> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
>> > >> index edb3712dcfa5..53f6cb98a3e0 100644
>> > >> --- a/fs/fs_parser.c
>> > >> +++ b/fs/fs_parser.c
>> > >> @@ -119,7 +119,8 @@ int __fs_parse(struct p_log *log,
>> > >>  	/* Try to turn the type we were given into the type desired by the
>> > >>  	 * parameter and give an error if we can't.
>> > >>  	 */
>> > >> -	if (is_flag(p)) {
>> > >> +	if (is_flag(p) ||
>> > >> +	    (!param->string && (p->flags & fs_param_can_be_empty))) {
>> > >>  		if (param->type !=3D fs_value_is_flag)
>> > >>  			return inval_plog(log, "Unexpected value for '%s'",
>> > >>  				      param->key);
>> > >
>> > > If the parameter was derived from FSCONFIG_SET_STRING in fsconfig() =
then
>> > > param->string is guaranteed to not be NULL. So really this is only
>> > > about:
>> > >
>> > > FSCONFIG_SET_FD
>> > > FSCONFIG_SET_BINARY
>> > > FSCONFIG_SET_PATH
>> > > FSCONFIG_SET_PATH_EMPTY
>> > >
>> > > and those values being used without a value. What filesystem does th=
is?
>> > > I don't see any.
>> > >
>> > > The tempting thing to do here is to to just remove fs_param_can_be_e=
mpty
>> > > from every helper that isn't fs_param_is_string() until we actually =
have
>> > > a filesystem that wants to use any of the above as flags. Will lose a
>> > > lot of code that isn't currently used.
>> >=20
>> > Right, I find it quite confusing and I may be fixing the issue in the
>> > wrong place.  What I'm seeing with ext4 when I mount a filesystem using
>> > the option '-o usrjquota' is that fs_parse() will get:
>> >=20
>> >  * p->type is set to fs_param_is_string
>> >    ('p' is a struct fs_parameter_spec, ->type is a function)
>> >  * param->type is set to fs_value_is_flag
>> >    ('param' is a struct fs_parameter, ->type is an enum)
>> >=20
>> > This is because ext4 will use the __fsparam macro to set define a
>> > fs_param_spec as a fs_param_is_string but will also set the
>> > fs_param_can_be_empty; and the fsconfig() syscall will get that parame=
ter
>> > as a flag.  That's why param->string will be NULL in this case.
>>=20
>> Thanks for the details. Let me see if I get this right. So you're saying=
 that
>> someone is doing:
>>=20
>> fsconfig(..., FSCONFIG_SET_FLAG, "usrjquota", NULL, 0); // [1]
>>=20
>> ? Is so that is a vital part of the explanation. So please put that in t=
he
>> commit message.
>>=20
>> Then ext4 defines:
>>=20
>> 	fsparam_string_empty ("usrjquota",		Opt_usrjquota),
>>=20
>> So [1] gets us:
>>=20
>>         param->type =3D=3D fs_value_is_flag
>>         param->string =3D=3D NULL
>>=20
>> Now we enter into
>> fs_parse()
>> -> __fs_parse()
>>    -> fs_lookup_key() for @param and that does:
>>=20
>>         bool want_flag =3D param->type =3D=3D fs_value_is_flag;
>>=20
>>         *negated =3D false;
>>         for (p =3D desc; p->name; p++) {
>>                 if (strcmp(p->name, name) !=3D 0)
>>                         continue;
>>                 if (likely(is_flag(p) =3D=3D want_flag))
>>                         return p;
>>                 other =3D p;
>>         }
>>=20
>> So we don't have a flag parameter defined so the only real match we get =
is
>> @other for:
>>=20
>>         fsparam_string_empty ("usrjquota",		Opt_usrjquota),
>>=20
>> What happens now is that you call p->type =3D=3D fs_param_is_string() an=
d that
>> rejects it as bad parameter because param->type =3D=3D fs_value_is_flag =
!=3D
>> fs_value_is_string as required. So you dont end up getting Opt_userjquota
>> called with param->string NULL, right? So there's not NULL deref or anyt=
hing,
>> right?
>>=20
>> You just fail to set usrjquota. Ok, so I think the correct fix is to do
>> something like the following in ext4:
>>=20
>>         fsparam_string_empty ("usrjquota",      Opt_usrjquota),
>>         fs_param_flag        ("usrjquota",      Opt_usrjquota_flag),
>>=20
>> and then in the switch you can do:
>>=20
>> switch (opt)
>> case Opt_usrjquota:
>>         // string thing
>> case Opt_usrjquota_flag:
>>         // flag thing
>>=20
>> And I really think we should kill all empty handling for non-string type=
s and
>> only add that when there's a filesystem that actually needs it.
>
> So one option is to do the following:

Thanks a lot of your review (I forgot to thank you in my other reply!).

Now, I haven't yet tested this properly, but I think that's a much simpler
and cleaner way of fixing this issue.  Now, although it needs some
testing, I think the patch has one problem (see comment below).

Do you want me to send out a cleaned-up version[*] of it after some
testing (+ a similar fix for overlayfs)?  Or would you rather handle this
yourself?

(I'll probably won't be able to look into it until mid-week.)

[*] Obviously, keeping a notice that you were the original author.

> From 8bfb142e6caba70704998be072222d6a31d8b97b Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Sat, 2 Mar 2024 18:54:35 +0100
> Subject: [PATCH] [UNTESTED]
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/ext4/super.c           | 32 ++++++++++++++++++--------------
>  include/linux/fs_parser.h |  3 +++
>  2 files changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index ebd97442d1d4..bd625f06ec0f 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1724,10 +1724,6 @@ static const struct constant_table ext4_param_dax[=
] =3D {
>  	{}
>  };
>=20=20
> -/* String parameter that allows empty argument */
> -#define fsparam_string_empty(NAME, OPT) \
> -	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
> -
>  /*
>   * Mount option specification
>   * We don't use fsparam_flag_no because of the way we set the
> @@ -1768,10 +1764,8 @@ static const struct fs_parameter_spec ext4_param_s=
pecs[] =3D {
>  	fsparam_enum	("data",		Opt_data, ext4_param_data),
>  	fsparam_enum	("data_err",		Opt_data_err,
>  						ext4_param_data_err),
> -	fsparam_string_empty
> -			("usrjquota",		Opt_usrjquota),
> -	fsparam_string_empty
> -			("grpjquota",		Opt_grpjquota),
> +	fsparam_string_or_flag ("usrjquota",	Opt_usrjquota),
> +	fsparam_string_or_flag ("grpjquota",	Opt_grpjquota),
>  	fsparam_enum	("jqfmt",		Opt_jqfmt, ext4_param_jqfmt),
>  	fsparam_flag	("grpquota",		Opt_grpquota),
>  	fsparam_flag	("quota",		Opt_quota),
> @@ -2183,15 +2177,25 @@ static int ext4_parse_param(struct fs_context *fc=
, struct fs_parameter *param)
>  	switch (token) {
>  #ifdef CONFIG_QUOTA
>  	case Opt_usrjquota:
> -		if (!param->string)
> -			return unnote_qf_name(fc, USRQUOTA);
> -		else
> +		if (param->type =3D=3D fs_value_is_string) {
> +			if (!*param->string)
> +				return unnote_qf_name(fc, USRQUOTA);
> +
>  			return note_qf_name(fc, USRQUOTA, param);
> +		}
> +
> +		// param->type =3D=3D fs_value_is_flag
> +		return note_qf_name(fc, USRQUOTA, param);
                       ^^^^^^^^^^^^
I think this isn't correct -- the correct function to call in this case is
unnote_qf_name(), not note_qf_name().  The same comment applies to the
grpjquota parameter handling.

Cheers,
--=20
Lu=C3=ADs

>  	case Opt_grpjquota:
> -		if (!param->string)
> -			return unnote_qf_name(fc, GRPQUOTA);
> -		else
> +		if (param->type =3D=3D fs_value_is_string) {
> +			if (!*param->string)
> +				return unnote_qf_name(fc, GRPQUOTA);
> +
>  			return note_qf_name(fc, GRPQUOTA, param);
> +		}
> +
> +		// param->type =3D=3D fs_value_is_flag
> +		return note_qf_name(fc, GRPQUOTA, param);
>  #endif
>  	case Opt_sb:
>  		if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
> diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
> index 01542c4b87a2..4f45141bea95 100644
> --- a/include/linux/fs_parser.h
> +++ b/include/linux/fs_parser.h
> @@ -131,5 +131,8 @@ static inline bool fs_validate_description(const char=
 *name,
>  #define fsparam_bdev(NAME, OPT)	__fsparam(fs_param_is_blockdev, NAME, OP=
T, 0, NULL)
>  #define fsparam_path(NAME, OPT)	__fsparam(fs_param_is_path, NAME, OPT, 0=
, NULL)
>  #define fsparam_fd(NAME, OPT)	__fsparam(fs_param_is_fd, NAME, OPT, 0, NU=
LL)
> +#define fsparam_string_or_flag(NAME, OPT) \
> +	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL), \
> +	fsparam_flag(NAME, OPT)
>=20=20
>  #endif /* _LINUX_FS_PARSER_H */
> --=20
>
> 2.43.0
>


