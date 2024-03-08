Return-Path: <linux-fsdevel+bounces-13989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C338761A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 11:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242F71C20D4B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017D554656;
	Fri,  8 Mar 2024 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GaKzFj7I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wENk/LPU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GaKzFj7I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wENk/LPU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5295B53E25;
	Fri,  8 Mar 2024 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892740; cv=none; b=DkAyRcf3ABoKQ2AG0VqpYAqOOPAELhQNV18HSDk+vMjypF1CqcvStn1XyRRVZXf2Y9yX8dyzvs5YaQja3mG4SreUvHqEYgi3yJMkvx56S+mYxTKOAr558e+RUdZ2pCSaNhMHG/WJ/l7HNAboiLWs0/K6tZ3cypuY51DroGWRwiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892740; c=relaxed/simple;
	bh=Wz2A9QM2895tOh012bS0E9vsQilm32L7GQVtgm+Jjys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WRTvq6SCdR1DCwmCCWe6pHgsrCkTaRE81ONWWTOFEMXmQBVLeHtkdRt6Ew5eDRYxRCI/2wQsu0kgViMTrt4ainW3zh3QzoD7XCgndwYiYckeDV+IyV3iiKqEbhm/tkrxYwxfRvbkzGYBDc7wc4YK69JDAtAppx2uzXXqGmekyTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GaKzFj7I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wENk/LPU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GaKzFj7I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wENk/LPU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C9535CD52;
	Fri,  8 Mar 2024 10:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709892735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F83dB1El6NnXAYCOZALOa4N69Sh5FR4UmucfTsrTsNo=;
	b=GaKzFj7I81piiDDKlygc08CyYgB8NmdeIFW+oJR/kP2SIlKgF0mcc66AfQ8l7xLz1zUjyK
	bIiD9V83I3+XL4cPoOCrTa2YHbvVo4BZTvzPGPBJ/RAUF0NDrtR/G8hO1Zu8rLBgUc4BRM
	dg/RUQnOr55LzSZzGE/GPZdIbaH/Qwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709892735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F83dB1El6NnXAYCOZALOa4N69Sh5FR4UmucfTsrTsNo=;
	b=wENk/LPU+jOKsKhv8KC+Go9ydZtF3RvlAJN55lm/1CR4YNlPcMRHdERz1yYh93Wz01jg0J
	sh5iDz5Xn4oMorCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709892735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F83dB1El6NnXAYCOZALOa4N69Sh5FR4UmucfTsrTsNo=;
	b=GaKzFj7I81piiDDKlygc08CyYgB8NmdeIFW+oJR/kP2SIlKgF0mcc66AfQ8l7xLz1zUjyK
	bIiD9V83I3+XL4cPoOCrTa2YHbvVo4BZTvzPGPBJ/RAUF0NDrtR/G8hO1Zu8rLBgUc4BRM
	dg/RUQnOr55LzSZzGE/GPZdIbaH/Qwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709892735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F83dB1El6NnXAYCOZALOa4N69Sh5FR4UmucfTsrTsNo=;
	b=wENk/LPU+jOKsKhv8KC+Go9ydZtF3RvlAJN55lm/1CR4YNlPcMRHdERz1yYh93Wz01jg0J
	sh5iDz5Xn4oMorCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B67513310;
	Fri,  8 Mar 2024 10:12:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /u7gGn7k6mWpagAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Fri, 08 Mar 2024 10:12:14 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 3cdf35d3;
	Fri, 8 Mar 2024 10:12:13 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,  Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger
 <adilger.kernel@dilger.ca>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein <amir73il@gmail.com>,
  linux-ext4@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-unionfs@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs_parser: handle parameters that can be empty and
 don't have a value
In-Reply-To: <20240308-fahrdienst-torten-eae8f3eed3b4@brauner> (Christian
	Brauner's message of "Fri, 8 Mar 2024 10:53:25 +0100")
References: <20240229163011.16248-1-lhenriques@suse.de>
	<20240229163011.16248-2-lhenriques@suse.de>
	<20240301-gegossen-seestern-683681ea75d1@brauner>
	<87il269crs.fsf@suse.de> <20240307151356.ishrtxrsge2i5mjn@quack3>
	<20240308-fahrdienst-torten-eae8f3eed3b4@brauner>
Date: Fri, 08 Mar 2024 10:12:13 +0000
Message-ID: <87a5n9t4le.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 FREEMAIL_CC(0.00)[suse.cz,mit.edu,dilger.ca,zeniv.linux.org.uk,szeredi.hu,gmail.com,vger.kernel.org];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.10
X-Spam-Flag: NO

Christian Brauner <brauner@kernel.org> writes:

> On Thu, Mar 07, 2024 at 04:13:56PM +0100, Jan Kara wrote:
>> On Fri 01-03-24 15:45:27, Luis Henriques wrote:
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
>> So I'm a bit confused here. Valid variants of these quota options are li=
ke
>> "usrjquota=3D<filename>" (to set quota file name) or "usrjquota=3D" (to =
clear
>> quota file name). The variant "usrjquota" should ideally be rejected
>> because it doesn't make a good sense and only adds to confusion. Now as =
far
>> as I'm reading fs/ext4/super.c: parse_options() (and as far as my testing
>> shows) this is what is happening so what is exactly the problem you're
>> trying to fix?
>
> mount(8) has no way of easily knowing that for something like
> mount -o usrjquota /dev/sda1 /mnt that "usrjquota" is supposed to be
> set as an empty string via FSCONFIG_SET_STRING. For mount(8) it is
> indistinguishable from a flag because it's specified without an
> argument. So mount(8) passes FSCONFIG_SET_FLAG and it seems strange that
> we should require mount(8) to know what mount options are strings or no.
> I've ran into this issue before myself when using the mount api
> programatically.

Right.  A simple usecase is to try to do:

  mount -t ext4 -o usrjquota=3D /dev/sda1 /mnt/

It will fail, and this has been broken for a while.

(And btw: email here is broken again -- I haven't received Jan's email
yet.  And this reply will likely take a while to reach its recipients.)

Cheers,
--=20
Lu=C3=ADs

