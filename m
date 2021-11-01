Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E54E4416DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 10:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhKAJaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 05:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233041AbhKAJ2R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 05:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635758743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=53OXlpDvni31LvIaln3YOdZGCjMTf4uZ9h8tjAcr9uc=;
        b=VSkBpMt9safA+wf+/e1/a9yk+QNgzzaOg8KpCBhFyC1/vPvhaEolxlAlp7Ln22UJUte4FJ
        7kBsMEZENVUaLVUQ9ceo39cyl8123AVjcjOFDPPvkNKH2+3boMdDfjDKeG4dl4Oh3LG26c
        +Z46ol0NlyHSA4YFCO4Mp81I7+/6Jws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-oEMrv1l3OUeU-98a7vTv4w-1; Mon, 01 Nov 2021 05:25:40 -0400
X-MC-Unique: oEMrv1l3OUeU-98a7vTv4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2149610A8E00;
        Mon,  1 Nov 2021 09:25:39 +0000 (UTC)
Received: from work (unknown [10.40.194.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86EE41007605;
        Mon,  1 Nov 2021 09:25:29 +0000 (UTC)
Date:   Mon, 1 Nov 2021 10:25:25 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v4 01/13] fs_parse: allow parameter value to be empty
Message-ID: <20211101092525.pdwtufampfajze5l@work>
References: <20211027141857.33657-1-lczerner@redhat.com>
 <20211027141857.33657-2-lczerner@redhat.com>
 <20211029084411.zk32u3hflf2vdzmx@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029084411.zk32u3hflf2vdzmx@wittgenstein>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 10:44:11AM +0200, Christian Brauner wrote:
> On Wed, Oct 27, 2021 at 04:18:45PM +0200, Lukas Czerner wrote:
> > Allow parameter value to be empty by specifying fs_param_can_be_empty
> > flag.
> 
> Hey Lukas,
> 
> what option is this for? Usually this should be handled by passing
> FSCONFIG_SET_FLAG. Doesn't seem like a good idea to let the string value
> be optionally empty. I'd rather have the guarantee that it has to be
> something instead of having to be extra careful because it could be NULL.

Hi Christian,

this is for ext4 mount options usrjquota and grpjquota that will treat
empty parameter, that is "grpjquota=" and "usrjquota=", as a means to
disable those. I agree that it's not ideal, but if I don't want to break
compatibilily when converting ext4 to this new mount API I have to keep
that option the way it is.

I share your concern, but for the string to be empty, the
fs_param_can_be_empty flag must be used intentionaly and so the code
handling this must expect the string to be empty in some cases.

Another option would be to use a flag parameter with the name including
the egual sign. Not sure if that's currently possible. But that would
require us to use separtate parameter and it feels even more clunky to
me especially since we can easly detect empty string instead.

Thanks!
-Lukas

> 
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
> > ---
> >  fs/fs_parser.c            | 31 +++++++++++++++++++++++--------
> >  include/linux/fs_parser.h |  2 +-
> >  2 files changed, 24 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> > index 3df07c0e32b3..ed40ce5742fd 100644
> > --- a/fs/fs_parser.c
> > +++ b/fs/fs_parser.c
> > @@ -199,6 +199,8 @@ int fs_param_is_bool(struct p_log *log, const struct fs_parameter_spec *p,
> >  	int b;
> >  	if (param->type != fs_value_is_string)
> >  		return fs_param_bad_value(log, param);
> > +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> > +		return 0;
> >  	b = lookup_constant(bool_names, param->string, -1);
> >  	if (b == -1)
> >  		return fs_param_bad_value(log, param);
> > @@ -211,8 +213,11 @@ int fs_param_is_u32(struct p_log *log, const struct fs_parameter_spec *p,
> >  		    struct fs_parameter *param, struct fs_parse_result *result)
> >  {
> >  	int base = (unsigned long)p->data;
> > -	if (param->type != fs_value_is_string ||
> > -	    kstrtouint(param->string, base, &result->uint_32) < 0)
> > +	if (param->type != fs_value_is_string)
> > +		return fs_param_bad_value(log, param);
> > +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> > +		return 0;
> > +	if (kstrtouint(param->string, base, &result->uint_32) < 0)
> >  		return fs_param_bad_value(log, param);
> >  	return 0;
> >  }
> > @@ -221,8 +226,11 @@ EXPORT_SYMBOL(fs_param_is_u32);
> >  int fs_param_is_s32(struct p_log *log, const struct fs_parameter_spec *p,
> >  		    struct fs_parameter *param, struct fs_parse_result *result)
> >  {
> > -	if (param->type != fs_value_is_string ||
> > -	    kstrtoint(param->string, 0, &result->int_32) < 0)
> > +	if (param->type != fs_value_is_string)
> > +		return fs_param_bad_value(log, param);
> > +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> > +		return 0;
> > +	if (kstrtoint(param->string, 0, &result->int_32) < 0)
> >  		return fs_param_bad_value(log, param);
> >  	return 0;
> >  }
> > @@ -231,8 +239,11 @@ EXPORT_SYMBOL(fs_param_is_s32);
> >  int fs_param_is_u64(struct p_log *log, const struct fs_parameter_spec *p,
> >  		    struct fs_parameter *param, struct fs_parse_result *result)
> >  {
> > -	if (param->type != fs_value_is_string ||
> > -	    kstrtoull(param->string, 0, &result->uint_64) < 0)
> > +	if (param->type != fs_value_is_string)
> > +		return fs_param_bad_value(log, param);
> > +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> > +		return 0;
> > +	if (kstrtoull(param->string, 0, &result->uint_64) < 0)
> >  		return fs_param_bad_value(log, param);
> >  	return 0;
> >  }
> > @@ -244,6 +255,8 @@ int fs_param_is_enum(struct p_log *log, const struct fs_parameter_spec *p,
> >  	const struct constant_table *c;
> >  	if (param->type != fs_value_is_string)
> >  		return fs_param_bad_value(log, param);
> > +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> > +		return 0;
> >  	c = __lookup_constant(p->data, param->string);
> >  	if (!c)
> >  		return fs_param_bad_value(log, param);
> > @@ -255,7 +268,8 @@ EXPORT_SYMBOL(fs_param_is_enum);
> >  int fs_param_is_string(struct p_log *log, const struct fs_parameter_spec *p,
> >  		       struct fs_parameter *param, struct fs_parse_result *result)
> >  {
> > -	if (param->type != fs_value_is_string || !*param->string)
> > +	if (param->type != fs_value_is_string ||
> > +	    (!*param->string && !(p->flags & fs_param_can_be_empty)))
> >  		return fs_param_bad_value(log, param);
> >  	return 0;
> >  }
> > @@ -275,7 +289,8 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
> >  {
> >  	switch (param->type) {
> >  	case fs_value_is_string:
> > -		if (kstrtouint(param->string, 0, &result->uint_32) < 0)
> > +		if ((!*param->string && !(p->flags & fs_param_can_be_empty)) ||
> > +		    kstrtouint(param->string, 0, &result->uint_32) < 0)
> >  			break;
> >  		if (result->uint_32 <= INT_MAX)
> >  			return 0;
> > diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
> > index aab0ffc6bac6..f103c91139d4 100644
> > --- a/include/linux/fs_parser.h
> > +++ b/include/linux/fs_parser.h
> > @@ -42,7 +42,7 @@ struct fs_parameter_spec {
> >  	u8			opt;	/* Option number (returned by fs_parse()) */
> >  	unsigned short		flags;
> >  #define fs_param_neg_with_no	0x0002	/* "noxxx" is negative param */
> > -#define fs_param_neg_with_empty	0x0004	/* "xxx=" is negative param */
> > +#define fs_param_can_be_empty	0x0004	/* "xxx=" is allowed */
> >  #define fs_param_deprecated	0x0008	/* The param is deprecated */
> >  	const void		*data;
> >  };
> > -- 
> > 2.31.1
> > 
> 

