Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B161470B82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 21:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbhLJUMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 15:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhLJUMt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:12:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293E7C061746;
        Fri, 10 Dec 2021 12:09:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92DACB829DA;
        Fri, 10 Dec 2021 20:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9211C00446;
        Fri, 10 Dec 2021 20:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639166951;
        bh=/QO5H74Xwj7qUD8ZoFMxj7uqs3k0aFmKXDDNDfcFkws=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L0RS+AiQAL+mPdv2nUwLy3tlT7od37Wr0TqOLAnDp0LknSsLTjaZ6cxwv7MM4tpmH
         EB1YSSD0PvohdJxs96FyIhrtQkAm7TTRRi+bTiQ+VUEIay3Jj6RdQGYT5qNW9ZuUw4
         P66pjfdGbjuowPItahYSj+q0F/JhdUcqLF/4MRPN9qN9O75/dn5vtch9Ji5CsBlShc
         Kt43sQZYJ7I8Ra3org6h/sQXy2xwZgGGWcNUdVPxq6UmMcOacfLmpt2XUEMwzBwxtf
         2e0raapUXMTdfiP8Op3N9fBQ9ltn3waxQa9n3K9LO0J/NRWJBBSx9vxYrNEVNGMwMl
         2qsywrj8meTyg==
Message-ID: <01dde47783ce124532912d96a6deeb4cd8278721.camel@kernel.org>
Subject: Re: [PATCH 00/36] ceph+fscrypt: context, filename, symlink and size
 handling support
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 10 Dec 2021 15:09:09 -0500
In-Reply-To: <YbOrlC8KooqvaAuz@sol.localdomain>
References: <20211209153647.58953-1-jlayton@kernel.org>
         <YbOrlC8KooqvaAuz@sol.localdomain>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-12-10 at 11:33 -0800, Eric Biggers wrote:
> On Thu, Dec 09, 2021 at 10:36:11AM -0500, Jeff Layton wrote:
> > I've not posted this in a while, so I figured it was a good time to do
> > so. This patchset is a pile of the mostly settled parts of the fscrypt
> > integration series. With this, pretty much everything but the actual
> > content encryption in files now works.
> 
> There have been a lot of versions of this sent out without contents encryption
> support, which is the most important part.  Is there a path forward for that?
> 

Yeah, it has taken a lot longer than expected. I'm really hoping to wrap
this up in time for a merge in v5.18.

The big problem that we just solved recently was truncate, which in
cephfs is handled by the MDS. We ended up extending the MDS protocol
with a truncate-and-write-last-block op, that gets gated on the object
version acquired from the read. That allows us to do a read-modify-write
cycle in a race free way.

I have patches that convert the non-pagecache I/O codepaths in ceph to
handle content encryption. They mostly work, but there are some bugs I'm
still hunting, so I'm not ready to post them just yet.

Adding support for buffered I/O should be fairly straightforward in
comparison, but we'll probably want to plumb support into the netfs
layer which may be a bit more work, as that should allow us to store
encrypted data in the fscache as well.
-- 
Jeff Layton <jlayton@kernel.org>
