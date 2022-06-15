Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AF154D368
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 23:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347544AbiFOVMp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 17:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241949AbiFOVMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06EC717AB6
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655327560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nc4/yIeOW6BIApE6WsS6JrQNQ82L7gmq356ZQg4s9AM=;
        b=YWKP7oeqifBqGNt51nfU+GN64ChVJOGNgYAWk4+ex10ikCI2cyxCs8oi7zaER8Ab6/omkM
        QjmRC03kaAGFIQzZ5I9PQhDGHAwI/zpLABDmVR2RtZyyabn6AFRf6aKVTLvJtKNYE7zti9
        AlJ6umS6k7/nJmZ7/7pwiGm/ecmRqn0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-Nazf6m_rP2OkXAe_W4o8zg-1; Wed, 15 Jun 2022 17:12:34 -0400
X-MC-Unique: Nazf6m_rP2OkXAe_W4o8zg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CEFA384F808;
        Wed, 15 Jun 2022 21:12:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.19.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E400A1131D;
        Wed, 15 Jun 2022 21:12:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A453D2209F9; Wed, 15 Jun 2022 17:12:33 -0400 (EDT)
Date:   Wed, 15 Jun 2022 17:12:33 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dharmendra Hans <dharamhans87@gmail.com>
Cc:     Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v4 1/1] Allow non-extending parallel direct writes on the
 same file.
Message-ID: <YqpLQe37Tvj8WTTG@redhat.com>
References: <20220605072201.9237-1-dharamhans87@gmail.com>
 <20220605072201.9237-2-dharamhans87@gmail.com>
 <Yp/CYjONZHoekSVA@redhat.com>
 <34dd96b3-e253-de4e-d5d3-a49bc1990e6f@ddn.com>
 <Yp/KnF0oSIsk0SYd@redhat.com>
 <3d189ccc-437e-d9c0-e9f1-b4e0d2012e3c@ddn.com>
 <YqH7PO7KtoiXkmVH@redhat.com>
 <CACUYsyFBRR9yH3=cQFDmMRSPt45Tf1+Z+y-tL54AzEPpQTC4uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACUYsyFBRR9yH3=cQFDmMRSPt45Tf1+Z+y-tL54AzEPpQTC4uA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 10, 2022 at 12:54:46PM +0530, Dharmendra Hans wrote:
