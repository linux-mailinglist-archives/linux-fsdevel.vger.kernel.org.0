Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82CEEF1028
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 08:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfKFHYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 02:24:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56518 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfKFHYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:24:10 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSFfj-0005CX-5l; Wed, 06 Nov 2019 07:24:07 +0000
Date:   Wed, 6 Nov 2019 07:24:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Thibaut Sautereau <thibaut@sautereau.fr>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        cgroups@vger.kernel.org
Subject: Re: NULL pointer deref in put_fs_context with unprivileged LXC
Message-ID: <20191106072407.GU26530@ZenIV.linux.org.uk>
References: <20191010213512.GA875@gandi.net>
 <20191011141403.ghjptf4nrttgg7jd@wittgenstein>
 <20191105205830.GA871@gandi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105205830.GA871@gandi.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 05, 2019 at 09:58:30PM +0100, Thibaut Sautereau wrote:

> > > 	BUG: kernel NULL pointer dereference, address: 0000000000000043

ERR_PTR(something)->d_sb, most likely.

> > > 	493		if (fc->root) {
> > > 	494			sb = fc->root->d_sb;
> > > 	495			dput(fc->root);
> > > 	496			fc->root = NULL;
> > > 	497			deactivate_super(sb);
> > > 	498		}

> 	fs_context: DEBUG: fc->root = fffffffffffffff3
> 	fs_context: DEBUG: fc->source = cgroup2

Yup.  That'd be ERR_PTR(-13), i.e. ERR_PTR(-EACCES).  Most likely
from
                nsdentry = kernfs_node_dentry(cgrp->kn, sb);
                dput(fc->root);
                fc->root = nsdentry;
                if (IS_ERR(nsdentry)) {
                        ret = PTR_ERR(nsdentry);
                        deactivate_locked_super(sb);
                }

in cgroup_do_get_tree().  As a quick test, try to add fc->root = NULL;
next to that deactivate_locked_super(sb); inside the if (IS_ERR(...))
body and see if it helps; it's not the best way to fix it (I'd rather
go for
                if (IS_ERR(nsdentry)) {
                        ret = PTR_ERR(nsdentry);
                        deactivate_locked_super(sb);
			nsdentry = NULL;
                }
                fc->root = nsdentry;
), but it would serve to verify that this is the source of that crap.
