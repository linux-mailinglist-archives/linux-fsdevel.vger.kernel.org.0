Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAA4359182
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 03:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhDIBfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 21:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhDIBfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:35:34 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B46EC061760;
        Thu,  8 Apr 2021 18:35:22 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUg37-003sOh-1m; Fri, 09 Apr 2021 01:35:05 +0000
Date:   Fri, 9 Apr 2021 01:35:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] kernfs: use VFS negative dentry caching
Message-ID: <YG+vSdNLmgwXrwgJ@zeniv-ca.linux.org.uk>
References: <161793058309.10062.17056551235139961080.stgit@mickey.themaw.net>
 <161793090597.10062.4954029445418116308.stgit@mickey.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161793090597.10062.4954029445418116308.stgit@mickey.themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 09, 2021 at 09:15:06AM +0800, Ian Kent wrote:
> +		parent = kernfs_dentry_node(dentry->d_parent);
> +		if (parent) {
> +			const void *ns = NULL;
> +
> +			if (kernfs_ns_enabled(parent))
> +				ns = kernfs_info(dentry->d_parent->d_sb)->ns;

	For any dentry d, we have d->d_parent->d_sb == d->d_sb.  All the time.
If you ever run into the case where that would not be true, you've found
a critical bug.

> +			kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
> +			if (kn)
> +				goto out_bad;
> +		}

Umm...  What's to prevent a race with successful rename(2)?  IOW, what's
there to stabilize ->d_parent and ->d_name while we are in that function?
