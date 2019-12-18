Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6822124544
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 12:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLRLEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 06:04:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:50710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfLRLEl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:04:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 67A99AFDF;
        Wed, 18 Dec 2019 11:04:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6C193DA786; Wed, 18 Dec 2019 12:04:37 +0100 (CET)
Date:   Wed, 18 Dec 2019 12:04:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] vfs: Adjust indentation in remap_verify_area
Message-ID: <20191218110437.GJ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Nathan Chancellor <natechancellor@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20191218035055.GG4203@ZenIV.linux.org.uk>
 <20191218051635.38347-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218051635.38347-1-natechancellor@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 10:16:35PM -0700, Nathan Chancellor wrote:
> Clang's -Wmisleading-indentation caught an instance in remap_verify_area
> where there was a trailing space after a tab. Remove it to get rid of
> the warning.
> 
> Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
> Link: https://github.com/ClangBuiltLinux/linux/issues/828
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> v1 -> v2:
> 
> * Trim warning and simplify patch explanation.
> 
>  fs/read_write.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 5bbf587f5bc1..c71e863163bd 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1757,7 +1757,7 @@ static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
>  	if (unlikely(pos < 0 || len < 0))
>  		return -EINVAL;
>  
> -	 if (unlikely((loff_t) (pos + len) < 0))
> +	if (unlikely((loff_t) (pos + len) < 0))

Instead of just fixing whitespace, can we please fix the undefined
behaviour on this line? pos and len are signed types, there's a helper
to do that in a way that's UB-safe.

And btw here's a patch:

https://lore.kernel.org/linux-fsdevel/20190808123942.19592-1-dsterba@suse.com/
