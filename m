Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66175358948
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 18:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhDHQI5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 12:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhDHQI4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:08:56 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103A0C061760;
        Thu,  8 Apr 2021 09:08:45 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 3F83C6A45; Thu,  8 Apr 2021 12:08:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 3F83C6A45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1617898124;
        bh=axZmNLbDt/fZw4wakJsGKJ/9lF8NGgPgczwwcmcr32s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xzRf39kkb5hbJHo0vMxninggJzrJFmP9k3bGOI0VrOm838dNeBBQcMVy2e2tkSJL5
         9N1AP8yMFnPrJltc5g2p7gJftMcmndLP4ULkrxHTWNs8PUqWeIrYF68m7ovuS/N9i5
         4suGWWxwsAYjwh9nr/c66ZZ5+vNnSzwDYc69tK6U=
Date:   Thu, 8 Apr 2021 12:08:44 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: open_by_handle_at() in userns
Message-ID: <20210408160844.GD25439@fieldses.org>
References: <20210328155624.930558-1-amir73il@gmail.com>
 <20210330073101.5pqvw72fxvyp5kvf@wittgenstein>
 <CAOQ4uxjQFGdT0xH17pm-nSKE_0--z_AapRW70MNrLJLcCB6MAg@mail.gmail.com>
 <CAOQ4uxiizVxVJgtytYk_o7GvG2O2qwyKHgScq8KLhq218CNdnw@mail.gmail.com>
 <20210331100854.sdgtzma6ifj7w5yn@wittgenstein>
 <CAOQ4uxjHsqZqLT-DOPS0Q0FiHZ2Ge=d3tP+3-qd+O2optq9rZg@mail.gmail.com>
 <20210408125530.gnv5hqcmgewklypn@wittgenstein>
 <20210408141504.GB25439@fieldses.org>
 <CAOQ4uxjkr_3d3KUkjMCtdpg===ZOPOwv41bUBkTppLmqRErHZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjkr_3d3KUkjMCtdpg===ZOPOwv41bUBkTppLmqRErHZQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 06:54:52PM +0300, Amir Goldstein wrote:
> They are understood to me :) but I didn't want to get into it, because it is
> complicated to explain and I wasn't sure if anyone cared...
> 
> I started working on open_by_handle_at() in userns for fanotify and fanotify
> mostly reports directory fhandle, so no issues with cross-directory renames.
> In any case, fanotify never reports "connectable" non-dir file handles.
> 
> Because my proposed change ALSO makes it possible to start talking about
> userspace nfs server inside userns (in case anyone cares), I wanted to lay
> out the path towards a userspace "subtree_check" like solution.

We have to support subdirectory exports and subtree checking because we
already have, but, FWIW, if I were writing a new NFS server from
scratch, I don't think I would.  It's poorly understood, and the effort
would be better spent on more flexible storage management.

--b.

> Another thing I am contemplating is, if and when idmapped mount support
> is added to overlayfs, we can store an additional "connectable" file handle
> in the overlayfs index (whose key is the non-connectable fhandle) and
> fix ovl_acceptable() similar to nfsd_acceptable() and then we will be able
> to mount an overlayfs inside userns with nfs_export support.
> 
> I've included a two liner patch on the fhandle_userns branch to allow
> overlayfs inside userns with nfs_export support in the case that
> underlying filesystem was mounted inside userns, but that is not such
> an interesting use case IMO.
> 
> Thanks,
> Amir.
