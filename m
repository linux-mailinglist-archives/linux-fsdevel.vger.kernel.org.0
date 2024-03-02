Return-Path: <linux-fsdevel+bounces-13364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044AD86F054
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 12:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA161F22113
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 11:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C4017561;
	Sat,  2 Mar 2024 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4tMOrHK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23436171BF;
	Sat,  2 Mar 2024 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709380008; cv=none; b=XN9ResLvqMm4Lo1fntqb8x6+4WydDF+XYjpmWeyabBKinN5J3VeVvInFVjB1mt/dhZ/VXVbCAl5dVSVEa6dy9KwjcP84lW5hTxg7vQhUGDc058YEng2swVNIvC+1DgUx+G90k3UBcr0BDfneAU55rAv7pNfcMPt1HrZTayapFFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709380008; c=relaxed/simple;
	bh=6ybbMazjaeBS8YeBDGv/Cm5reWpCfIW0IWKWohJFMZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4XaGO742MEBw9qxHOudVocV3Vxdv8RpwJ6fwPYKW9ijR3hcJaoifXtYEMMz5Z6yN6oGsyDUs++I1Rhaq0odDgdNvalDXWVeK6b/IM1UQDN7apNm+BRAF/Pntt1Q7B8n07Mb2VR9C/lqKBO2A+s8N+FV0cZGsShkrXunlpaLGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4tMOrHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DB5C433F1;
	Sat,  2 Mar 2024 11:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709380007;
	bh=6ybbMazjaeBS8YeBDGv/Cm5reWpCfIW0IWKWohJFMZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4tMOrHK23Pkkn1kDxMqBt0gfVxve00K9dk6+AN7WC3lM5MEh6L9QJj2Ghj7A42fz
	 k93yrwr8rXsSvSP7EkDVl5Epmtup3GeBjC35GAxnbDpu4xLUFBf9uAvkn2feBhZwIQ
	 muSESoyxAg6humaLYqA2iY/RR92SFJB0HRUeKGgI7bhSEQHvvVcG051dpZnvAwyCUr
	 AI6G/4ttXvFbcbRF7sT1CFgpDv0ZakY1kyXw6MdB9AbWnf/MmYP8eIHzRNgELWV2L7
	 /0amtXNG6C1bOELcdUltZ73hN3XPrrhoViHwgQ6vlV9l5z5mjdVwwtaZK4MOUDiNvp
	 nxPXRM9P3mpEQ==
Date: Sat, 2 Mar 2024 12:46:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Luis Henriques <lhenriques@suse.de>, 
	Eric Sandeen <sandeen@sandeen.net>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs_parser: handle parameters that can be empty and
 don't have a value
Message-ID: <20240302-avancieren-sehtest-90eb364bfcd5@brauner>
References: <20240229163011.16248-1-lhenriques@suse.de>
 <20240229163011.16248-2-lhenriques@suse.de>
 <20240301-gegossen-seestern-683681ea75d1@brauner>
 <87il269crs.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il269crs.fsf@suse.de>

On Fri, Mar 01, 2024 at 03:45:27PM +0000, Luis Henriques wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Thu, Feb 29, 2024 at 04:30:08PM +0000, Luis Henriques wrote:
> >> Currently, only parameters that have the fs_parameter_spec 'type' set to
> >> NULL are handled as 'flag' types.  However, parameters that have the
> >> 'fs_param_can_be_empty' flag set and their value is NULL should also be
> >> handled as 'flag' type, as their type is set to 'fs_value_is_flag'.
> >> 
> >> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> >> ---
> >>  fs/fs_parser.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> >> index edb3712dcfa5..53f6cb98a3e0 100644
> >> --- a/fs/fs_parser.c
> >> +++ b/fs/fs_parser.c
> >> @@ -119,7 +119,8 @@ int __fs_parse(struct p_log *log,
> >>  	/* Try to turn the type we were given into the type desired by the
> >>  	 * parameter and give an error if we can't.
> >>  	 */
> >> -	if (is_flag(p)) {
> >> +	if (is_flag(p) ||
> >> +	    (!param->string && (p->flags & fs_param_can_be_empty))) {
> >>  		if (param->type != fs_value_is_flag)
> >>  			return inval_plog(log, "Unexpected value for '%s'",
> >>  				      param->key);
> >
> > If the parameter was derived from FSCONFIG_SET_STRING in fsconfig() then
> > param->string is guaranteed to not be NULL. So really this is only
> > about:
> >
> > FSCONFIG_SET_FD
> > FSCONFIG_SET_BINARY
> > FSCONFIG_SET_PATH
> > FSCONFIG_SET_PATH_EMPTY
> >
> > and those values being used without a value. What filesystem does this?
> > I don't see any.
> >
> > The tempting thing to do here is to to just remove fs_param_can_be_empty
> > from every helper that isn't fs_param_is_string() until we actually have
> > a filesystem that wants to use any of the above as flags. Will lose a
> > lot of code that isn't currently used.
> 
> Right, I find it quite confusing and I may be fixing the issue in the
> wrong place.  What I'm seeing with ext4 when I mount a filesystem using
> the option '-o usrjquota' is that fs_parse() will get:
> 
>  * p->type is set to fs_param_is_string
>    ('p' is a struct fs_parameter_spec, ->type is a function)
>  * param->type is set to fs_value_is_flag
>    ('param' is a struct fs_parameter, ->type is an enum)
> 
> This is because ext4 will use the __fsparam macro to set define a
> fs_param_spec as a fs_param_is_string but will also set the
> fs_param_can_be_empty; and the fsconfig() syscall will get that parameter
> as a flag.  That's why param->string will be NULL in this case.

Thanks for the details. Let me see if I get this right. So you're saying that
someone is doing:

fsconfig(..., FSCONFIG_SET_FLAG, "usrjquota", NULL, 0); // [1]

? Is so that is a vital part of the explanation. So please put that in the
commit message.

Then ext4 defines:

	fsparam_string_empty ("usrjquota",		Opt_usrjquota),

So [1] gets us:

        param->type == fs_value_is_flag
        param->string == NULL

Now we enter into
fs_parse()
-> __fs_parse()
   -> fs_lookup_key() for @param and that does:

        bool want_flag = param->type == fs_value_is_flag;

        *negated = false;
        for (p = desc; p->name; p++) {
                if (strcmp(p->name, name) != 0)
                        continue;
                if (likely(is_flag(p) == want_flag))
                        return p;
                other = p;
        }

So we don't have a flag parameter defined so the only real match we get is
@other for:

        fsparam_string_empty ("usrjquota",		Opt_usrjquota),

What happens now is that you call p->type == fs_param_is_string() and that
rejects it as bad parameter because param->type == fs_value_is_flag !=
fs_value_is_string as required. So you dont end up getting Opt_userjquota
called with param->string NULL, right? So there's not NULL deref or anything,
right?

You just fail to set usrjquota. Ok, so I think the correct fix is to do
something like the following in ext4:

        fsparam_string_empty ("usrjquota",      Opt_usrjquota),
        fs_param_flag        ("usrjquota",      Opt_usrjquota_flag),

and then in the switch you can do:

switch (opt)
case Opt_usrjquota:
        // string thing
case Opt_usrjquota_flag:
        // flag thing

And I really think we should kill all empty handling for non-string types and
only add that when there's a filesystem that actually needs it.

