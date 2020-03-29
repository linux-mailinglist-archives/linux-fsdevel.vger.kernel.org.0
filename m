Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11461196FE5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Mar 2020 22:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgC2U0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Mar 2020 16:26:02 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:50458 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgC2U0C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585513561; x=1617049561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XcOjDkKyHG8/20i13RYhVQ3x8zemgSzZm8uhpNUwYiE=;
  b=rYad5Tdodfper+h/wgQ0WZM9U57ZH5iP4IOswd06RgNvz35V0J8E/KjR
   Wls+3ph8KayZbd6UEuqVQy0WigMcah9NjCIbAFe5PR/PiMLOJCElgl7VG
   1d/VcKDjRDENZZzHag/sDLd8QEG+nRwoglGoy+cDBIB/QwMZ/3ZbYfHMl
   U=;
IronPort-SDR: n/JP9XR4uDPxBEzDr3ZBMGmWMp2P+vnlAA5YSiJO9jTDuL0S6zg3M32xoZ+mzDviGBQscdAMUf
 U6/0rE0WYlkQ==
X-IronPort-AV: E=Sophos;i="5.72,321,1580774400"; 
   d="scan'208";a="23212012"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 29 Mar 2020 20:25:48 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id B9D04A2651;
        Sun, 29 Mar 2020 20:25:47 +0000 (UTC)
Received: from EX13D20UEE002.ant.amazon.com (10.43.62.204) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 29 Mar 2020 20:25:46 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D20UEE002.ant.amazon.com (10.43.62.204) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 29 Mar 2020 20:25:46 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Sun, 29 Mar 2020 20:25:46 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 42604C13B4; Sun, 29 Mar 2020 20:25:46 +0000 (UTC)
Date:   Sun, 29 Mar 2020 20:25:46 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>
Subject: vfs_listxattr and the NFS server: namespaces
Message-ID: <20200329202546.GA31026@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200327232717.15331-1-fllinden@amazon.com>
 <20200327232717.15331-11-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200327232717.15331-11-fllinden@amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:27:16PM +0000, Frank van der Linden wrote:
> Implement the main entry points for the *XATTR operations.
> 
> Add functions to calculate the reply size for the user extended attribute
> operations, and implement the XDR encode / decode logic for these
> operations.
> 
> Add the user extended attributes operations to nfsd4_ops.

The reason I Cc-ed this one to linux-fsdevel, is the following piece of
code:
> +	/*
> +	 * Unfortunately, there is no interface to only list xattrs for
> +	 * one prefix. So there is no good way to convert maxcount to
> +	 * a maximum value to pass to vfs_listxattr, as we don't know
> +	 * how many of the returned attributes will be user attributes.
> +	 *
> +	 * So, always ask vfs_listxattr for the maximum size, and encode
> +	 * as many as possible.
> +	 */
> +	listxattrs->lsxa_buf = svcxdr_tmpalloc(argp, XATTR_LIST_MAX);
> +	if (!listxattrs->lsxa_buf)
> +		status = nfserr_jukebox;
> +
> +	DECODE_TAIL;
> +}

Naturally, it is a waste to always (temporarily) allocate XATTR_LIST_MAX
(currently 64k) bytes for every listxattr request, when in reality you
probably won't need anywhere near that.

The reason for doing that is that, while the NFS request comes with a 
maximum size, you can't translate that in to a maximum size to pass
to vfs_listxattr, since you are specifying the max size for "user."
extended attributes only, since that is the namespace that the NFS
implementation is restricted to. But vfs_listxattr always retrieves
all extended attributes.

The question is then: how to avoid doing that? It might be a good
idea to be able to specify a namespace to vfs_listxattr. This isn't
terribly hard to implement, and can be phased in. E.g:

* Add a "const char *namespace" argument to the listxattr inode op
* For the normal use case it will be NULL, meaning all xattrs. This
  includes use in the system call path (a new system call that
  includes a namespace argument could be added).
* A filesystem that does not support only returning xattrs for one
  namespace will return a specified error if @namespace != NULL, after
  which the fs-indepdent code in fs/xattr.c falls back to pre-allocating
  an XATTR_LIST_MAX buffer and then filtering out all attributes that
  are not in the specified namespace.
* Since the initial use is from the NFS code, converting XFS and ext4
  to support the @namespace argument should catch most use cases of
  the @namespace argument, the rest can be converted over time.

Does this sound reasonable? Or is it overkill?

Another way to do it is to add a vfs_listxattr_alloc variant, and
have the NFS server code filter out the user. xattrs as now. There is
one problem with that: it's possible for the size of listxattr result
to increase between the first null (length probe) call and the second call,
in which case the NFS server would return a spurious error. A small chance,
but it's there nonetheless. And it would be hard to distinguish from
other errors. So I think I still would prefer using an extra namespace
argument.

Alternatively, we could decide that the temporarily allocation of 64k
is no big deal.

Thoughts?

- Frank
