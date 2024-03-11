Return-Path: <linux-fsdevel+bounces-14118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F747877E17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 11:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2631F2250D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 10:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7EC2C68A;
	Mon, 11 Mar 2024 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xGMqr62q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="heVgMOLh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xGMqr62q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="heVgMOLh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670F638DE5;
	Mon, 11 Mar 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710152775; cv=none; b=Yfi+UdJN/kRbwT5K5yeGI9Rgx+lJBynYP5XBB+yB+3pypq5UFOh8Sx94EpMfAAmWua2Y+D9WVx0rFOve+W0F80lmrxSzrHNqdoi2CBegOJigcckucAx1/iX6THpmel6wxGl/OR/GICyYIe88R8CNlUB6wLppMIT/E/zcqMoXXKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710152775; c=relaxed/simple;
	bh=gTxTKxq7hX6ZKCzKmQvyu5Rv591nK7Dcm5TczUYz1GQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gv6GXPj6ZTe8nI0gazxPWTpWEkIYSN0ETSGZR8U/UTj7X5/DiUW5oGPp/qoKz/xLwxDa4lNqp6QFlVzo4EecXq89lHvhHZPy7mfrJFNfFov+wNEYR7xm3fpm1Kv1DzaSJ0ocomxEaZgJJna/lbw7QXBr4NaTo4a2GeYcaBAIp9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xGMqr62q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=heVgMOLh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xGMqr62q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=heVgMOLh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 81F7B2216C;
	Mon, 11 Mar 2024 10:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710152771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNM87c4Pty4kQiOcgpWbP50DmgrTMGqlSYmym96AgQA=;
	b=xGMqr62qCiz4yIvIN3++w6xKIzmJdJWxQKc0ICWl90bZER3GzEftkgou93bFwoOgCsfLMp
	KufSd4spThqa1key/tUMzWfYqt8y5pIyFNCyUwZsSV7NNrQ654KFSuvrKkHrObUguP3Wa5
	7o8STw/235cNhcwS3SYwb9/F2s4VTcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710152771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNM87c4Pty4kQiOcgpWbP50DmgrTMGqlSYmym96AgQA=;
	b=heVgMOLhP3IqOVq8cNg7apUdg0nDMfh3C8jMHwoK4GaahABQ8fZicHWnBnCv7B7iqL1eYm
	BknV/ThzSjaSIyDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710152771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNM87c4Pty4kQiOcgpWbP50DmgrTMGqlSYmym96AgQA=;
	b=xGMqr62qCiz4yIvIN3++w6xKIzmJdJWxQKc0ICWl90bZER3GzEftkgou93bFwoOgCsfLMp
	KufSd4spThqa1key/tUMzWfYqt8y5pIyFNCyUwZsSV7NNrQ654KFSuvrKkHrObUguP3Wa5
	7o8STw/235cNhcwS3SYwb9/F2s4VTcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710152771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNM87c4Pty4kQiOcgpWbP50DmgrTMGqlSYmym96AgQA=;
	b=heVgMOLhP3IqOVq8cNg7apUdg0nDMfh3C8jMHwoK4GaahABQ8fZicHWnBnCv7B7iqL1eYm
	BknV/ThzSjaSIyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7983136BA;
	Mon, 11 Mar 2024 10:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aOiUKULc7mUvGgAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Mon, 11 Mar 2024 10:26:10 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id eb1f437d;
	Mon, 11 Mar 2024 10:26:05 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,  Theodore Ts'o <tytso@mit.edu>,
  Andreas Dilger <adilger.kernel@dilger.ca>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Miklos Szeredi <miklos@szeredi.hu>,  Amir
 Goldstein <amir73il@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-unionfs@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs_parser: handle parameters that can be empty and
 don't have a value
In-Reply-To: <20240308230911.r5a4xn6f5vp24hil@quack3> (Jan Kara's message of
	"Sat, 9 Mar 2024 00:09:11 +0100")
References: <20240229163011.16248-1-lhenriques@suse.de>
	<20240229163011.16248-2-lhenriques@suse.de>
	<20240301-gegossen-seestern-683681ea75d1@brauner>
	<87il269crs.fsf@suse.de> <20240307151356.ishrtxrsge2i5mjn@quack3>
	<20240308-fahrdienst-torten-eae8f3eed3b4@brauner>
	<87a5n9t4le.fsf@suse.de> <20240308230911.r5a4xn6f5vp24hil@quack3>
Date: Mon, 11 Mar 2024 10:26:05 +0000
Message-ID: <87r0gh6p4y.fsf@suse.de>
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
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 FREEMAIL_CC(0.00)[kernel.org,mit.edu,dilger.ca,zeniv.linux.org.uk,szeredi.hu,gmail.com,vger.kernel.org];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Jan Kara <jack@suse.cz> writes:

> On Fri 08-03-24 10:12:13, Luis Henriques wrote:
>> Christian Brauner <brauner@kernel.org> writes:
>>=20
>> > On Thu, Mar 07, 2024 at 04:13:56PM +0100, Jan Kara wrote:
>> >> On Fri 01-03-24 15:45:27, Luis Henriques wrote:
>> >> > Christian Brauner <brauner@kernel.org> writes:
>> >> >=20
>> >> > > On Thu, Feb 29, 2024 at 04:30:08PM +0000, Luis Henriques wrote:
>> >> > >> Currently, only parameters that have the fs_parameter_spec 'type=
' set to
>> >> > >> NULL are handled as 'flag' types.  However, parameters that have=
 the
