Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B5F11D8C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 22:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfLLVr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 16:47:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54628 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730831AbfLLVr0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:47:26 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifWIu-0001IZ-3M; Thu, 12 Dec 2019 21:47:24 +0000
Date:   Thu, 12 Dec 2019 21:47:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Laura Abbott <labbott@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] vfs: Handle file systems without ->parse_params better
Message-ID: <20191212214724.GL4203@ZenIV.linux.org.uk>
References: <20191212213604.19525-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212213604.19525-1-labbott@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 04:36:04PM -0500, Laura Abbott wrote:
> @@ -141,14 +191,19 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
>  		 */
>  		return ret;
>  
> -	if (fc->ops->parse_param) {
> -		ret = fc->ops->parse_param(fc, param);
> -		if (ret != -ENOPARAM)
> -			return ret;
> -	}
> +	parse_param = fc->ops->parse_param;
> +	if (!parse_param)
> +		parse_param = fs_generic_parse_param;
> +
> +	ret = parse_param(fc, param);
> +	if (ret != -ENOPARAM)
> +		return ret;
>  
> -	/* If the filesystem doesn't take any arguments, give it the
> -	 * default handling of source.
> +	/*
> +	 * File systems may have a ->parse_param function but rely on
> +	 * the top level to parse the source function. File systems
> +	 * may have their own source parsing though so this needs
> +	 * to come after the call to parse_param above.
>  	 */
>  	if (strcmp(param->key, "source") == 0) {
>  		if (param->type != fs_value_is_string)
> -- 
> 2.21.0

No.  Please, get rid of the boilerplate.  About 80% of that thing
is an absolutely pointless dance around "but we need that to call
fs_parse()".  We do *NOT* need to call fs_parse() here.  We do
not need a struct fs_parameter_description instance.  We do not
need struct fs_parameter_spec instances.  We do not need a magical
global constant.  And I'm not entirely convinced that we need
to make fs_generic_parse_param() default - filesystems that
want this behaviour can easily ask for it.  A sane default is
to reject any bogus options.

I would call it ignore_unknowns_parse_param(), while we are at it.
