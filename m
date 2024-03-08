Return-Path: <linux-fsdevel+bounces-13986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6054087614D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 10:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196C82840CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E825537FE;
	Fri,  8 Mar 2024 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtH6iBRE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F3535BC;
	Fri,  8 Mar 2024 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891611; cv=none; b=PySgpcBlh6DCNMHyzvpl974gTy4VHGU9N2NTDBUxgn4hUl3TyD5QD5hWAfvFCoRSrYM2B4vjBLthLGPeobnGuRwIjXLmoT393YjiO+4Xu2Ne80ywSJKAJoN4dn4SENP1q2F1k8+5nR5WBVMdW1xZQki1d9sr2HwcXmCzCgSEFi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891611; c=relaxed/simple;
	bh=QmRLKVLKdt30yVzpTeSE0AYS+PV/cT94dyjGByHQZGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkG5ZmLzU7dlBOOFMZNfXgKaXHZLC2fISJRJS9z4sGZLzxMfBt8hvvRNl2JqEmugwYIVAnxoVqczBGT9CJEuGXRbPm5PiVktKuzMzOMp2MjPqg8MMhqiDu22Zsj9ImYWVBFqFJcs+8Dl8yIszRjlkSpATb03MN86bNdspdDnoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtH6iBRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F71FC43399;
	Fri,  8 Mar 2024 09:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709891611;
	bh=QmRLKVLKdt30yVzpTeSE0AYS+PV/cT94dyjGByHQZGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtH6iBREN3fVVbo0N98tpdhelBvJwfta1zM+gE/yvF18IO5iE87HFY4lXF56SGXBC
	 kfA/twpwFNN6zkz9o5kHiYAIigkaQWNx1W625GlLF0ECkUajoYcHp+5D7ex0cpOEUd
	 sEYKQ3DkTH72v7llSvb3nIRzJsR/IxsWbzs/xRevqAVtCc30bIc8TcGQUFjcwuWW27
	 OHAKUnSrl2Vq3SBUSQXLvr2Op7avFBjDWLafKD56EP9l5GOtlMwkAs3Cz/C/qTaV7A
	 iXKRr01hwuLcx5zDqGxrCDLJoW9eIw/4OwGCpqHmra+EUNn0rnVAQduOepaSxxcbHI
	 SuzZNHn2+YKkA==
Date: Fri, 8 Mar 2024 10:53:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Luis Henriques <lhenriques@suse.de>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs_parser: handle parameters that can be empty and
 don't have a value
Message-ID: <20240308-fahrdienst-torten-eae8f3eed3b4@brauner>
References: <20240229163011.16248-1-lhenriques@suse.de>
 <20240229163011.16248-2-lhenriques@suse.de>
 <20240301-gegossen-seestern-683681ea75d1@brauner>
 <87il269crs.fsf@suse.de>
 <20240307151356.ishrtxrsge2i5mjn@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307151356.ishrtxrsge2i5mjn@quack3>

On Thu, Mar 07, 2024 at 04:13:56PM +0100, Jan Kara wrote:
> On Fri 01-03-24 15:45:27, Luis Henriques wrote:
> > Christian Brauner <brauner@kernel.org> writes:
> > 
> > > On Thu, Feb 29, 2024 at 04:30:08PM +0000, Luis Henriques wrote:
> > >> Currently, only parameters that have the fs_parameter_spec 'type' set to
> > >> NULL are handled as 'flag' types.  However, parameters that have the
> > >> 'fs_param_can_be_empty' flag set and their value is NULL should also be
> > >> handled as 'flag' type, as their type is set to 'fs_value_is_flag'.
> > >> 
> > >> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > >> ---
> > >>  fs/fs_parser.c | 3 ++-
> > >>  1 file changed, 2 insertions(+), 1 deletion(-)
> > >> 
> > >> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> > >> index edb3712dcfa5..53f6cb98a3e0 100644
> > >> --- a/fs/fs_parser.c
> > >> +++ b/fs/fs_parser.c
> > >> @@ -119,7 +119,8 @@ int __fs_parse(struct p_log *log,
> > >>  	/* Try to turn the type we were given into the type desired by the
> > >>  	 * parameter and give an error if we can't.
> > >>  	 */
> > >> -	if (is_flag(p)) {
> > >> +	if (is_flag(p) ||
> > >> +	    (!param->string && (p->flags & fs_param_can_be_empty))) {
> > >>  		if (param->type != fs_value_is_flag)
> > >>  			return inval_plog(log, "Unexpected value for '%s'",
> > >>  				      param->key);
> > >
> > > If the parameter was derived from FSCONFIG_SET_STRING in fsconfig() then
> > > param->string is guaranteed to not be NULL. So really this is only
> > > about:
> > >
> > > FSCONFIG_SET_FD
> > > FSCONFIG_SET_BINARY
> > > FSCONFIG_SET_PATH
> > > FSCONFIG_SET_PATH_EMPTY
> > >
> > > and those values being used without a value. What filesystem does this?
> > > I don't see any.
> > >
> > > The tempting thing to do here is to to just remove fs_param_can_be_empty
> > > from every helper that isn't fs_param_is_string() until we actually have
> > > a filesystem that wants to use any of the above as flags. Will lose a
> > > lot of code that isn't currently used.
> > 
> > Right, I find it quite confusing and I may be fixing the issue in the
> > wrong place.  What I'm seeing with ext4 when I mount a filesystem using
> > the option '-o usrjquota' is that fs_parse() will get:
> > 
> >  * p->type is set to fs_param_is_string
> >    ('p' is a struct fs_parameter_spec, ->type is a function)
> >  * param->type is set to fs_value_is_flag
> >    ('param' is a struct fs_parameter, ->type is an enum)
> > 
> > This is because ext4 will use the __fsparam macro to set define a
> > fs_param_spec as a fs_param_is_string but will also set the
> > fs_param_can_be_empty; and the fsconfig() syscall will get that parameter
> > as a flag.  That's why param->string will be NULL in this case.
> 
> So I'm a bit confused here. Valid variants of these quota options are like
> "usrjquota=<filename>" (to set quota file name) or "usrjquota=" (to clear
> quota file name). The variant "usrjquota" should ideally be rejected
> because it doesn't make a good sense and only adds to confusion. Now as far
> as I'm reading fs/ext4/super.c: parse_options() (and as far as my testing
> shows) this is what is happening so what is exactly the problem you're
> trying to fix?

mount(8) has no way of easily knowing that for something like
mount -o usrjquota /dev/sda1 /mnt that "usrjquota" is supposed to be
set as an empty string via FSCONFIG_SET_STRING. For mount(8) it is
indistinguishable from a flag because it's specified without an
argument. So mount(8) passes FSCONFIG_SET_FLAG and it seems strange that
we should require mount(8) to know what mount options are strings or no.
I've ran into this issue before myself when using the mount api
programatically.