>> >> > >> 'fs_param_can_be_empty' flag set and their value is NULL should =
also be
>> >> > >> handled as 'flag' type, as their type is set to 'fs_value_is_fla=
g'.
>> >> > >>=20
>> >> > >> Signed-off-by: Luis Henriques <lhenriques@suse.de>
>> >> > >> ---
>> >> > >>  fs/fs_parser.c | 3 ++-
>> >> > >>  1 file changed, 2 insertions(+), 1 deletion(-)
>> >> > >>=20
>> >> > >> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
>> >> > >> index edb3712dcfa5..53f6cb98a3e0 100644
>> >> > >> --- a/fs/fs_parser.c
>> >> > >> +++ b/fs/fs_parser.c
>> >> > >> @@ -119,7 +119,8 @@ int __fs_parse(struct p_log *log,
>> >> > >>  	/* Try to turn the type we were given into the type desired by=
 the
>> >> > >>  	 * parameter and give an error if we can't.
>> >> > >>  	 */
>> >> > >> -	if (is_flag(p)) {
>> >> > >> +	if (is_flag(p) ||
>> >> > >> +	    (!param->string && (p->flags & fs_param_can_be_empty))) {
>> >> > >>  		if (param->type !=3D fs_value_is_flag)
>> >> > >>  			return inval_plog(log, "Unexpected value for '%s'",
>> >> > >>  				      param->key);
>> >> > >
>> >> > > If the parameter was derived from FSCONFIG_SET_STRING in fsconfig=
() then
>> >> > > param->string is guaranteed to not be NULL. So really this is only
>> >> > > about:
>> >> > >
>> >> > > FSCONFIG_SET_FD
>> >> > > FSCONFIG_SET_BINARY
>> >> > > FSCONFIG_SET_PATH
>> >> > > FSCONFIG_SET_PATH_EMPTY
>> >> > >
>> >> > > and those values being used without a value. What filesystem does=
 this?
>> >> > > I don't see any.
>> >> > >
>> >> > > The tempting thing to do here is to to just remove fs_param_can_b=
e_empty
>> >> > > from every helper that isn't fs_param_is_string() until we actual=
ly have
>> >> > > a filesystem that wants to use any of the above as flags. Will lo=
se a
>> >> > > lot of code that isn't currently used.
>> >> >=20
>> >> > Right, I find it quite confusing and I may be fixing the issue in t=
he
>> >> > wrong place.  What I'm seeing with ext4 when I mount a filesystem u=
sing
>> >> > the option '-o usrjquota' is that fs_parse() will get:
>> >> >=20
>> >> >  * p->type is set to fs_param_is_string
>> >> >    ('p' is a struct fs_parameter_spec, ->type is a function)
>> >> >  * param->type is set to fs_value_is_flag
>> >> >    ('param' is a struct fs_parameter, ->type is an enum)
>> >> >=20
>> >> > This is because ext4 will use the __fsparam macro to set define a
>> >> > fs_param_spec as a fs_param_is_string but will also set the
>> >> > fs_param_can_be_empty; and the fsconfig() syscall will get that par=
ameter
>> >> > as a flag.  That's why param->string will be NULL in this case.
>> >>=20
>> >> So I'm a bit confused here. Valid variants of these quota options are=
 like
>> >> "usrjquota=3D<filename>" (to set quota file name) or "usrjquota=3D" (=
to clear
>> >> quota file name). The variant "usrjquota" should ideally be rejected
>> >> because it doesn't make a good sense and only adds to confusion. Now =
as far
>> >> as I'm reading fs/ext4/super.c: parse_options() (and as far as my tes=
ting
>> >> shows) this is what is happening so what is exactly the problem you're
>> >> trying to fix?
>> >
>> > mount(8) has no way of easily knowing that for something like
>> > mount -o usrjquota /dev/sda1 /mnt that "usrjquota" is supposed to be
>> > set as an empty string via FSCONFIG_SET_STRING. For mount(8) it is
>> > indistinguishable from a flag because it's specified without an
>> > argument. So mount(8) passes FSCONFIG_SET_FLAG and it seems strange th=
at
>> > we should require mount(8) to know what mount options are strings or n=
o.
>> > I've ran into this issue before myself when using the mount api
>> > programatically.
>>=20
>> Right.  A simple usecase is to try to do:
>>=20
>>   mount -t ext4 -o usrjquota=3D /dev/sda1 /mnt/
>>=20
>> It will fail, and this has been broken for a while.
>
> I see. But you have to have new enough mount that is using fsconfig, don't
> you? Because for me in my test VM this works just fine...

Oh, interesting.  FTR I'm using mount from util-linux 2.39.3, but I
haven't tried this with older versions.

Cheers,
--=20
Lu=C3=ADs


>
> But anyway, I get the point. Thanks for educating me :)
>
> 								Honza
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

