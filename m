Return-Path: <linux-fsdevel+bounces-13436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A9F86FCA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 10:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C7D1F23146
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 09:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5E91B7F9;
	Mon,  4 Mar 2024 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKwLK1Ko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B231B277;
	Mon,  4 Mar 2024 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543067; cv=none; b=hFeCWeQ+2quwLOmAWijhPJcjKv313MkwwY8uBpOHSK2nJxxJxuahwIfMlHGYv6MleTWNoMJLFng0AzgyHwzm5f+0er7RzMPj0/TSZ0erFAHZmIsQY6D6kcu/cDhmGSWzap7vpeBTP8SKvnUvMp6UjXzN17li8qp1xJtAYFBLZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543067; c=relaxed/simple;
	bh=UCM0pJ0SapiYzbJ580UWI0Y0kfo0DrJqJnUfk88E47w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtPfHd7C/V/jgl8W8spzf+cWBT1UvUuv0fop2ybNPPYUxfVC+tPmbZIfGZr/4JuyW5odplQYoXix7KmFcNcBHPjKttMZ3lVNJyO4D0ZWebfPu6Lryz6j2VFXjHItBtD8TWMSh1rBYQFDK0F3i5Yl6S9UcZFim288A4wi5w6p+WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKwLK1Ko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AC3C433F1;
	Mon,  4 Mar 2024 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709543067;
	bh=UCM0pJ0SapiYzbJ580UWI0Y0kfo0DrJqJnUfk88E47w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKwLK1KovmqLCtRqFADlKInVG7HY7pmbRTyqwytWLsDtcuNUEPBWnB0EDykxjWI10
	 oTIw//xYISoqYXhUu3/lu/31/XuNmizyS2TMbU8m7fL2KuPDdirc0qqdBEMbP7mIqL
	 9Je12yBP8IvpCzPz1FdSDUoV+c/gsXzg0Ji05sr0Tslj9tUorAgITzEUMS4xryLQ7M
	 LBtTTnSHe331Bhn2C6/MA2ggrGiVKJCC4fH/UInd4qeMkYZ+Ej/38JRiXI3Fv5JrzA
	 f9Z24nucYt3c6b3QwmDpSLN8sR8X5dM19ABneIw+JG0RJBpeuKVB/sHL/4LMqmP3hX
	 CEYQHlb3DIe9A==
Date: Mon, 4 Mar 2024 10:04:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Luis Henriques <lhenriques@suse.de>
Cc: Eric Sandeen <sandeen@sandeen.net>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs_parser: handle parameters that can be empty and
 don't have a value
Message-ID: <20240304-werkvertrag-modifikation-2ea095766970@brauner>
References: <20240229163011.16248-1-lhenriques@suse.de>
 <20240229163011.16248-2-lhenriques@suse.de>
 <20240301-gegossen-seestern-683681ea75d1@brauner>
 <87il269crs.fsf@suse.de>
 <20240302-avancieren-sehtest-90eb364bfcd5@brauner>
 <20240302-lamellen-hauskatze-b36d3207d73d@brauner>
 <87wmqj80jl.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmqj80jl.fsf@suse.de>

