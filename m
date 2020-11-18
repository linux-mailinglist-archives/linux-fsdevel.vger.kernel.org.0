Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4252B7F3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 15:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgKRORG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 09:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRORG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:17:06 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F450C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 06:17:05 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 294A5C009; Wed, 18 Nov 2020 15:17:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1605709024; bh=BFPA0x9SzykN28MusL5Go/gQn2frP/40Rom8hNtpNjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZeuYQufeIgu4T1qFPDaFwKsel1NaRWR00crUWbNX+aVYjrtNjgJr1mR2mKlRFGlX
         avILicQHgWTKbBBfmGgww4Rf3g+uczXnLXnK8h98dP3zuOyVUI/Lw2nu9M8XZ/d8dA
         AFBZ0eQVS/oTN45FtoEjULB4ni+W1pgLy9icbfnJa8tdXty1bc1mx9XNp4YtnEd14N
         btGXiUWR8KjqBGY2HLSVopMRWu87n7vgBR0Wm6Fd4FV8pFJlRxCPFMRWBlvutHEOf6
         Tftry6eMNYi1hkljJxR/FN2QQhg5Lf6QcoNOxv+2+LlmdxVjyOcgmnt9wjBi05PH5e
         ESRDiwgoW4klw==
Date:   Wed, 18 Nov 2020 15:16:49 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 9p: Convert to new fscache API
Message-ID: <20201118141649.GA14211@nautica>
References: <20201118124826.GA17850@nautica>
 <1514086.1605697347@warthog.procyon.org.uk>
 <1561011.1605706707@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1561011.1605706707@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote on Wed, Nov 18, 2020:
> > What's the current schedule/plan for the fscache branch merging? Will
> > you be trying this merge window next month?
> 
> That's the aim.  We have afs, ceph and nfs are about ready; I've had a go at
> doing the 9p conversion, which I'll have to leave to you now, I think, and am
> having a poke at cifs.

Ok, will try to polish it up by then.
Worst case as discussed is to have fscache be an alias for cache=loose
until it's ready but with the first version you gave me it hopefully
won't be needed.

> > >  (*) I have made an assumption that 9p_client_read() and write can handle I/Os
> > >      larger than a page.  If this is not the case, v9fs_req_ops will need
> > >      clamp_length() implementing.
> > 
> > There's a max driven by the client's msize
> 
> The netfs read helpers provide you with a couple of options here:
> 
>  (1) You can use ->clamp_length() to do multiple slices of at least 1 byte
>      each.  The assumption being that these represent parallel operations.  A
>      new subreq will be generated for each slice.
> 
>  (2) You can go with large slices that are larger than msize, and just read
>      part of it with each read.  After reading, the netfs helper will keep
>      calling you again to read some more of it, provided you didn't return an
>      error and you at least read something.

clamp_length looks good for that, if we can get parallel requests out
it'll all come back faster.

> > (client->msize - P9_IOHDRSZ ; unfortunately msize is just guaranted to be >=
> > 4k so that means the actual IO size would be smaller in that case even if
> > that's not intended to be common)
> 
> Does that mean you might be limited to reads of less than PAGE_SIZE on some
> systems (ppc64 for example)?  This isn't a problem for the read helper, but
> might be an issue for writing from THPs.

Quite likely, the actual used size varies depending on the backend (64k
for tcp, 500k for virtio) but can definietly be less than PAGE_SIZE.

I take it the read helper would just iterate as long as there's data
still required to read, writing from THPs wouldn't do that?


> > >  (*) The cache needs to be invalidated if a 3rd-party change happens, but I
> > >      haven't done that.
> > 
> > There's no concurrent access logic in 9p as far as I'm aware (like NFS
> > does if the mtime changes for example), so I assume we can keep ignoring
> > this.
> 
> By that, I presume you mean concurrent accesses are just not permitted?

Sorry - I meant coherency if files are modified on multiple clients
isn't guaranted - there are voluntary locks but that's about it, nothing
will detect e.g. remote file size modifications.
Concurrency on a given client works fine and should be used if possible.

-- 
Dominique
