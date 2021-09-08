Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC93403F7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 21:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbhIHTLr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 15:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhIHTLq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:11:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91A8B610A3;
        Wed,  8 Sep 2021 19:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631128238;
        bh=u+kiB7HjM/T2FYDJZafBBCyh264F1JkNmR2O3D1dGFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VtVlbnoJHzuw7p5S8oEbWCYN53Ft21MwQqoi5TT79B4FohAom59y3Sqqv23CdqaPw
         6J8ne7qaXe6moF+J0a2RyeD3S2cy7ngOmQfg614RED+8dJrn5XZyPgL/9jgZyEf4rb
         ZsTgb4qgYxGmADi4mQvOWoKLeisZ1+CWOhY5avQgKQA+xGKLLoUhe3TzLETQy582ya
         FTl2VMSQhVhdglMbaLRpQYxZv4zi9xqrhREol4r6/tGCviNb1Cg2QB06L6lZrKVQZJ
         cctovkFaUceohBdKpzuQvKQiIJF5HdUX8nL3AdDcTb555NEsRUeht9fnoDDpLvy039
         mmdrzr6fcpIcg==
Received: by pali.im (Postfix)
        id 4F78D708; Wed,  8 Sep 2021 21:10:36 +0200 (CEST)
Date:   Wed, 8 Sep 2021 21:10:36 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v4 1/9] fs/ntfs3: Remove unnecesarry mount option noatime
Message-ID: <20210908191036.ztjy7eoitrxujqcu@pali>
References: <20210907153557.144391-1-kari.argillander@gmail.com>
 <20210907153557.144391-2-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210907153557.144391-2-kari.argillander@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday 07 September 2021 18:35:49 Kari Argillander wrote:
> Remove unnecesarry mount option noatime because this will be handled
> by VFS. Our option parser will never get opt like this.
> 
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
>  Documentation/filesystems/ntfs3.rst | 4 ----
>  fs/ntfs3/super.c                    | 7 -------
>  2 files changed, 11 deletions(-)
> 
> diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
> index ffe9ea0c1499..af7158de6fde 100644
> --- a/Documentation/filesystems/ntfs3.rst
> +++ b/Documentation/filesystems/ntfs3.rst
> @@ -85,10 +85,6 @@ acl			Support POSIX ACLs (Access Control Lists). Effective if
>  			supported by Kernel. Not to be confused with NTFS ACLs.
>  			The option specified as acl enables support for POSIX ACLs.
>  
> -noatime			All files and directories will not update their last access
> -			time attribute if a partition is mounted with this parameter.
> -			This option can speed up file system operation.
> -
>  ===============================================================================
>  
>  ToDo list
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 55bbc9200a10..a18b99a3e3b5 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -223,7 +223,6 @@ enum Opt {
>  	Opt_nohidden,
>  	Opt_showmeta,
>  	Opt_acl,
> -	Opt_noatime,
>  	Opt_nls,
>  	Opt_prealloc,
>  	Opt_no_acs_rules,
> @@ -242,7 +241,6 @@ static const match_table_t ntfs_tokens = {
>  	{ Opt_sparse, "sparse" },
>  	{ Opt_nohidden, "nohidden" },
>  	{ Opt_acl, "acl" },
> -	{ Opt_noatime, "noatime" },
>  	{ Opt_showmeta, "showmeta" },
>  	{ Opt_nls, "nls=%s" },
>  	{ Opt_prealloc, "prealloc" },
> @@ -333,9 +331,6 @@ static noinline int ntfs_parse_options(struct super_block *sb, char *options,
>  			ntfs_err(sb, "support for ACL not compiled in!");
>  			return -EINVAL;
>  #endif
> -		case Opt_noatime:
> -			sb->s_flags |= SB_NOATIME;
> -			break;
>  		case Opt_showmeta:
>  			opts->showmeta = 1;
>  			break;
> @@ -587,8 +582,6 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
>  		seq_puts(m, ",prealloc");
>  	if (sb->s_flags & SB_POSIXACL)
>  		seq_puts(m, ",acl");
> -	if (sb->s_flags & SB_NOATIME)
> -		seq_puts(m, ",noatime");
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
