Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147DE3005FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 15:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbhAVOtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 09:49:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728860AbhAVOt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611326877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PgyZJSwtqIgwqYrJxFOaG0Fx5oWxu4/J+hWDwv7TtTQ=;
        b=FxpBSNVmlbq4nq2e8HKnG5vV/cVEe72jbNvlx6676GMCnjK74LniZ4Q6rGd414FMVna1gj
        KZtr5s5PCOvqzFoO0cJFuahlxijA1LhJg7QfjVLfQ7jGuyxGfsomrqjfe1HZzpVrGp4uhd
        8DDuqRqBMKn6Y4LiRXRL04Rw/7OHd3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-jvQ__wgONxeW8icT-BZWiw-1; Fri, 22 Jan 2021 09:47:56 -0500
X-MC-Unique: jvQ__wgONxeW8icT-BZWiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DD8C800D55;
        Fri, 22 Jan 2021 14:47:54 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-118-99.rdu2.redhat.com [10.10.118.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B17560BF3;
        Fri, 22 Jan 2021 14:47:54 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 3D4DA1204EC; Fri, 22 Jan 2021 09:47:53 -0500 (EST)
Date:   Fri, 22 Jan 2021 09:47:53 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 2/3] nfsd: move change attribute generation to filesystem
Message-ID: <20210122144753.GA52753@pick.fieldses.org>
References: <1611084297-27352-1-git-send-email-bfields@redhat.com>
 <1611084297-27352-3-git-send-email-bfields@redhat.com>
 <20210120084638.GA3678536@infradead.org>
 <20210121202756.GA13298@pick.fieldses.org>
 <20210122082059.GA119852@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122082059.GA119852@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 22, 2021 at 08:20:59AM +0000, Christoph Hellwig wrote:
> On Thu, Jan 21, 2021 at 03:27:56PM -0500, J. Bruce Fields wrote:
> > I also have a vague idea that some filesystem-specific improvements
> > might be possible.  (E.g., if a filesystem had some kind of boot count
> > in the superblock, maybe that would be a better way to prevent the
> > change attribute from going backwards on reboot than the thing
> > generic_fetch_iversion is currently doing with ctime.  But I have no
> > concrete plan there, maybe I'm dreaming.)
> 
> Even without the ctime i_version never goes backward, what is the
> problem here?

Suppose a modification bumps the change attribute, a client reads
the new value of the change attribute before it's committed to disk,
then the server crashes.  After the server comes back up, the client
requests the change attribute again and sees an older value.

That's actually not too bad.  What I'd mainly like to avoid is
incrementing the change attribute further and risking reuse of an old
value for a different new state of the file.

Which is why generic_fetch_iversion is adding the ctime in the higher
bits.

So we depend on good time for correctness.  Trond has had some concerns
about that.

Something like a boot counter might be more reliable.

Another interesting case is after restore from backup.

--b.

