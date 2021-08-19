Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09F43F16C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 11:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbhHSJ4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 05:56:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232750AbhHSJ4G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:56:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 034C4610FA;
        Thu, 19 Aug 2021 09:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629366930;
        bh=9nllqIp3YFYIG2iUBvQY9Xv3E71kmWvo0C/6DGN1Cxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l0QwUiIIYQCpLtLfKk6Ifeh5vya9k/3wkdQ3wKEzljGCaKA30CFsXpi8trnqnZTA1
         uCv7WBoy6gFCpexTBQZ6UR6vsVdXCunBudE2j41Y4fwhcqVpRFxlxvDVC+agPPtYcf
         BIEZEApYBVCkrAeNShWdaHzQudL04knqwVIMlpNAutdA+d1lTNNY2wvLwQPnpMbUa3
         3C6clJyqwmk0j/lrnmSj3U9RKmnwPKpUGRLG5LXWKJBjGTEipYRdotN7bUROvkhQkd
         H5ncmwGs9mNHVaHH2wb5QF41MfoFbXwgRIKKT/8Ym3oImGeunBrELOJjFL1eicbfaG
         OS+MKKSPaqGNA==
Received: by pali.im (Postfix)
        id A1E0A7EA; Thu, 19 Aug 2021 11:55:27 +0200 (CEST)
Date:   Thu, 19 Aug 2021 11:55:27 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 5/6] fs/ntfs3: Add iocharset= mount option as alias
 for nls=
Message-ID: <20210819095527.w4uv6gzuyaotxjpe@pali>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
 <20210819002633.689831-6-kari.argillander@gmail.com>
 <20210819082658.4xu6zmoro5xxdk5a@pali>
 <20210819094532.7uardf2q2u5w24yt@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210819094532.7uardf2q2u5w24yt@kari-VirtualBox>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 19 August 2021 12:45:32 Kari Argillander wrote:
> On Thu, Aug 19, 2021 at 10:26:58AM +0200, Pali Rohár wrote:
> > On Thursday 19 August 2021 03:26:32 Kari Argillander wrote:
> > > Other fs drivers are using iocharset= mount option for specifying charset.
> > > So add it also for ntfs3 and mark old nls= mount option as deprecated.
> > > 
> > > Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> > > ---
> > >  Documentation/filesystems/ntfs3.rst |  4 ++--
> > >  fs/ntfs3/super.c                    | 12 ++++++++----
> > >  2 files changed, 10 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
> > > index af7158de6fde..ded706474825 100644
> > > --- a/Documentation/filesystems/ntfs3.rst
> > > +++ b/Documentation/filesystems/ntfs3.rst
> > > @@ -32,12 +32,12 @@ generic ones.
> > >  
> > >  ===============================================================================
> > >  
> > > -nls=name		This option informs the driver how to interpret path
> > > +iocharset=name		This option informs the driver how to interpret path
> > >  			strings and translate them to Unicode and back. If
> > >  			this option is not set, the default codepage will be
> > >  			used (CONFIG_NLS_DEFAULT).
> > >  			Examples:
> > > -				'nls=utf8'
> > > +				'iocharset=utf8'
> > >  
> > >  uid=
> > >  gid=
> > > diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> > > index 8e86e1956486..c3c07c181f15 100644
> > > --- a/fs/ntfs3/super.c
> > > +++ b/fs/ntfs3/super.c
> > > @@ -240,7 +240,7 @@ enum Opt {
> > >  	Opt_nohidden,
> > >  	Opt_showmeta,
> > >  	Opt_acl,
> > > -	Opt_nls,
> > > +	Opt_iocharset,
> > >  	Opt_prealloc,
> > >  	Opt_no_acs_rules,
> > >  	Opt_err,
> > > @@ -259,9 +259,13 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
> > >  	fsparam_flag_no("hidden",		Opt_nohidden),
> > >  	fsparam_flag_no("acl",			Opt_acl),
> > >  	fsparam_flag_no("showmeta",		Opt_showmeta),
> > > -	fsparam_string("nls",			Opt_nls),
> > >  	fsparam_flag_no("prealloc",		Opt_prealloc),
> > >  	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
> > > +	fsparam_string("iocharset",		Opt_iocharset),
> > > +
> > > +	__fsparam(fs_param_is_string,
> > > +		  "nls", Opt_iocharset,
> > > +		  fs_param_deprecated, NULL),
> > 
> > Anyway, this is a new filesystem driver. Therefore, do we need to have
> > for it since beginning deprecated option?
> 
> I have also thought about this. In my mind this is new driver to our tree.
> But is been available from Paragon. Their customers may migrate to this
> so let's give them easy path to it. They also have free version and
> there is many Linux user who will switch to this when this is available.
> 
> Another thing what I been thinking is that how we will switch from
> ntfs->ntfs3. To give easy path to this driver then we should in some
> point add ntfs driver mount options to this one. Maybe not totally
> funtional, but so that mounting is possible. Current ntfs driver had nls
> option so it makes sense to add it here. We might even like to think
> ntfs-3g mount options because that is more used.
> 
> Of course we can just drop this. But I like that user experience is good
> with kernel. And if we can make that little more pleasent with couple
> line of trivial code then imo let's do it. We just need to make sure we
> drop these in one point of time. It is too often these kind of things
> will live in kernel "internity".

Makes sense. Sometimes it is better to introduce legacy/deprecated code
also to the new one.

In case this ntfs3 driver is going to replace ntfs driver then it would
have to understand all options supported by ntfs, even those which are
already deprecated and also those which will be deprecated in future.
(Until there is a decision to drop it)

> > 
> > >  	{}
> > >  };
> > >  
> > > @@ -332,7 +336,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
> > >  	case Opt_showmeta:
> > >  		opts->showmeta = result.negated ? 0 : 1;
> > >  		break;
> > > -	case Opt_nls:
> > > +	case Opt_iocharset:
> > >  		opts->nls_name = param->string;
> > >  		param->string = NULL;
> > >  		break;
> > > @@ -519,7 +523,7 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
> > >  	if (opts->dmask)
> > >  		seq_printf(m, ",dmask=%04o", ~opts->fs_dmask_inv);
> > >  	if (opts->nls_name)
> > > -		seq_printf(m, ",nls=%s", opts->nls_name);
> > > +		seq_printf(m, ",iocharset=%s", opts->nls_name);
> > >  	if (opts->sys_immutable)
> > >  		seq_puts(m, ",sys_immutable");
> > >  	if (opts->discard)
> > > -- 
> > > 2.25.1
> > > 
> > 
