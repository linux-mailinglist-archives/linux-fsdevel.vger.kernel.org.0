Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D591F11D8A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 22:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfLLVgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 16:36:14 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54506 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731134AbfLLVgO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:36:14 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifW81-0000rX-8D; Thu, 12 Dec 2019 21:36:09 +0000
Date:   Thu, 12 Dec 2019 21:36:09 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfs: Don't reject unknown parameters
Message-ID: <20191212213609.GK4203@ZenIV.linux.org.uk>
References: <20191212145042.12694-1-labbott@redhat.com>
 <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com>
 <fbe90a0b-cf24-8c0c-48eb-6183852dfbf1@redhat.com>
 <CAHk-=wh7Wuk9QCP6oH5Qc1a89_X6H1CHRK_OyB4NLmX7nRYJeA@mail.gmail.com>
 <cf4c9634-1503-d182-cb12-810fb969bc96@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf4c9634-1503-d182-cb12-810fb969bc96@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 03:01:56PM -0500, Laura Abbott wrote:

> +static const struct fs_parameter_spec no_opt_fs_param_specs[] = {
> +        fsparam_string  ("source",              NO_OPT_SOURCE),
> +        {}
> +};
> +
> +const struct fs_parameter_description no_opt_fs_parameters = {
> +        .name           = "no_opt_fs",
> +        .specs          = no_opt_fs_param_specs,
> +};
> +
> +int fs_no_opt_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +        struct fs_parse_result result;
> +        int opt;
> +
> +        opt = fs_parse(fc, &no_opt_fs_parameters, param, &result);
> +        if (opt < 0) {
> +                /* Just log an error for backwards compatibility */
> +                errorf(fc, "%s: Unknown parameter '%s'",
> +                      fc->fs_type->name, param->key);
> +                return 0;
> +        }
> +
> +        switch (opt) {
> +        case NO_OPT_SOURCE:
> +                if (param->type != fs_value_is_string)
> +                        return invalf(fc, "%s: Non-string source",
> +					fc->fs_type->name);
> +                if (fc->source)
> +                        return invalf(fc, "%s: Multiple sources specified",
> +					fc->fs_type->name);
> +                fc->source = param->string;
> +                param->string = NULL;
> +                break;
> +        }
> +
> +        return 0;
> +}
> +EXPORT_SYMBOL(fs_no_opt_parse_param);

Yecchhhh...   Could you explain why do you want to bother with fs_parse()
here?  Seriously, look at it.
{
        const struct fs_parameter_spec *p;
        const struct fs_parameter_enum *e;
        int ret = -ENOPARAM, b;

        result->has_value = !!param->string;
        result->negated = false;
        result->uint_64 = 0;

        p = fs_lookup_key(desc, param->key);
OK, that's
	if (strcmp(param->key, "source") == 0)
		p = no_opt_fs_param_specs;
	else
		p = NULL;
	
        if (!p) {
not "source"
                /* If we didn't find something that looks like "noxxx", see if
                 * "xxx" takes the "no"-form negative - but only if there
                 * wasn't an value.
                 */
                if (result->has_value)
                        goto unknown_parameter;
if param->string is non-NULL - piss off

                if (param->key[0] != 'n' || param->key[1] != 'o' || !param->key[2])
                        goto unknown_parameter;
if not "no"<something> - ditto

                p = fs_lookup_key(desc, param->key + 2);
                if (!p)
                        goto unknown_parameter;
if not "nosource" - ditto
                if (!(p->flags & fs_param_neg_with_no))
                        goto unknown_parameter;
... and since ->flags doesn't have that bit, the same for "nosource" anyway.
                result->boolean = false;
                result->negated = true;
won't get here
        }

OK, so the above is simply 'piss off unless param->key is "source"'.  And
p is no_opt_fs_param_specs.

        if (p->flags & fs_param_deprecated)
nope
                warnf(fc, "%s: Deprecated parameter '%s'",
                      desc->name, param->key);

        if (result->negated)
                goto okay;
nope - set to false, never changed
        /* Certain parameter types only take a string and convert it. */
        switch (p->type) {
that'd be fs_param_is_string
...
        case fs_param_is_string:
                if (param->type != fs_value_is_string)
                        goto bad_value;
                if (!result->has_value) {
if param->string is NULL...
                        if (p->flags & fs_param_v_optional)
nope
                                goto okay;
                        goto bad_value;
                }
                /* Fall through */
        default:
                break;
        }

        /* Try to turn the type we were given into the type desired by the
         * parameter and give an error if we can't.
         */
        switch (p->type) {
again, fs_param_is_string
...
        case fs_param_is_string:
                goto okay;
...
okay:
        return p->opt;
bad_value:
        return invalf(fc, "%s: Bad value for '%s'", desc->name, param->key);
unknown_parameter:
        return -ENOPARAM;


In other words, that thing is equivalent to
	if (strcmp(param->key, "source")) {
		errorf(fc, "%s: Unknown parameter '%s'",
			fc->fs_type->name, param->key);
		return 0;
	}
	if (param->type != fs_value_is_string || !param->value) {
		invalf(fc, "%s: Bad value for '%s'", fc->fs_type->name, param->key);
		errorf(fc, "%s: Unknown parameter '%s'",
			fc->fs_type->name, param->key);
		return 0; // almost certainly not what you intended for that case
	}
	if (fc->source)
		return invalf(fc, "%s: Multiple sources specified", fc->fs_type->name);
	fc->source = param->string;
	param->string = NULL;
	return 0;

And that - without the boilerplate from hell.  But if you look at the caller of
that method, you'll see this:
        if (fc->ops->parse_param) {
                ret = fc->ops->parse_param(fc, param);
                if (ret != -ENOPARAM)
                        return ret;
        }

        /* If the filesystem doesn't take any arguments, give it the
         * default handling of source.
         */
        if (strcmp(param->key, "source") == 0) {
                if (param->type != fs_value_is_string)
                        return invalf(fc, "VFS: Non-string source");
                if (fc->source)
                        return invalf(fc, "VFS: Multiple sources");
                fc->source = param->string;
                param->string = NULL;
                return 0;
        }

        return invalf(fc, "%s: Unknown parameter '%s'",
                      fc->fs_type->name, param->key);
} 

So you could bloody well just leave recognition (and handling) of "source"
to the caller, leaving you with just this:

	if (strcmp(param->key, "source") == 0)
		return -ENOPARAM;
	/* Just log an error for backwards compatibility */
	errorf(fc, "%s: Unknown parameter '%s'", fc->fs_type->name, param->key);
	return 0;

and that's it.
