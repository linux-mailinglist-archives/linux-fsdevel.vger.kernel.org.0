Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD77300CBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 20:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbhAVTe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 14:34:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58709 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730149AbhAVSsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611341214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DgZksRNGLKOso9EgtpnMOO8M2vQqiNnVtzZmopG4+kA=;
        b=V8ADB3R3aL2R6XwZ3za1TxLhTx6hVcVYYwibYp4Q+l/vOElf+asSSOZ8KEa+zcarRBJjOY
        Sgkia6zjHuZzhUHCNlhb+Av6pcavrlN9e0ZKVSNsN6snKW8VL/gIvr3MHk7VnqES9WpFDD
        ZbPnoQ+/4bJOepxcEVJ1E/WRTTRg1bA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-O781iRt_O3SMO4zdn1AXmA-1; Fri, 22 Jan 2021 13:46:52 -0500
X-MC-Unique: O781iRt_O3SMO4zdn1AXmA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2775107ACE8;
        Fri, 22 Jan 2021 18:46:50 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-118-99.rdu2.redhat.com [10.10.118.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A0969CA0;
        Fri, 22 Jan 2021 18:46:50 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id EEBD81204EC; Fri, 22 Jan 2021 13:46:48 -0500 (EST)
Date:   Fri, 22 Jan 2021 13:46:48 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 2/3] nfsd: move change attribute generation to filesystem
Message-ID: <20210122184648.GD52753@pick.fieldses.org>
References: <1611084297-27352-1-git-send-email-bfields@redhat.com>
 <1611084297-27352-3-git-send-email-bfields@redhat.com>
 <20210120084638.GA3678536@infradead.org>
 <20210121202756.GA13298@pick.fieldses.org>
 <20210122082059.GA119852@infradead.org>
 <20210122144753.GA52753@pick.fieldses.org>
 <20210122173248.GB241302@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122173248.GB241302@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 22, 2021 at 05:32:48PM +0000, Christoph Hellwig wrote:
> On Fri, Jan 22, 2021 at 09:47:53AM -0500, J. Bruce Fields wrote:
> > > > I also have a vague idea that some filesystem-specific improvements
> > > > might be possible.  (E.g., if a filesystem had some kind of boot count
> > > > in the superblock, maybe that would be a better way to prevent the
> > > > change attribute from going backwards on reboot than the thing
> > > > generic_fetch_iversion is currently doing with ctime.  But I have no
> > > > concrete plan there, maybe I'm dreaming.)
> > > 
> > > Even without the ctime i_version never goes backward, what is the
> > > problem here?
> > 
> > Suppose a modification bumps the change attribute, a client reads
> > the new value of the change attribute before it's committed to disk,
> > then the server crashes.  After the server comes back up, the client
> > requests the change attribute again and sees an older value.
> 
> So all metadata operations kicked off by nfsd are synchronous due
> to ->commit_metadata/sync_inode_metadata, so this could only happen
> for operations not kicked off by nfsd.

Plain old nfs write also bumps the change attribute.

> More importanly ctime will
> also be lost as i_version and the ctime are commited together.

That's not the reason for using ctime.

The ctime is so that change attributes due to new changes that happen
after the boot will not collide with change attributes used before.

So:

	0. file has change attribute i.
	1. write bumps change attribute to i+1.
	2. client fetches new data and change attribute i+1.
	3. server crashes and comes back up.
	4. a new write with different data bumps change attribute to i+1.
	5. client fetches change attribute again, incorrectly concludes
	   its data cache is still correct.

Including the ctime ensures the change attributes at step 2 and 4 are no
longer the same.

> > That's actually not too bad.  What I'd mainly like to avoid is
> > incrementing the change attribute further and risking reuse of an old
> > value for a different new state of the file.
> 
> Ok but that is an issue if we need to deal with changes that did not
> come in through NFSD.

Those matter too, of course.

--b.

