Return-Path: <linux-fsdevel+bounces-14140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D48A87847B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 17:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543F62822B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3193F5026B;
	Mon, 11 Mar 2024 16:02:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEEB4DA1A;
	Mon, 11 Mar 2024 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172920; cv=none; b=S/h65tHWa+7fx5LQVIQgma62kXKqvwxKaNcCOeDlEgiJ6n53d1DIDC4kmtJrIYoS+7573Y/M8CagCZFdG7MMLr8homp7f0KEB35A0zQGcg83u5stDpBt9sgDRQBQVINcASK7HG1o9/aBWW3ZirULH8CnH8g5/Ir4IJzlkj9E/H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172920; c=relaxed/simple;
	bh=X3GdXd5MdElqZ7SH6kkZIYIIS49/wbQOMBJNyVWcWws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aw56kK/j1oo9KDsf5cb/KlIsW/NaogSb8ym/BEGR1jv6J0FrnjBVwkJ9HQpREGZmEI51XKWRSB7AW6wYlAZHjju4OBdyp0AFecJhnTE5lNnKonQLGwb29cUCoDjLFZVHoFdOFATudqCmQiU+sAZ3WNQAfQ5rg67X4zia0OKhxHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 179A25C7EB;
	Mon, 11 Mar 2024 16:01:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C1DB1395F;
	Mon, 11 Mar 2024 16:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LA3xAu8q72XkDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 Mar 2024 16:01:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ACDCDA0807; Mon, 11 Mar 2024 17:01:50 +0100 (CET)
Date: Mon, 11 Mar 2024 17:01:50 +0100
From: Jan Kara <jack@suse.cz>
To: Luis Henriques <lhenriques@suse.de>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs_parser: handle parameters that can be empty and
 don't have a value
