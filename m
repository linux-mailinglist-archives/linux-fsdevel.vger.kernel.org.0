Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 780BD127179
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 00:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfLSX3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 18:29:53 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57032 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLSX3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 18:29:53 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ii5Et-0004ur-MU; Thu, 19 Dec 2019 23:29:51 +0000
Date:   Thu, 19 Dec 2019 23:29:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH V2] fs_parser: remove fs_parameter_description name field
Message-ID: <20191219232951.GL4203@ZenIV.linux.org.uk>
References: <22be7526-d9da-5309-22a8-3405ed1c0842@sandeen.net>
 <20191218033606.GF4203@ZenIV.linux.org.uk>
 <c83d12e2-59a1-7f35-0544-150515db9434@sandeen.net>
 <20191218040651.GH4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218040651.GH4203@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 04:06:51AM +0000, Al Viro wrote:
> On Tue, Dec 17, 2019 at 09:43:44PM -0600, Eric Sandeen wrote:
> > On 12/17/19 9:36 PM, Al Viro wrote:
> > > On Fri, Dec 06, 2019 at 10:31:57AM -0600, Eric Sandeen wrote:
> > >> There doesn't seem to be a strong reason to have a copy of the
> > >> filesystem name string in the fs_parameter_description structure;
> > >> it's easy enough to get the name from the fs_type, and using it
> > >> instead ensures consistency across messages (for example,
> > >> vfs_parse_fs_param() already uses fc->fs_type->name for the error
> > >> messages, because it doesn't have the fs_parameter_description).
> > > 
> > > Arrgh...  That used to be fine.  Now we have this:
> > > static int rbd_parse_param(struct fs_parameter *param,
> > >                             struct rbd_parse_opts_ctx *pctx)
> > > {
> > >         struct rbd_options *opt = pctx->opts;
> > >         struct fs_parse_result result; 
> > >         int token, ret;
> > > 
> > >         ret = ceph_parse_param(param, pctx->copts, NULL);
> > >         if (ret != -ENOPARAM)
> > >                 return ret;
> > > 
> > >         token = fs_parse(NULL, rbd_parameters, param, &result);
> > > 			 ^^^^
> > > 
> > > 	Cthulhu damn it...  And yes, that crap used to work.
> > > Frankly, I'm tempted to allocate fs_context in there (in
> > > rbd_parse_options(), or in rbd_add_parse_args()) - we've other
> > > oddities due to that...
> > > 
> > > 	Alternatively, we could provide __fs_parse() that
> > > would take name as a separate argument and accepted NULL fc,
> > > with fs_parse() being a wrapper for that.
> > > 
> > > *grumble*
> > 
> > FYI be careful if you do munge this in, V2 inexplicably killed the name in
> > the fs_type for afs.  V3 fixed that thinko or whatever it was.
> 
> I used v3, anyway...  The reason I'm rather unhappy about the
> entire situation is that in the end of that series I have
> fs_param_is_u32() et.al. being _functions_.  With switch in
> fs_parse() gone.
> 
> Typical instance looks like this:
> 
> int fs_param_is_enum(struct fs_context *fc, const struct fs_parameter_spec *p,
>                      struct fs_parameter *param, struct fs_parse_result *result)
> {
>         const struct constant_table *c;
>         if (param->type != fs_value_is_string)
>                 return fs_param_bad_value(fc, param);
>         c = __lookup_constant(p->data, param->string);
>         if (!c)
>                 return fs_param_bad_value(fc, param);
>         result->uint_32 = c->value;
>         return 0;
> }
> 
> and I would rather not breed the arguments here ;-/  I could take logging
> into the fs_parse() itself (it's very similar in all current instances),
> but... if we go for something like
> 
> int fs_param_is_range(struct fs_context *fc, const struct fs_parameter_spec *p,
>                      struct fs_parameter *param, struct fs_parse_result *result)
> {
> 	const struct {u32 from, to;} *range = p->data;
> 
>         if (param->type != fs_value_is_string ||
> 	    kstrtouint(param->string, 0, &result->uint_32) < 0)
>                 return fs_param_bad_value(fc, param);
> 	
> 	if (result->uint_32 < range->from || result->uint_32 > range->to)
> 		return invalf(fc, "%s: Value for %s must be in [%u..%u]",
> 				fc->fs_type->name, param->key, range->from,
> 				range->to);
>         return 0;
> }
> which is not all that unreasonable, the requirement of handling all
> warnings in fs_parse() becomes unfeasible.  And the main reason for
> conversion to method is the pressure to provide such custom types -
> stuff like <number>{|K|M|G} for memory sizes, etc.
> 
> Shite...  We can, of course, pass the name to instances, but... *ugh*

OK...  Some observations after looking through that stuff:

1) there is a legitimate need to use fs_parse() (or at least its underlying
machinery) outside of anything mount-related.  One case already in mainline
is ceph and rbd sharing parts of the syntax (libceph stuff).  There almost
certainly will be more.

2) fs_parse() is a bit of misnomer - it decides which option it is and
does things like conversion of string to number, etc., but it does not
manipulate the parser state.  Its _caller_ (->parse_param(), usually)
does.

