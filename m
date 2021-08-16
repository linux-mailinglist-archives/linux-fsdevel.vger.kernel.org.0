Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E6C3ED406
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 14:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhHPMg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 08:36:58 -0400
Received: from verein.lst.de ([213.95.11.211]:54252 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhHPMgy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:36:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EC5286736F; Mon, 16 Aug 2021 14:36:19 +0200 (CEST)
Date:   Mon, 16 Aug 2021 14:36:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 1/4] fs/ntfs3: Use new api for mounting
Message-ID: <20210816123619.GB17355@lst.de>
References: <20210816024703.107251-1-kari.argillander@gmail.com> <20210816024703.107251-2-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816024703.107251-2-kari.argillander@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +/*
> + * ntfs_load_nls
> + *

No need to state the function name here.

> + * Load nls table or if @nls is utf8 then return NULL because
> + * nls=utf8 is totally broken.
> + */
> +static struct nls_table *ntfs_load_nls(char *nls)
> +{
> +	struct nls_table *ret;
> +
> +	if (!nls)
> +		return ERR_PTR(-EINVAL);
> +	if (strcmp(nls, "utf8"))
> +		return NULL;
> +	if (strcmp(nls, CONFIG_NLS_DEFAULT))
> +		return load_nls_default();
> +
> +	ret = load_nls(nls);
> +	if (!ret)
> +		return ERR_PTR(-EINVAL);
> +
> +	return ret;
> +}

This looks like something quite generic and not file system specific.
But I haven't found time to look at the series from Pali how this all
fits together.

> +// clang-format off

Please don't use C++ comments.  And we also should not put weird
formatter annotations into the kernel source anyway.

> +static void ntfs_default_options(struct ntfs_mount_options *opts)
>  {
>  	opts->fs_uid = current_uid();
>  	opts->fs_gid = current_gid();
> +	opts->fs_fmask_inv = ~current_umask();
> +	opts->fs_dmask_inv = ~current_umask();
> +	opts->nls = ntfs_load_nls(CONFIG_NLS_DEFAULT);
> +}

This function seems pretty pointless with a single trivial caller.

> +static int ntfs_fs_parse_param(struct fs_context *fc, struct fs_parameter *param)

Please avoid the overly long line.

> +		break;
> +	case Opt_showmeta:
> +		opts->showmeta = result.negated ? 0 : 1;
> +		break;
> +	case Opt_nls:
> +		unload_nls(opts->nls);
> +
> +		opts->nls = ntfs_load_nls(param->string);
> +		if (IS_ERR(opts->nls)) {
> +			return invalf(fc, "ntfs3: Cannot load nls %s",
> +				      param->string);
>  		}

So instead of unloading here, why not set keep a copy of the string
in the mount options structure and only load the actual table after
option parsing has finished?

> +     struct ntfs_mount_options *new_opts = fc->s_fs_info;

Does this rely on the mount_options being the first member in struct
ntfs_sb_info?  If so that is a landmine for future changes.

> +/*
> + * Set up the filesystem mount context.
> + */
> +static int ntfs_init_fs_context(struct fs_context *fc)
> +{
> +	struct ntfs_sb_info *sbi;
> +
> +	sbi = ntfs_zalloc(sizeof(struct ntfs_sb_info));

Not related to your patch, but why does ntfs3 have kmalloc wrappers
like this?
