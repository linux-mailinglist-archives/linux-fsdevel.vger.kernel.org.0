Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B15C4F2065
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 22:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbfKFVGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 16:06:51 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38611 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732012AbfKFVGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 16:06:50 -0500
X-Originating-IP: 78.194.159.98
Received: from gandi.net (unknown [78.194.159.98])
        (Authenticated sender: thibaut@sautereau.fr)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 1E25D1C0003;
        Wed,  6 Nov 2019 21:06:46 +0000 (UTC)
Date:   Wed, 6 Nov 2019 22:06:46 +0100
From:   Thibaut Sautereau <thibaut@sautereau.fr>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        cgroups@vger.kernel.org
Subject: Re: NULL pointer deref in put_fs_context with unprivileged LXC
Message-ID: <20191106210646.GA1495@gandi.net>
References: <20191010213512.GA875@gandi.net>
 <20191011141403.ghjptf4nrttgg7jd@wittgenstein>
 <20191105205830.GA871@gandi.net>
 <20191106072407.GU26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106072407.GU26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 06, 2019 at 07:24:07AM +0000, Al Viro wrote:
> On Tue, Nov 05, 2019 at 09:58:30PM +0100, Thibaut Sautereau wrote:
> 
> > > > 	BUG: kernel NULL pointer dereference, address: 0000000000000043
> 
> ERR_PTR(something)->d_sb, most likely.
> 
> > > > 	493		if (fc->root) {
> > > > 	494			sb = fc->root->d_sb;
> > > > 	495			dput(fc->root);
> > > > 	496			fc->root = NULL;
> > > > 	497			deactivate_super(sb);
> > > > 	498		}
> 
> > 	fs_context: DEBUG: fc->root = fffffffffffffff3
> > 	fs_context: DEBUG: fc->source = cgroup2
> 
> Yup.  That'd be ERR_PTR(-13), i.e. ERR_PTR(-EACCES).  Most likely
> from
>                 nsdentry = kernfs_node_dentry(cgrp->kn, sb);
>                 dput(fc->root);
>                 fc->root = nsdentry;
>                 if (IS_ERR(nsdentry)) {
>                         ret = PTR_ERR(nsdentry);
>                         deactivate_locked_super(sb);
>                 }
> 
> in cgroup_do_get_tree().  As a quick test, try to add fc->root = NULL;
> next to that deactivate_locked_super(sb); inside the if (IS_ERR(...))
> body and see if it helps; it's not the best way to fix it (I'd rather
> go for
>                 if (IS_ERR(nsdentry)) {
>                         ret = PTR_ERR(nsdentry);
>                         deactivate_locked_super(sb);
> 			nsdentry = NULL;
>                 }
>                 fc->root = nsdentry;
> ), but it would serve to verify that this is the source of that crap.

Yes, you're absolutely right. Your first suggestion fixes the bug, as
well as your second one. Thanks!

By the way, I had just finished the bisection, confirming that
71d883c37e8d ("cgroup_do_mount(): massage calling conventions") brought
the issue.

Do you want me to send a patch or are you dealing with that?

-- 
Thibaut
