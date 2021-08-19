Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EACE3F1525
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 10:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbhHSI1h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 04:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232653AbhHSI1g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:27:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2D7D610E5;
        Thu, 19 Aug 2021 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629361620;
        bh=LSIX0GysxAO+kRaMRlB6pLhDkoUy6E0pIPVlk+M/9S0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WsWw+S/Blqzha+nJtiE2PMtf5pHipJH2t1/mmahOil5li5ktq7uyKedEy0xC9/zhk
         GCxlF83SrzuSXNeTc94x5fGVEhyigsNCg8wmDhkCuh/qAPuAAdKUETCaF4zqrFa0ns
         fX6NM5bmshWZ4XigdUW2hFQGTN50GvQlg4j/fp0eUFA6zuYtU1EzMbvQ5oPVCoAi2H
         0VgNHpQu/pm1dL05VEFUyLzPI27Le3L1YLTuo/ZYyI3o3v3EUBfyDvVq64jk0LsZU9
         K6crHPFpvx8QAHIL9zWywxEmv1rpZCPUo3uS/hNFaqBIEQ52l11qEC++G1/WJMKET9
         06+XWlfSzj2Dg==
Received: by pali.im (Postfix)
        id 7F9297EA; Thu, 19 Aug 2021 10:26:58 +0200 (CEST)
Date:   Thu, 19 Aug 2021 10:26:58 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 5/6] fs/ntfs3: Add iocharset= mount option as alias
 for nls=
Message-ID: <20210819082658.4xu6zmoro5xxdk5a@pali>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
 <20210819002633.689831-6-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819002633.689831-6-kari.argillander@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 19 August 2021 03:26:32 Kari Argillander wrote:
> Other fs drivers are using iocharset= mount option for specifying charset.
> So add it also for ntfs3 and mark old nls= mount option as deprecated.
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
>  Documentation/filesystems/ntfs3.rst |  4 ++--
>  fs/ntfs3/super.c                    | 12 ++++++++----
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
> index af7158de6fde..ded706474825 100644
> --- a/Documentation/filesystems/ntfs3.rst
> +++ b/Documentation/filesystems/ntfs3.rst
> @@ -32,12 +32,12 @@ generic ones.
>  
>  ===============================================================================
>  
> -nls=name		This option informs the driver how to interpret path
> +iocharset=name		This option informs the driver how to interpret path
>  			strings and translate them to Unicode and back. If
>  			this option is not set, the default codepage will be
>  			used (CONFIG_NLS_DEFAULT).
>  			Examples:
> -				'nls=utf8'
> +				'iocharset=utf8'
>  
>  uid=
>  gid=
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 8e86e1956486..c3c07c181f15 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -240,7 +240,7 @@ enum Opt {
>  	Opt_nohidden,
>  	Opt_showmeta,
>  	Opt_acl,
> -	Opt_nls,
> +	Opt_iocharset,
>  	Opt_prealloc,
>  	Opt_no_acs_rules,
>  	Opt_err,
> @@ -259,9 +259,13 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
>  	fsparam_flag_no("hidden",		Opt_nohidden),
>  	fsparam_flag_no("acl",			Opt_acl),
>  	fsparam_flag_no("showmeta",		Opt_showmeta),
> -	fsparam_string("nls",			Opt_nls),
>  	fsparam_flag_no("prealloc",		Opt_prealloc),
>  	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
> +	fsparam_string("iocharset",		Opt_iocharset),
> +
> +	__fsparam(fs_param_is_string,
> +		  "nls", Opt_iocharset,
> +		  fs_param_deprecated, NULL),

Anyway, this is a new filesystem driver. Therefore, do we need to have
for it since beginning deprecated option?

>  	{}
>  };
>  
> @@ -332,7 +336,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
>  	case Opt_showmeta:
>  		opts->showmeta = result.negated ? 0 : 1;
>  		break;
> -	case Opt_nls:
> +	case Opt_iocharset:
>  		opts->nls_name = param->string;
>  		param->string = NULL;
>  		break;
> @@ -519,7 +523,7 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
>  	if (opts->dmask)
>  		seq_printf(m, ",dmask=%04o", ~opts->fs_dmask_inv);
>  	if (opts->nls_name)
> -		seq_printf(m, ",nls=%s", opts->nls_name);
> +		seq_printf(m, ",iocharset=%s", opts->nls_name);
>  	if (opts->sys_immutable)
>  		seq_puts(m, ",sys_immutable");
>  	if (opts->discard)
> -- 
> 2.25.1
> 