3) right now the only part of fs_context used by the damn thing is fc->log;
Eric's patch adds fc->fs_type->name.  Note that it's used only for logging
purposes.

4) the primitives used for logging (invalf, errorf, warnf) are taking
fs_context; however, the only part being used is fc->log.  NULL fs_context
is treated as NULL fc_log, which means "log via printk".

5) absolute majority of log messages are prefixed, usually by fs type
name.  The few that are not probably ought to be - e.g. the things like
arch/powerpc/platforms/cell/spufs/inode.c:629:                  return invalf(fc, "Unknown uid");
would be better off with spufs: unknown uid.

We could require _some_ fs_context to be supplied by all callers,
mount-related or not.  However, considering the above, that looks rather
unnatural, especially if we go ahead and allow fc->fs_type->name uses.

Alternatively, we could pass fc_log + prefix; fs_parse() itself would
remain as-is, becoming a wrapper for __fs_parse() that would take
fs_log + string instead of fs_context.  Potentially unpleasant part
that way: option recognition has no access to the data from previously
processed options.  Another inconvenience is that we get an extra
argument to pass into fs_param_is_...().

One note on logfc(): it tries to be smarter than it's worth being -
in the reality it _never_ gets bare "%s" as format; there's always
"w ", "e " or "i " in the beginning.  So this part
        if (strcmp(fmt, "%s") == 0) {
                p = va_arg(va, const char *);
                goto unformatted_string;
        }
in there is pointless (at least in the current form).

I wonder if we should do the following:
	* structure with two members - pointer to fc_log and a string
(prefix) embedded into fs_context, in place of ->log.
	* __logfc() taking pointer to that struct, integer or
character representing the "log level", then format and vararg part.
	* warnf() being simply __logfc(&fc->log, 'w', fmt, ## __VA_ARGS__)
	* __logfc() using "%c %s%s%pV",
				loglevel,
				prefix?prefix:"",
				prefix ? ":" : "",
				fmt, va
for kvasprintf() (assuming that %pV *can* be used with it, of course)
	* const char *set_log_prefix(pointer, string) replacing the
prefix field of the struct and returning the original.  fs_context
allocation would set it to fs_type->name.
	* __fs_parse() would be taking a pointer to that field of
fs_context instead of the entire thing; ditto for fs_param_is_...()
	* rbd would create a local structure with "rbd" for prefix
and NULL for log
	* net/ceph would replace the prefix in the thing it has
been given with "libceph" and revert back to original in the end

The most worrying part in that is kvasprintf interplay with %pV -
we might need to open-code it, since we need va_copy() not of that
sucker's arguments, but of the va_list one level deeper.  But with
that open-coding (and it's not all that scary, really -
	va_list va;
	va_list va_copy;

	va_start(va, fmt);
	va_copy(va_copy, va);
	size = snprintf(NULL, 0, "%c %s%s%pV",
			loglevel, prefix ? prefix : "",
			prefix ? ":" : "", fmt, va_copy);
	va_end(va_copy);
	p = kmalloc(size + 1, GFP_KERNEL);
	if (!p)
		sod off
	snprintf(p, size + 1, "%c %s%s%pV",
		loglevel, prefix?prefix:"",
		prefix ? ":" : "", fmt, va);
	va_end(va);
) it ought to be feasible, AFAICS...

Comments?  Oh, and for "log to printk" case we can bloody well
get rid of allocation and just do printk with the right
loglevel and format modified in the obvious way...
