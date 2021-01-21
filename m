Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504D42FF5F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 21:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbhAUUeq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 15:34:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbhAUU33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611260882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZM6fDETjG/OSIznEV8j1/yCgekfI8hxlFIQEzJi1LHc=;
        b=WcHwg7NNpHdp+LbL5NAEj2Gy3pYIbO5EGpxt0LURy8TbXQduxL+6VJrBm4yIRpU+BwYauV
        USuGWqvr3yw1cgoWgA2sK8/PGZOhRLQIkgLDylXwhR52vJjer5ktVPdrDKNL6mqbbJgz+/
        2eIQb1sZwQy3moJmH1DqIPTvzrgYaoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-u041yri1OwCN7zre_Q3n-w-1; Thu, 21 Jan 2021 15:27:59 -0500
X-MC-Unique: u041yri1OwCN7zre_Q3n-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CD438066E5;
        Thu, 21 Jan 2021 20:27:58 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-121-75.rdu2.redhat.com [10.10.121.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00A526EF45;
        Thu, 21 Jan 2021 20:27:57 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id D725B1204AB; Thu, 21 Jan 2021 15:27:56 -0500 (EST)
Date:   Thu, 21 Jan 2021 15:27:56 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 2/3] nfsd: move change attribute generation to filesystem
Message-ID: <20210121202756.GA13298@pick.fieldses.org>
References: <1611084297-27352-1-git-send-email-bfields@redhat.com>
 <1611084297-27352-3-git-send-email-bfields@redhat.com>
 <20210120084638.GA3678536@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120084638.GA3678536@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 08:46:38AM +0000, Christoph Hellwig wrote:
> On Tue, Jan 19, 2021 at 02:24:56PM -0500, J. Bruce Fields wrote:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > After this, only filesystems lacking change attribute support will leave
> > the fetch_iversion export op NULL.
> > 
> > This seems cleaner to me, and will allow some minor optimizations in the
> > nfsd code.
> 
> Another indirect call just to fetch the change attribute (which happens
> a lot IIRC) does not seem very optimal to me.

In the next patch we're removing an fh_getattr (vfs_getattr) in the case
we call the new op, so that's typically a net decrease in indirect
calls.

Though maybe we could use a flag here and do without either.

> And the fact that we need three duplicate implementations also is not
> very nice.

Ext4 and xfs are identical, btrfs is a little different since it doesn't
consult I_VERSION.  (And then there's nfs, which uses the origin
server's i_version if it can.)

I also have a vague idea that some filesystem-specific improvements
might be possible.  (E.g., if a filesystem had some kind of boot count
in the superblock, maybe that would be a better way to prevent the
change attribute from going backwards on reboot than the thing
generic_fetch_iversion is currently doing with ctime.  But I have no
concrete plan there, maybe I'm dreaming.)

--b.

