Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D71542021
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 02:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380798AbiFHAR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 20:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578242AbiFGXbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBCBA2509F6
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654639264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bMoHrYtckfc4pwaLoUCwp8YR9pNNBcpYBih/HMrWY2U=;
        b=WoaJ3nuOliRY6bl+dXdNOuaSFgE6jE7NLallflqX+iY3C+l0mXYGN+yUbfWmdGFys+B8tf
        KBOmmetJ1U0GMTPHKsNqVtGRH1EWqOcm6FzHrac4oVC2BgqYBE16S4CTqYKv4IKI7V8VzM
        bQnll1YuE4O/FmZMrzXVUFT9XsiLfRA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-V_ZYYpPZOn6FNOhZnUMt-g-1; Tue, 07 Jun 2022 18:01:01 -0400
X-MC-Unique: V_ZYYpPZOn6FNOhZnUMt-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B28A1C161AF;
        Tue,  7 Jun 2022 22:01:01 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04CF11415100;
        Tue,  7 Jun 2022 22:01:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id BB16D220882; Tue,  7 Jun 2022 18:01:00 -0400 (EDT)
Date:   Tue, 7 Jun 2022 18:01:00 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Dharmendra Singh <dharamhans87@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v4 1/1] Allow non-extending parallel direct writes on the
 same file.
Message-ID: <Yp/KnF0oSIsk0SYd@redhat.com>
References: <20220605072201.9237-1-dharamhans87@gmail.com>
 <20220605072201.9237-2-dharamhans87@gmail.com>
 <Yp/CYjONZHoekSVA@redhat.com>
 <34dd96b3-e253-de4e-d5d3-a49bc1990e6f@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34dd96b3-e253-de4e-d5d3-a49bc1990e6f@ddn.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 11:42:16PM +0200, Bernd Schubert wrote:
> 
> 
> On 6/7/22 23:25, Vivek Goyal wrote:
> > On Sun, Jun 05, 2022 at 12:52:00PM +0530, Dharmendra Singh wrote:
> > > From: Dharmendra Singh <dsingh@ddn.com>
> > > 
> > > In general, as of now, in FUSE, direct writes on the same file are
> > > serialized over inode lock i.e we hold inode lock for the full duration
> > > of the write request. I could not found in fuse code a comment which
> > > clearly explains why this exclusive lock is taken for direct writes.
> > > 
> > > Following might be the reasons for acquiring exclusive lock but not
> > > limited to
> > > 1) Our guess is some USER space fuse implementations might be relying
> > >     on this lock for seralization.
> > 
> > Hi Dharmendra,
> > 
> > I will just try to be devil's advocate. So if this is server side
> > limitation, then it is possible that fuse client's isize data in
> > cache is stale. For example, filesystem is shared between two
> > clients.
> > 
> > - File size is 4G as seen by client A.
> > - Client B truncates the file to 2G.
> > - Two processes in client A, try to do parallel direct writes and will
> >    be able to proceed and server will get two parallel writes both
> >    extending file size.
> > 
> > I can see that this can happen with virtiofs with cache=auto policy.
> > 
> > IOW, if this is a fuse server side limitation, then how do you ensure
> > that fuse kernel's i_size definition is not stale.
> 
> Hi Vivek,
> 
> I'm sorry, to be sure, can you explain where exactly a client is located for
> you? For us these are multiple daemons linked to libufse - which you seem to
> call 'server' Typically these clients are on different machines. And servers
> are for us on the other side of the network - like an NFS server.

Hi Bernd,

Agreed, terminology is little confusing. I am calling "fuse kernel" as
client and fuse daemon (user space) as server. This server in turn might
be the client to another network filesystem and real files might be
served by that server on network.

So for simple virtiofs case, There can be two fuse daemons (virtiofsd
instances) sharing same directory (either on local filesystem or on
a network filesystem).

> 
> So now while I'm not sure what you mean with 'client', I'm wondering about
> two generic questions
> 
> a) I need to double check, but we were under the assumption the code in
> question is a direct-io code path. I assume cache=auto would use the page
> cache and should not be effected?

By default cache=auto use page cache but if application initiates a
direct I/O, it should use direct I/O path.

> 
> b) How would the current lock help for distributed clients? Or multiple fuse
> daemons (what you seem to call server) per local machine?

I thought that current lock is trying to protect fuse kernel side and
assumed fuse server (daemon linked to libfuse) can handle multiple
parallel writes. Atleast that's how I thought about the things. I might
be wrong. I am not sure.

> 
> For a single vfs mount point served by fuse, truncate should take the
> exclusive lock and parallel writes the shared lock - I don't see a problem
> here either.

Agreed that this does not seem like a problem from fuse kernel side. I was
just questioning that where parallel direct writes become a problem. And
answer I heard was that it probably is fuse server (daemon linked with
libfuse) which is expecting the locking. And if that's the case, this
patch is not fool proof. It is possible that file got truncated from
a different client (from a different fuse daemon linked with libfuse).

So say A is first fuse daemon and B is another fuse daemon. Both are
clients to some network file system as NFS.

- Fuse kernel for A, sees file size as 4G.
- fuse daemon B truncates the file to size 2G.
- Fuse kernel for A, has stale cache, and can send two parallel writes
  say at 3G and 3.5G offset.
- Fuser daemon A might not like it.(Assuming this is fuse daemon/user
  space side limitation).

I hope I am able to explain my concern. I am not saying that this patch
is not good. All I am saying that fuse daemon (user space) can not rely
on that it will never get two parallel direct writes which can be beyond
the file size. If fuse kernel cache is stale, it can happen. Just trying
to set the expectations right.

Thanks
Vivek

