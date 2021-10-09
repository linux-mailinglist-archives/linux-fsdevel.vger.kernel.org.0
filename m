Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08E8427983
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 13:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhJILox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Oct 2021 07:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232933AbhJILow (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Oct 2021 07:44:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E8B460F55;
        Sat,  9 Oct 2021 11:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633779775;
        bh=T4zLC2wq7Ew+/gREr7dQWKQu8oEQOgyhjA1bYwutRow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bk00IqJOHz2JLrg4Q2254i35CtdF2AqaBldbRYLwOcnYYiG77LthopT4hiNZbYxn4
         7DCoJXrRPzYmdxelXcGatKBD/JRh8XKzysJbvAGXUEjoiFBWzKUIe9wy/TjRw2ccwU
         /dD5578rEDZ2eRn7NXvfXsziNb6uCqrJ8+ER3mxOXZRTRez1S/9amqooK9gVczUf9M
         +XmE+MPDkk0F8dOqkyazSmaOTB3/1c231m4YZilnl0sykCzoK0TkTGmDUxJWIv4+47
         eXSeg0OvF2q6ThYRFhZs7P/4kmcObLTex4gjlildMuwRlnHT+aErJv0Y1v3ez6DXv9
         5CWYXm2kM1tTA==
Received: by pali.im (Postfix)
        id B9356310; Sat,  9 Oct 2021 13:42:52 +0200 (CEST)
Date:   Sat, 9 Oct 2021 13:42:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v4 7/9] fs/ntfs3: Add iocharset= mount option as alias
 for nls=
Message-ID: <20211009114252.jn2uehmaveucimp5@pali>
References: <20210907153557.144391-1-kari.argillander@gmail.com>
 <20210907153557.144391-8-kari.argillander@gmail.com>
 <20210908190938.l32kihefvtfw5tjp@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210908190938.l32kihefvtfw5tjp@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

This patch have not been applied yet:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ntfs3/super.c#n247

What happened that in upstream tree is still only nls= option and not
this iocharset=?

On Wednesday 08 September 2021 21:09:38 Pali Rohár wrote:
> On Tuesday 07 September 2021 18:35:55 Kari Argillander wrote:
> > Other fs drivers are using iocharset= mount option for specifying charset.
> > So add it also for ntfs3 and mark old nls= mount option as deprecated.
> > 
> > Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> 
> Reviewed-by: Pali Rohár <pali@kernel.org>
> 
> > ---
> >  Documentation/filesystems/ntfs3.rst |  4 ++--
> >  fs/ntfs3/super.c                    | 18 +++++++++++-------
> >  2 files changed, 13 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
> > index af7158de6fde..ded706474825 100644
> > --- a/Documentation/filesystems/ntfs3.rst
> > +++ b/Documentation/filesystems/ntfs3.rst
> > @@ -32,12 +32,12 @@ generic ones.
> >  
> >  ===============================================================================
> >  
> > -nls=name		This option informs the driver how to interpret path
> > +iocharset=name		This option informs the driver how to interpret path
> >  			strings and translate them to Unicode and back. If
> >  			this option is not set, the default codepage will be
> >  			used (CONFIG_NLS_DEFAULT).
> >  			Examples:
> > -				'nls=utf8'
> > +				'iocharset=utf8'
> >  
> >  uid=
> >  gid=
> > diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> > index 729ead6f2fac..503e2e23f711 100644
> > --- a/fs/ntfs3/super.c
> > +++ b/fs/ntfs3/super.c
> > @@ -226,7 +226,7 @@ enum Opt {
> >  	Opt_nohidden,
> >  	Opt_showmeta,
> >  	Opt_acl,
> > -	Opt_nls,
> > +	Opt_iocharset,
> >  	Opt_prealloc,
> >  	Opt_no_acs_rules,
> >  	Opt_err,
> > @@ -245,9 +245,13 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
> >  	fsparam_flag_no("hidden",		Opt_nohidden),
> >  	fsparam_flag_no("acl",			Opt_acl),
> >  	fsparam_flag_no("showmeta",		Opt_showmeta),
> > -	fsparam_string("nls",			Opt_nls),
> >  	fsparam_flag_no("prealloc",		Opt_prealloc),
> >  	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
> > +	fsparam_string("iocharset",		Opt_iocharset),
> > +
> > +	__fsparam(fs_param_is_string,
> > +		  "nls", Opt_iocharset,
> > +		  fs_param_deprecated, NULL),
> >  	{}
> >  };
> >  
> > @@ -346,7 +350,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
> >  	case Opt_showmeta:
> >  		opts->showmeta = result.negated ? 0 : 1;
> >  		break;
> > -	case Opt_nls:
> > +	case Opt_iocharset:
> >  		kfree(opts->nls_name);
> >  		opts->nls_name = param->string;
> >  		param->string = NULL;
> > @@ -380,11 +384,11 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)
> >  	new_opts->nls = ntfs_load_nls(new_opts->nls_name);
> >  	if (IS_ERR(new_opts->nls)) {
> >  		new_opts->nls = NULL;
> > -		errorf(fc, "ntfs3: Cannot load nls %s", new_opts->nls_name);
> > +		errorf(fc, "ntfs3: Cannot load iocharset %s", new_opts->nls_name);
> >  		return -EINVAL;
> >  	}
> >  	if (new_opts->nls != sbi->options->nls)
> > -		return invalf(fc, "ntfs3: Cannot use different nls when remounting!");
> > +		return invalf(fc, "ntfs3: Cannot use different iocharset when remounting!");
> >  
> >  	sync_filesystem(sb);
> >  
> > @@ -528,9 +532,9 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
> >  	if (opts->dmask)
> >  		seq_printf(m, ",dmask=%04o", ~opts->fs_dmask_inv);
> >  	if (opts->nls)
> > -		seq_printf(m, ",nls=%s", opts->nls->charset);
> > +		seq_printf(m, ",iocharset=%s", opts->nls->charset);
> >  	else
> > -		seq_puts(m, ",nls=utf8");
> > +		seq_puts(m, ",iocharset=utf8");
> >  	if (opts->sys_immutable)
> >  		seq_puts(m, ",sys_immutable");
> >  	if (opts->discard)
> > -- 
> > 2.25.1
> > 
