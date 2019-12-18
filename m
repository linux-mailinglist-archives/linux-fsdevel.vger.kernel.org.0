Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1865123E43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 05:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfLREGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 23:06:53 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55532 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLREGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:06:53 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihQbr-0002cz-KC; Wed, 18 Dec 2019 04:06:51 +0000
Date:   Wed, 18 Dec 2019 04:06:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH V2] fs_parser: remove fs_parameter_description name field
Message-ID: <20191218040651.GH4203@ZenIV.linux.org.uk>
References: <22be7526-d9da-5309-22a8-3405ed1c0842@sandeen.net>
 <20191218033606.GF4203@ZenIV.linux.org.uk>
 <c83d12e2-59a1-7f35-0544-150515db9434@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c83d12e2-59a1-7f35-0544-150515db9434@sandeen.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 09:43:44PM -0600, Eric Sandeen wrote:
> On 12/17/19 9:36 PM, Al Viro wrote:
> > On Fri, Dec 06, 2019 at 10:31:57AM -0600, Eric Sandeen wrote:
> >> There doesn't seem to be a strong reason to have a copy of the
> >> filesystem name string in the fs_parameter_description structure;
> >> it's easy enough to get the name from the fs_type, and using it
> >> instead ensures consistency across messages (for example,
> >> vfs_parse_fs_param() already uses fc->fs_type->name for the error
> >> messages, because it doesn't have the fs_parameter_description).
> > 
> > Arrgh...  That used to be fine.  Now we have this:
> > static int rbd_parse_param(struct fs_parameter *param,
> >                             struct rbd_parse_opts_ctx *pctx)
> > {
> >         struct rbd_options *opt = pctx->opts;
> >         struct fs_parse_result result; 
> >         int token, ret;
> > 
> >         ret = ceph_parse_param(param, pctx->copts, NULL);
> >         if (ret != -ENOPARAM)
> >                 return ret;
> > 
> >         token = fs_parse(NULL, rbd_parameters, param, &result);
> > 			 ^^^^
> > 
> > 	Cthulhu damn it...  And yes, that crap used to work.
> > Frankly, I'm tempted to allocate fs_context in there (in
> > rbd_parse_options(), or in rbd_add_parse_args()) - we've other
> > oddities due to that...
> > 
> > 	Alternatively, we could provide __fs_parse() that
> > would take name as a separate argument and accepted NULL fc,
> > with fs_parse() being a wrapper for that.
> > 
> > *grumble*
> 
> FYI be careful if you do munge this in, V2 inexplicably killed the name in
> the fs_type for afs.  V3 fixed that thinko or whatever it was.

I used v3, anyway...  The reason I'm rather unhappy about the
entire situation is that in the end of that series I have
fs_param_is_u32() et.al. being _functions_.  With switch in
fs_parse() gone.

Typical instance looks like this:

int fs_param_is_enum(struct fs_context *fc, const struct fs_parameter_spec *p,
                     struct fs_parameter *param, struct fs_parse_result *result)
{
        const struct constant_table *c;
        if (param->type != fs_value_is_string)
                return fs_param_bad_value(fc, param);
        c = __lookup_constant(p->data, param->string);
        if (!c)
                return fs_param_bad_value(fc, param);
        result->uint_32 = c->value;
        return 0;
}

and I would rather not breed the arguments here ;-/  I could take logging
into the fs_parse() itself (it's very similar in all current instances),
but... if we go for something like

int fs_param_is_range(struct fs_context *fc, const struct fs_parameter_spec *p,
                     struct fs_parameter *param, struct fs_parse_result *result)
{
	const struct {u32 from, to;} *range = p->data;

        if (param->type != fs_value_is_string ||
	    kstrtouint(param->string, 0, &result->uint_32) < 0)
                return fs_param_bad_value(fc, param);
	
	if (result->uint_32 < range->from || result->uint_32 > range->to)
		return invalf(fc, "%s: Value for %s must be in [%u..%u]",
				fc->fs_type->name, param->key, range->from,
				range->to);
        return 0;
}
which is not all that unreasonable, the requirement of handling all
warnings in fs_parse() becomes unfeasible.  And the main reason for
conversion to method is the pressure to provide such custom types -
stuff like <number>{|K|M|G} for memory sizes, etc.

Shite...  We can, of course, pass the name to instances, but... *ugh*
