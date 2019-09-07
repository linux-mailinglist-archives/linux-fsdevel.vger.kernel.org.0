Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A512AC72D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 17:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394688AbfIGPHj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Sep 2019 11:07:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50710 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732540AbfIGPHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Sep 2019 11:07:38 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i6cJK-0003cK-H1; Sat, 07 Sep 2019 15:07:34 +0000
Date:   Sat, 7 Sep 2019 16:07:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v3] ceph: Convert ceph to use the new mount API
Message-ID: <20190907150734.GB1131@ZenIV.linux.org.uk>
References: <20190906101618.8939-1-jlayton@kernel.org>
 <CAOi1vP-3aHy8yerpMkmA80WF1=e4umg_zCt8Dvc+X6V8-Dg+Qw@mail.gmail.com>
 <7a72bf67b17f78398604270a2cbfe5d145686377.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a72bf67b17f78398604270a2cbfe5d145686377.camel@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 04:10:24PM -0400, Jeff Layton wrote:
> > >         case Opt_queue_depth:
> > > -               if (intval < 1) {
> > > -                       pr_err("queue_depth out of range\n");
> > > -                       return -EINVAL;
> > > -               }
> > > -               pctx->opts->queue_depth = intval;
> > > +               if (result.uint_32 < 1)
> > > +                       goto out_of_range;
> > > +               opts->queue_depth = result.uint_32;

FWIW, I wonder if something like fsparam_int_range() would be
useful, both here and in other places.

NOTE: this is not going to happen until we get rid of trying to
enumerate those "types"; enum fs_parameter_type as it is now
is an invitation for trouble.

What I want to get at is a situation when fs_parameter_spec
"type" is a *method*, not an enumerator.  I'm not entirely
sure what would the right calling conventions be, though.

But fs_parse() switch is not sustainable - we can't keep
it long-term.  A really straigtforward approach would be
something along the lines of

bool is_string_param(const struct fs_parameter_spec *p,
	            struct fs_parameter *param)
{
	if (param->type != fs_value_is_string)
		return false;
	if (param->string)
		return true;
	return p->flags & fs_param_v_optional;
}

int fs_param_is_string(struct fs_context *fc,
		    const struct fs_parameter_spec *p,
	            struct fs_parameter *param,
		    struct fs_parse_result *result)
{
	if (is_string_param(p, param))
		return 0;
	return fs_param_bad(fc, param);
}

int fs_param_is_s32(struct fs_context *fc,
		    const struct fs_parameter_spec *p,
	            struct fs_parameter *param,
		    struct fs_parse_result *result)
{
	if (is_string_param(p, param)) {
		const char *s = param->string;
		result->int_32 = 0;
		if (!s || kstrtoint(s, 0, &result->int_32) == 0)
			return 0;
	}
	return fs_param_bad(fc, param);
}

int fs_param_is_blob(struct fs_context *fc,
		    const struct fs_parameter_spec *p,
	            struct fs_parameter *param,
		    struct fs_parse_result *result)
{
	return param->type == fs_value_is_blob ? 0 : fs_param_bad(fc, param);
}

int fs_param_is_fd(struct fs_context *fc,
		    const struct fs_parameter_spec *p,
	            struct fs_parameter *param,
		    struct fs_parse_result *result)
{
	if (param->type == fs_value_is_file) {
		result->uint_32 = param->dirfd;
                if (result->uint_32 <= INT_MAX)
			return 0;
	} else if (is_string_param(p, param)) {
		const char *s = param->string;

		if (s && kstrtouint(param->string, 0, &result->uint_32) == 0 &&
                    result->uint_32 <= INT_MAX)
			return 0;
        }
	return fs_param_bad(fc, param);
}

etc., but error reporting is clumsy that way ;-/
