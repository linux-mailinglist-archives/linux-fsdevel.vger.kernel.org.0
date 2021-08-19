Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26603F1508
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 10:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbhHSIUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 04:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237388AbhHSITH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:19:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DDBD61139;
        Thu, 19 Aug 2021 08:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629361111;
        bh=CEbIrDdhxLBG3UOQ0SIJDOcUYVzcUjSinMnWqdzBTqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JroX3RhgPBClAzXd/NVpaiGqXyoepzPbCc/Dhci036xrY8b6r9GuzBjlVtmhwnSiw
         ftTNMRWI9g/bHvtkgx+vE+P92R5N2lBFqu6s/B/NUSYRd3FjSuJgTqjevNfpZNRi1g
         8RosFTSplDrNmMB/W9y866apgI2vBbPQ1HHdF7FlLqZMoSzBvbfqCluOVl5WLRhIpq
         w7dyVypGEbvlpYULiOtzlErmFA21TY+FZ/w4LdjFCQbcziAPcBCREXaQBWzYbcCv2h
         ST8AZkOW1dejhErieVml5FUEDpfhvFfUetkPZBpz3coobvTlJXq0tDni0UzSbNhZk+
         6DWdhYL2W+mTA==
Received: by pali.im (Postfix)
        id CB4D47EA; Thu, 19 Aug 2021 10:18:28 +0200 (CEST)
Date:   Thu, 19 Aug 2021 10:18:28 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 3/6] fs/ntfs3: Use new api for mounting
Message-ID: <20210819081828.zdlejcujqmpzpzif@pali>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
 <20210819002633.689831-4-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819002633.689831-4-kari.argillander@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello! I have there one comment:

On Thursday 19 August 2021 03:26:30 Kari Argillander wrote:
> @@ -545,10 +518,8 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
>  		seq_printf(m, ",fmask=%04o", ~opts->fs_fmask_inv);
>  	if (opts->dmask)
>  		seq_printf(m, ",dmask=%04o", ~opts->fs_dmask_inv);
> -	if (opts->nls)
> -		seq_printf(m, ",nls=%s", opts->nls->charset);
> -	else
> -		seq_puts(m, ",nls=utf8");
> +	if (opts->nls_name)
> +		seq_printf(m, ",nls=%s", opts->nls_name);

Please always print correct "nls=". Obviously ntfs driver (which
internally stores filenames in UTF-16) must always use some conversion
to null-term bytes. And if some kernel/driver default conversion is used
then userspace should know it, what exactly is used (e.g. to ensure that
would use correct encoding name argument of open(), stat()... syscalls).

>  	if (opts->sys_immutable)
>  		seq_puts(m, ",sys_immutable");
>  	if (opts->discard)
> @@ -619,7 +590,6 @@ static const struct super_operations ntfs_sops = {
>  	.statfs = ntfs_statfs,
>  	.show_options = ntfs_show_options,
>  	.sync_fs = ntfs_sync_fs,
> -	.remount_fs = ntfs_remount,
>  	.write_inode = ntfs3_write_inode,
>  };