On Sun, Mar 03, 2024 at 09:31:42PM +0000, Luis Henriques wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Sat, Mar 02, 2024 at 12:46:41PM +0100, Christian Brauner wrote:
> >> On Fri, Mar 01, 2024 at 03:45:27PM +0000, Luis Henriques wrote:
> >> > Christian Brauner <brauner@kernel.org> writes:
> >> > 
> >> > > On Thu, Feb 29, 2024 at 04:30:08PM +0000, Luis Henriques wrote:
> >> > >> Currently, only parameters that have the fs_parameter_spec 'type' set to
> >> > >> NULL are handled as 'flag' types.  However, parameters that have the
> >> > >> 'fs_param_can_be_empty' flag set and their value is NULL should also be
> >> > >> handled as 'flag' type, as their type is set to 'fs_value_is_flag'.
> >> > >> 
> >> > >> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> >> > >> ---
> >> > >>  fs/fs_parser.c | 3 ++-
> >> > >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> > >> 
> >> > >> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> >> > >> index edb3712dcfa5..53f6cb98a3e0 100644
> >> > >> --- a/fs/fs_parser.c
> >> > >> +++ b/fs/fs_parser.c
> >> > >> @@ -119,7 +119,8 @@ int __fs_parse(struct p_log *log,
> >> > >>  	/* Try to turn the type we were given into the type desired by the
> >> > >>  	 * parameter and give an error if we can't.
> >> > >>  	 */
> >> > >> -	if (is_flag(p)) {
> >> > >> +	if (is_flag(p) ||
> >> > >> +	    (!param->string && (p->flags & fs_param_can_be_empty))) {
> >> > >>  		if (param->type != fs_value_is_flag)
> >> > >>  			return inval_plog(log, "Unexpected value for '%s'",
> >> > >>  				      param->key);
> >> > >
> >> > > If the parameter was derived from FSCONFIG_SET_STRING in fsconfig() then
> >> > > param->string is guaranteed to not be NULL. So really this is only
> >> > > about:
> >> > >
> >> > > FSCONFIG_SET_FD
> >> > > FSCONFIG_SET_BINARY
> >> > > FSCONFIG_SET_PATH
> >> > > FSCONFIG_SET_PATH_EMPTY
> >> > >
> >> > > and those values being used without a value. What filesystem does this?
> >> > > I don't see any.
> >> > >
> >> > > The tempting thing to do here is to to just remove fs_param_can_be_empty
> >> > > from every helper that isn't fs_param_is_string() until we actually have
> >> > > a filesystem that wants to use any of the above as flags. Will lose a
> >> > > lot of code that isn't currently used.
> >> > 
> >> > Right, I find it quite confusing and I may be fixing the issue in the
> >> > wrong place.  What I'm seeing with ext4 when I mount a filesystem using
> >> > the option '-o usrjquota' is that fs_parse() will get:
> >> > 
> >> >  * p->type is set to fs_param_is_string
> >> >    ('p' is a struct fs_parameter_spec, ->type is a function)
> >> >  * param->type is set to fs_value_is_flag
> >> >    ('param' is a struct fs_parameter, ->type is an enum)
> >> > 
> >> > This is because ext4 will use the __fsparam macro to set define a
> >> > fs_param_spec as a fs_param_is_string but will also set the
> >> > fs_param_can_be_empty; and the fsconfig() syscall will get that parameter
> >> > as a flag.  That's why param->string will be NULL in this case.
> >> 
> >> Thanks for the details. Let me see if I get this right. So you're saying that
> >> someone is doing:
> >> 
> >> fsconfig(..., FSCONFIG_SET_FLAG, "usrjquota", NULL, 0); // [1]
> >> 
> >> ? Is so that is a vital part of the explanation. So please put that in the
> >> commit message.
> >> 
> >> Then ext4 defines:
> >> 
> >> 	fsparam_string_empty ("usrjquota",		Opt_usrjquota),
> >> 
> >> So [1] gets us:
> >> 
> >>         param->type == fs_value_is_flag
> >>         param->string == NULL
> >> 
> >> Now we enter into
> >> fs_parse()
> >> -> __fs_parse()
> >>    -> fs_lookup_key() for @param and that does:
> >> 
> >>         bool want_flag = param->type == fs_value_is_flag;
> >> 
> >>         *negated = false;
> >>         for (p = desc; p->name; p++) {
> >>                 if (strcmp(p->name, name) != 0)
> >>                         continue;
> >>                 if (likely(is_flag(p) == want_flag))
> >>                         return p;
> >>                 other = p;
> >>         }
> >> 
> >> So we don't have a flag parameter defined so the only real match we get is
> >> @other for:
> >> 
> >>         fsparam_string_empty ("usrjquota",		Opt_usrjquota),
> >> 
> >> What happens now is that you call p->type == fs_param_is_string() and that
> >> rejects it as bad parameter because param->type == fs_value_is_flag !=
> >> fs_value_is_string as required. So you dont end up getting Opt_userjquota
> >> called with param->string NULL, right? So there's not NULL deref or anything,
> >> right?
> >> 
> >> You just fail to set usrjquota. Ok, so I think the correct fix is to do
> >> something like the following in ext4:
> >> 
> >>         fsparam_string_empty ("usrjquota",      Opt_usrjquota),
> >>         fs_param_flag        ("usrjquota",      Opt_usrjquota_flag),
> >> 
> >> and then in the switch you can do:
> >> 
> >> switch (opt)
> >> case Opt_usrjquota:
> >>         // string thing
> >> case Opt_usrjquota_flag:
> >>         // flag thing
> >> 
> >> And I really think we should kill all empty handling for non-string types and
> >> only add that when there's a filesystem that actually needs it.
> >
> > So one option is to do the following:
> 
> Thanks a lot of your review (I forgot to thank you in my other reply!).
> 
> Now, I haven't yet tested this properly, but I think that's a much simpler
> and cleaner way of fixing this issue.  Now, although it needs some
> testing, I think the patch has one problem (see comment below).
> 
> Do you want me to send out a cleaned-up version[*] of it after some

Yes, please. That would be great!

