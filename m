Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF803A4B9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jun 2021 02:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFLAJc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 20:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLAJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 20:09:32 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58B1C061574;
        Fri, 11 Jun 2021 17:07:33 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrrBG-0078iT-5C; Sat, 12 Jun 2021 00:07:18 +0000
Date:   Sat, 12 Jun 2021 00:07:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/7] kernfs: use VFS negative dentry caching
Message-ID: <YMP6topegaTXGNgC@zeniv-ca.linux.org.uk>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
 <162322862726.361452.10114120072438540655.stgit@web.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162322862726.361452.10114120072438540655.stgit@web.messagingengine.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 09, 2021 at 04:50:27PM +0800, Ian Kent wrote:

> +	if (d_really_is_negative(dentry)) {
> +		struct dentry *d_parent = dget_parent(dentry);
> +		struct kernfs_node *parent;

What the hell is dget_parent() for?  You don't do anything blocking
here, so why not simply grab dentry->d_lock - that'll stabilize
the value of ->d_parent just fine.  Just don't forget to drop the
lock before returning and that's it...

> +		/* If the kernfs parent node has changed discard and
> +		 * proceed to ->lookup.
> +		 */
> +		parent = kernfs_dentry_node(d_parent);
> +		if (parent) {
> +			if (kernfs_dir_changed(parent, dentry)) {
> +				dput(d_parent);
> +				return 0;
> +			}
> +		}
> +		dput(d_parent);
> +
> +		/* The kernfs node doesn't exist, leave the dentry
> +		 * negative and return success.
> +		 */
> +		return 1;
> +	}
