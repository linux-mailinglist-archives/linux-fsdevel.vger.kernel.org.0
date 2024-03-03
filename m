Return-Path: <linux-fsdevel+bounces-13399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C0886F72A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 22:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BB11F210F7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 21:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8477A70B;
	Sun,  3 Mar 2024 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T2U7VoZG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZxpMKeKP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T2U7VoZG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZxpMKeKP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9060C883C;
	Sun,  3 Mar 2024 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709500651; cv=none; b=V3SA/8sMtUXIBSbvoZIF8I8BpfzzmCJZxuGyhQiXYg788FLmM/W+A5NL6hOi7mkNtmIjOpKmF00aiojvNQRZjvpaqwxuOvcR4oY0NgFjUsq/IGoshrZu7DaFU2+iIYMglVrBd8eTU19Mc21etSphrM5DuBx5ZIFM8yMGAIAq+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709500651; c=relaxed/simple;
	bh=90rsFaUvU4p11hyAZn6SW109fs1X50un485uas0bB/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FDaqfWqrvCzpzM/2HfhEp5bQmC5KJixyhor139sBQmkZtnl1EjyxPO/Nzyhi3rUOX3tDtgliddRihBl8GfORtZc0FfHvBQwC8Cjo1u3zEbi8xZ1L+VUFKSzHkBwieXE0hmyQrlZspWxzZOeb8aAwAtpTa/w3bPkiMceIm2oF2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T2U7VoZG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZxpMKeKP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T2U7VoZG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZxpMKeKP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AFBBA3FA31;
	Sun,  3 Mar 2024 21:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709500647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3oZ+8HS/j/n7WwUT7zGmsgBnZucInUNE/8oUtbL/mI=;
	b=T2U7VoZGiiQ5oRx6kPy9k//N8iETyGYUIJ6IhyUHF+x6mBQlbeb50cUbG8mCy2uvke4jhZ
	ku0mqIGHYMj/I6rmkqcynWu0xoHMJ2o1qS/ljTBHPBuPIQHgbU49zUQZQjKouLAWsZaPso
	q7QDoY6Za6DaIWbIvWHHLK3N6JJS5ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709500647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3oZ+8HS/j/n7WwUT7zGmsgBnZucInUNE/8oUtbL/mI=;
	b=ZxpMKeKPvAbfpWvC4q6cInd3fdqgplf084gGrCOptWUeOy+htp/vXeFbv0OJNOcq+Gu6WU
	dgILG/BszCFi/NBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709500647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3oZ+8HS/j/n7WwUT7zGmsgBnZucInUNE/8oUtbL/mI=;
	b=T2U7VoZGiiQ5oRx6kPy9k//N8iETyGYUIJ6IhyUHF+x6mBQlbeb50cUbG8mCy2uvke4jhZ
	ku0mqIGHYMj/I6rmkqcynWu0xoHMJ2o1qS/ljTBHPBuPIQHgbU49zUQZQjKouLAWsZaPso
	q7QDoY6Za6DaIWbIvWHHLK3N6JJS5ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709500647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3oZ+8HS/j/n7WwUT7zGmsgBnZucInUNE/8oUtbL/mI=;
	b=ZxpMKeKPvAbfpWvC4q6cInd3fdqgplf084gGrCOptWUeOy+htp/vXeFbv0OJNOcq+Gu6WU
	dgILG/BszCFi/NBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C29211379D;
	Sun,  3 Mar 2024 21:17:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aJvLK+bo5GWFUQAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Sun, 03 Mar 2024 21:17:26 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 2709e7ed;
	Sun, 3 Mar 2024 21:17:25 +0000 (UTC)
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
In-Reply-To: <20240302-avancieren-sehtest-90eb364bfcd5@brauner> (Christian
	Brauner's message of "Sat, 2 Mar 2024 12:46:41 +0100")
References: <20240229163011.16248-1-lhenriques@suse.de>
	<20240229163011.16248-2-lhenriques@suse.de>
	<20240301-gegossen-seestern-683681ea75d1@brauner>
	<87il269crs.fsf@suse.de>
	<20240302-avancieren-sehtest-90eb364bfcd5@brauner>
Date: Sun, 03 Mar 2024 21:17:25 +0000
Message-ID: <871q8r9fru.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
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

> On Fri, Mar 01, 2024 at 03:45:27PM +0000, Luis Henriques wrote:
>> Christian Brauner <brauner@kernel.org> writes:
>>=20
>> > On Thu, Feb 29, 2024 at 04:30:08PM +0000, Luis Henriques wrote:
>> >> Currently, only parameters that have the fs_parameter_spec 'type' set=
 to
>> >> NULL are handled as 'flag' types.  However, parameters that have the
>> >> 'fs_param_can_be_empty' flag set and their value is NULL should also =
be
>> >> handled as 'flag' type, as their type is set to 'fs_value_is_flag'.
>> >>=20
>> >> Signed-off-by: Luis Henriques <lhenriques@suse.de>
>> >> ---
>> >>  fs/fs_parser.c | 3 ++-
>> >>  1 file changed, 2 insertions(+), 1 deletion(-)
>> >>=20
>> >> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
>> >> index edb3712dcfa5..53f6cb98a3e0 100644
>> >> --- a/fs/fs_parser.c
>> >> +++ b/fs/fs_parser.c
>> >> @@ -119,7 +119,8 @@ int __fs_parse(struct p_log *log,
>> >>  	/* Try to turn the type we were given into the type desired by the
>> >>  	 * parameter and give an error if we can't.
>> >>  	 */
>> >> -	if (is_flag(p)) {
>> >> +	if (is_flag(p) ||
>> >> +	    (!param->string && (p->flags & fs_param_can_be_empty))) {
>> >>  		if (param->type !=3D fs_value_is_flag)
>> >>  			return inval_plog(log, "Unexpected value for '%s'",
>> >>  				      param->key);
>> >
>> > If the parameter was derived from FSCONFIG_SET_STRING in fsconfig() th=
en
>> > param->string is guaranteed to not be NULL. So really this is only
>> > about:
>> >
>> > FSCONFIG_SET_FD
>> > FSCONFIG_SET_BINARY
>> > FSCONFIG_SET_PATH
>> > FSCONFIG_SET_PATH_EMPTY
>> >
>> > and those values being used without a value. What filesystem does this?
>> > I don't see any.
>> >
>> > The tempting thing to do here is to to just remove fs_param_can_be_emp=
ty
>> > from every helper that isn't fs_param_is_string() until we actually ha=
ve
>> > a filesystem that wants to use any of the above as flags. Will lose a
>> > lot of code that isn't currently used.
>>=20
>> Right, I find it quite confusing and I may be fixing the issue in the
>> wrong place.  What I'm seeing with ext4 when I mount a filesystem using
>> the option '-o usrjquota' is that fs_parse() will get:
>>=20
>>  * p->type is set to fs_param_is_string
>>    ('p' is a struct fs_parameter_spec, ->type is a function)
>>  * param->type is set to fs_value_is_flag
>>    ('param' is a struct fs_parameter, ->type is an enum)
>>=20
>> This is because ext4 will use the __fsparam macro to set define a
>> fs_param_spec as a fs_param_is_string but will also set the
>> fs_param_can_be_empty; and the fsconfig() syscall will get that parameter
>> as a flag.  That's why param->string will be NULL in this case.
>
> Thanks for the details. Let me see if I get this right. So you're saying =
that
> someone is doing:
>
> fsconfig(..., FSCONFIG_SET_FLAG, "usrjquota", NULL, 0); // [1]
>
> ? Is so that is a vital part of the explanation. So please put that in the
> commit message.

Right, I guess I should have added a simple usecase for that in the commit
message.  I.e. add a simple 'mount' command with this parameter without
any value.

> Then ext4 defines:
>
> 	fsparam_string_empty ("usrjquota",		Opt_usrjquota),
>
> So [1] gets us:
>
>         param->type =3D=3D fs_value_is_flag
>         param->string =3D=3D NULL
>
> Now we enter into
> fs_parse()
> -> __fs_parse()
>    -> fs_lookup_key() for @param and that does:
>
>         bool want_flag =3D param->type =3D=3D fs_value_is_flag;
>
>         *negated =3D false;
>         for (p =3D desc; p->name; p++) {
>                 if (strcmp(p->name, name) !=3D 0)
>                         continue;
>                 if (likely(is_flag(p) =3D=3D want_flag))
>                         return p;
>                 other =3D p;
>         }
>
> So we don't have a flag parameter defined so the only real match we get is
> @other for:
>
>         fsparam_string_empty ("usrjquota",		Opt_usrjquota),
>
> What happens now is that you call p->type =3D=3D fs_param_is_string() and=
 that
> rejects it as bad parameter because param->type =3D=3D fs_value_is_flag !=
=3D
> fs_value_is_string as required. So you dont end up getting Opt_userjquota
> called with param->string NULL, right? So there's not NULL deref or anyth=
ing,
> right?
>
> You just fail to set usrjquota. Ok, so I think the correct fix is to do
> something like the following in ext4:
>
>         fsparam_string_empty ("usrjquota",      Opt_usrjquota),
>         fs_param_flag        ("usrjquota",      Opt_usrjquota_flag),
>
> and then in the switch you can do:
>
> switch (opt)
> case Opt_usrjquota:
>         // string thing
> case Opt_usrjquota_flag:
>         // flag thing
>
> And I really think we should kill all empty handling for non-string types=
 and
> only add that when there's a filesystem that actually needs it.

Yeah, that looks like the right fix.  I see you sent out a patch doing
something like this, so I'll comment there instead.

Cheers,
--=20
Lu=C3=ADs

