Return-Path: <linux-fsdevel+bounces-13375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B6A86F1C7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 18:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF5D1F220DE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 17:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8C92C86A;
	Sat,  2 Mar 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svPxXjRh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDD72B9DC;
	Sat,  2 Mar 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709402218; cv=none; b=Lgxeur9KjDdy5ydRiuhY4ev33huSTs1jfWLunTMq8rOY5w9AAfbZE4mxtU4a5+S767DTGKbqItOz8v+QOR9hUGSA3kKbQO1FE4M1ezMKaa3EY8N3xNJlGbNe5m05uFd9/MMTTf6yUktny6U2BYr0CVPJK3driRY+abtdRC8qY0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709402218; c=relaxed/simple;
	bh=efKYKPI74pku34t18RPgkBg9wk+E2mY4YniXXUzA3sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaBOg87ofyDSfICWVac0D5Ak0gBTK65aTMhxExRrL2FyUdCpEQp9G1PdvRDa2UhNZP3yxWefxid5EDLidTEsP3E4URl/SoSUt4LhiMahoXBZ/qbVaRMKfFGeg3Fpqz3rYd2sI/Nou9jHINMhmL9VFSsjK/cJngCG5RXhARu7EKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svPxXjRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4A5C433C7;
	Sat,  2 Mar 2024 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709402217;
	bh=efKYKPI74pku34t18RPgkBg9wk+E2mY4YniXXUzA3sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svPxXjRhhd7PqmrQljRQeiPfVQIVoPY4UIzQ0T3ZYsegJ483PzjIVu98p5GRy1HJL
	 OZbZvvsiwZkyhkKOIEbauYzxO30tFuPkl7vNf7g/ml8YL9Y8/C+5O4DgmZ27HYEDi8
	 B7iE08u8cfHfJNElWfDPLprtopPCtdrlDFF7uDwsNkeSssrSXXiHp23u/9HJBzJZBT
	 m8Uy0GxC/YZowpkhxDi9NB9pevjT5xs5H1x9UpEP0KIJ9qeVfdBNaFq0AlDbLqEAzy
	 7XKx6T4jEttr9PVdUHwS+3HqJyYq7CMZYVe6C+rdIDAEyAnZpoI2KBzoS+i5CICCKF
	 hbR2mZtXKymoA==
Date: Sat, 2 Mar 2024 18:56:51 +0100
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
Message-ID: <20240302-lamellen-hauskatze-b36d3207d73d@brauner>
References: <20240229163011.16248-1-lhenriques@suse.de>
 <20240229163011.16248-2-lhenriques@suse.de>
 <20240301-gegossen-seestern-683681ea75d1@brauner>
 <87il269crs.fsf@suse.de>
 <20240302-avancieren-sehtest-90eb364bfcd5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240302-avancieren-sehtest-90eb364bfcd5@brauner>

On Sat, Mar 02, 2024 at 12:46:41PM +0100, Christian Brauner wrote:
> On Fri, Mar 01, 2024 at 03:45:27PM +0000, Luis Henriques wrote:
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
> Thanks for the details. Let me see if I get this right. So you're saying that
> someone is doing:
> 
> fsconfig(..., FSCONFIG_SET_FLAG, "usrjquota", NULL, 0); // [1]
> 
> ? Is so that is a vital part of the explanation. So please put that in the
> commit message.
> 
> Then ext4 defines:
> 
> 	fsparam_string_empty ("usrjquota",		Opt_usrjquota),
> 
> So [1] gets us:
> 
>         param->type == fs_value_is_flag
>         param->string == NULL
> 
> Now we enter into
> fs_parse()
> -> __fs_parse()
>    -> fs_lookup_key() for @param and that does:
> 
>         bool want_flag = param->type == fs_value_is_flag;
> 
>         *negated = false;
>         for (p = desc; p->name; p++) {
>                 if (strcmp(p->name, name) != 0)
>                         continue;
>                 if (likely(is_flag(p) == want_flag))
>                         return p;
>                 other = p;
>         }
> 
> So we don't have a flag parameter defined so the only real match we get is
> @other for:
> 
>         fsparam_string_empty ("usrjquota",		Opt_usrjquota),
> 
> What happens now is that you call p->type == fs_param_is_string() and that
> rejects it as bad parameter because param->type == fs_value_is_flag !=
> fs_value_is_string as required. So you dont end up getting Opt_userjquota
> called with param->string NULL, right? So there's not NULL deref or anything,
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
> And I really think we should kill all empty handling for non-string types and
> only add that when there's a filesystem that actually needs it.

So one option is to do the following:

From 8bfb142e6caba70704998be072222d6a31d8b97b Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 2 Mar 2024 18:54:35 +0100
Subject: [PATCH] [UNTESTED]

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/super.c           | 32 ++++++++++++++++++--------------
 include/linux/fs_parser.h |  3 +++
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ebd97442d1d4..bd625f06ec0f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1724,10 +1724,6 @@ static const struct constant_table ext4_param_dax[] = {
 	{}
 };
 
-/* String parameter that allows empty argument */
-#define fsparam_string_empty(NAME, OPT) \
-	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
-
 /*
  * Mount option specification
  * We don't use fsparam_flag_no because of the way we set the
@@ -1768,10 +1764,8 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_enum	("data",		Opt_data, ext4_param_data),
 	fsparam_enum	("data_err",		Opt_data_err,
 						ext4_param_data_err),
-	fsparam_string_empty
-			("usrjquota",		Opt_usrjquota),
-	fsparam_string_empty
-			("grpjquota",		Opt_grpjquota),
+	fsparam_string_or_flag ("usrjquota",	Opt_usrjquota),
+	fsparam_string_or_flag ("grpjquota",	Opt_grpjquota),
 	fsparam_enum	("jqfmt",		Opt_jqfmt, ext4_param_jqfmt),
 	fsparam_flag	("grpquota",		Opt_grpquota),
 	fsparam_flag	("quota",		Opt_quota),
@@ -2183,15 +2177,25 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	switch (token) {
 #ifdef CONFIG_QUOTA
 	case Opt_usrjquota:
-		if (!param->string)
-			return unnote_qf_name(fc, USRQUOTA);
-		else
+		if (param->type == fs_value_is_string) {
+			if (!*param->string)
+				return unnote_qf_name(fc, USRQUOTA);
+
 			return note_qf_name(fc, USRQUOTA, param);
+		}
+
+		// param->type == fs_value_is_flag
+		return note_qf_name(fc, USRQUOTA, param);
 	case Opt_grpjquota:
-		if (!param->string)
-			return unnote_qf_name(fc, GRPQUOTA);
-		else
+		if (param->type == fs_value_is_string) {
+			if (!*param->string)
+				return unnote_qf_name(fc, GRPQUOTA);
+
 			return note_qf_name(fc, GRPQUOTA, param);
+		}
+
+		// param->type == fs_value_is_flag
+		return note_qf_name(fc, GRPQUOTA, param);
 #endif
 	case Opt_sb:
 		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 01542c4b87a2..4f45141bea95 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -131,5 +131,8 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_bdev(NAME, OPT)	__fsparam(fs_param_is_blockdev, NAME, OPT, 0, NULL)
 #define fsparam_path(NAME, OPT)	__fsparam(fs_param_is_path, NAME, OPT, 0, NULL)
 #define fsparam_fd(NAME, OPT)	__fsparam(fs_param_is_fd, NAME, OPT, 0, NULL)
+#define fsparam_string_or_flag(NAME, OPT) \
+	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL), \
+	fsparam_flag(NAME, OPT)
 
 #endif /* _LINUX_FS_PARSER_H */
-- 
2.43.0


