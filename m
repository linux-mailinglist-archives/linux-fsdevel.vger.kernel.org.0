Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C1D43F924
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 10:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhJ2Iqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 04:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229874AbhJ2Iqp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:46:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6904660FE3;
        Fri, 29 Oct 2021 08:44:14 +0000 (UTC)
Date:   Fri, 29 Oct 2021 10:44:11 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v4 01/13] fs_parse: allow parameter value to be empty
Message-ID: <20211029084411.zk32u3hflf2vdzmx@wittgenstein>
References: <20211027141857.33657-1-lczerner@redhat.com>
 <20211027141857.33657-2-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211027141857.33657-2-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27, 2021 at 04:18:45PM +0200, Lukas Czerner wrote:
> Allow parameter value to be empty by specifying fs_param_can_be_empty
> flag.

Hey Lukas,

what option is this for? Usually this should be handled by passing
FSCONFIG_SET_FLAG. Doesn't seem like a good idea to let the string value
be optionally empty. I'd rather have the guarantee that it has to be
something instead of having to be extra careful because it could be NULL.

> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  fs/fs_parser.c            | 31 +++++++++++++++++++++++--------
>  include/linux/fs_parser.h |  2 +-
>  2 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index 3df07c0e32b3..ed40ce5742fd 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -199,6 +199,8 @@ int fs_param_is_bool(struct p_log *log, const struct fs_parameter_spec *p,
>  	int b;
>  	if (param->type != fs_value_is_string)
>  		return fs_param_bad_value(log, param);
> +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> +		return 0;
>  	b = lookup_constant(bool_names, param->string, -1);
>  	if (b == -1)
>  		return fs_param_bad_value(log, param);
> @@ -211,8 +213,11 @@ int fs_param_is_u32(struct p_log *log, const struct fs_parameter_spec *p,
>  		    struct fs_parameter *param, struct fs_parse_result *result)
>  {
>  	int base = (unsigned long)p->data;
> -	if (param->type != fs_value_is_string ||
> -	    kstrtouint(param->string, base, &result->uint_32) < 0)
> +	if (param->type != fs_value_is_string)
> +		return fs_param_bad_value(log, param);
> +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> +		return 0;
> +	if (kstrtouint(param->string, base, &result->uint_32) < 0)
>  		return fs_param_bad_value(log, param);
>  	return 0;
>  }
> @@ -221,8 +226,11 @@ EXPORT_SYMBOL(fs_param_is_u32);
>  int fs_param_is_s32(struct p_log *log, const struct fs_parameter_spec *p,
>  		    struct fs_parameter *param, struct fs_parse_result *result)
>  {
> -	if (param->type != fs_value_is_string ||
> -	    kstrtoint(param->string, 0, &result->int_32) < 0)
> +	if (param->type != fs_value_is_string)
> +		return fs_param_bad_value(log, param);
> +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> +		return 0;
> +	if (kstrtoint(param->string, 0, &result->int_32) < 0)
>  		return fs_param_bad_value(log, param);
>  	return 0;
>  }
> @@ -231,8 +239,11 @@ EXPORT_SYMBOL(fs_param_is_s32);
>  int fs_param_is_u64(struct p_log *log, const struct fs_parameter_spec *p,
>  		    struct fs_parameter *param, struct fs_parse_result *result)
>  {
> -	if (param->type != fs_value_is_string ||
> -	    kstrtoull(param->string, 0, &result->uint_64) < 0)
> +	if (param->type != fs_value_is_string)
> +		return fs_param_bad_value(log, param);
> +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> +		return 0;
> +	if (kstrtoull(param->string, 0, &result->uint_64) < 0)
>  		return fs_param_bad_value(log, param);
>  	return 0;
>  }
> @@ -244,6 +255,8 @@ int fs_param_is_enum(struct p_log *log, const struct fs_parameter_spec *p,
>  	const struct constant_table *c;
>  	if (param->type != fs_value_is_string)
>  		return fs_param_bad_value(log, param);
> +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> +		return 0;
>  	c = __lookup_constant(p->data, param->string);
>  	if (!c)
>  		return fs_param_bad_value(log, param);
> @@ -255,7 +268,8 @@ EXPORT_SYMBOL(fs_param_is_enum);
>  int fs_param_is_string(struct p_log *log, const struct fs_parameter_spec *p,
>  		       struct fs_parameter *param, struct fs_parse_result *result)
>  {
> -	if (param->type != fs_value_is_string || !*param->string)
> +	if (param->type != fs_value_is_string ||
> +	    (!*param->string && !(p->flags & fs_param_can_be_empty)))
>  		return fs_param_bad_value(log, param);
>  	return 0;
>  }
> @@ -275,7 +289,8 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
>  {
>  	switch (param->type) {
>  	case fs_value_is_string:
> -		if (kstrtouint(param->string, 0, &result->uint_32) < 0)
> +		if ((!*param->string && !(p->flags & fs_param_can_be_empty)) ||
> +		    kstrtouint(param->string, 0, &result->uint_32) < 0)
>  			break;
>  		if (result->uint_32 <= INT_MAX)
>  			return 0;
> diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
> index aab0ffc6bac6..f103c91139d4 100644
> --- a/include/linux/fs_parser.h
> +++ b/include/linux/fs_parser.h
> @@ -42,7 +42,7 @@ struct fs_parameter_spec {
>  	u8			opt;	/* Option number (returned by fs_parse()) */
>  	unsigned short		flags;
>  #define fs_param_neg_with_no	0x0002	/* "noxxx" is negative param */
> -#define fs_param_neg_with_empty	0x0004	/* "xxx=" is negative param */
> +#define fs_param_can_be_empty	0x0004	/* "xxx=" is allowed */
>  #define fs_param_deprecated	0x0008	/* The param is deprecated */
>  	const void		*data;
>  };
> -- 
> 2.31.1
> 