> On Thu, Jun 9, 2022 at 7:23 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Jun 08, 2022 at 12:42:20AM +0200, Bernd Schubert wrote:
> > >
> > >
> > > On 6/8/22 00:01, Vivek Goyal wrote:
> > > > On Tue, Jun 07, 2022 at 11:42:16PM +0200, Bernd Schubert wrote:
> > > > >
> > > > >
> > > > > On 6/7/22 23:25, Vivek Goyal wrote:
> > > > > > On Sun, Jun 05, 2022 at 12:52:00PM +0530, Dharmendra Singh wrote:
> > > > > > > From: Dharmendra Singh <dsingh@ddn.com>
> > > > > > >
> > > > > > > In general, as of now, in FUSE, direct writes on the same file are
> > > > > > > serialized over inode lock i.e we hold inode lock for the full duration
> > > > > > > of the write request. I could not found in fuse code a comment which
> > > > > > > clearly explains why this exclusive lock is taken for direct writes.
> > > > > > >
> > > > > > > Following might be the reasons for acquiring exclusive lock but not
> > > > > > > limited to
> > > > > > > 1) Our guess is some USER space fuse implementations might be relying
> > > > > > >      on this lock for seralization.
> > > > > >
> > > > > > Hi Dharmendra,
> > > > > >
> > > > > > I will just try to be devil's advocate. So if this is server side
> > > > > > limitation, then it is possible that fuse client's isize data in
> > > > > > cache is stale. For example, filesystem is shared between two
> > > > > > clients.
> > > > > >
> > > > > > - File size is 4G as seen by client A.
> > > > > > - Client B truncates the file to 2G.
> > > > > > - Two processes in client A, try to do parallel direct writes and will
> > > > > >     be able to proceed and server will get two parallel writes both
> > > > > >     extending file size.
> > > > > >
> > > > > > I can see that this can happen with virtiofs with cache=auto policy.
> > > > > >
> > > > > > IOW, if this is a fuse server side limitation, then how do you ensure
> > > > > > that fuse kernel's i_size definition is not stale.
> > > > >
> > > > > Hi Vivek,
> > > > >
> > > > > I'm sorry, to be sure, can you explain where exactly a client is located for
> > > > > you? For us these are multiple daemons linked to libufse - which you seem to
> > > > > call 'server' Typically these clients are on different machines. And servers
> > > > > are for us on the other side of the network - like an NFS server.
> > > >
> > > > Hi Bernd,
> > > >
> > > > Agreed, terminology is little confusing. I am calling "fuse kernel" as
> > > > client and fuse daemon (user space) as server. This server in turn might
> > > > be the client to another network filesystem and real files might be
> > > > served by that server on network.
> > > >
> > > > So for simple virtiofs case, There can be two fuse daemons (virtiofsd
> > > > instances) sharing same directory (either on local filesystem or on
> > > > a network filesystem).
> > >
> > > So the combination of fuse-kernel + fuse-daemon == vfs mount.
> >
> > This is fine for regular fuse file systems. For virtiofs fuse-kernel is
> > running in a VM and fuse-daemon is running outside the VM on host.
> > >
> > > >
> > > > >
> > > > > So now while I'm not sure what you mean with 'client', I'm wondering about
> > > > > two generic questions
> > > > >
> > > > > a) I need to double check, but we were under the assumption the code in
> > > > > question is a direct-io code path. I assume cache=auto would use the page
> > > > > cache and should not be effected?
> > > >
> > > > By default cache=auto use page cache but if application initiates a
> > > > direct I/O, it should use direct I/O path.
> > >
> > > Ok, so we are on the same page regarding direct-io.
> > >
> > > >
> > > > >
> > > > > b) How would the current lock help for distributed clients? Or multiple fuse
> > > > > daemons (what you seem to call server) per local machine?
> > > >
> > > > I thought that current lock is trying to protect fuse kernel side and
> > > > assumed fuse server (daemon linked to libfuse) can handle multiple
> > > > parallel writes. Atleast that's how I thought about the things. I might
> > > > be wrong. I am not sure.
> > > >
> > > > >
> > > > > For a single vfs mount point served by fuse, truncate should take the
> > > > > exclusive lock and parallel writes the shared lock - I don't see a problem
> > > > > here either.
> > > >
> > > > Agreed that this does not seem like a problem from fuse kernel side. I was
> > > > just questioning that where parallel direct writes become a problem. And
> > > > answer I heard was that it probably is fuse server (daemon linked with
> > > > libfuse) which is expecting the locking. And if that's the case, this
> > > > patch is not fool proof. It is possible that file got truncated from
> > > > a different client (from a different fuse daemon linked with libfuse).
> > > >
> > > > So say A is first fuse daemon and B is another fuse daemon. Both are
> > > > clients to some network file system as NFS.
> > > >
> > > > - Fuse kernel for A, sees file size as 4G.
> > > > - fuse daemon B truncates the file to size 2G.
> > > > - Fuse kernel for A, has stale cache, and can send two parallel writes
> > > >    say at 3G and 3.5G offset.
> > >
> > > I guess you mean inode cache, not data cache, as this is direct-io.
> >
> > Yes inode cache and cached ->i_size might be an issue. These patches
> > used cached ->i_size to determine if parallel direct I/O should be
> > allowed or not.
> >
> >
> > > But now
> > > why would we need to worry about any cache here, if this is direct-io - the
> > > application writes without going into any cache and at the same time a
> > > truncate happens? The current kernel side lock would not help here, but a
> > > distrubuted lock is needed to handle this correctly?
> > >
> > > int fd = open(path, O_WRONLY | O_DIRECT);
> > >
> > > clientA: pwrite(fd, buf, 100G, 0) -> takes a long time
> > > clientB: ftruncate(fd, 0)
> > >
> > > I guess on a local file system that will result in a zero size file. On
> > > different fuse mounts (without a DLM) or NFS, undefined behavior.
> > >
> > >
> > > > - Fuser daemon A might not like it.(Assuming this is fuse daemon/user
> > > >    space side limitation).
> > >
> > > I think there are two cases for the fuser daemons:
> > >
> > > a) does not have a distributed lock - just needs to handle the writes, the
> > > local kernel lock does not protect against distributed races.
> >
> > Exactly. This is the point I am trying to raise. "Local kernel lock does
> > not protect against distributed races".
> >
> > So in this case local kernel has ->i_size cached and this might be an
> > old value and checking i_size does not guarantee that fuse daemon
> > will not get parallel extending writes.
> >
> > > I guess most
> > > of these file systems can enable parallel writes, unless the kernel lock is
> > > used to handle userspace thread synchronization.
> >
> > Right. If user space is relying on kernel lock for thread synchronization,
> > it can not enable parallel writes.
> >
> > But if it is not relying on this, it should be able to enable parallel
> > writes. Just keep in mind that ->i_size check is not sufficient to
> > guarantee that you will not get "two extnding parallel writes". If
> > another client on a different machine truncated the file, it is
> > possible this client has old cached ->i_size and it will can
> > get multiple file extending parallel writes.
> >
> > So if fuse daemon enables parallel extending writes, it should be
> > prepared to deal with multiple extending parallel writes.
> >
> > And if this is correct assumption, I am wondering why to even try
> > to do ->i_size check and try to avoid parallel extending writes
> > in fuse kernel. May be there is something I am not aware of. And
> > that's why I am just raising questions.
> 
> Let's consider couple of cases:
> 1) Fuse daemon is  file server itself(local file system):
>    Here we need to make sure few things in fuse kernel
>      a) Appending writes are handled. This requires serialized access
> to inode in fuse kernel as we generate off from i_size(as i_size is
> updated after write         returns).
>      b) If we allow concurrent writes then we can have following cases
>         - All writes coming under i_size, it's overwrite.
>            If any of the write fails(though it is expected all
> following writes would fail on that file),  usually on a single
> daemon, all following writes on the same
>            file would be aborted. Since fuse upates i_size after write
> returns successfully, we have no worry in this case, no action is
> required from fuse like
>            truncate etc as we are not using page cache here.
> 
>        - All writes are extending writes
>          These writes are extending current i_size.  Let's assume, as
> of now, i_size is 1 mb.  Now, wr1 extends i_size from 1mb to 2mb, and
> wr2 extends i_size
>          from 2mb  to 3mb. Let's assume wr1 succeeds, and wr2 fails,
> in this case wr1 would update i_size to 2mb and
>          wr2 would not update i_size, so we are good, nothing required here.
>          In just reverse case, where wr1 fails and wr2 succeeds, then
> wr2 must be updating i_size to 3mb(wr1 would not update i_size). Here
> we are required
>         to create hole in the file from offset 1mb to 2mb otherwise
> gargabe would be provided to the reader as it is fresh write and no
> old data exists yet at that offset.