Message-ID: <20240311160150.kzlfbdrmgiynuteu@quack3>
References: <20240229163011.16248-1-lhenriques@suse.de>
 <20240229163011.16248-2-lhenriques@suse.de>
 <20240301-gegossen-seestern-683681ea75d1@brauner>
 <87il269crs.fsf@suse.de>
 <20240307151356.ishrtxrsge2i5mjn@quack3>
 <20240308-fahrdienst-torten-eae8f3eed3b4@brauner>
 <87a5n9t4le.fsf@suse.de>
 <20240308230911.r5a4xn6f5vp24hil@quack3>
 <87r0gh6p4y.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0gh6p4y.fsf@suse.de>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 179A25C7EB
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon 11-03-24 10:26:05, Luis Henriques wrote:
> Jan Kara <jack@suse.cz> writes:
> > On Fri 08-03-24 10:12:13, Luis Henriques wrote:
> >> Christian Brauner <brauner@kernel.org> writes:
> >> 
> >> > On Thu, Mar 07, 2024 at 04:13:56PM +0100, Jan Kara wrote:
> >> >> On Fri 01-03-24 15:45:27, Luis Henriques wrote:
> >> >> > Christian Brauner <brauner@kernel.org> writes:
> >> >> > 
> >> >> > > On Thu, Feb 29, 2024 at 04:30:08PM +0000, Luis Henriques wrote:
> >> >> > >> Currently, only parameters that have the fs_parameter_spec 'type' set to
> >> >> > >> NULL are handled as 'flag' types.  However, parameters that have the
> >> >> > >> 'fs_param_can_be_empty' flag set and their value is NULL should also be
> >> >> > >> handled as 'flag' type, as their type is set to 'fs_value_is_flag'.
> >> >> > >> 
> >> >> > >> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> >> >> > >> ---
> >> >> > >>  fs/fs_parser.c | 3 ++-
> >> >> > >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >> > >> 
> >> >> > >> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> >> >> > >> index edb3712dcfa5..53f6cb98a3e0 100644
> >> >> > >> --- a/fs/fs_parser.c
> >> >> > >> +++ b/fs/fs_parser.c
> >> >> > >> @@ -119,7 +119,8 @@ int __fs_parse(struct p_log *log,
> >> >> > >>  	/* Try to turn the type we were given into the type desired by the
> >> >> > >>  	 * parameter and give an error if we can't.
> >> >> > >>  	 */
> >> >> > >> -	if (is_flag(p)) {
> >> >> > >> +	if (is_flag(p) ||
> >> >> > >> +	    (!param->string && (p->flags & fs_param_can_be_empty))) {
> >> >> > >>  		if (param->type != fs_value_is_flag)
> >> >> > >>  			return inval_plog(log, "Unexpected value for '%s'",
> >> >> > >>  				      param->key);
> >> >> > >
> >> >> > > If the parameter was derived from FSCONFIG_SET_STRING in fsconfig() then
> >> >> > > param->string is guaranteed to not be NULL. So really this is only
> >> >> > > about:
> >> >> > >
> >> >> > > FSCONFIG_SET_FD
> >> >> > > FSCONFIG_SET_BINARY
> >> >> > > FSCONFIG_SET_PATH
> >> >> > > FSCONFIG_SET_PATH_EMPTY
> >> >> > >
> >> >> > > and those values being used without a value. What filesystem does this?
> >> >> > > I don't see any.
> >> >> > >
> >> >> > > The tempting thing to do here is to to just remove fs_param_can_be_empty
> >> >> > > from every helper that isn't fs_param_is_string() until we actually have
> >> >> > > a filesystem that wants to use any of the above as flags. Will lose a
> >> >> > > lot of code that isn't currently used.
> >> >> > 
> >> >> > Right, I find it quite confusing and I may be fixing the issue in the
> >> >> > wrong place.  What I'm seeing with ext4 when I mount a filesystem using
> >> >> > the option '-o usrjquota' is that fs_parse() will get:
> >> >> > 
> >> >> >  * p->type is set to fs_param_is_string
> >> >> >    ('p' is a struct fs_parameter_spec, ->type is a function)
> >> >> >  * param->type is set to fs_value_is_flag
> >> >> >    ('param' is a struct fs_parameter, ->type is an enum)
> >> >> > 
> >> >> > This is because ext4 will use the __fsparam macro to set define a
> >> >> > fs_param_spec as a fs_param_is_string but will also set the
> >> >> > fs_param_can_be_empty; and the fsconfig() syscall will get that parameter
> >> >> > as a flag.  That's why param->string will be NULL in this case.
> >> >> 
> >> >> So I'm a bit confused here. Valid variants of these quota options are like
> >> >> "usrjquota=<filename>" (to set quota file name) or "usrjquota=" (to clear
> >> >> quota file name). The variant "usrjquota" should ideally be rejected
> >> >> because it doesn't make a good sense and only adds to confusion. Now as far
> >> >> as I'm reading fs/ext4/super.c: parse_options() (and as far as my testing
> >> >> shows) this is what is happening so what is exactly the problem you're
> >> >> trying to fix?
> >> >
> >> > mount(8) has no way of easily knowing that for something like
> >> > mount -o usrjquota /dev/sda1 /mnt that "usrjquota" is supposed to be
> >> > set as an empty string via FSCONFIG_SET_STRING. For mount(8) it is
> >> > indistinguishable from a flag because it's specified without an
> >> > argument. So mount(8) passes FSCONFIG_SET_FLAG and it seems strange that
> >> > we should require mount(8) to know what mount options are strings or no.
> >> > I've ran into this issue before myself when using the mount api
> >> > programatically.
> >> 
> >> Right.  A simple usecase is to try to do:
> >> 
> >>   mount -t ext4 -o usrjquota= /dev/sda1 /mnt/
> >> 
> >> It will fail, and this has been broken for a while.
> >
> > I see. But you have to have new enough mount that is using fsconfig, don't
> > you? Because for me in my test VM this works just fine...
> 
> Oh, interesting.  FTR I'm using mount from util-linux 2.39.3, but I
> haven't tried this with older versions.

I'm using util-linux 2.37.2 and checking the changelogs indeed 2.39 started
to use the new mount API from the kernel. Checking strace of the new mount
I can indeed see mount(8) does:

fsconfig(3, FSCONFIG_SET_FLAG, "usrjquota", NULL, 0) = -1 EINVAL (Invalid argument)

So it is actually util-linux, not the kernel parser, that IMHO incorrectly
parses the mount options and uses FSCONFIG_SET_FLAG instead of
FSCONFIG_SET_STRING with an empty string.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

