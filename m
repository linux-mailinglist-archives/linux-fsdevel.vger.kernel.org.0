Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68329123399
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 18:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfLQRdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 12:33:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47978 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQRdB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 12:33:01 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihGiR-00015M-Mf; Tue, 17 Dec 2019 17:32:59 +0000
Date:   Tue, 17 Dec 2019 17:32:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/12] fs_parser: "string" with missing value is a "flag"
Message-ID: <20191217173259.GA4203@ZenIV.linux.org.uk>
References: <20191128155940.17530-1-mszeredi@redhat.com>
 <20191128155940.17530-10-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128155940.17530-10-mszeredi@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 28, 2019 at 04:59:37PM +0100, Miklos Szeredi wrote:
> There's no such thing as a NULL string value, the fsconfig(2) syscall
> rejects that outright.
> 
> So get rid of that concept from the implementation.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fs_context.c           | 2 +-
>  fs/fs_parser.c            | 9 ++-------
>  include/linux/fs_parser.h | 1 -
>  3 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 66fd7d753e91..7c4216156950 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -174,7 +174,7 @@ int vfs_parse_fs_string(struct fs_context *fc, const char *key,
>  
>  	struct fs_parameter param = {
>  		.key	= key,
> -		.type	= fs_value_is_string,
> +		.type	= v_size ? fs_value_is_string : fs_value_is_flag,
>  		.size	= v_size,
>  	};

No.  This is simply wrong - as it is, there's no difference between
"foo" and "foo=".  Passing NULL in the latter case is wrong, but
this is not a good fix.

This
        if (v_size > 0) {
                param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
                if (!param.string)
                        return -ENOMEM;
        }
should really be
	if (value) {
                param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
                if (!param.string)
                        return -ENOMEM;
        }
and your chunk should be conditional upon value, not v_size.  The
same problem exists for rbd.c
