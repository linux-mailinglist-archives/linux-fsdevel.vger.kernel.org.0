Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70323123E01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 04:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfLRDgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 22:36:08 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55176 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfLRDgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:36:08 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihQ86-0001fo-Jn; Wed, 18 Dec 2019 03:36:06 +0000
Date:   Wed, 18 Dec 2019 03:36:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH V2] fs_parser: remove fs_parameter_description name field
Message-ID: <20191218033606.GF4203@ZenIV.linux.org.uk>
References: <22be7526-d9da-5309-22a8-3405ed1c0842@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22be7526-d9da-5309-22a8-3405ed1c0842@sandeen.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 06, 2019 at 10:31:57AM -0600, Eric Sandeen wrote:
> There doesn't seem to be a strong reason to have a copy of the
> filesystem name string in the fs_parameter_description structure;
> it's easy enough to get the name from the fs_type, and using it
> instead ensures consistency across messages (for example,
> vfs_parse_fs_param() already uses fc->fs_type->name for the error
> messages, because it doesn't have the fs_parameter_description).

Arrgh...  That used to be fine.  Now we have this:
static int rbd_parse_param(struct fs_parameter *param,
                            struct rbd_parse_opts_ctx *pctx)
{
        struct rbd_options *opt = pctx->opts;
        struct fs_parse_result result; 
        int token, ret;

        ret = ceph_parse_param(param, pctx->copts, NULL);
        if (ret != -ENOPARAM)
                return ret;

        token = fs_parse(NULL, rbd_parameters, param, &result);
			 ^^^^

	Cthulhu damn it...  And yes, that crap used to work.
Frankly, I'm tempted to allocate fs_context in there (in
rbd_parse_options(), or in rbd_add_parse_args()) - we've other
oddities due to that...

	Alternatively, we could provide __fs_parse() that
would take name as a separate argument and accepted NULL fc,
with fs_parse() being a wrapper for that.

*grumble*