Hi Dharmendra,

I think this idea of fuse daemon having to ensure holes in file don't
return garbase is confusing.

Should underlying filesystem not take care of this. For example, in above
example assume only wr2 was issued (and not wr1). IOW, i_size 1 1MB. I
do lseek(2MB) and write 1MB of data from 2MB to 3MB (wr2). This succeeds
and fuse will udpate i_size to 3MB. Now we should have a hole between
1MB to 2MB. Will underlying filesystem not take care of it in normal
cases and return 0 if we read from hole.

man lseek says.

       lseek()  allows  the  file  offset to be set beyond the end of the file
       (but this does not change the size of the  file).   If  data  is  later
       written  at  this  point,  subsequent  reads  of the data in the gap (a
       "hole") return null bytes ('\0') until data is  actually  written  into
       the gap.

Thanks
Vivek


> 
> 2) Fuse daemon forwards req to actual file server(i.e fuse daemon is
> client here)
>     Please note that this fuse daemon is forwarding data to actual
> servers(and we can have single or multple servers consuming data)
> therefore it can send
>     wr1 to srv1 and wr2 to srv2 and so on.
>     Here we need to make sure few things again
>     a) Appending writes as pointed out in 1), every fuse daemon should
> generate correct offset(local to itself) at which data is written. We
> need exclusive lock for this.
>     b) Allowing concurrent writes:
>          -  All writes coming under i_size, it's overwrite.
>             Here it can happen that some write went to srv1 and
> succeeded and some went to srv2 and failed(due to space issue on this
> node or something else
>            like network problems). In this case we are not required to
> do anything as usual.
>          - All writes are extending writes
>            Let's assume as done in 1), as of now, i_size is 1 mb.
> Now, wr1 extends i_size from 1mb to 2mb and goes to srv1, and wr2
> extends i_size
>          from 2mb  to 3mb and goes to srv2. Let's assume wr1 succeeds,
> and wr2 fails, in this case wr1 would update i_size to 2mb and
>          wr2 would not update i_size, so we are good, nothing required here.
>          In just reverse case, where wr1 fails and wr2 succeeds, then
> wr2 must be updating i_size to 3mb(wr1 would not update i_size). Here
> we are required
>         to create hole in the file from offset 1mb to 2mb otherwise
> gargabe would be provided to the reader as it is fresh write and no
> old data exists yet at that offset.
> 
> It can happen that holes are not supported by all file server types.
> In that case also, I don't think we can allow extending writes.
> My understanding is that each fuse daemon is supposed to maintain
> consistency related to offset/i_size on its own end when we do not
> have DLM.
> 
> > >
> > > b) has a distributed lock - needs a callback to fuse kernel to inform the
> > > kernel to invalidate all data.
> > >
> > > At DDN we have both of them, a) is in production, the successor b) is being
> > > worked on. We might come back with more patches for more callbacks for the
> > > DLM - I'm not sure yet.
> > >
> > >
> > > >
> > > > I hope I am able to explain my concern. I am not saying that this patch
> > > > is not good. All I am saying that fuse daemon (user space) can not rely
> > > > on that it will never get two parallel direct writes which can be beyond
> > > > the file size. If fuse kernel cache is stale, it can happen. Just trying
> > > > to set the expectations right.
> > >
> > >
> > > I don't see an issue yet. Regarding virtiofs, does it have a distributed
> > > lock manager (DLM)? I guess not?
> >
> > Nope. virtiofs does not have any DLM.
> >
> > Vivek
> > >
> > >
> > > Thanks,
> > > Bernd
> > >
> >
> 

